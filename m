From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.13.13-rt5
Date: Fri, 17 Nov 2017 22:04:40 +0100
Message-ID: <20171117210440.lxhcynkwxgyuf6pj@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:52757 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760902AbdKQVEn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Nov 2017 16:04:43 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.13.13-rt5 patch set. 

Changes since v4.13.13-rt4:

  - Correct the elif macro in the apparmor patch applied in the last
    release.

  - Update the fixup for the PCI switchtec driver. It was introduced in
    the v4.13 cycle and was not perfect.

  - Some of the bit_spin_locks were converted to proper spinlock
    including BH_Uptodate_Lock. After that change some new users popped
    up and were not updated. They are now.

  - The raid5 code disabled interrupts where it should not on -RT.
    Noticed while running the lvm test suite.

  - The device-mapper could deadlock itself on -RT. A deadlock could
    also happen with plain ext4. Reported and patched by Mikulas
    Patocka.

  - Lockdep could report a possible double lock in during the futex
    lock-pi opcode due to missing annotation. Reported by Fernando
    Lopez-Lezcano.

Known issues
	None

The delta patch against v4.13.13-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.13/incr/patch-4.13.13-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.13.13-rt5

The RT patch against v4.13.13 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.13/older/patch-4.13.13-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.13/older/patches-4.13.13-rt5.tar.xz

Sebastian
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -410,7 +410,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 		md_wakeup_thread(conf->mddev->thread);
 	return;
 slow_path:
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	/* we are ok here if STRIPE_ON_RELEASE_LIST is set or not */
 	if (atomic_dec_and_lock(&sh->count, &conf->device_lock)) {
 		INIT_LIST_HEAD(&list);
@@ -419,7 +419,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 		spin_unlock(&conf->device_lock);
 		release_inactive_stripe_list(conf, &list, hash);
 	}
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }
 
 static inline void remove_hash(struct stripe_head *sh)
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -452,6 +452,7 @@ static void mrpc_complete_cmd(struct switchtec_dev *stdev)
 		      stuser->read_len);
 
 out:
+	stuser->cmd_done = true;
 	wake_up_interruptible(&stuser->cmd_comp);
 	list_del_init(&stuser->list);
 	stuser_put(stuser);
@@ -722,7 +723,7 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
 	mutex_unlock(&stdev->mrpc_mutex);
 
 	if (filp->f_flags & O_NONBLOCK) {
-		if (!stuser->cmd_done)
+		if (!READ_ONCE(stuser->cmd_done))
 			return -EAGAIN;
 	} else {
 		rc = wait_event_interruptible(stuser->cmd_comp,
@@ -782,7 +783,7 @@ static unsigned int switchtec_dev_poll(struct file *filp, poll_table *wait)
 
 	mutex_unlock(&stdev->mrpc_mutex);
 
-	if (stuser->cmd_done)
+	if (READ_ONCE(stuser->cmd_done))
 		ret |= POLLIN | POLLRDNORM;
 
 	if (stuser->event_cnt != atomic_read(&stdev->event_cnt))
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -94,8 +94,7 @@ static void ext4_finish_bio(struct bio *bio)
 		 * We check all buffers in the page under BH_Uptodate_Lock
 		 * to avoid races with other end io clearing async_write flags
 		 */
-		local_irq_save(flags);
-		bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
+		flags = bh_uptodate_lock_irqsave(head);
 		do {
 			if (bh_offset(bh) < bio_start ||
 			    bh_offset(bh) + bh->b_size > bio_end) {
@@ -107,8 +106,7 @@ static void ext4_finish_bio(struct bio *bio)
 			if (bio->bi_status)
 				buffer_io_error(bh);
 		} while ((bh = bh->b_this_page) != head);
-		bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
-		local_irq_restore(flags);
+		bh_uptodate_unlock_irqrestore(head, flags);
 		if (!under_io) {
 #ifdef CONFIG_EXT4_FS_ENCRYPTION
 			if (data_page)
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -107,8 +107,7 @@ xfs_finish_page_writeback(
 	ASSERT(bvec->bv_offset + bvec->bv_len <= PAGE_SIZE);
 	ASSERT((bvec->bv_len & (i_blocksize(inode) - 1)) == 0);
 
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
+	flags = bh_uptodate_lock_irqsave(head);
 	do {
 		if (off >= bvec->bv_offset &&
 		    off < bvec->bv_offset + bvec->bv_len) {
@@ -130,8 +129,7 @@ xfs_finish_page_writeback(
 		}
 		off += bh->b_size;
 	} while ((bh = bh->b_this_page) != head);
-	bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
-	local_irq_restore(flags);
+	bh_uptodate_unlock_irqrestore(head, flags);
 
 	if (!busy)
 		end_page_writeback(bvec->bv_page);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -24,6 +24,7 @@
 #include <linux/sched/debug.h>
 #include <linux/timer.h>
 #include <linux/ww_mutex.h>
+#include <linux/blkdev.h>
 
 #include "rtmutex_common.h"
 
@@ -1939,6 +1940,15 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
+	/*
+	 * If rt_mutex blocks, the function sched_submit_work will not call
+	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
+	 * We must call blk_schedule_flush_plug here, if we don't call it,
+	 * a deadlock in device mapper may happen.
+	 */
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
 	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK, ww_ctx);
 }
 
@@ -1956,6 +1966,9 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 	    likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
 	return slowfn(lock, state, timeout, chwalk, ww_ctx);
 }
 
@@ -2261,6 +2274,14 @@ void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				struct task_struct *proxy_owner)
 {
 	__rt_mutex_init(lock, NULL, NULL);
+#ifdef CONFIG_DEBUG_SPINLOCK
+	/*
+	 * get another key class for the wait_lock. LOCK_PI and UNLOCK_PI is
+	 * holding the ->wait_lock of the proxy_lock while unlocking a sleeping
+	 * lock.
+	 */
+	raw_spin_lock_init(&lock->wait_lock);
+#endif
 	debug_rt_mutex_proxy_lock(lock, proxy_owner);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
diff --git a/security/apparmor/include/path.h b/security/apparmor/include/path.h
--- a/security/apparmor/include/path.h
+++ b/security/apparmor/include/path.h
@@ -67,7 +67,7 @@ static inline void AA_BUG_PREEMPT_ENABLED(const char *s)
 		  "__get_buffer without aa_buffers_lock\n");
 }
 
-#elif CONFIG_DEBUG_PREEMPT
+#elif defined(CONFIG_DEBUG_PREEMPT)
 #define AA_BUG_PREEMPT_ENABLED(X) AA_BUG(preempt_count() <= 0, X)
 #else
 #define AA_BUG_PREEMPT_ENABLED(X) /* nop */
