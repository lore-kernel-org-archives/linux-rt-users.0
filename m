From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH v2 2/4] Android: rename arch from bionic to android
Date: Wed, 21 Oct 2015 21:00:09 +0200
Message-ID: <1445454011-18839-3-git-send-email-haustad@cisco.com>
References: <1445454011-18839-1-git-send-email-haustad@cisco.com>
Cc: John Kacur <jkacur@redhat.com>, Henrik Austad <henrik@austad.us>,
	Henrik Austad <haustad@cisco.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-2.cisco.com ([173.38.203.52]:13993 "EHLO
	aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566AbbJUTE1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Oct 2015 15:04:27 -0400
In-Reply-To: <1445454011-18839-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Henrik Austad <henrik@austad.us>

Bionic is the libc implementation used in Android and should not be
confused with the architecture.

Cc: John Kacur <jkacur@redhat.com>
Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 Makefile                  |  3 +--
 src/arch/android/Makefile | 22 ++++++++++++++++++++++
 src/arch/bionic/Makefile  | 22 ----------------------
 3 files changed, 23 insertions(+), 24 deletions(-)
 create mode 100644 src/arch/android/Makefile
 delete mode 100644 src/arch/bionic/Makefile

diff --git a/Makefile b/Makefile
index 703333fe1b42..86a5c4b211a0 100644
--- a/Makefile
+++ b/Makefile
@@ -69,8 +69,7 @@ ifdef HAVE_PARSE_CPUSTRING_ALL
 endif
 endif
 
-# Include any arch specific makefiles here.
-include src/arch/bionic/Makefile
+include src/arch/android/Makefile
 
 VPATH	= src/cyclictest:
 VPATH	+= src/signaltest:
diff --git a/src/arch/android/Makefile b/src/arch/android/Makefile
new file mode 100644
index 000000000000..e25f67203e5a
--- /dev/null
+++ b/src/arch/android/Makefile
@@ -0,0 +1,22 @@
+
+# Bionic (android) does not have:
+# - pthread barriers
+# - pthread_[gs]etaffinity
+#
+# Typically see something like "aarch64-linux-android"
+ifeq (android,$(ostype))
+	USE_BIONIC := 1
+	CFLAGS += -DPTHREAD_BIONIC
+
+	LDFLAGS += -pie
+# -lrt and -lpthread is in standard bionic library, no standalone library
+	LIBS := $(filter-out -lrt,$(LIBS))
+	LIBS := $(filter-out -lpthread,$(LIBS))
+
+# BIONIC does not support PI, barriers and has different files in
+# include/. This means that currently, only these binaries will compile
+# and link properly:
+# - cyclictest
+# - hackbench
+	sources := cyclictest.c hackbench.c
+endif
diff --git a/src/arch/bionic/Makefile b/src/arch/bionic/Makefile
deleted file mode 100644
index e25f67203e5a..000000000000
--- a/src/arch/bionic/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-
-# Bionic (android) does not have:
-# - pthread barriers
-# - pthread_[gs]etaffinity
-#
-# Typically see something like "aarch64-linux-android"
-ifeq (android,$(ostype))
-	USE_BIONIC := 1
-	CFLAGS += -DPTHREAD_BIONIC
-
-	LDFLAGS += -pie
-# -lrt and -lpthread is in standard bionic library, no standalone library
-	LIBS := $(filter-out -lrt,$(LIBS))
-	LIBS := $(filter-out -lpthread,$(LIBS))
