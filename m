From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] RFC - rt-tools: Detect whether numa is available at build time
Date: Sat, 26 May 2012 01:39:49 +0200
Message-ID: <1337989189-17563-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47857 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308Ab2EYXju (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 May 2012 19:39:50 -0400
Received: by bkcji2 with SMTP id ji2so1134867bkc.19
        for <linux-rt-users@vger.kernel.org>; Fri, 25 May 2012 16:39:49 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a preliminary hack, I need to clean it up a little, but incase you
want to give it a try, here is the alpha version.

Note - I stole this methodology from tools/perf

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                 |   33 +++++++++++++++++++++++++++------
 config/feature-tests.mak |    8 ++++++++
 config/utilities.mak     |    7 +++++++
 3 files changed, 42 insertions(+), 6 deletions(-)
 create mode 100644 config/feature-tests.mak
 create mode 100644 config/utilities.mak

diff --git a/Makefile b/Makefile
index 3a82407..33f5027 100644
--- a/Makefile
+++ b/Makefile
@@ -16,9 +16,6 @@ srcdir	?= $(prefix)/src
 
 machinetype = $(shell $(CC) -dumpmachine | \
     sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
-ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
-NUMA 	:= 1
-endif
 
 CFLAGS ?= -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
 LDFLAGS ?=
@@ -31,9 +28,33 @@ else
 	CFLAGS	+= -O0 -g
 endif
 
-ifeq ($(NUMA),1)
-	CFLAGS += -DNUMA
-	NUMA_LIBS = -lnuma
+ifeq ("$(origin O)", "command line")
+	OUTPUT := $(O)/
+endif
+
+ifneq ($(OUTPUT),)
+# check that the output directory actually exists
+OUTDIR := $(shell cd $(OUTPUT) && /bin/pwd)
+$(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
+endif
+
+include config/utilities.mak
+include config/feature-tests.mak
+
+ifeq ($(NUMA),0)
+	NO_NUMA=0
+endif
+
+ifdef NO_NUMA
+	CFLAGS += -DNO_NUMA_SUPPORT
+else
+	ifneq ($(call try-cc,$(SOURCE_NUMA),-lnuma),y)
+		msg := $(warning numa not found. Install numactl-devel to build with numa support);
+		CFLAGS += -DNO_NUMA_SUPPORT
+	else
+		CFLAGS += -DNUMA
+		NUMA_LIBS = -lnuma
+	endif
 endif
 
 VPATH	= src/cyclictest:
diff --git a/config/feature-tests.mak b/config/feature-tests.mak
new file mode 100644
index 0000000..8fb61ea
--- /dev/null
+++ b/config/feature-tests.mak
@@ -0,0 +1,8 @@
+ifndef NO_NUMA
+define SOURCE_NUMA
+int main(void)
+{
+	return numa_available();
+}
+endef
+endif
diff --git a/config/utilities.mak b/config/utilities.mak
new file mode 100644
index 0000000..da7c434
--- /dev/null
+++ b/config/utilities.mak
@@ -0,0 +1,7 @@
+# try-cc
+# Usage: option = $(call try-cc, source-to-build, cc-options)
+try-cc = $(shell sh -c						  \
+	'TMP="$(OUTPUT)$(TMPOUT).$$$$";				  \
+	 echo "$(1)" |						  \
+	 $(CC) -x c - $(2) -o "$$TMP" > /dev/null 2>&1 && echo y; \
+	 rm -f "$$TMP"')
-- 
1.7.7.6

