From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [btrfs/rt] lockdep false positive
Date: Sun, 22 Jan 2017 18:45:14 +0100
Message-ID: <1485107114.4467.73.camel@gmail.com>
References: <1485074793.4467.49.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33771 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbdAVRpR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 22 Jan 2017 12:45:17 -0500
In-Reply-To: <1485074793.4467.49.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2017-01-22 at 09:46 +0100, Mike Galbraith wrote:
> Greetings btrfs/lockdep wizards,
> 
> RT trees have trouble with the BTRFS lockdep positive avoidance lock
> class dance (see disk-io.c).  Seems the trouble is due to RT not having
> a means of telling lockdep that its rwlocks are recursive for read by
> the lock owner only, combined with the BTRFS lock class dance assuming
> that read_lock() is annotated rwlock_acquire_read(), which RT cannot
> do, as that would be a big fat lie.
> 
> Creating a rt_read_lock_shared() for btrfs_clear_lock_blocking_rw() did
> indeed make lockdep happy as a clam for test purposes.  (hm, submitting
> that would be excellent way to replenish frozen shark supply:)
> 
> Ideas?

Hrm.  The below seems to work fine, but /me strongly suspects that if
it were this damn trivial, the issue would be long dead.

RT does not have a way to describe its rwlock semantics to lockdep,
leading to the btrfs false positive below.  Btrfs maintains an array
of keys which it assigns on the fly in order to avoid false positives
in stock code, however, that scheme depends upon lockdep knowing that
read_lock()+read_lock() is allowed within a class, as multiple locks
are assigned to the same class, and end up acquired by the same task.

[  341.960754] =============================================
[  341.960754] [ INFO: possible recursive locking detected ]
[  341.960756] 4.10.0-rt1-rt #124 Tainted: G            E  
[  341.960756] ---------------------------------------------
[  341.960757] kworker/u8:9/2039 is trying to acquire lock:
[  341.960757]  (btrfs-tree-00){+.+...}, at: [<ffffffffa036fd15>] btrfs_clear_lock_blocking_rw+0x55/0x100 [btrfs]

This kworker assigned this lock to class 'tree' level 0 shortly
before acquisition, however..

[  341.960783] 
[  341.960783]  but task is already holding lock:
[  341.960783]  (btrfs-tree-00){+.+...}, at: [<ffffffffa036fd15>] btrfs_clear_lock_blocking_rw+0x55/0x100 [btrfs]

..another kworker previously assigned another lock we now hold to the
'tree' level 0 key as well.  Since RT tells lockdep that read_lock() is an
exclusive acquisition, in class read_lock()+read_lock() is forbidden.

[  341.960794]        CPU0
[  341.960795]        ----
[  341.960795]   lock(btrfs-tree-00);
[  341.960795]   lock(btrfs-tree-00);
[  341.960796] 
[  341.960796]  *** DEADLOCK ***
[  341.960796]
[  341.960796]  May be due to missing lock nesting notation
[  341.960796]
[  341.960796] 6 locks held by kworker/u8:9/2039:
[  341.960797]  #0:  ("%s-%s""btrfs", name){.+.+..}, at: [<ffffffff8109f711>] process_one_work+0x171/0x700
[  341.960812]  #1:  ((&work->normal_work)){+.+...}, at: [<ffffffff8109f711>] process_one_work+0x171/0x700
[  341.960815]  #2:  (sb_internal){.+.+..}, at: [<ffffffffa032d4f7>] start_transaction+0x2a7/0x5a0 [btrfs]
[  341.960825]  #3:  (btrfs-tree-02){+.+...}, at: [<ffffffffa036fd15>] btrfs_clear_lock_blocking_rw+0x55/0x100 [btrfs]
[  341.960835]  #4:  (btrfs-tree-01){+.+...}, at: [<ffffffffa036fd15>] btrfs_clear_lock_blocking_rw+0x55/0x100 [btrfs]
[  341.960854]  #5:  (btrfs-tree-00){+.+...}, at: [<ffffffffa036fd15>] btrfs_clear_lock_blocking_rw+0x55/0x100 [btrfs]

Attempting to describe RT rwlock semantics to lockdep prevents this.

Not-signed-off-by: /me
---
 include/linux/lockdep.h  |    5 +++++
 kernel/locking/lockdep.c |    8 ++++++++
 kernel/locking/rt.c      |    7 ++-----
 3 files changed, 15 insertions(+), 5 deletions(-)

--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -543,13 +543,18 @@ static inline void print_irqtrace_events
 #define lock_acquire_exclusive(l, s, t, n, i)		lock_acquire(l, s, t, 0, 1, n, i)
 #define lock_acquire_shared(l, s, t, n, i)		lock_acquire(l, s, t, 1, 1, n, i)
 #define lock_acquire_shared_recursive(l, s, t, n, i)	lock_acquire(l, s, t, 2, 1, n, i)
+#define lock_acquire_reader_recursive(l, s, t, n, i)	lock_acquire(l, s, t, 3, 1, n, i)
 
 #define spin_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
 #define spin_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
 #define spin_release(l, n, i)			lock_release(l, n, i)
 
 #define rwlock_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
+#ifndef CONFIG_PREEMPT_RT_FULL
 #define rwlock_acquire_read(l, s, t, i)		lock_acquire_shared_recursive(l, s, t, NULL, i)
+#else
+#define rwlock_acquire_read(l, s, t, i)		lock_acquire_reader_recursive(l, s, t, NULL, i)
+#endif
 #define rwlock_release(l, n, i)			lock_release(l, n, i)
 
 #define seqcount_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1761,6 +1761,14 @@ check_deadlock(struct task_struct *curr,
 		if ((read == 2) && prev->read)
 			return 2;
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+		/*
+		 * Allow read-after-read or read-after-write recursion of the
+		 * same lock class for RT rwlocks.
+		 */
+		if (read == 3 && (prev->read == 3 || prev->read == 0))
+			return 2;
+#endif
 		/*
 		 * We're holding the nest_lock, which serializes this lock's
 		 * nesting behaviour.
--- a/kernel/locking/rt.c
+++ b/kernel/locking/rt.c
@@ -265,17 +265,14 @@ void __lockfunc rt_read_lock(rwlock_t *r
 {
 	struct rt_mutex *lock = &rwlock->lock;
 
-
+	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	/*
 	 * recursive read locks succeed when current owns the lock
 	 */
-	if (rt_mutex_owner(lock) != current) {
-		rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
+	if (rt_mutex_owner(lock) != current)
 		__rt_spin_lock(lock);
-	}
 	rwlock->read_depth++;
 }
-
 EXPORT_SYMBOL(rt_read_lock);
 
 void __lockfunc rt_write_unlock(rwlock_t *rwlock)
