From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/5] rt-tests: Automatically generate dependencies.
Date: Wed, 27 Jan 2010 21:24:28 +0100
Message-ID: <1264623868-23595-6-git-send-email-jkacur@redhat.com>
References: <1264623868-23595-1-git-send-email-jkacur@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Carsten Emde <C.Emde@osadl.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35046 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab0A0UYn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jan 2010 15:24:43 -0500
In-Reply-To: <1264623868-23595-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Automatically generate dependencies. This will tell the make file that
cyclictest is dependent on rt_numa.h for example, and that if a change
is made there, then cyclictest needs to be remade.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 6156c03..4be0838 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,10 @@
 VERSION_STRING = 0.63
 
-TARGETS	= cyclictest signaltest pi_stress \
-	  rt-migrate-test ptsematest sigwaittest svsematest \
-	  sendme pip
+sources = cyclictest.c signaltest.c pi_stress.c rt-migrate-test.c	\
+	  ptsematest.c sigwaittest.c svsematest.c sendme.c pip.c
+
+TARGETS = $(sources:.c=)
+
 LIBS 	= -lrt -lpthread
 EXTRA_LIBS ?= -ldl	# for get_cpu
 DESTDIR	?=
@@ -39,9 +41,19 @@ VPATH	+= src/lib
 %.o: %.c
 	$(CC) -D VERSION_STRING=$(VERSION_STRING) -c $< $(CFLAGS)
 
+# Pattern rule to generate dependency files from .c files
+%.d: %.c
+	@set -e; rm -f $@; \
+	$(CC) -MM $(CFLAGS) $< > $@.$$$$; \
+	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
+	rm -f $@.$$$$
+
 .PHONY: all
 all: $(TARGETS) hwlatdetect
 
+# Include dependency files, automatically generate them if needed.
+-include $(sources:.c=.d)
+
 cyclictest: cyclictest.o rt-utils.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(NUMA_LIBS)
 
@@ -73,7 +85,7 @@ sendme: sendme.o rt-utils.o rt-get_cpu.o
 pip: pip.o error.o rt-utils.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
-CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec
+CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec *.d
 CLEANUP += $(if $(wildcard .git), ChangeLog)
 
 .PHONY: clean
-- 
1.6.6

