From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 29/39] Revert "rwsem-rt: Do not allow readers to nest"
Date: Thu, 12 Mar 2015 15:13:36 -0400
Message-ID: <20150312191411.837383984@goodmis.org>
References: <20150312191307.081068717@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:15728 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752465AbbCLTOW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 15:14:22 -0400
Content-Disposition: inline; filename=0029-Revert-rwsem-rt-Do-not-allow-readers-to-nest.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.14.34-rt32-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This behaviour is required by cpufreq and its logic is "okay": It does a
read_lock followed by a try_read_lock.
Lockdep warns if one try a read_lock twice in -RT and vanilla so it
should be good. We still only allow multiple readers as long as it is in
the same process.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/rwsem_rt.h |  1 +
 kernel/locking/rt.c      | 29 +++++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/rwsem_rt.h b/include/linux/rwsem_rt.h
index 0065b08fbb7a..924c2d274ab5 100644
--- a/include/linux/rwsem_rt.h
+++ b/include/linux/rwsem_rt.h
@@ -20,6 +20,7 @@
 
 struct rw_semaphore {
 	struct rt_mutex		lock;
+	int			read_depth;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
diff --git a/kernel/locking/rt.c b/kernel/locking/rt.c
index eac2ddea9c45..9a972e996185 100644
--- a/kernel/locking/rt.c
+++ b/kernel/locking/rt.c
@@ -322,7 +322,8 @@ EXPORT_SYMBOL(rt_up_write);
 void  rt_up_read(struct rw_semaphore *rwsem)
 {
 	rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
-	rt_mutex_unlock(&rwsem->lock);
+	if (--rwsem->read_depth == 0)
+		rt_mutex_unlock(&rwsem->lock);
 }
 EXPORT_SYMBOL(rt_up_read);
 
@@ -333,6 +334,7 @@ EXPORT_SYMBOL(rt_up_read);
 void  rt_downgrade_write(struct rw_semaphore *rwsem)
 {
 	BUG_ON(rt_mutex_owner(&rwsem->lock) != current);
+	rwsem->read_depth = 1;
 }
 EXPORT_SYMBOL(rt_downgrade_write);
 
@@ -370,12 +372,23 @@ EXPORT_SYMBOL(rt_down_write_nested_lock);
 
 int  rt_down_read_trylock(struct rw_semaphore *rwsem)
 {
-	int ret;
+	struct rt_mutex *lock = &rwsem->lock;
+	int ret = 1;
 
-	ret = rt_mutex_trylock(&rwsem->lock);
-	if (ret)
-		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
+	/*
+	 * recursive read locks succeed when current owns the rwsem,
+	 * but not when read_depth == 0 which means that the rwsem is
+	 * write locked.
+	 */
+	if (rt_mutex_owner(lock) != current)
+		ret = rt_mutex_trylock(&rwsem->lock);
+	else if (!rwsem->read_depth)
+		ret = 0;
 
+	if (ret) {
+		rwsem->read_depth++;
+		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(rt_down_read_trylock);
@@ -383,7 +396,10 @@ EXPORT_SYMBOL(rt_down_read_trylock);
 static void __rt_down_read(struct rw_semaphore *rwsem, int subclass)
 {
 	rwsem_acquire(&rwsem->dep_map, subclass, 0, _RET_IP_);
-	rt_mutex_lock(&rwsem->lock);
+
+	if (rt_mutex_owner(&rwsem->lock) != current)
+		rt_mutex_lock(&rwsem->lock);
+	rwsem->read_depth++;
 }
 
 void  rt_down_read(struct rw_semaphore *rwsem)
@@ -408,6 +424,7 @@ void  __rt_rwsem_init(struct rw_semaphore *rwsem, const char *name,
 	debug_check_no_locks_freed((void *)rwsem, sizeof(*rwsem));
 	lockdep_init_map(&rwsem->dep_map, name, key, 0);
 #endif
+	rwsem->read_depth = 0;
 	rwsem->lock.save_state = 0;
 }
 EXPORT_SYMBOL(__rt_rwsem_init);
-- 
2.1.4


