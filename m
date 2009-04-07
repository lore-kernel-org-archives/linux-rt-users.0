From: Jan Blunck <jblunck@suse.de>
Subject: [patch 1/3] Make rt_down_read_trylock() behave like down_read_trylock()
Date: Wed, 08 Apr 2009 01:58:54 +0200
Message-ID: <20090407235902.196040156@suse.de>
References: <20090407235853.309888494@suse.de>
Cc: kvm@vger.kernel.org
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46229 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbZDHAB0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2009 20:01:26 -0400
Content-Disposition: inline; filename=patches.rt/rt_down_read_trylock-fix.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patch removes the stupid "Read locks within the self-held write lock
succeed" behaviour. This is breaking in mm_take_all_locks() since it is quite
common to ensure that a lock is taken with BUG_ON(down_read_trylock(&mm->mmap_sem)).

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 kernel/rt.c |   12 ------------
 1 file changed, 12 deletions(-)

Index: b/kernel/rt.c
===================================================================
--- a/kernel/rt.c
+++ b/kernel/rt.c
@@ -381,18 +381,6 @@ int  rt_down_read_trylock(struct rw_sema
 	unsigned long flags;
 	int ret;
 
-	/*
-	 * Read locks within the self-held write lock succeed.
-	 */
-	spin_lock_irqsave(&rwsem->lock.wait_lock, flags);
-	if (rt_mutex_real_owner(&rwsem->lock) == current) {
-		spin_unlock_irqrestore(&rwsem->lock.wait_lock, flags);
-		rwsem_acquire_read(&rwsem->dep_map, 0, 1, _RET_IP_);
-		rwsem->read_depth++;
-		return 1;
-	}
-	spin_unlock_irqrestore(&rwsem->lock.wait_lock, flags);
