From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] gitignore: differentiate between program names and
 directories
Date: Tue, 14 Feb 2012 02:05:42 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1202140203550.6766@tycho>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57270 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab2BNBFg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Feb 2012 20:05:36 -0500
Received: by bkcjm19 with SMTP id jm19so5019522bkc.19
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Feb 2012 17:05:34 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


>From 4f42b10461f3807017b8f06962adbff1b3d73e24 Mon Sep 17 
00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Tue, 14 Feb 2012 01:47:25 +0100
Subject: [PATCH] gitignore: differentiate between program names and
 directories

Many rt-test programs including cyclictest have directories with the
same name as the generated binaries. Tell .gitignore to only ignore
the program names and not the directories by using a slash prefix.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/.gitignore b/.gitignore
index 44b3d4d..047925c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,19 +10,24 @@ releases
 BUILD
 RPMS
 SRPMS
-classic_pi
-pi_stress
-cyclictest
-signaltest
+
+#
+# Top-level programs
+#
+/classic_pi
+/pi_stress
+/cyclictest
+/signaltest
+/hwlatdetect
+/rt-migrate-test
+/ptsematest
+/sendme
+/sigwaittest
+/svsematest
+/pip_stress
+/hackbench
+/pmqtest
+
 rt-tests.spec
-hwlatdetect
 tags
 TAGS
-rt-migrate-test
-ptsematest
-sendme
-sigwaittest
-svsematest
-pip_stress
-hackbench
-pmqtest
-- 
1.7.7.6

