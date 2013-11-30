From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH 3/4] migrate_disable pushd down in atomic_dec_and_spin_lock
Date: Sat, 30 Nov 2013 04:07:34 +0100
Message-ID: <20131130030734.GD8101@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:54106 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555Ab3K3DHf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 22:07:35 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 44d3537f3d7053562aeef2739c460f472c78da71 Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Fri, 29 Nov 2013 00:19:41 -0500
Subject: [PATCH 3/4] migrate_disable pushd down in atomic_dec_and_spin_lock

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 kernel/rtmutex.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 891ac58..f99e85a 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -952,12 +952,12 @@ int atomic_dec_and_spin_lock(atomic_t *atomic, spinlock_t *lock)
 	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
 	if (atomic_add_unless(atomic, -1, 1))
 		return 0;
-	migrate_disable();
 	rt_spin_lock(lock);
-	if (atomic_dec_and_test(atomic))
+	if (atomic_dec_and_test(atomic)){
+		migrate_disable();
 		return 1;
+	}
 	rt_spin_unlock(lock);
-	migrate_enable();
 	return 0;
 }
 EXPORT_SYMBOL(atomic_dec_and_spin_lock);
-- 
1.7.2.5

