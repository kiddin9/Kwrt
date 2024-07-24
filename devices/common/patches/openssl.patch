--- a/package/libs/openssl/Config.in
+++ b/package/libs/openssl/Config.in
@@ -4,7 +4,7 @@ comment "Build Options"
 
 config OPENSSL_OPTIMIZE_SPEED
 	bool
-	default y if x86_64 || i386
+	default y
 	prompt "Enable optimization for speed instead of size"
 	select OPENSSL_WITH_ASM
 	help
@@ -38,9 +38,9 @@ config OPENSSL_WITH_ASM
 
 config OPENSSL_WITH_SSE2
 	bool
-	default y if !TARGET_x86_legacy && !TARGET_x86_geode
+	default y if x86_64 || i386 && !TARGET_x86_legacy
 	prompt "Enable use of x86 SSE2 instructions"
-	depends on OPENSSL_WITH_ASM && i386
+	depends on OPENSSL_WITH_ASM && x86_64 || i386
 	help
 		Use of SSE2 instructions greatly increase performance with a
 		minimum increase in package size, but it will bring no benefit
@@ -133,7 +133,7 @@ config OPENSSL_WITH_CHACHA_POLY1305
 
 config OPENSSL_PREFER_CHACHA_OVER_GCM
 	bool
-	default y if !x86_64 && !aarch64
+	default y if !x86_64
 	prompt "Prefer ChaCha20-Poly1305 over AES-GCM by default"
 	depends on OPENSSL_WITH_CHACHA_POLY1305
 	help
