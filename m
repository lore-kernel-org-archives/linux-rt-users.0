From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 3/8] sched: make task->oncpu available in all configurations
Date: Mon, 19 May 2008 13:07:28 -0400
Message-ID: <20080519170727.6820.45060.stgit@novell1.haskins.net>
References: <20080519170356.6820.5274.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, bill.huey@gmail.com,
	dsingleton@mvista.com, dwalker@mvista.com, npiggin@suse.de,
	pavel@ucw.cz, acme@redhat.com, sdietrich@novell.com,
	pmorreale@novell.com, mkohari@novell.com, ghaskins@novell.com
To: mingo@elte.hu, peterz@infradead.org, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762838AbYESRk7@vger.kernel.org>
In-Reply-To: <20080519170356.6820.5274.stgit@novell1.haskins.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We will use this later in the series to eliminate the need for a function
call.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 include/linux/sched.h |    2 --
 kernel/sched.c        |   35 ++++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2d38d9e..76a76fd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1080,10 +1080,8 @@ struct task_struct {
 	int lock_depth;		/* BKL lock depth */
 
 #ifdef CONFIG_SMP
-#ifdef __ARCH_WANT_UNLOCKED_CTXSW
 	int oncpu;
 #endif
-#endif
 
 	int prio, static_prio, normal_prio;
 #ifdef CONFIG_PREEMPT_RCU_BOOST
diff --git a/kernel/sched.c b/kernel/sched.c
index f3e36ee..78e7e8e 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -694,18 +694,39 @@ static inline int task_current(struct rq *rq, struct task_struct *p)
 	return rq->curr == p;
 }
 
-#ifndef __ARCH_WANT_UNLOCKED_CTXSW
 static inline int task_running(struct rq *rq, struct task_struct *p)
 {
+#ifdef CONFIG_SMP
+	return p->oncpu;
+#else
 	return task_current(rq, p);
+#endif
 }
 
+#ifndef __ARCH_WANT_UNLOCKED_CTXSW
 static inline void prepare_lock_switch(struct rq *rq, struct task_struct *next)
 {
+#ifdef CONFIG_SMP
+	/*
+	 * We can optimise this out completely for !SMP, because the
+	 * SMP rebalancing from interrupt is the only thing that cares
+	 * here.
+	 */
+	next->oncpu = 1;
+#endif
 }
 
 static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
 {
+#ifdef CONFIG_SMP
+	/*
+	 * After ->oncpu is cleared, the task can be moved to a different CPU.
+	 * We must ensure this doesn't happen until the switch is completely
+	 * finished.
+	 */
+	smp_wmb();
+	prev->oncpu = 0;
+#endif
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
 	rq->lock.owner = current;
@@ -721,14 +742,6 @@ static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
 }
 
 #else /* __ARCH_WANT_UNLOCKED_CTXSW */
-static inline int task_running(struct rq *rq, struct task_struct *p)
-{
-#ifdef CONFIG_SMP
-	return p->oncpu;
-#else
-	return task_current(rq, p);
-#endif
-}
 
 static inline void prepare_lock_switch(struct rq *rq, struct task_struct *next)
 {
@@ -2077,7 +2090,7 @@ void sched_fork(struct task_struct *p, int clone_flags)
 	if (likely(sched_info_on()))
 		memset(&p->sched_info, 0, sizeof(p->sched_info));
 #endif
-#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
+#if defined(CONFIG_SMP)
 	p->oncpu = 0;
 #endif
 #ifdef CONFIG_PREEMPT
@@ -5679,7 +5692,7 @@ void __cpuinit init_idle(struct task_struct *idle, int cpu)
 
 	spin_lock_irqsave(&rq->lock, flags);
 	rq->curr = rq->idle = idle;
-#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
+#if defined(CONFIG_SMP)
 	idle->oncpu = 1;
 #endif
 	spin_unlock_irqrestore(&rq->lock, flags);
