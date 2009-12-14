From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/7] Add the new tests to .gitignore
Date: Mon, 14 Dec 2009 16:58:55 +0100
Message-ID: <1260806336-4691-7-git-send-email-jkacur@redhat.com>
References: <1260806336-4691-1-git-send-email-jkacur@redhat.com>
 <1260806336-4691-2-git-send-email-jkacur@redhat.com>
 <1260806336-4691-3-git-send-email-jkacur@redhat.com>
 <1260806336-4691-4-git-send-email-jkacur@redhat.com>
 <1260806336-4691-5-git-send-email-jkacur@redhat.com>
 <1260806336-4691-6-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:14664 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580AbZLNP73 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 10:59:29 -0500
Received: by gv-out-0910.google.com with SMTP id r4so33153gve.37
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 07:59:28 -0800 (PST)
In-Reply-To: <1260806336-4691-6-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index c77f406..d03a635 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,3 +18,8 @@ hwlatdetect
 tags
 TAGS
 rt-migrate-test
+ptsematest
+sendme
+sigwaittest
+svsematest
+
-- 
1.6.5.2

