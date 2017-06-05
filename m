From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: [PATCH] README: Added info about setting branch --tracking
Date: Mon, 5 Jun 2017 09:01:33 +0100
Message-ID: <20170605080130.strwcmn6lqptqf76@debian1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rolf.freitag@email.de, linux-rt-users@vger.kernel.org
To: jkacur@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35383 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdFEIBg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Jun 2017 04:01:36 -0400
Received: by mail-wm0-f49.google.com with SMTP id x70so6088067wme.0
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Jun 2017 01:01:36 -0700 (PDT)
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
 README | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/README b/README
index a618eb5..47e3e54 100644
--- a/README
+++ b/README
@@ -4,3 +4,10 @@ The master branch is unused. You should use an existing branch instead.
 
 The stable/v1.0 branch contains the old stable version.
 The unstable/devel branches contain the development versions.
+
+To checkout stable/v1.0 and setup remote tracking to /origin/stable/v1.0 please do:
+	git checkout -b stable/v1.0 origin/stable/v1.0
+or
+	git checkout -b stable/v1.0 --track origin/stable/v1.0
+and similarly for the unstable/devel/v1.1.1 branch please do:
+	git checkout -b unstable/devel/v1.1.1 --track origin/unstable/devel/v1.1.1
-- 
2.1.4

