From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/6] pi_stress clean-ups, fix hang.
Date: Mon, 14 Sep 2009 16:34:35 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909141633390.4675@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41140 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbZINOef (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2009 10:34:35 -0400
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8EEYdWo007684
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2009 10:34:39 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 2b4e7ebb087d6454bba6a456087c4a07728b172c Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Wed, 2 Sep 2009 13:19:01 +0200
Subject: [PATCH] Remove the pi_tests Makefile since it is deadcode.

The make process for all of the programs including cyclictest are driven
by the Makefile in the root directory. This Makefile here, is no longer
maintained, so remove it.
---
 src/pi_tests/Makefile |   71 -------------------------------------------------
 1 files changed, 0 insertions(+), 71 deletions(-)
 delete mode 100644 src/pi_tests/Makefile

diff --git a/src/pi_tests/Makefile b/src/pi_tests/Makefile
deleted file mode 100644
index 6b9b595..0000000
--- a/src/pi_tests/Makefile
+++ /dev/null
@@ -1,71 +0,0 @@
-PACKAGE	:=	pi_tests
-SPEC	:=	$(PACKAGE).spec
-VERSION	:=	$(shell awk '/^Version:/ { print $$2 }' $(SPEC))
-RELEASE	:=	$(shell awk '/Release:/ { print $$2 }' ${PACKAGE}.spec)
-SRPM	:=	$(PACKAGE)-$(VERSION)-$(RELEASE).src.rpm
-HERE	:= 	$(shell pwd)
-TARGET	:=	$(shell uname -p)
-RPMARGS	:=	--define "_sourcedir $(HERE)" 	\
-		--define "_builddir $(HERE)/BUILD"	\
-		--define "_rpmdir $(HERE)/RPMS" 	\
-		--define "_srcrpmdir $(HERE)/SRPMS"
-CC	:= gcc
-OPT	:= -g -O
-CFLAGS 	:= $(OPT) -Wall -D_GNU_SOURCE -DVERSION=\"$(VERSION)\"
-LIBS	:= -lpthread -lrt
-
-SRC	:= classic_pi.c allprios.c tst-mutexpi10.c pi_stress.c sigtest.c
-DOC	:= pi_stress.8 README COPYING
-TARGETS	:= $(subst .c,,$(SRC))
-
-all: classic_pi pi_stress
-
-classic_pi: classic_pi.c
-	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
-
-pi_stress: pi_stress.c
-	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
-
-tst-mutexpi10:  tst-mutexpi10.c
-	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
-
-#tst-mutexpi10.c:	classic_pi.c
-#	indent --gnu-style classic_pi.c -o tst-mutexpi10.c
-
-allprios:	allprios.c
-	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
-
-tarball:  pi_tests-$(VERSION).tar.gz
-
-libctest: tst-mutexpi10
-
-sigtest: sigtest.c
-	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
-
-pi_tests-$(VERSION).tar.gz:	clean $(SRC) $(DOC) Makefile pi_tests.spec
-	rm -rf $@ pi_tests-$(VERSION)
-	mkdir pi_tests-$(VERSION)
-	cp $(SRC) $(DOC) Makefile pi_tests.spec pi_tests-$(VERSION)
-	tar -czvf pi_tests-$(VERSION).tar.gz pi_tests-$(VERSION)
-
-clean:
-	rm -rf *~ *.[oi] $(TARGETS) *.tar.gz pi_tests-*
-
-rpm:  rpmdirs $(SPEC) tarball
-	rm -rf RPMS/$(TARGET)
-	rpmbuild -ba --target $(TARGET) $(RPMARGS) $(SPEC)
-
-rpmdirs:
-	@[ -d BUILD ]  || mkdir BUILD
-	@[ -d RPMS ]   || mkdir RPMS
-	@[ -d SRPMS ]  || mkdir SRPMS
-
-rpmlint lint: rpm
-	rpmlint -vi RPMS/*/*
-	rpmlint -vi SRPMS/*
-
-DESTINATION	:= 	people.redhat.com:~williams/public_html/tests
