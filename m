From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/4] Completely remove VERSION_STRING until we have a better solution.
Date: Mon, 21 Dec 2009 22:45:50 +0100
Message-ID: <1261431950-28500-5-git-send-email-jkacur@redhat.com>
References: <1261431950-28500-1-git-send-email-jkacur@redhat.com>
 <1261431950-28500-2-git-send-email-jkacur@redhat.com>
 <1261431950-28500-3-git-send-email-jkacur@redhat.com>
 <1261431950-28500-4-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <C.Emde@osadl.org>, linux-rt-users@vger.kernel.org,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:41653 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277AbZLUVqL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 16:46:11 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so3775817bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Dec 2009 13:46:11 -0800 (PST)
In-Reply-To: <1261431950-28500-4-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Carsten Emde <C.Emde@osadl.org>

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/backfire/backfire.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/backfire/backfire.c b/src/backfire/backfire.c
index d737347..aaf9c4a 100644
--- a/src/backfire/backfire.c
+++ b/src/backfire/backfire.c
@@ -132,7 +132,7 @@ static int __init backfire_init(void)
 	if (ret)
 		printk(KERN_ERR "backfire: can't register dynamic misc device\n");
 	else
-		printk(KERN_INFO "backfire driver v__VERSION_STRING__ misc device %d\n",
+		printk(KERN_INFO "backfire driver misc device %d\n",
 			backfire_dev.minor);
 	return ret;
 }
-- 
1.6.5.2

