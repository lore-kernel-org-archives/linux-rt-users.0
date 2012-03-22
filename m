From: John Kacur <jkacur@redhat.com>
Subject: [PATCH rt-tests RFC 5/6] Makefile: Introduce a static library
Date: Thu, 22 Mar 2012 02:14:05 +0100
Message-ID: <1332378846-18104-6-git-send-email-jkacur@redhat.com>
References: <1332378846-18104-1-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <C.Emde@osadl.org>,
	Darren Hart <dvhart@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nicholas McGuire <der.herr@hofr.at>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42549 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030377Ab2CVBPv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 21:15:51 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq7so126247wib.1
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 18:15:50 -0700 (PDT)
In-Reply-To: <1332378846-18104-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Introduce a static libray.
Currently it contains the functions in rt-utils.c error.c and rt-get_cpu.c

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index e1edf6c..ff697ca 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,7 @@ sources = cyclictest.c signaltest.c pi_stress.c rt-migrate-test.c	\
 
 TARGETS = $(sources:.c=)
 
-LIBS 	= -lrt -lpthread
+LIBS 	= -lrt -lpthread -lrttest -L.
 EXTRA_LIBS ?= -ldl	# for get_cpu
 DESTDIR	?=
 prefix  ?= /usr/local
@@ -61,10 +61,10 @@ all: $(TARGETS) hwlatdetect
 # Include dependency files, automatically generate them if needed.
 -include $(sources:.c=.d)
 
-cyclictest: cyclictest.o rt-utils.o
+cyclictest: cyclictest.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(NUMA_LIBS)
 
-signaltest: signaltest.o rt-utils.o
+signaltest: signaltest.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
 pi_stress: pi_stress.o
@@ -77,28 +77,31 @@ hwlatdetect:  src/hwlatdetect/hwlatdetect.py
 rt-migrate-test: rt-migrate-test.o
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
-ptsematest: ptsematest.o rt-utils.o rt-get_cpu.o
+ptsematest: ptsematest.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
-sigwaittest: sigwaittest.o rt-utils.o rt-get_cpu.o
+sigwaittest: sigwaittest.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
-svsematest: svsematest.o rt-utils.o rt-get_cpu.o
+svsematest: svsematest.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
-pmqtest: pmqtest.o rt-utils.o rt-get_cpu.o
+pmqtest: pmqtest.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
-sendme: sendme.o rt-utils.o rt-get_cpu.o
+sendme: sendme.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
-pip_stress: pip_stress.o error.o rt-utils.o
+pip_stress: pip_stress.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
 hackbench: hackbench.o
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
-CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec *.d
+librttest.a: rt-utils.o error.o rt-get_cpu.o
+	$(AR) rcs librttest.a rt-utils.o error.o rt-get_cpu.o
+
+CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec *.d *.a
 CLEANUP += $(if $(wildcard .git), ChangeLog)
 
 .PHONY: clean
-- 
1.7.7.6

