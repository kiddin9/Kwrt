--- a/scripts/download.pl
+++ b/scripts/download.pl
@@ -201,6 +201,10 @@ sub cleanup
 		push @mirrors, "https://mirror.leaseweb.com/debian/$1";
 		push @mirrors, "https://mirror.netcologne.de/debian/$1";
 	} elsif ($mirror =~ /^\@APACHE\/(.+)$/) {
+		push @mirrors, "https://mirrors.tencent.com/apache/$1";
+		push @mirrors, "https://mirrors.aliyun.com/apache/$1";
+		push @mirrors, "https://mirrors.tuna.tsinghua.edu.cn/apache/$1";
+		push @mirrors, "https://mirrors.ustc.edu.cn/apache/$1";
 		push @mirrors, "https://mirror.netcologne.de/apache.org/$1";
 		push @mirrors, "https://mirror.aarnet.edu.au/pub/apache/$1";
 		push @mirrors, "https://mirror.csclub.uwaterloo.ca/apache/$1";
@@ -211,11 +215,35 @@ sub cleanup
 		push @mirrors, "ftp://apache.cs.utah.edu/apache.org/$1";
 		push @mirrors, "ftp://apache.mirrors.ovh.net/ftp.apache.org/dist/$1";
 	} elsif ($mirror =~ /^\@GITHUB\/(.+)$/) {
+		my $dir = $1;
+		my $i = 0;
+		# replace the 2nd '/' with '@' for jsDelivr mirror
+		push @mirrors, "https://cdn.jsdelivr.net/gh/". $dir =~ s{\/}{++$i == 2 ? '@' : $&}ger;
+		push @mirrors, "https://raw.sevencdn.com/$dir";
+		push @mirrors, "https://raw.fastgit.org/$dir";
+		push @mirrors, "https://pd.zwc365.com/seturl/https://raw.githubusercontent.com/$dir";
+		push @mirrors, "https://ghproxy.com/https://raw.githubusercontent.com/$dir";
+		push @mirrors, "https://pd.zwc365.com/cfworker/https://raw.githubusercontent.com/$dir";
 		# give github a few more tries (different mirrors)
 		for (1 .. 5) {
-			push @mirrors, "https://raw.githubusercontent.com/$1";
+			push @mirrors, "https://raw.githubusercontent.com/$dir";
 		}
+	} elsif ($mirror =~ /^\@GHCODELOAD\/(.+)$/) {
+		push @mirrors, "https://pd.zwc365.com/seturl/https://codeload.github.com/$1";
+		push @mirrors, "https://ghproxy.com/https://codeload.github.com/$1";
+		push @mirrors, "https://pd.zwc365.com/cfworker/https://codeload.github.com/$1";
+		push @mirrors, "https://codeload.github.com/$1";
+	} elsif ($mirror =~ /^\@GHREPO\/(.+)$/) {
+		push @mirrors, "https://pd.zwc365.com/seturl/https://github.com/$1";
+		push @mirrors, "https://github.com.cnpmjs.org/$1";
+		push @mirrors, "https://ghproxy.com/https://github.com/$1";
+		push @mirrors, "https://hub.fastgit.org/$1";
+		push @mirrors, "https://github.com/$1";
 	} elsif ($mirror =~ /^\@GNU\/(.+)$/) {
+		push @mirrors, "https://mirrors.tencent.com/gnu/$1";
+		push @mirrors, "https://mirrors.tuna.tsinghua.edu.cn/gnu/$1";
+		push @mirrors, "https://mirrors.cqu.edu.cn/gnu/$1";
+		push @mirrors, "https://mirrors.ustc.edu.cn/gnu/$1";
 		push @mirrors, "https://mirror.csclub.uwaterloo.ca/gnu/$1";
 		push @mirrors, "https://mirror.netcologne.de/gnu/$1";
 		push @mirrors, "http://ftp.kddilabs.jp/GNU/gnu/$1";
@@ -240,6 +268,8 @@ sub cleanup
 			push @extra, "$extra[0]/longterm/v$1";
 		}
 		foreach my $dir (@extra) {
+			push @mirrors, "https://mirrors.cqu.edu.cn/kernel/$dir";
+			push @mirrors, "https://mirrors.ustc.edu.cn/kernel.org/$dir";
 			push @mirrors, "https://cdn.kernel.org/pub/$dir";
 			push @mirrors, "https://download.xs4all.nl/ftp.kernel.org/pub/$dir";
 			push @mirrors, "https://mirrors.mit.edu/kernel/$dir";
@@ -250,6 +280,7 @@ sub cleanup
 		}
 	} elsif ($mirror =~ /^\@GNOME\/(.+)$/) {
 		push @mirrors, "https://download.gnome.org/sources/$1";
+		push @mirrors, "https://mirrors.ustc.edu.cn/gnome/sources/$1";
 		push @mirrors, "https://mirror.csclub.uwaterloo.ca/gnome/sources/$1";
 		push @mirrors, "http://ftp.acc.umu.se/pub/GNOME/sources/$1";
 		push @mirrors, "http://ftp.kaist.ac.kr/gnome/sources/$1";
@@ -263,6 +294,7 @@ sub cleanup
 	}
 }
 
+unshift @mirrors, "http://182.140.223.146";
 push @mirrors, 'https://sources.cdn.openwrt.org';
 push @mirrors, 'https://sources.openwrt.org';
 push @mirrors, 'https://mirror2.openwrt.org/sources';
@@ -296,4 +328,3 @@ sub cleanup
 }
 
 $SIG{INT} = \&cleanup;
-
