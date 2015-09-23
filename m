From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] build: Generate .o, .a, and .d files in bld dir
Date: Thu, 24 Sep 2015 00:33:59 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509240033130.29601@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33691 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbbIWWeB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Sep 2015 18:34:01 -0400
Received: by wiclk2 with SMTP id lk2so4488458wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Sep 2015 15:34:00 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 19ddcbd5dc74e4d0ef212437b8a355afd861b938 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Thu, 24 Sep 2015 00:21:30 +0200
Subject: [PATCH 2/2] build: Generate .o, .a, and .d files in bld dir

When building rt-tests, object files, libs and .d (dependencies) were
all generated in the base directory. Instead, place all of these
build files in a dir called bld. The final programs are still in the
basedir

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile       | 39 +++++++++++++++++++++------------------
 bld/.gitignore |  0
 2 files changed, 21 insertions(+), 18 deletions(-)
 create mode 100644 bld/.gitignore

diff --git a/Makefile b/Makefile
index 4c0c096eb919..87946fb5dd4e 100644
--- a/Makefile
+++ b/Makefile
@@ -2,6 +2,8 @@ VERSION = 0.94
 CC=$(CROSS_COMPILE)gcc
 AR=$(CROSS_COMPILE)ar
 
+OBJDIR = bld
+
 HAVE_NPTL ?= yes
 
 ifeq ($(HAVE_NPTL),yes)
@@ -14,7 +16,7 @@ sources += signaltest.c ptsematest.c sigwaittest.c svsematest.c sendme.c \
 TARGETS = $(sources:.c=)
 
 LIBS	= -lrt -lpthread
-RTTESTLIB = -lrttest -L.
+RTTESTLIB = -lrttest -L$(OBJDIR)
 EXTRA_LIBS ?= -ldl	# for get_cpu
 DESTDIR	?=
 prefix  ?= /usr/local
@@ -87,58 +89,59 @@ VPATH	+= src/backfire:
 VPATH	+= src/lib:
 VPATH	+= src/hackbench:
 
-%.o: %.c
-	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS)
+$(OBJDIR)/%.o: %.c
+	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS) -o $@
 
 # Pattern rule to generate dependency files from .c files
-%.d: %.c
+$(OBJDIR)/%.d: %.c
 	@$(CC) -MM $(CFLAGS) $(CPPFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@ || rm -f $@
 
 .PHONY: all
 all: $(TARGETS) hwlatdetect
 
 # Include dependency files, automatically generate them if needed.
--include $(sources:.c=.d)
+-include $(addprefix $(OBJDIR)/,$(sources:.c=.d))
 
-cyclictest: cyclictest.o librttest.a
+cyclictest: $(OBJDIR)/cyclictest.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(NUMA_LIBS)
 
-signaltest: signaltest.o librttest.a
+signaltest: $(OBJDIR)/signaltest.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
-pi_stress: pi_stress.o librttest.a
+pi_stress: $(OBJDIR)/pi_stress.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
 hwlatdetect:  src/hwlatdetect/hwlatdetect.py
 	chmod +x src/hwlatdetect/hwlatdetect.py
 	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
 
-rt-migrate-test: rt-migrate-test.o librttest.a
+rt-migrate-test: $(OBJDIR)/rt-migrate-test.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
-ptsematest: ptsematest.o librttest.a
+ptsematest: $(OBJDIR)/ptsematest.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
 
-sigwaittest: sigwaittest.o librttest.a
+sigwaittest: $(OBJDIR)/sigwaittest.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
 
-svsematest: svsematest.o librttest.a
+svsematest: $(OBJDIR)/svsematest.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
 
-pmqtest: pmqtest.o librttest.a
+pmqtest: $(OBJDIR)/pmqtest.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
 
-sendme: sendme.o librttest.a
+sendme: $(OBJDIR)/sendme.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
 
-pip_stress: pip_stress.o librttest.a
+pip_stress: $(OBJDIR)/pip_stress.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
-hackbench: hackbench.o
+hackbench: $(OBJDIR)/hackbench.o
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
 
-librttest.a: rt-utils.o error.o rt-get_cpu.o rt-sched.o
-	$(AR) rcs librttest.a $^
+LIBOBJS =$(addprefix $(OBJDIR)/,error.o rt-get_cpu.o rt-sched.o rt-utils.o)
+$(OBJDIR)/librttest.a: $(LIBOBJS)
+	$(AR) rcs $@ $^
 
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec *.d *.a
 CLEANUP += $(if $(wildcard .git), ChangeLog)
diff --git a/bld/.gitignore b/bld/.gitignore
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.4.3

