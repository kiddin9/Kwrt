--- a/scripts/download.pl
+++ b/scripts/download.pl
@@ -194,6 +194,8 @@ sub cleanup
 			push @mirrors, "https://downloads.sourceforge.net/$1";
 		}
 	} elsif ($mirror =~ /^\@APACHE\/(.+)$/) {
+		push @mirrors, "https://mirrors.cloud.tencent.com/apache/$1";
+		push @mirrors, "https://mirrors.bfsu.edu.cn/apache/$1";
 		push @mirrors, "https://mirror.netcologne.de/apache.org/$1";
 		push @mirrors, "https://mirror.aarnet.edu.au/pub/apache/$1";
 		push @mirrors, "https://mirror.csclub.uwaterloo.ca/apache/$1";
@@ -204,11 +206,16 @@ sub cleanup
 		push @mirrors, "ftp://apache.cs.utah.edu/apache.org/$1";
 		push @mirrors, "ftp://apache.mirrors.ovh.net/ftp.apache.org/dist/$1";
 	} elsif ($mirror =~ /^\@GITHUB\/(.+)$/) {
+		my $dir = $1;
+		my $i = 0;
+		push @mirrors, "https://cdn.jsdelivr.net/gh/". $dir =~ s{\/}{++$i == 2 ? '@' : $&}ger;
 		# give github a few more tries (different mirrors)
 		for (1 .. 5) {
-			push @mirrors, "https://raw.githubusercontent.com/$1";
+			push @mirrors, "https://raw.githubusercontent.com/$dir";
 		}
 	} elsif ($mirror =~ /^\@GNU\/(.+)$/) {
+		push @mirrors, "https://mirrors.cloud.tencent.com/gnu/$1";
+		push @mirrors, "https://mirrors.bfsu.edu.cn/gnu/$1";
 		push @mirrors, "https://mirror.csclub.uwaterloo.ca/gnu/$1";
 		push @mirrors, "https://mirror.netcologne.de/gnu/$1";
 		push @mirrors, "http://ftp.kddilabs.jp/GNU/gnu/$1";
@@ -234,6 +241,7 @@ sub cleanup
 			push @extra, "$extra[0]/longterm/v$1";
 		}
 		foreach my $dir (@extra) {
+			push @mirrors, "https://mirrors.ustc.edu.cn/kernel.org/$dir";
 			push @mirrors, "https://cdn.kernel.org/pub/$dir";
 			push @mirrors, "https://mirror.rackspace.com/kernel.org/pub/$dir";
 			push @mirrors, "https://download.xs4all.nl/ftp.kernel.org/pub/$dir";
@@ -244,6 +244,7 @@ sub cleanup
 			push @mirrors, "ftp://www.mirrorservice.org/sites/ftp.kernel.org/pub/$dir";
 		}
 	} elsif ($mirror =~ /^\@GNOME\/(.+)$/) {
+		push @mirrors, "https://mirrors.ustc.edu.cn/gnome/sources/$1";
 		push @mirrors, "https://mirror.csclub.uwaterloo.ca/gnome/sources/$1";
 		push @mirrors, "http://ftp.acc.umu.se/pub/GNOME/sources/$1";
 		push @mirrors, "http://ftp.kaist.ac.kr/gnome/sources/$1";
