From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] Makefile: Remove anything to do with rpms, specs etc
Date: Thu, 22 Oct 2015 17:51:23 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510221750380.5660@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34014 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964875AbbJVPv0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2015 11:51:26 -0400
Received: by wikq8 with SMTP id q8so38386805wik.1
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2015 08:51:25 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 07371fae4842d85587b2c4f9085d301c30481ecc Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Thu, 22 Oct 2015 17:30:52 +0200
Subject: [PATCH 3/3] Makefile: Remove anything to do with rpms, specs etc

Remove anything to do with rpm, spec, release and so on that should be
maintained in distribution specific ways. One exception is make tarball,
which is useful in a more general way.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 56 +++-----------------------------------------------------
 1 file changed, 3 insertions(+), 53 deletions(-)

diff --git a/Makefile b/Makefile
index 1e4b7d1b0d3a..908187202ba3 100644
--- a/Makefile
+++ b/Makefile
@@ -140,7 +140,7 @@ LIBOBJS =$(addprefix $(OBJDIR)/,error.o rt-get_cpu.o rt-sched.o rt-utils.o)
 $(OBJDIR)/librttest.a: $(LIBOBJS)
 	$(AR) rcs $@ $^
 
-CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec *.d *.a
+CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej *.d *.a
 CLEANUP += $(if $(wildcard .git), ChangeLog)
 
 .PHONY: clean
@@ -153,17 +153,13 @@ clean:
 RPMDIRS = BUILD BUILDROOT RPMS SRPMS SPECS
 .PHONY: distclean
 distclean: clean
-	rm -rf $(RPMDIRS) releases *.tar.gz *.tar.asc rt-tests.spec tmp
+	rm -rf $(RPMDIRS) releases *.tar.gz *.tar.asc tmp
 
 .PHONY: rebuild
 rebuild:
 	$(MAKE) clean
 	$(MAKE) all
 
-.PHONY: changelog
-changelog:
-	git log >ChangeLog
-
 .PHONY: install
 install: all install_hwlatdetect
 	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man4"
@@ -191,56 +187,11 @@ install_hwlatdetect: hwlatdetect
 		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
 		gzip -c src/hwlatdetect/hwlatdetect.8 >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz" ; \
 	fi
-.PHONY: release
-release: distclean changelog
-	mkdir -p releases
-	mkdir -p tmp/rt-tests
-	cp -r Makefile COPYING ChangeLog MAINTAINERS doc README.markdown src tmp/rt-tests
-	rm -f rt-tests-$(VERSION).tar rt-tests-$(VERSION).tar.asc
-	tar -C tmp -cf rt-tests-$(VERSION).tar rt-tests
-	gpg2 --default-key clrkwllms@kernel.org --detach-sign --armor rt-tests-$(VERSION).tar
-	gzip rt-tests-$(VERSION).tar
-	rm -f ChangeLog
-	cp rt-tests-$(VERSION).tar.gz rt-tests-$(VERSION).tar.asc releases
 
 .PHONY: tarball
 tarball:
 	git archive --worktree-attributes --prefix=rt-tests-${VERSION}/ -o rt-tests-${VERSION}.tar v${VERSION}
 
-.PHONY: push
-push:	release
-	scripts/do-git-push $(VERSION)
-
-.PHONY: pushtest
-pushtest: release
-	scripts/do-git-push --test $(VERSION)
-
-rt-tests.spec: Makefile rt-tests.spec-in
-	sed s/__VERSION__/$(VERSION)/ <$@-in >$@
-ifeq ($(NUMA),1)
-	sed -i -e 's/__MAKE_NUMA__/NUMA=1/' $@
-	sed -i -e 's/__BUILDREQUIRES_NUMA__/numactl-devel/' $@
-else
-	sed -i -e 's/__MAKE_NUMA__//' $@
-	sed -i -e 's/__BUILDREQUIRES_NUMA__//' $@
-endif
-
-
-HERE	:=	$(shell pwd)
-RPMARGS	:=	--define "_topdir $(HERE)" 	\
-		--define "_sourcedir $(HERE)/releases" 	\
-		--define "_builddir $(HERE)/BUILD" 	\
-
-.PHONY: rpm
-rpm:	rpmdirs release rt-tests.spec
-	rpmbuild -ba $(RPMARGS) rt-tests.spec
-
-.PHONY: rpmdirs
-rpmdirs:
-	@[ -d BUILD ]  || mkdir BUILD
-	@[ -d RPMS ]   || mkdir RPMS
-	@[ -d SRPMS ]  || mkdir SRPMS
