From: John Kacur <jkacur@redhat.com>
Subject: [PATCH rt-tests RFC 4/6] Makefile: Support user supplied CFLAGS and LDFLAGS
Date: Thu, 22 Mar 2012 02:14:04 +0100
Message-ID: <1332378846-18104-5-git-send-email-jkacur@redhat.com>
References: <1332378846-18104-1-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <C.Emde@osadl.org>,
	Darren Hart <dvhart@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nicholas McGuire <der.herr@hofr.at>,
	John Kacur <jkacur@redhat.com>,
	Denys Dmytriyenko <denis@denix.org>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57769 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030377Ab2CVBPt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 21:15:49 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1014845wgb.1
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 18:15:48 -0700 (PDT)
In-Reply-To: <1332378846-18104-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Darren Hart <dvhart@linux.intel.com>

Accept user supplied CFLAGS and LDFLAGS, overwriting the
Makefile supplied versions. This can cause the build to
fail if the user does not provide at least what the Makefile
defines, but so be it.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
CC: Clark Williams <williams@redhat.com>
CC: John Kacur <jkacur@redhat.com>
CC: Denys Dmytriyenko <denis@denix.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
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
1.7.7.6

