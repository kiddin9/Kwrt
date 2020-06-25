#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LANG=zh_CN.UTF-8

THIS_SCRIPT="sysinfo"
MOTD_DISABLE=""

SHOW_IP_PATTERN="^[ewr].*|^br.*|^lt.*|^umts.*"

DATA_STORAGE=/userdisk/data
MEDIA_STORAGE=/userdisk/snail


[[ -f /etc/default/motd ]] && . /etc/default/motd
for f in $MOTD_DISABLE; do
	[[ $f == $THIS_SCRIPT ]] && exit 0
done


# don't edit below here
function display()
{
	# $1=name $2=value $3=red_limit $4=minimal_show_limit $5=unit $6=after $7=acs/desc{
	# battery red color is opposite, lower number
	if [[ "$1" == "Battery" ]]; then
		local great="<";
	else
		local great=">";
	fi
	if [[ -n "$2" && "$2" > "0" && (( "${2%.*}" -ge "$4" )) ]]; then
		printf "%-14s%s" "$1:"
		if awk "BEGIN{exit ! ($2 $great $3)}"; then
			echo -ne "\e[0;91m $2";
		else
			echo -ne "\e[0;92m $2";
		fi
		printf "%-1s%s\x1B[0m" "$5"
		printf "%-11s%s\t" "$6"
		return 1
	fi
} # display


function get_ip_addresses()
{
	local ips=()
	for f in /sys/class/net/*; do
		local intf=$(basename $f)
		# match only interface names starting with e (Ethernet), br (bridge), w (wireless), r (some Ralink drivers use ra<number> format)
		if [[ $intf =~ $SHOW_IP_PATTERN ]]; then
			local tmp=$(ip -4 addr show dev $intf | awk '/inet/ {print $2}' | cut -d'/' -f1)
			# add both name and IP - can be informative but becomes ugly with long persistent/predictable device names
			#[[ -n $tmp ]] && ips+=("$intf: $tmp")
			# add IP only
			[[ -n $tmp ]] && ips+=("$tmp")
		fi
	done
	echo "${ips[@]}"
} # get_ip_addresses


function storage_info()
{
	# storage info
	RootInfo=$(df -h /)
	root_usage=$(awk '/\// {print $(NF-1)}' <<<${RootInfo} | sed 's/%//g')
	root_total=$(awk '/\// {print $(NF-4)}' <<<${RootInfo})

	# storage info
	BootInfo=$(df -h /boot)
	boot_usage=$(awk '/\// {print $(NF-1)}' <<<${BootInfo} | sed 's/%//g')
	boot_total=$(awk '/\// {print $(NF-4)}' <<<${BootInfo})

	StorageInfo=$(df -h $MEDIA_STORAGE 2>/dev/null | grep $MEDIA_STORAGE)
	if [[ -n "${StorageInfo}" && ${RootInfo} != *$MEDIA_STORAGE* ]]; then
		media_usage=$(awk '/\// {print $(NF-1)}' <<<${StorageInfo} | sed 's/%//g')
		media_total=$(awk '/\// {print $(NF-4)}' <<<${StorageInfo})
	fi

	StorageInfo=$(df -h $DATA_STORAGE 2>/dev/null | grep $DATA_STORAGE)
	if [[ -n "${StorageInfo}" && ${RootInfo} != *$DATA_STORAGE* ]]; then
		data_usage=$(awk '/\// {print $(NF-1)}' <<<${StorageInfo} | sed 's/%//g')
		data_total=$(awk '/\// {print $(NF-4)}' <<<${StorageInfo})
	fi
} # storage_info


# query various systems and send some stuff to the background for overall faster execution.
# Works only with ambienttemp and batteryinfo since A20 is slow enough :)
ip_address=$(get_ip_addresses &)
storage_info
critical_load=$(( 1 + $(grep -c processor /proc/cpuinfo) / 2 ))

# get uptime, logged in users and load in one take
UptimeString=$(uptime | tr -d ',')
time=$(awk -F" " '{print $3" "$4}' <<<"${UptimeString}")
load="$(awk -F"average: " '{print $2}'<<<"${UptimeString}")"
case ${time} in
	1:*) # 1-2 hours
		time=$(awk -F" " '{print $3" 小时"}' <<<"${UptimeString}")
		;;
	*:*) # 2-24 hours
		time=$(awk -F" " '{print $3" 小时"}' <<<"${UptimeString}")
		;;
	*day) # days
		days=$(awk -F" " '{print $3"天"}' <<<"${UptimeString}")
		time=$(awk -F" " '{print $5}' <<<"${UptimeString}")
		time="$days "$(awk -F":" '{print $1"小时 "$2"分钟"}' <<<"${time}")
		;;
esac


# memory and swap
mem_info=$(LC_ALL=C free -w 2>/dev/null | grep "^Mem" || LC_ALL=C free | grep "^Mem")
memory_usage=$(awk '{printf("%.0f",(($2-($4+$6))/$2) * 100)}' <<<${mem_info})
memory_total=$(awk '{printf("%d",$2/1024)}' <<<${mem_info})
swap_info=$(LC_ALL=C free -m | grep "^Swap")
swap_usage=$( (awk '/Swap/ { printf("%3.0f", $3/$2*100) }' <<<${swap_info} 2>/dev/null || echo 0) | tr -c -d '[:digit:]')
swap_total=$(awk '{print $(2)}' <<<${swap_info})


# display info
display "系统负载" "${load%% *}" "${critical_load}" "0" "" "${load#* }"
printf "运行时间:  \x1B[92m%s\x1B[0m\t\t" "$time"
echo "" # fixed newline


display "内存已用" "$memory_usage" "70" "0" " %" " of ${memory_total}MB"
display "交换内存" "$swap_usage" "10" "0" " %" " of $swap_total""Mb"
printf "IP  地址:  \x1B[92m%s\x1B[0m" "$ip_address"
echo "" # fixed newline


a=0;b=0;c=0
display "CPU 温度" "$board_temp" "45" "0" "°C" "" ; a=$?
display "环境温度" "$amb_temp" "40" "0" "°C" "" ; b=$?
(( ($a+$b) >0 )) && echo "" # new line only if some value is displayed


display "启动存储" "$boot_usage" "90" "1" "%" " of $boot_total"
display "系统存储" "$root_usage" "90" "1" "%" " of $root_total"
echo ""

display "数据存储" "$data_usage" "90" "1" "%" " of $data_total"
display "媒体存储" "$media_usage" "90" "1" "%" " of $media_total"
echo ""
echo ""


