From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH 2/4] migrate_disable pushd down in rt_spin_trylock_irqsave
Date: Sat, 30 Nov 2013 04:06:59 +0100
Message-ID: <20131130030659.GC8101@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:54102 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab3K3DHA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 22:07:00 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 045071bcd2c41337466a6fb07b5325fb09d3d569 Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Fri, 29 Nov 2013 00:17:27 -0500
Subject: [PATCH 2/4] migrate_disable pushd down in rt_spin_trylock_irqsave

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 kernel/rtmutex.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 4e9691f..891ac58 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -938,12 +938,11 @@ int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
 	int ret;
 
 	*flags = 0;
-	migrate_disable();
 	ret = rt_mutex_trylock(&lock->lock);
-	if (ret)
+	if (ret) {
+		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-	else
-		migrate_enable();
+	}
 	return ret;
 }
 EXPORT_SYMBOL(rt_spin_trylock_irqsave);
-- 
1.7.2.5

