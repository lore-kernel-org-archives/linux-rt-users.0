From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT 3/3] rt: Make cpu_chill() into yield() and add new cpu_rest() as msleep(1)
Date: Thu, 03 Sep 2015 21:19:03 -0400
Message-ID: <20150904012118.503183590@goodmis.org>
References: <20150904011900.730816481@goodmis.org>
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
Content-Disposition: inline; filename=0003-rt-Make-cpu_chill-into-yield-and-add-new-cpu_rest-as.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Turn the cpu_chill() into a sched_yield() which is only used by those calling
spin_try_or_boost_lock(), as it will allow the owner of the lock, which had its
priority boosted (if needed), to run even with SCHED_FIFO tasks.

As there are still locations that use cpu_chill(), as it spins on status events
like bits and what not (not locks), where the updater is not known and can not
be boosted, add a new cpu_rest() that will take over the msleep(1) action.

Hopefully, we can get rid of the cpu_rest() and find a way to know what tasks
need priority boosting, and perhaps make another API that will allow boosting
of the updater, and the current task can contine to spin instead of sleep.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/namespace.c         |  2 +-
 include/linux/delay.h  | 13 +++++++++++++
 kernel/sched/core.c    | 14 ++++++++++++++
 kernel/time/hrtimer.c  |  4 ++--
 kernel/workqueue.c     |  2 +-
 net/packet/af_packet.c |  4 ++--
 net/rds/ib_rdma.c      |  2 +-
 7 files changed, 34 insertions(+), 7 deletions(-)

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
index 37caab306336..b11e40388387 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -53,9 +53,22 @@ static inline void ssleep(unsigned int seconds)
 }
 
 #ifdef CONFIG_PREEMPT_RT_FULL
+/*
+ * Use cpu_chill() after a spin_try_or_boost_lock() which will boost the owner
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 392aad4ec3d6..3e3efc980136 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4473,6 +4473,20 @@ SYSCALL_DEFINE0(sched_yield)
 	return 0;
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+/*
+ * Used after a spin_try_or_boost_lock(), which should boost the owner
+ * of the lock to the priority of the current task (if needed), and
+ * this will yield the current task to the owner if the owner is on
+ * current's CPU.
+ */
+void cpu_chill(void)
+{
+	sys_sched_yield();
+}
+EXPORT_SYMBOL(cpu_chill);
+#endif
+
 int __sched _cond_resched(void)
 {
 	if (should_resched()) {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2c6be169bdc7..7dfeb55be5c1 100644
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
@@ -1894,7 +1894,7 @@ void cpu_chill(void)
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
 }
-EXPORT_SYMBOL(cpu_chill);
+EXPORT_SYMBOL(cpu_rest);
 #endif
 
 /*
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
2.4.6
