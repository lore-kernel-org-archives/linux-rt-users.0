From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: [PATCH] README: Added info about setting branch --tracking
Date: Thu, 8 Jun 2017 11:19:55 +0100
Message-ID: <20170608101953.zkiad4lttux6yaw4@debian1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jkacur@redhat.com, rolf.freitag@email.de,
        linux-rt-users@vger.kernel.org
To: bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36756 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdFHKT7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2017 06:19:59 -0400
Received: by mail-wm0-f54.google.com with SMTP id 7so134716703wmo.1
        for <linux-rt-users@vger.kernel.org>; Thu, 08 Jun 2017 03:19:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

To setup remote tracking of the branch stable/v1.0
git checkout with --track option can be used:
	git checkout -b stable/v1.0 --track origin/stable/v1.0
Otherwise when git checkout -b stable/v1.0 is used
branch may not be properly set up to track it's remote counterpart
(given git option) and users may be confused due to no files present
in the folder, but README.

Signed-off-by: Piotr Gregor <pgregor@quadrant-systems.co.uk>
---
 README | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/README b/README
index a618eb5..70e18cd 100644
--- a/README
+++ b/README
@@ -4,3 +4,19 @@ The master branch is unused. You should use an existing branch instead.
 
 The stable/v1.0 branch contains the old stable version.
 The unstable/devel branches contain the development versions.
+
+
+BRANCH CHECKOUT
+
+To list available branches for tracking please do:
+	git branch -r
+
+To checkout stable/v1.0 and setup remote tracking to /origin/stable/v1.0 please do:
+	git checkout -b stable/v1.0 origin/stable/v1.0
+or
+	git checkout -b stable/v1.0 --track origin/stable/v1.0
+
+Older versions of git will not work with git checkout stable/v1.0.
+
+Similarly for the unstable/devel/v1.1.1 branch please do:
+	git checkout -b unstable/devel/v1.1.1 --track origin/unstable/devel/v1.1.1
-- 
2.1.4

