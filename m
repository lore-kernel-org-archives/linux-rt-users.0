From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH 2/3] read_lock migrate_disable pushdown to rt_read_lock
Date: Fri, 6 Dec 2013 00:44:49 +0100
Message-ID: <20131205234449.GF15603@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>,
	Peter Zijlstra <peterz@infradead.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:58612 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107Ab3LEXou (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 18:44:50 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



 pushdown of migrate_disable/enable from read_*lock* to the rt_read_*lock*
 api level

general mapping to mutexes:

read_*lock* 
  `-> rt_read_*lock* 
          `-> __spin_lock (the sleeping spin locks)
                 `-> rt_mutex 

The real read_lock* mapping:

          read_lock_irqsave -.
read_lock_irq                `-> rt_read_lock_irqsave()  
       `->read_lock ---------.       \
          read_lock_bh ------+        \ 
                             `--> rt_read_lock() 
                                   if (rt_mutex_owner(lock) != current){
                                           `-> __rt_spin_lock()
                                                rt_spin_lock_fastlock()
                                                       `->rt_mutex_cmpxchg()
                                    migrate_disable()
                                   }
                                   rwlock->read_depth++;
read_trylock mapping:

read_trylock 
          `-> rt_read_trylock 
               if (rt_mutex_owner(lock) != current){
                                              `-> rt_mutex_trylock()
                                                   rt_mutex_fasttrylock()
                                                    rt_mutex_cmpxchg()
                migrate_disable()
               }
               rwlock->read_depth++;

read_unlock* mapping:

read_unlock_bh --------+
read_unlock_irq -------+
read_unlock_irqrestore +
read_unlock -----------+
                       `-> rt_read_unlock() 
                            if(--rwlock->read_depth==0){
                                      `-> __rt_spin_unlock()
                                           rt_spin_lock_fastunlock()
                                                        `-> rt_mutex_cmpxchg()
                             migrate_disable()
                            }

 So calls to migrate_disable/enable() are better placed at the rt_read_*
 level of lock/trylock/unlock as all of the read_*lock* API has this as a
 common path. In the rt_read* API of lock/trylock/unlock the nesting level
 is already being recorded in rwlock->read_depth, so we can push down the
 migrate disable/enable to that level and condition it on the read_depth 
 going from 0 to 1 -> migrate_disable and 1 to 0 -> migrate_enable. This 
 eliminates the recursive calls that were needed when migrate_disable/enable
 was done at the read_*lock* level.

 The approach to read_*_bh also eliminates the concerns raised with the 
 regards to api inbalances (read_lock_bh -> read_unlock+local_bh_enable) 

 this is on top of 3.12.1-rt4 with the first batch of migration_cleanup 
 patches applied.

 No change of functional behavior 

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 include/linux/rwlock_rt.h |    6 ------
 kernel/rt.c               |    9 +++++----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 853ee36..6d86c33 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -33,7 +33,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 #define read_lock_irqsave(lock, flags)			\
 	do {						\
 		typecheck(unsigned long, flags);	\
-		migrate_disable();			\
 		flags = rt_read_lock_irqsave(lock);	\
 	} while (0)
 
@@ -46,14 +45,12 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 
 #define read_lock(lock)					\
 	do {						\
-		migrate_disable();			\
 		rt_read_lock(lock);			\
 	} while (0)
 
 #define read_lock_bh(lock)				\
 	do {						\
 		local_bh_disable();			\
-		migrate_disable();			\
 		rt_read_lock(lock);			\
 	} while (0)
 
@@ -77,13 +74,11 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 #define read_unlock(lock)				\
 	do {						\
 		rt_read_unlock(lock);			\
-		migrate_enable();			\
 	} while (0)
 
 #define read_unlock_bh(lock)				\
 	do {						\
 		rt_read_unlock(lock);			\
-		migrate_enable();			\
 		local_bh_enable();			\
 	} while (0)
 
@@ -109,7 +104,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 		typecheck(unsigned long, flags);	\
 		(void) flags;				\
 		rt_read_unlock(lock);			\
-		migrate_enable();			\
 	} while (0)
 
 #define write_unlock_irqrestore(lock, flags) \
diff --git a/kernel/rt.c b/kernel/rt.c
index 29771e2..3403000 100644
--- a/kernel/rt.c
+++ b/kernel/rt.c
@@ -213,19 +213,18 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
 	 * but not when read_depth == 0 which means that the lock is
 	 * write locked.
 	 */
-	migrate_disable();
 	if (rt_mutex_owner(lock) != current) {
 		ret = rt_mutex_trylock(lock);
-		if (ret)
+		if (ret) {
+			migrate_disable();
 			rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
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
@@ -248,6 +247,7 @@ void __lockfunc rt_read_lock(rwlock_t *rwlock)
 	if (rt_mutex_owner(lock) != current) {
 		rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 		__rt_spin_lock(lock);
+		migrate_disable();
 	}
 	rwlock->read_depth++;
 }
@@ -268,6 +268,7 @@ void __lockfunc rt_read_unlock(rwlock_t *rwlock)
 	if (--rwlock->read_depth == 0) {
 		rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
 		__rt_spin_unlock(&rwlock->lock);
+		migrate_enable();
 	}
 }
 EXPORT_SYMBOL(rt_read_unlock);
-- 
1.7.2.5

