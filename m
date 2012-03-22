From: John Kacur <jkacur@redhat.com>
Subject: [PATCH rt-tests RFC 1/6] gitignore: differentiate between program names and directories
Date: Thu, 22 Mar 2012 02:14:01 +0100
Message-ID: <1332378846-18104-2-git-send-email-jkacur@redhat.com>
References: <1332378846-18104-1-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <C.Emde@osadl.org>,
	Darren Hart <dvhart@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nicholas McGuire <der.herr@hofr.at>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54961 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964838Ab2CVBPn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 21:15:43 -0400
Received: by mail-wi0-f172.google.com with SMTP id hj6so120206wib.1
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 18:15:42 -0700 (PDT)
In-Reply-To: <1332378846-18104-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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

