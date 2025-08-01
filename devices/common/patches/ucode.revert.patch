From 39972c47eb9e367ca8e8611b1d1de4669df2ff92 Mon Sep 17 00:00:00 2001
From: Felix Fietkau <nbd@nbd.name>
Date: Fri, 18 Jul 2025 12:22:10 +0200
Subject: [PATCH] ucode: update to Git HEAD (2025-07-18)

54b00e3b1fa9 ubus: fix double registry clear on disconnect
69521b55855c ubus: fix use-after-free on deferred request reply() method
f499de690c33 Merge pull request #298 from nbd168/ubus-fixes
22e8c16d9deb debug: fix crash when passing tagged string to getinfo()
2c9eea5174d6 ubus: use ucv_resource_create_ex for connections/channels
0a4cf4b7e71a ubus: use ucv_resource_create_ex for for ubus.request resources
99ee75a69cd3 ubus: use ucv_resource_create_ex for ubus.deferred resources
f085a42b977f ubus: use ucv_resource_create_ex for objects
94ad17d13a0d ubus: use ucv_resource_create_ex for ubus.notify resources
a3fa47fdda3e ubus: use ucv_resource_create_ex for ubus.listener resources
9ab5fa869dec ubus: use ucv_resource_create_ex for ubus.subscriber resources
43dd5716db84 Merge pull request #300 from nbd168/ubus-gc
be92ebd70633 CI: debian: install cmake package
fd202fd40bd1 socket: respect port argument in sockinst.connect()
767c209b917b socket: properly handle async `connect(2)` errors in socket.connect()
37ac8f112af6 socket: improve port argument validation in sockinst.connect()
5b3b6b789b9c ubus: fix refcount issue in uc_ubus_object_notify
cdcd50ad0408 Merge pull request #305 from nbd168/ubus-fix
f682ac2f6b82 program: add bytecode version to program header flags
af411d8101b2 vm: implement PVAL opcode
afdfffb61258 vm: support initiating method calls with I_CALL/I_QCALL opcodes
5d680425db40 compiler: stop emitting I_MCALL/I_QMCALL opcodes
a616feed39eb compiler, vm: rework optional chaining and function call semantics
d29ec45ab107 Merge pull request #306 from jow-/optional-chaining-short-circuiting
0946a4fb20b8 vm: adjust JMPNT opcode behavior
6f8291f73757 compiler: improve assignment lhs expression checks
22e1346a7bda Merge pull request #308 from jow-/compiler-lhs-check-fixes
cf846c4a11d4 vm: properly handle modulo by zero
4d81e6c13506 resolv: add documentation and fix clobbering ns strings
20ee2dabd243 debian/changelog: v0.0.20250529
82426d1a02e2 Merge pull request #314 from jow-/resolv-fix313
50d303c8309d ubus: add support for automatically subscribing to objects
fdbf73da4136 Merge pull request #312 from nbd168/ubus-subscribe
5a0d21d59f88 vm: export function for converting exception to ucode value
aaf712eb4fb4 uloop: add guard() function
693af2b61b52 ubus: add guard() function

Signed-off-by: Felix Fietkau <nbd@nbd.name>
(cherry picked from commit c39a09686e3d562367ab3a47da6a005eebaf5ca2)
---
 package/utils/ucode/Makefile                  |  6 ++---
 ...-double-registry-clear-on-disconnect.patch | 26 ------------------
 ...er-free-on-deferred-request-reply-me.patch | 27 -------------------
 3 files changed, 3 insertions(+), 56 deletions(-)
 delete mode 100644 package/utils/ucode/patches/010-ubus-fix-double-registry-clear-on-disconnect.patch
 delete mode 100644 package/utils/ucode/patches/020-ubus-fix-use-after-free-on-deferred-request-reply-me.patch

diff --git a/package/utils/ucode/Makefile b/package/utils/ucode/Makefile
index ed155af02f3d60..8ae1b91c1f213a 100644
--- a/package/utils/ucode/Makefile
+++ b/package/utils/ucode/Makefile
@@ -12,9 +12,9 @@ PKG_RELEASE:=1
 
 PKG_SOURCE_PROTO:=git
 PKG_SOURCE_URL=https://github.com/jow-/ucode.git
-PKG_SOURCE_DATE:=2025-05-11
-PKG_SOURCE_VERSION:=d5b3a9dc1091dd28cf6f0f60cd34fc322ef27717
-PKG_MIRROR_HASH:=cd8af9d5ac28e2530b56015a3f2fcf6f36062546cac8b23a5f7b75b367209b54
+PKG_SOURCE_DATE:=2025-07-18
+PKG_SOURCE_VERSION:=3f64c8089bf3ea4847c96b91df09fbfcaec19e1d
+PKG_MIRROR_HASH:=55fbff7c527e1fadbda2e038636f39419649841ee63a5f3cdb50b9714b13420c
 PKG_MAINTAINER:=Jo-Philipp Wich <jo@mein.io>
 PKG_LICENSE:=ISC
 
diff --git a/package/utils/ucode/patches/010-ubus-fix-double-registry-clear-on-disconnect.patch b/package/utils/ucode/patches/010-ubus-fix-double-registry-clear-on-disconnect.patch
deleted file mode 100644
index 70b6a99be7958b..00000000000000
--- a/package/utils/ucode/patches/010-ubus-fix-double-registry-clear-on-disconnect.patch
+++ /dev/null
@@ -1,26 +0,0 @@
-From: Felix Fietkau <nbd@nbd.name>
-Date: Fri, 9 May 2025 11:57:57 +0200
-Subject: [PATCH] ubus: fix double registry clear on disconnect
-
-Set c->registry_index to -1 in order to ensure that the resource free path
-does not clobber registry items of unrelated connections.
-
-Signed-off-by: Felix Fietkau <nbd@nbd.name>
----
-
---- a/lib/ubus.c
-+++ b/lib/ubus.c
-@@ -2375,8 +2375,11 @@ uc_ubus_channel_disconnect_cb(struct ubu
- 		c->ctx.sock.fd = -1;
- 	}
- 
--	if (c->registry_index >= 0)
--		connection_reg_clear(c->vm, c->registry_index);
-+	if (c->registry_index >= 0) {
-+		int idx = c->registry_index;
-+		c->registry_index = -1;
-+		connection_reg_clear(c->vm, idx);
-+	}
- }
- 
- static uc_value_t *
diff --git a/package/utils/ucode/patches/020-ubus-fix-use-after-free-on-deferred-request-reply-me.patch b/package/utils/ucode/patches/020-ubus-fix-use-after-free-on-deferred-request-reply-me.patch
deleted file mode 100644
index 142595a5bdbb5e..00000000000000
--- a/package/utils/ucode/patches/020-ubus-fix-use-after-free-on-deferred-request-reply-me.patch
+++ /dev/null
@@ -1,27 +0,0 @@
-From: Felix Fietkau <nbd@nbd.name>
-Date: Mon, 12 May 2025 12:43:44 +0200
-Subject: [PATCH] ubus: fix use-after-free on deferred request reply() method
-
-Hold a reference to the defer resource as long as it is still needed
-
-Signed-off-by: Felix Fietkau <nbd@nbd.name>
----
-
---- a/lib/ubus.c
-+++ b/lib/ubus.c
-@@ -636,6 +636,7 @@ uc_ubus_call_user_cb(uc_ubus_deferred_t
- 	uc_value_t *this, *func;
- 
- 	request_reg_get(defer->vm, defer->registry_index, &this, &func, NULL, NULL);
-+	ucv_get(this);
- 
- 	if (ucv_is_callable(func)) {
- 		uc_vm_stack_push(defer->vm, ucv_get(this));
-@@ -648,6 +649,7 @@ uc_ubus_call_user_cb(uc_ubus_deferred_t
- 	}
- 
- 	request_reg_clear(defer->vm, defer->registry_index);
-+	ucv_put(this);
- }
- 
- static void
