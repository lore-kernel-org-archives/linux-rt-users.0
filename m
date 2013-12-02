From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH] consolidate spin_lock/unlock waiting with spin_unlock_wait
Date: Mon, 2 Dec 2013 05:41:26 +0100
Message-ID: <20131202044126.GA18399@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:55343 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab3LBEl2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Dec 2013 23:41:28 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 19ac7e10b38947dbd8d731a13243fb28490f5ab4 Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Sun, 1 Dec 2013 23:03:52 -0500
Subject: [PATCH] consolidate spin_lock/unlock waiting with spin_unlock_wait

 since:
 commit c2f21ce2e31286a0a32f8da0a7856e9ca1122ef3
 Author: Thomas Gleixner <tglx@linutronix.de>
 Date:   Wed Dec 2 20:02:59 2009 +0100

 include/linux/spinlock.h includes spin_unlock_wait() to wait for a concurrent
 holder of a lock. this patch just moves over to that API. spin_unlock_wait
 covers both raw_spinlock_t and spinlock_t so it should be safe here as well.
 the added rt-variant of read_seqbegin in include/linux/seqlock.h that is being
 modified, was introduced by patch:
   seqlock-prevent-rt-starvation.patch

 patch is on top of 3.12.1-rt4

 behavior should be unchanged.


Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 include/linux/seqlock.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 142c0f7..019a936 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -236,8 +236,7 @@ repeat:
 		 * Take the lock and let the writer proceed (i.e. evtl
 		 * boost it), otherwise we could loop here forever.
 		 */
-		spin_lock(&sl->lock);
-		spin_unlock(&sl->lock);
+		spin_unlock_wait(&sl->lock);
 		goto repeat;
 	}
 	return ret;
-- 
1.7.2.5

