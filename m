From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH] condition migration_disable on lock acquisition
Date: Fri, 22 Nov 2013 05:42:23 +0100
Message-ID: <20131122044223.GB31849@opentech.at>
References: <20131120102107.GA12022@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:33247 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021Ab3KVEmZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Nov 2013 23:42:25 -0500
Content-Disposition: inline
In-Reply-To: <20131120102107.GA12022@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From a73aed45d686f800871ba0342cd223bf23e70302 Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Thu, 21 Nov 2013 22:52:30 -0500
Subject: [PATCH] condition migration_disable on lock acquisition

 No need to unconditionally migrate_disable (what is it protecting ?) and
 re-enable on failure to acquire the lock.
 This patch moves the migrate_disable to be conditioned on sucessful lock
 acquisition only.

 No change of functionality

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 kernel/rt.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rt.c b/kernel/rt.c
index 433ae42..4b2c4a9 100644
--- a/kernel/rt.c
+++ b/kernel/rt.c
@@ -182,11 +182,10 @@ int __lockfunc rt_write_trylock(rwlock_t *rwlock)
 {
 	int ret = rt_mutex_trylock(&rwlock->lock);
 
-	migrate_disable();
-	if (ret)
+	if (ret) {
 		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
-	else
-		migrate_enable();
+		migrate_disable();
+	}
 
 	return ret;
 }
-- 
1.7.2.5

