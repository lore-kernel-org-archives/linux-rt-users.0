From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 2/4] android: rename arch from bionic to android
Date: Wed, 21 Oct 2015 15:49:00 +0200
Message-ID: <1445435342-16969-3-git-send-email-haustad@cisco.com>
References: <1445435342-16969-1-git-send-email-haustad@cisco.com>
Cc: Henrik Austad <henrik@austad.us>, John Kacur <jkacur@redhat.com>,
	Henrik Austad <haustad@cisco.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-2.cisco.com ([173.38.203.52]:22905 "EHLO
	aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbbJUNxQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Oct 2015 09:53:16 -0400
In-Reply-To: <1445435342-16969-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Henrik Austad <henrik@austad.us>

Bionic is the libc implementation used in Android and should not be
confused with the architecture.

Cc: John Kacur <jkacur@redhat.com>
Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 Makefile                  |  2 +-
 src/arch/android/Makefile | 23 +++++++++++++++++++++++
 src/arch/bionic/Makefile  | 23 -----------------------
 3 files changed, 24 insertions(+), 24 deletions(-)
 create mode 100644 src/arch/android/Makefile
 delete mode 100644 src/arch/bionic/Makefile

diff --git a/Makefile b/Makefile
index c0801db45ced..804eb6824f0e 100644
--- a/Makefile
+++ b/Makefile
@@ -70,7 +70,7 @@ endif
 
 # Include any arch specific makefiles here. Make sure that TARGETS aren't
 # evaluated until AFTER this include
-include src/arch/bionic/Makefile
+include src/arch/android/Makefile
 TARGETS = $(sources:.c=)
 
 VPATH	= src/cyclictest:
diff --git a/src/arch/android/Makefile b/src/arch/android/Makefile
new file mode 100644
index 000000000000..8e169f080adb
--- /dev/null
+++ b/src/arch/android/Makefile
@@ -0,0 +1,23 @@
+
+# Bionic (android) does not have:
+# - pthread barriers
+# - pthread_[gs]etaffinity
+#
+# Typically see something like "aarch64-linux-android"
+ifeq (android,$(ostype))
+	USE_BIONIC := 1
+	CFLAGS += -DNO_PTHREAD_BARRIER
+	CFLAGS += -DNO_PTHREAD_SETAFFINITY
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
index 8e169f080adb..000000000000
--- a/src/arch/bionic/Makefile
+++ /dev/null
@@ -1,23 +0,0 @@
-
-# Bionic (android) does not have:
-# - pthread barriers
-# - pthread_[gs]etaffinity
-#
-# Typically see something like "aarch64-linux-android"
-ifeq (android,$(ostype))
-	USE_BIONIC := 1
-	CFLAGS += -DNO_PTHREAD_BARRIER
-	CFLAGS += -DNO_PTHREAD_SETAFFINITY
-
-	LDFLAGS += -pie
-# -lrt and -lpthread is in standard bionic library, no standalone library
-	LIBS := $(filter-out -lrt,$(LIBS))
-	LIBS := $(filter-out -lpthread,$(LIBS))
