From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT v2 2/3] [PATCH 2/3] rt: Make cpu_chill() call rt_mutex_wait_for_lock() and
 add new cpu_rest() as msleep(1)
Date: Thu, 10 Sep 2015 10:50:57 -0400
Message-ID: <20150910150115.493825411@goodmis.org>
References: <20150910145055.948545589@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-rt-Make-cpu_chill-call-rt_mutex_wait_for_lock-and-ad.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Make the cpu_chill() call rt_mutex_wait_for_lock() where it will only sleep
if the owner of a lock boosted by spin_trylock_or_boost() still has the
lock. The owner will then wake up the caller of cpu_chill().

As there are still locations that use cpu_chill(), as it spins on status events
like bits and what not (not locks), where the updater is not known and can not
be boosted, add a new cpu_rest() that will take over the msleep(1) action.

Hopefully, we can get rid of the cpu_rest() and find a way to know what tasks
need priority boosting, and perhaps make another API that will allow boosting
of the updater, and the current task can contine to spin instead of sleep.

Also convert trylock spinners over to spin_try_or_boost_lock(), which will
later call cpu_chill().

When trying to take locks in reverse order, it is possible that on
PREEMPT_RT that the running task could have preempted the owner and never
let it run, creating a live lock. This is because spinlocks in PREEMPT_RT
can be preempted.

Currently, this is solved by calling cpu_chill(), which on PREEMPT_RT is
converted into a msleep(1), and we just hopen that the owner will have time
to release the lock, and nobody else will take in when the task wakes up.

By converting these to spin_trylock_or_boost() which will boost the owners,
the cpu_chill() now must be called afterward to sleep if the owner still has
the lock, and the owner will do the wake up.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 block/blk-ioc.c        |  4 ++--
 fs/autofs4/expire.c    |  2 +-
 fs/dcache.c            |  6 +++---
 fs/namespace.c         |  2 +-
 include/linux/delay.h  | 13 +++++++++++++
 kernel/time/hrtimer.c  | 17 +++++++++++++++--
 kernel/workqueue.c     |  2 +-
 net/packet/af_packet.c |  4 ++--
 net/rds/ib_rdma.c      |  2 +-
 9 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 28f467e636cc..93cf668ca314 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -105,7 +105,7 @@ static void ioc_release_fn(struct work_struct *work)
 						struct io_cq, ioc_node);
 		struct request_queue *q = icq->q;
 
-		if (spin_trylock(q->queue_lock)) {
+		if (spin_trylock_or_boost(q->queue_lock)) {
 			ioc_destroy_icq(icq);
 			spin_unlock(q->queue_lock);
 		} else {
@@ -183,7 +183,7 @@ retry:
 	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
 		if (icq->flags & ICQ_EXITED)
 			continue;
-		if (spin_trylock(icq->q->queue_lock)) {
+		if (spin_trylock_or_boost(icq->q->queue_lock)) {
 			ioc_exit_icq(icq);
 			spin_unlock(icq->q->queue_lock);
 		} else {
diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index d487fa27add5..79eef1e3157e 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -148,7 +148,7 @@ again:
 			}
 
 			parent = p->d_parent;
-			if (!spin_trylock(&parent->d_lock)) {
+			if (!spin_trylock_or_boost(&parent->d_lock)) {
 				spin_unlock(&p->d_lock);
 				cpu_chill();
 				goto relock;
diff --git a/fs/dcache.c b/fs/dcache.c
index c1dad92434d5..151d2db0ded7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -573,12 +573,12 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	struct inode *inode = dentry->d_inode;
 	struct dentry *parent = NULL;
 
-	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
+	if (inode && unlikely(!spin_trylock_or_boost(&inode->i_lock)))
 		goto failed;
 
 	if (!IS_ROOT(dentry)) {
 		parent = dentry->d_parent;
-		if (unlikely(!spin_trylock(&parent->d_lock))) {
+		if (unlikely(!spin_trylock_or_boost(&parent->d_lock))) {
 			if (inode)
 				spin_unlock(&inode->i_lock);
 			goto failed;
@@ -2394,7 +2394,7 @@ again:
 	inode = dentry->d_inode;
 	isdir = S_ISDIR(inode->i_mode);
 	if (dentry->d_lockref.count == 1) {
-		if (!spin_trylock(&inode->i_lock)) {
+		if (!spin_trylock_or_boost(&inode->i_lock)) {
 			spin_unlock(&dentry->d_lock);
 			cpu_chill();
 			goto again;
diff --git a/fs/namespace.c b/fs/namespace.c
index 28937028f3a5..24769de44041 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -356,7 +356,7 @@ int __mnt_want_write(struct vfsmount *m)
 	smp_mb();
 	while (ACCESS_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
 		preempt_enable();
-		cpu_chill();
+		cpu_rest();
 		preempt_disable();
 	}
 	/*
diff --git a/include/linux/delay.h b/include/linux/delay.h
index 37caab306336..b787f4b11243 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -53,9 +53,22 @@ static inline void ssleep(unsigned int seconds)
 }
 
 #ifdef CONFIG_PREEMPT_RT_FULL
+/*
+ * Use cpu_chill() after a spin_trylock_or_boost() which will boost the owner
+ * of the lock to the callers priority (if needed), and cpu_chill will
+ * act like a sched_yield() allowing the owner to proceed.
+ */
 extern void cpu_chill(void);
+/*
+ * Use cpu_rest() if there's no way to find out who the owner you are waiting
+ * for (like spinning on a status variable or bit). This is equivalent to
+ * a msleep(1) and you can hope that the status will change by the time
+ * you wake up.
+ */
+extern void cpu_rest(void);
 #else
 # define cpu_chill()	cpu_relax()
+# define cpu_rest()	cpu_relax()
 #endif
 
 #endif /* defined(_LINUX_DELAY_H) */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2c6be169bdc7..6fd780ffa5d8 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1881,7 +1881,7 @@ SYSCALL_DEFINE2(nanosleep, struct timespec __user *, rqtp,
 /*
  * Sleep for 1 ms in hope whoever holds what we want will let it go.
  */
-void cpu_chill(void)
+void cpu_rest(void)
 {
 	struct timespec tu = {
 		.tv_nsec = NSEC_PER_MSEC,
@@ -1894,8 +1894,21 @@ void cpu_chill(void)
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
 }
+EXPORT_SYMBOL(cpu_rest);
+
+/*
+ * Used after a spin_trylock_or_boost(), which should boost the owner
+ * of the lock to the priority of the current task (if needed), and
+ * this will yield the current task to the owner if the owner is on
+ * current's CPU.
+ */
+void cpu_chill(void)
+{
+	rt_mutex_wait_for_lock(current);
+}
 EXPORT_SYMBOL(cpu_chill);
-#endif
+
+#endif /* CONFIG_PREEMPT_RT_FULL */
 
 /*
  * Functions related to boot-time initialization:
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 21daecdfd86d..32b4d73349dd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1260,7 +1260,7 @@ fail:
 	local_unlock_irqrestore(pendingb_lock, *flags);
 	if (work_is_canceling(work))
 		return -ENOENT;
-	cpu_chill();
+	cpu_rest();
 	return -EAGAIN;
 }
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ef1eb20504a7..e906044802c8 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -699,7 +699,7 @@ static void prb_retire_rx_blk_timer_expired(unsigned long data)
 	if (BLOCK_NUM_PKTS(pbd)) {
 		while (atomic_read(&pkc->blk_fill_in_prog)) {
 			/* Waiting for skb_copy_bits to finish... */
-			cpu_chill();
+			cpu_rest();
 		}
 	}
 
@@ -961,7 +961,7 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
 		if (!(status & TP_STATUS_BLK_TMO)) {
 			while (atomic_read(&pkc->blk_fill_in_prog)) {
 				/* Waiting for skb_copy_bits to finish... */
-				cpu_chill();
+				cpu_rest();
 			}
 		}
 		prb_close_block(pkc, pbd, po, status);
diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
index c8faaf36423a..31fe3b8b4cde 100644
--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -287,7 +287,7 @@ static inline void wait_clean_list_grace(void)
 	for_each_online_cpu(cpu) {
 		flag = &per_cpu(clean_list_grace, cpu);
 		while (test_bit(CLEAN_LIST_BUSY_BIT, flag))
-			cpu_chill();
+			cpu_rest();
 	}
 }
 
-- 
2.5.1
