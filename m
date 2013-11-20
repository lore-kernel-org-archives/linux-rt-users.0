From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH 1/2] remove recursive call to migrate_disable in
	read_lock_bh
Date: Wed, 20 Nov 2013 11:21:07 +0100
Message-ID: <20131120102107.GA12022@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:45178 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752513Ab3KTKVK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Nov 2013 05:21:10 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 46393dc3185026c8500c2b734747d7c8785f3dc9 Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Tue, 19 Nov 2013 23:31:05 -0500
Subject: [PATCH 1/2] remove recursive call to migrate_disable in read_lock_bh

 read_lock_bh/read_unlock_bh unconditionally calls local_bh_disable/enable 
 which already does a migrate_disable/enable - no need for this recursive call.

 patch is on top of 3.12-rt2

 No change of functionality

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 include/linux/rwlock_rt.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 853ee36..87f5a1d 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -53,7 +53,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 #define read_lock_bh(lock)				\
 	do {						\
 		local_bh_disable();			\
-		migrate_disable();			\
 		rt_read_lock(lock);			\
 	} while (0)
 
@@ -83,7 +82,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 #define read_unlock_bh(lock)				\
 	do {						\
 		rt_read_unlock(lock);			\
-		migrate_enable();			\
 		local_bh_enable();			\
 	} while (0)
 
-- 
1.7.2.5

