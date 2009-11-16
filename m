From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] rt-tests: Makefile - Change FLAGS to CFLAGS
Date: Mon, 16 Nov 2009 19:40:12 +0100
Message-ID: <1258396814-12929-2-git-send-email-jkacur@redhat.com>
References: <1258396814-12929-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:44546 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbZKPSkM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Nov 2009 13:40:12 -0500
Received: by fxm21 with SMTP id 21so3019125fxm.21
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Nov 2009 10:40:17 -0800 (PST)
In-Reply-To: <1258396814-12929-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Change FLAGS to CFLAGS as this is the standard

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 6a56a65..9685587 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@ VERSION_STRING = 0.53
 
 TARGETS	= cyclictest signaltest classic_pi pi_stress \
 	  hwlatdetect rt-migrate-test
-FLAGS	= -Wall -Wno-nonnull -O2
+CFLAGS	= -Wall -Wno-nonnull -O2
 LIBS 	= -lpthread -lrt
 DESTDIR	?=
 prefix  ?= /usr/local
@@ -12,23 +12,23 @@ mandir	?= $(prefix)/share/man/man8
 all: $(TARGETS)
 
 cyclictest: src/cyclictest/cyclictest.c
-	$(CC) $(FLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
 
 signaltest: src/signaltest/signaltest.c
-	$(CC) $(FLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
 
 classic_pi: src/pi_tests/classic_pi.c
-	$(CC) $(FLAGS) -D_GNU_SOURCE -D VERSION_STRING=\"$(VERSION_STRING)\" $^ -o $@ $(LIBS)
+	$(CC) $(CFLAGS) -D_GNU_SOURCE -D VERSION_STRING=\"$(VERSION_STRING)\" $^ -o $@ $(LIBS)
 
 pi_stress:  src/pi_tests/pi_stress.c
-	$(CC) $(FLAGS) -D_GNU_SOURCE -D VERSION_STRING=\"$(VERSION_STRING)\" $^ -o $@ $(LIBS)
+	$(CC) $(CFLAGS) -D_GNU_SOURCE -D VERSION_STRING=\"$(VERSION_STRING)\" $^ -o $@ $(LIBS)
 
 hwlatdetect:  src/hwlatdetect/hwlatdetect.py
 	chmod +x src/hwlatdetect/hwlatdetect.py
 	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
 
 rt-migrate-test: src/rt-migrate-test/rt-migrate-test.c
-	$(CC) $(FLAGS) -D_GNU_SOURCE -D VERSION_STRING=\"$(VERSION_STRING)\" $^ -o $@ $(LIBS)
+	$(CC) $(CFLAGS) -D_GNU_SOURCE -D VERSION_STRING=\"$(VERSION_STRING)\" $^ -o $@ $(LIBS)
 
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec
 CLEANUP += $(if $(wildcard .git), ChangeLog)
-- 
1.6.2.5

