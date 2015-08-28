From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 2/4] rt-tests: Break out install_hwlatdetect
Date: Thu, 27 Aug 2015 19:19:49 -0500
Message-ID: <7bc5d10cf841febd5c511934cfed3ddcf512ffec.1440720422.git.joshc@ni.com>
References: <cover.1440720422.git.joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org,
	Darren Hart <dvhart@linux.intel.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:41294 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751878AbbH1ATx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Aug 2015 20:19:53 -0400
In-Reply-To: <cover.1440720422.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Darren Hart <dvhart@linux.intel.com>

Allow hwlatdetect to be installed independently of the rest of the
tests. This is convenient for build systems that package it separately
due to the python dependency.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
CC: Clark Williams <williams@redhat.com>
CC: John Kacur <jkacur@redhat.com>
Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 Makefile | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 1ec7f6a..e5a9942 100644
--- a/Makefile
+++ b/Makefile
@@ -131,21 +131,15 @@ changelog:
 	git log >ChangeLog
 
 .PHONY: install
-install: all
+install: all install_hwlatdetect
 	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man4"
 	mkdir -p "$(DESTDIR)$(srcdir)" "$(DESTDIR)$(mandir)/man8"
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
-	if test -n "$(PYLIB)" ; then \
-		install -D -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
-		rm -f "$(DESTDIR)$(bindir)/hwlatdetect" ; \
-		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
-	fi
 	install -D -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/backfire.c"
 	install -m 644 src/backfire/Makefile "$(DESTDIR)$(srcdir)/backfire/Makefile"
 	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4.gz"
 	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
 	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
-	gzip src/hwlatdetect/hwlatdetect.8 -c >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz"
 	gzip src/ptsematest/ptsematest.8 -c >"$(DESTDIR)$(mandir)/man8/ptsematest.8.gz"
 	gzip src/sigwaittest/sigwaittest.8 -c >"$(DESTDIR)$(mandir)/man8/sigwaittest.8.gz"
 	gzip src/svsematest/svsematest.8 -c >"$(DESTDIR)$(mandir)/man8/svsematest.8.gz"
@@ -153,6 +147,16 @@ install: all
 	gzip src/backfire/sendme.8 -c >"$(DESTDIR)$(mandir)/man8/sendme.8.gz"
 	gzip src/hackbench/hackbench.8 -c >"$(DESTDIR)$(mandir)/man8/hackbench.8.gz"
 
+.PHONY: install_hwlatdetect
+install_hwlatdetect: hwlatdetect
+	if test -n "$(PYLIB)" ; then \
+		mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8" ; \
+		install -D -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
+		rm -f "$(DESTDIR)$(bindir)/hwlatdetect" ; \
+		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
+		gzip src/hwlatdetect/hwlatdetect.8 -c >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz" ; \
+	fi
+
 .PHONY: release
 release: distclean changelog
 	mkdir -p releases
-- 
2.5.0

