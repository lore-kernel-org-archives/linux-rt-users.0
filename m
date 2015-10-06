From: John Kacur <jkacur@redhat.com>
Subject: Move android functionality into it's own arch Makefile
Date: Tue, 6 Oct 2015 09:09:50 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510060907550.14006@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37452 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbbJFHJx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2015 03:09:53 -0400
Received: by wicfx3 with SMTP id fx3so144946887wic.0
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Oct 2015 00:09:52 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From c9950551308f01768570eb4a04a2d0b221ff7818 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Tue, 6 Oct 2015 07:44:07 +0200
Subject: [PATCH 2/2] Bionic: Move android functionality into it's own arch
 Makefile

- Make the Makefile more readable by moving android functionality to it's
own Makefile.
- Don't evaluate TARGETS until after including arch Makefiles

Signed-off-by: John Kacur <jkacur@redhat.com>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 Makefile                 | 30 ++++--------------------------
 src/arch/bionic/Makefile | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 26 deletions(-)
 create mode 100644 src/arch/bionic/Makefile

diff --git a/Makefile b/Makefile
index 4c4a06e1fc6e..5e3648da6bc0 100644
--- a/Makefile
+++ b/Makefile
@@ -16,8 +16,6 @@ sources = cyclictest.c \
 	  sigwaittest.c \
 	  svsematest.c
 
-TARGETS = $(sources:.c=)
-
 LIBS	= -lrt -lpthread
 RTTESTLIB = -lrttest -L$(OBJDIR)
 EXTRA_LIBS ?= -ldl	# for get_cpu
@@ -70,30 +68,10 @@ ifdef HAVE_PARSE_CPUSTRING_ALL
 endif
 endif
 
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
-
-# BIONIC does not support PI, barriers and have different files in
-# include/. This means that currently, only these binaries will compile
-# and link properly:
-# - cyclictest
-# - hackbench
-# - hwlatdetect
-	sources := cyclictest.c hackbench.c hwlatdetect.c
-	TARGETS = $(sources:.c=)
-endif
+# Include any arch specific makefiles here. Make sure that TARGETS aren't
+# evaluated until AFTER this include
+include src/arch/bionic/Makefile
+TARGETS = $(sources:.c=)
 
 VPATH	= src/cyclictest:
 VPATH	+= src/signaltest:
diff --git a/src/arch/bionic/Makefile b/src/arch/bionic/Makefile
new file mode 100644
index 000000000000..410d2c9c7c37
--- /dev/null
+++ b/src/arch/bionic/Makefile
@@ -0,0 +1,25 @@
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
+# - hwlatdetect
+	sources := cyclictest.c hackbench.c hwlatdetect.c
+endif
+
-- 
2.4.3

