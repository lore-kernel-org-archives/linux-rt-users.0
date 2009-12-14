From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] Remove making of backfire kernel module from the rt-tests makefile The kernel module can be made by cding to src/backfire and doing make modules sudo make modules_install
Date: Mon, 14 Dec 2009 22:39:01 +0100
Message-ID: <1260826742-15296-3-git-send-email-jkacur@redhat.com>
References: <1260826742-15296-1-git-send-email-jkacur@redhat.com>
 <1260826742-15296-2-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:50074 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbZLNVjT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 16:39:19 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so3800658fxm.21
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 13:39:18 -0800 (PST)
In-Reply-To: <1260826742-15296-2-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index d19c992..8e44ec5 100644
--- a/Makefile
+++ b/Makefile
@@ -75,9 +75,7 @@ install: all
 	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8"
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
 	mkdir -p "$(DESTDIR)$(srcdir)/backfire"
-	sed s/__VERSION_STRING__/$(VERSION_STRING)/ <src/backfire/backfire.c >"$(DESTDIR)$(srcdir)/backfire/backfire.c"
-	cp src/backfire/Makefile "$(DESTDIR)$(srcdir)/backfire"
-	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4.gz
+	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4.gz"
 	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
 	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
 	gzip src/hwlatdetect/hwlatdetect.8 -c >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz"
-- 
1.6.5.2

