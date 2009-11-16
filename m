From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] rt-tests: Makefile - Specify when a target is a PHONY target.
Date: Mon, 16 Nov 2009 19:40:13 +0100
Message-ID: <1258396814-12929-3-git-send-email-jkacur@redhat.com>
References: <1258396814-12929-1-git-send-email-jkacur@redhat.com>
 <1258396814-12929-2-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:34201 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbZKPSkM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Nov 2009 13:40:12 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so3019099fxm.21
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Nov 2009 10:40:18 -0800 (PST)
In-Reply-To: <1258396814-12929-2-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: John Kacur: <jkacur@redhat.com>
---
 Makefile |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 9685587..96c7bca 100644
--- a/Makefile
+++ b/Makefile
@@ -9,6 +9,7 @@ prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man/man8
 
+.PHONY: all
 all: $(TARGETS)
 
 cyclictest: src/cyclictest/cyclictest.c
@@ -33,16 +34,20 @@ rt-migrate-test: src/rt-migrate-test/rt-migrate-test.c
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec
 CLEANUP += $(if $(wildcard .git), ChangeLog)
 
+.PHONY: clean
 clean:
 	for F in $(CLEANUP); do find -type f -name $$F | xargs rm -f; done
 	rm -f hwlatdetect
 
+.PHONY: distclean
 distclean: clean
 	rm -rf BUILD RPMS SRPMS releases *.tar.gz rt-tests.spec
 
+.PHONY: changelog
 changelog:
 	git log >ChangeLog
 
+.PHONY: all
 install: all
 	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)"
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
@@ -50,6 +55,7 @@ install: all
 	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/pi_stress.8.gz"
 	gzip src/hwlatdetect/hwlatdetect.8 -c >"$(DESTDIR)$(mandir)/hwlatdetect.8.gz"
 
+.PHONY: release
 release: clean changelog
 	mkdir -p releases
 	rm -rf tmp && mkdir -p tmp/rt-tests
@@ -58,12 +64,16 @@ release: clean changelog
 	rm -f ChangeLog
 	cp rt-tests-$(VERSION_STRING).tar.gz releases
 
+.PHONY: push
 push:	release
 	scripts/do-git-push $(VERSION_STRING)
 
+.PHONY: pushtest
 pushtest: release
 	scripts/do-git-push --test $(VERSION_STRING)
 
+# Note although rt-tests.spec is a file, it is okay to remake it every time.
+.PHONY: rt-tests.spec
 rt-tests.spec: Makefile rt-tests.spec-in
 	sed s/__VERSION__/$(VERSION_STRING)/ <$@-in >$@
 
@@ -72,14 +82,17 @@ RPMARGS	:=	--define "_topdir $(HERE)" 	\
 		--define "_sourcedir $(HERE)/releases" 	\
 		--define "_builddir $(HERE)/BUILD" 	\
 
+.PHONY: rpm
 rpm:	rpmdirs release rt-tests.spec
 	rpmbuild -ba $(RPMARGS) rt-tests.spec
 
+.PHONY: rpmdirs
 rpmdirs:
 	@[ -d BUILD ]  || mkdir BUILD
 	@[ -d RPMS ]   || mkdir RPMS
 	@[ -d SRPMS ]  || mkdir SRPMS
 
+.PHONY: help
 help:
 	@echo ""
 	@echo " rt-tests useful Makefile targets:"
-- 
1.6.2.5

