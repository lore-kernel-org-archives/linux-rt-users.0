From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH 2/2] remove recursive call to migrate_disable in
	write_lock_bh
Date: Wed, 20 Nov 2013 11:27:34 +0100
Message-ID: <20131120102734.GA3793@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:45320 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860Ab3KTK1f (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Nov 2013 05:27:35 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 19176ba9a8a83e4acf34d9739fa06d6c18fa957f Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Tue, 19 Nov 2013 23:33:10 -0500
Subject: [PATCH 2/2] remove recursive call to migrate_disable in write_lock_bh

 write_lock_bh/write_unlock_bh calls local_bh_disable/enable which 
 already does a migrate_disable/enable no need for this recursive call.

 patch is on top of 3.12-rt2

 No change of functionality


Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 include/linux/rwlock_rt.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 87f5a1d..9a5fe26 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -67,7 +67,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 #define write_lock_bh(lock)				\
 	do {						\
 		local_bh_disable();			\
-		migrate_disable();			\
 		rt_write_lock(lock);			\
 	} while (0)
 
@@ -96,7 +95,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 #define write_unlock_bh(lock)				\
 	do {						\
 		rt_write_unlock(lock);			\
-		migrate_enable();			\
 		local_bh_enable();			\
 	} while (0)
 
-- 
1.7.2.5

