From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH] migrate_disable pushd down in rt_read_trylock
Date: Sat, 23 Nov 2013 01:51:58 +0100
Message-ID: <20131123005158.GA16338@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:53659 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755634Ab3KWAv7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Nov 2013 19:51:59 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 5c9a0c1510ec29c1e148f66f3c111f52f7565df1 Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Fri, 22 Nov 2013 02:41:48 -0500
Subject: [PATCH] migrate_disable pushd down in rt_read_trylock

 No need to migrate_disable before requesting the lock and no need to 
 speculatively disable/enable on every recursive call. migration_disable 
 can be done at the latest point in the code before returning an acquired 
 ``lock.

 patch is on top of 3.12-rt2

 No change of functionality

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 kernel/rt.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rt.c b/kernel/rt.c
index 71d26a4..54211f0 100644
--- a/kernel/rt.c
+++ b/kernel/rt.c
@@ -212,19 +212,18 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
 	 * but not when read_depth == 0 which means that the lock is
 	 * write locked.
 	 */
-	migrate_disable();
 	if (rt_mutex_owner(lock) != current) {
 		ret = rt_mutex_trylock(lock);
-		if (ret)
+		if (ret) {
 			rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
+			migrate_disable();
+		}
 	} else if (!rwlock->read_depth) {
 		ret = 0;
 	}
 
 	if (ret)
 		rwlock->read_depth++;
-	else
-		migrate_enable();
 
 	return ret;
 }
-- 
1.7.2.5

