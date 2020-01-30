Return-Path: <SRS0=DFOT=3T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2CCC33C9E
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jan 2020 08:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25D7206D5
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jan 2020 08:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgA3IaB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:30:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52559 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgA3IaB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Jan 2020 03:30:01 -0500
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1ix5D5-0003mC-5P; Thu, 30 Jan 2020 09:29:59 +0100
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH] make: Make man page compression configurable
Date:   Thu, 30 Jan 2020 09:29:49 +0100
Message-Id: <20200130082949.9647-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Currently the man pages are unconditionally gzip compressed. However, users
might want to use something else such as bzip2 or none.

When using package management systems it makes sense to use no compression at
all, as the package system might chose the appropriate one. Therefore, introduce
MAN_COMPRESSION. This variable is handling how the compression is done. Default
is gzip.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 Makefile | 60 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index e2142ba3f4e9..ecbd5b1cb98b 100644
--- a/Makefile
+++ b/Makefile
@@ -34,6 +34,32 @@ LDFLAGS ?=
 
 PYLIB  ?= $(shell python3 -c 'import distutils.sysconfig;  print (distutils.sysconfig.get_python_lib())')
 
+MANPAGES = src/cyclictest/cyclictest.8 \
+	   src/pi_tests/pi_stress.8 \
+	   src/ptsematest/ptsematest.8 \
+	   src/rt-migrate-test/rt-migrate-test.8 \
+	   src/sigwaittest/sigwaittest.8 \
+	   src/svsematest/svsematest.8 \
+	   src/pmqtest/pmqtest.8 \
+	   src/hackbench/hackbench.8 \
+	   src/signaltest/signaltest.8 \
+	   src/pi_tests/pip_stress.8 \
+	   src/queuelat/queuelat.8 \
+	   src/sched_deadline/deadline_test.8 \
+	   src/ssdd/ssdd.8 \
+	   src/sched_deadline/cyclicdeadline.8
+
+ifdef PYLIB
+	MANPAGES += src/hwlatdetect/hwlatdetect.8
+endif
+
+MAN_COMPRESSION ?= gzip
+ifeq ($(MAN_COMPRESSION),gzip)
+	MANPAGES := $(MANPAGES:.8=.8.gz)
+else ifeq ($(MAN_COMPRESSION),bzip2)
+	MANPAGES := $(MANPAGES:.8=.8.bz2)
+endif
+
 ifndef DEBUG
 	CFLAGS	+= -O2 -g
 else
@@ -150,11 +176,17 @@ queuelat: $(OBJDIR)/queuelat.o $(OBJDIR)/librttest.a
 ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
+%.8.gz: %.8
+	gzip -c $< > $@
+
+%.8.bz2: %.8
+	bzip2 -c $< > $@
+
 LIBOBJS =$(addprefix $(OBJDIR)/,error.o rt-get_cpu.o rt-sched.o rt-utils.o)
 $(OBJDIR)/librttest.a: $(LIBOBJS)
 	$(AR) rcs $@ $^
 
-CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej *.d *.a
+CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej *.d *.a *.8.gz *.8.bz2
 CLEANUP += $(if $(wildcard .git), ChangeLog)
 
 .PHONY: clean
@@ -175,36 +207,26 @@ rebuild:
 	$(MAKE) all
 
 .PHONY: install
-install: all install_hwlatdetect
-	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8"
+install: all install_manpages install_hwlatdetect
+	mkdir -p "$(DESTDIR)$(bindir)"
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
 	install src/queuelat/get_cpuinfo_mhz.sh "$(DESTDIR)$(bindir)"
 	install src/queuelat/determine_maximum_mpps.sh "${DESTDIR}${bindir}"
-	gzip -c src/cyclictest/cyclictest.8 >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
-	gzip -c src/pi_tests/pi_stress.8 >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
-	gzip -c src/ptsematest/ptsematest.8 >"$(DESTDIR)$(mandir)/man8/ptsematest.8.gz"
-	gzip -c src/rt-migrate-test/rt-migrate-test.8 >"$(DESTDIR)$(mandir)/man8/rt-migrate-test.8.gz"
-	gzip -c src/sigwaittest/sigwaittest.8 >"$(DESTDIR)$(mandir)/man8/sigwaittest.8.gz"
-	gzip -c src/svsematest/svsematest.8 >"$(DESTDIR)$(mandir)/man8/svsematest.8.gz"
-	gzip -c src/pmqtest/pmqtest.8 >"$(DESTDIR)$(mandir)/man8/pmqtest.8.gz"
-	gzip -c src/hackbench/hackbench.8 >"$(DESTDIR)$(mandir)/man8/hackbench.8.gz"
-	gzip -c src/signaltest/signaltest.8 >"$(DESTDIR)$(mandir)/man8/signaltest.8.gz"
-	gzip -c src/pi_tests/pip_stress.8 >"$(DESTDIR)$(mandir)/man8/pip_stress.8.gz"
-	gzip -c src/queuelat/queuelat.8 >"$(DESTDIR)$(mandir)/man8/queuelat.8.gz"
-	gzip -c src/sched_deadline/deadline_test.8 >"$(DESTDIR)$(mandir)/man8/deadline_test.8.gz"
-	gzip -c src/ssdd/ssdd.8 >"$(DESTDIR)$(mandir)/man8/ssdd.8.gz"
-	gzip -c src/sched_deadline/cyclicdeadline.8 >"$(DESTDIR)$(mandir)/man8/cyclicdeadline.8.gz"
 
 .PHONY: install_hwlatdetect
 install_hwlatdetect: hwlatdetect
 	if test -n "$(PYLIB)" ; then \
-		mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8" ; \
+		mkdir -p "$(DESTDIR)$(bindir)" ; \
 		install -D -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
 		rm -f "$(DESTDIR)$(bindir)/hwlatdetect" ; \
 		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
-		gzip -c src/hwlatdetect/hwlatdetect.8 >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz" ; \
 	fi
 
+.PHONY: install_manpages
+install_manpages: $(MANPAGES)
+	mkdir -p "$(DESTDIR)$(mandir)/man8"
+	cp $(MANPAGES) "$(DESTDIR)$(mandir)/man8"
+
 .PHONY: tarball
 tarball:
 	git archive --worktree-attributes --prefix=rt-tests-${VERSION}/ -o rt-tests-${VERSION}.tar v${VERSION}
-- 
2.20.1

