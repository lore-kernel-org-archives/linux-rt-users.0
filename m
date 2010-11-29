From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/2] rt-tests: Simplify makefile a bit
Date: Mon, 29 Nov 2010 16:38:55 +0100
Message-ID: <1291045135-15541-3-git-send-email-w.sang@pengutronix.de>
References: <1291045135-15541-1-git-send-email-w.sang@pengutronix.de>
Cc: Clark Williams <williams@redhat.com>,
	Wolfram Sang <w.sang@pengutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52827 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab0K2PjR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Nov 2010 10:39:17 -0500
In-Reply-To: <1291045135-15541-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

install can also create directories with -D.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 Makefile |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b83614c..c11e43a 100644
--- a/Makefile
+++ b/Makefile
@@ -114,12 +114,10 @@ install: all
 	mkdir -p "$(DESTDIR)$(srcdir)" "$(DESTDIR)$(mandir)/man8"
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
 	if test -n "$(PYLIB)" ; then \
-		mkdir -p "$(DESTDIR)$(PYLIB)" ; \
-		install -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
+		install -D -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
 		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
 	fi
-	mkdir -p "$(DESTDIR)$(srcdir)/backfire"
-	install -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/backfire.c"
+	install -D -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/backfire.c"
 	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4.gz"
 	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
 	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
-- 
1.7.2.3

