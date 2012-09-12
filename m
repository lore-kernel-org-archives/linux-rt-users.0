From: Darren Hart <dvhart@linux.intel.com>
Subject: [PATCH 2/2] rt-tests: Break out install_hwlatdetect
Date: Tue, 11 Sep 2012 17:41:53 -0700
Message-ID: <af93e580d005a2bba6ed36528003af4cf631adb8.1347410497.git.dvhart@linux.intel.com>
References: <1347410513-23165-1-git-send-email-dvhart@linux.intel.com>
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Darren Hart <dvhart@linux.intel.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37048 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154Ab2ILAme (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2012 20:42:34 -0400
In-Reply-To: <1347410513-23165-1-git-send-email-dvhart@linux.intel.com>
In-Reply-To: <66765522b634952346f1a3ab7d00c7222a1f9361.1347410497.git.dvhart@linux.intel.com>
References: <66765522b634952346f1a3ab7d00c7222a1f9361.1347410497.git.dvhart@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Allow hwlatdetect to be installed independently of the rest of the
tests. This is convenient for build systems that package it separately
due to the python dependency.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
CC: Clark Williams <williams@redhat.com>
CC: John Kacur <jkacur@redhat.com>
---
 Makefile | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 61e2f9f..636e63b 100644
--- a/Makefile
+++ b/Makefile
@@ -119,21 +119,15 @@ changelog:
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
@@ -141,6 +135,16 @@ install: all
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
 release: clean changelog
 	mkdir -p releases
-- 
1.7.11.4

