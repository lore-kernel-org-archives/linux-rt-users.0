From: Darren Hart <dvhart@linux.intel.com>
Subject: [PATCH 1/3] rt-tests: Support user supplied CFLAGS and LDFLAGS
Date: Tue, 20 Mar 2012 12:05:01 -0700
Message-ID: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
Cc: Darren Hart <dvhart@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Denys Dmytriyenko <denis@denix.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:32691 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756179Ab2CTTHF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2012 15:07:05 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Accept user supplied CFLAGS and LDFLAGS, overwriting the
Makefile supplied versions. This can cause the build to
fail if the user does not provide at least what the Makefile
defines, but so be it.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
CC: Clark Williams <williams@redhat.com>
CC: John Kacur <jkacur@redhat.com>
CC: Denys Dmytriyenko <denis@denix.org>
---
 Makefile |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 4038dcc..e1edf6c 100644
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,8 @@ ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
 NUMA 	:= 1
 endif
 
-CFLAGS = -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
+CFLAGS ?= -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
+LDFLAGS ?=
 
 PYLIB  := $(shell python -c 'import distutils.sysconfig;  print distutils.sysconfig.get_python_lib()')
 
@@ -61,41 +62,41 @@ all: $(TARGETS) hwlatdetect
 -include $(sources:.c=.d)
 
 cyclictest: cyclictest.o rt-utils.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(NUMA_LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(NUMA_LIBS)
 
 signaltest: signaltest.o rt-utils.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
 pi_stress: pi_stress.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
 hwlatdetect:  src/hwlatdetect/hwlatdetect.py
 	chmod +x src/hwlatdetect/hwlatdetect.py
 	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
 
 rt-migrate-test: rt-migrate-test.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
 ptsematest: ptsematest.o rt-utils.o rt-get_cpu.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
 sigwaittest: sigwaittest.o rt-utils.o rt-get_cpu.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
 svsematest: svsematest.o rt-utils.o rt-get_cpu.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
 pmqtest: pmqtest.o rt-utils.o rt-get_cpu.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
 sendme: sendme.o rt-utils.o rt-get_cpu.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
 pip_stress: pip_stress.o error.o rt-utils.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
 hackbench: hackbench.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec *.d
 CLEANUP += $(if $(wildcard .git), ChangeLog)
-- 
1.7.6.5

