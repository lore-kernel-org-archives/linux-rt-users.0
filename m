From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH RT] Cleanup of unnecessary do while 0 in api mappings
Date: Sat, 8 Feb 2014 12:39:20 +0100
Message-ID: <20140208113920.GA3861@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:60547 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbaBHLjY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Feb 2014 06:39:24 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Cleanup of unnecessary do while 0 in api mappings

With the migration pushdonw a few of the do{ }while(0)
loops became obsolete but got left over - this patch 
only removes this fallout.

Patch applies on top of 3.12.9-rt13

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 include/linux/rwlock_rt.h |   20 ++++----------------
 1 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index e85a5df..4c729ce 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -42,10 +42,7 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 		flags = rt_write_lock_irqsave(lock);	\
 	} while (0)
 
-#define read_lock(lock)					\
-	do {						\
-		rt_read_lock(lock);			\
-	} while (0)
+#define read_lock(lock)		rt_read_lock(lock)
 
 #define read_lock_bh(lock)				\
 	do {						\
@@ -55,10 +52,7 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 
 #define read_lock_irq(lock)	read_lock(lock)
 
-#define write_lock(lock)				\
-	do {						\
-		rt_write_lock(lock);			\
-	} while (0)
+#define write_lock(lock)	rt_write_lock(lock)
 
 #define write_lock_bh(lock)				\
 	do {						\
@@ -68,10 +62,7 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 
 #define write_lock_irq(lock)	write_lock(lock)
 
-#define read_unlock(lock)				\
-	do {						\
-		rt_read_unlock(lock);			\
-	} while (0)
+#define read_unlock(lock)	rt_read_unlock(lock)
 
 #define read_unlock_bh(lock)				\
 	do {						\
@@ -81,10 +72,7 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 
 #define read_unlock_irq(lock)	read_unlock(lock)
 
-#define write_unlock(lock)				\
-	do {						\
-		rt_write_unlock(lock);			\
-	} while (0)
+#define write_unlock(lock)	rt_write_unlock(lock)
 
 #define write_unlock_bh(lock)				\
 	do {						\
-- 
1.7.2.5

