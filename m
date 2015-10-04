From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt-tests 2/3] remove several unused Makefiles
Date: Sun,  4 Oct 2015 12:48:42 +0200
Message-ID: <1443955723-23042-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1443955723-23042-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Henrik Austad <haustad@cisco.com>, Josh Cartwright <joshc@ni.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:55315 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751367AbbJDK5L (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Oct 2015 06:57:11 -0400
In-Reply-To: <1443955723-23042-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 src/hackbench/Makefile   |  5 ----
 src/pi_tests/Makefile    | 71 ----------------------------------------=
--------
 src/pmqtest/Makefile     | 16 -----------
 src/ptsematest/Makefile  | 16 -----------
 src/sigwaittest/Makefile | 17 ------------
 src/svsematest/Makefile  | 16 -----------
 6 files changed, 141 deletions(-)
 delete mode 100644 src/hackbench/Makefile
 delete mode 100644 src/pi_tests/Makefile
 delete mode 100644 src/pmqtest/Makefile
 delete mode 100644 src/ptsematest/Makefile
 delete mode 100644 src/sigwaittest/Makefile
 delete mode 100644 src/svsematest/Makefile

diff --git a/src/hackbench/Makefile b/src/hackbench/Makefile
deleted file mode 100644
index 469cf25c3559..000000000000
--- a/src/hackbench/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-hackbench: hackbench.c
-	$(CC) $(CFLAGS) -o hackbench hackbench.c -g -Wall -O2 -lpthread
-
-clean :
-	rm -f hackbench
diff --git a/src/pi_tests/Makefile b/src/pi_tests/Makefile
deleted file mode 100644
index 6b9b595b24f5..000000000000
--- a/src/pi_tests/Makefile
+++ /dev/null
@@ -1,71 +0,0 @@
-PACKAGE	:=3D	pi_tests
-SPEC	:=3D	$(PACKAGE).spec
-VERSION	:=3D	$(shell awk '/^Version:/ { print $$2 }' $(SPEC))
-RELEASE	:=3D	$(shell awk '/Release:/ { print $$2 }' ${PACKAGE}.spec)
-SRPM	:=3D	$(PACKAGE)-$(VERSION)-$(RELEASE).src.rpm
-HERE	:=3D 	$(shell pwd)
-TARGET	:=3D	$(shell uname -p)
-RPMARGS	:=3D	--define "_sourcedir $(HERE)" 	\
-		--define "_builddir $(HERE)/BUILD"	\
-		--define "_rpmdir $(HERE)/RPMS" 	\
-		--define "_srcrpmdir $(HERE)/SRPMS"
-CC	:=3D gcc
-OPT	:=3D -g -O
-CFLAGS 	:=3D $(OPT) -Wall -D_GNU_SOURCE -DVERSION=3D\"$(VERSION)\"
-LIBS	:=3D -lpthread -lrt
-
-SRC	:=3D classic_pi.c allprios.c tst-mutexpi10.c pi_stress.c sigtest.c
-DOC	:=3D pi_stress.8 README COPYING
-TARGETS	:=3D $(subst .c,,$(SRC))
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
-DESTINATION	:=3D 	people.redhat.com:~williams/public_html/tests
-
-push: rpm
-	scp pi_tests-$(VERSION).tar.gz $(DESTINATION)
-	scp SRPMS/* $(DESTINATION)
diff --git a/src/pmqtest/Makefile b/src/pmqtest/Makefile
deleted file mode 100644
index 0902c9b0352b..000000000000
--- a/src/pmqtest/Makefile
+++ /dev/null
@@ -1,16 +0,0 @@
-CFLAGS +=3D -Wall -O2
-LDFLAGS +=3D -lpthread
-
-all:	pmqtest
-	@echo Done
-
-pmqtest.o: pmqtest.c
-
-pmqtest:
-
-clean:
-	@rm -f *.o
-
-tar:	clean
-	@rm -f pmqtest
-	$(shell bn=3D`basename $$PWD`; cd ..; tar -zcf $$bn.tgz $$bn)
diff --git a/src/ptsematest/Makefile b/src/ptsematest/Makefile
deleted file mode 100644
index dc12bc26d334..000000000000
--- a/src/ptsematest/Makefile
+++ /dev/null
@@ -1,16 +0,0 @@
-CFLAGS +=3D -Wall -O2
-LDFLAGS +=3D -lpthread
-
-all:	ptsematest
-	@echo Done
-
-ptsematest.o: ptsematest.c
-
-ptsematest:
-
-clean:
-	@rm -f *.o
-
-tar:	clean
-	@rm -f ptsematest
-	$(shell bn=3D`basename $$PWD`; cd ..; tar -zcf $$bn.tgz $$bn)
diff --git a/src/sigwaittest/Makefile b/src/sigwaittest/Makefile
deleted file mode 100644
index 697e3d50d698..000000000000
--- a/src/sigwaittest/Makefile
+++ /dev/null
@@ -1,17 +0,0 @@
-CFLAGS +=3D -Wall -O2
-LDFLAGS +=3D -lpthread -lrt
-
-all:	sigwaittest
-	@echo Done
-
-sigwaittest.o: sigwaittest.c
-
-sigwaittest:
-
-clean:
-	@rm -f *.o
-
-tar:	clean
-	@rm -f sigwaittest
-	$(shell bn=3D`basename $$PWD`; cd ..; tar -zcf $$bn.tgz $$bn)
-
diff --git a/src/svsematest/Makefile b/src/svsematest/Makefile
deleted file mode 100644
index da8d32d847a4..000000000000
--- a/src/svsematest/Makefile
+++ /dev/null
@@ -1,16 +0,0 @@
-CFLAGS +=3D -Wall -O2
-LDFLAGS +=3D -lpthread -lrt
-
-all:	svsematest
-	@echo Done
-
-svsematest.o: svsematest.c
-
-svsematest:
-
-clean:
-	@rm -f *.o
