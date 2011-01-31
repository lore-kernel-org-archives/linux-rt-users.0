From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Linearized 2.6.33.7-rt30 patch set available (with free coffee!)
Date: Mon, 31 Jan 2011 13:05:50 -0800
Message-ID: <4D47242E.1000508@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------080508050701070100010300"
To: <paul.gortmaker@windriver.com>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:8106 "EHLO
	VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab1AaVGk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Jan 2011 16:06:40 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--------------080508050701070100010300
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi Paul,

Thanks for the patch set!  I had started down the path of doing
the same work, and truly appreciate the effort you put into this.

One of the patches had a chunk that failed to apply:

genirq-support-forced-threading-of-interrupts.patch

patching file kernel/irq/manage.c
Hunk #2 succeeded at 465 (offset 3 lines).
Hunk #3 succeeded at 633 (offset 3 lines).
Hunk #4 succeeded at 706 (offset 3 lines).
Hunk #5 succeeded at 736 (offset 3 lines).
Hunk #6 succeeded at 804 (offset 3 lines).
Hunk #7 FAILED at 829.
1 out of 7 hunks FAILED -- rejects in file kernel/irq/manage.c


I fixed it up and I am attaching the new version of the patch.

With the fixed patch, the kernel source tree with your patches
applied matches the kernel source tree with the monolithic
2.6.33.7-rt30 patch applied.

-Frank Rowand

--------------080508050701070100010300
Content-Type: text/x-patch;
	name="genirq-support-forced-threading-of-interrupts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="genirq-support-forced-threading-of-interrupts.patch"

>From b23664db5316f231a75007c9cfc3922e797cee2e Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 16 Jul 2009 12:23:12 +0200
Subject: [PATCH] genirq: support forced threading of interrupts

commit 8baf330d664a262b4e6d42728b40e6161ef02183 in tip.

Based on the mainline infrastructure we force thread all interrupts
with per device threads.

[PG: put HARDIRQ directly into PFE extra_flags; flatten some other
 irq changes buried in merge commits back into this commit.]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

---
 include/linux/interrupt.h |   13 	11 +	2 -	0 !
 include/linux/irq.h       |    1 	1 +	0 -	0 !
 include/linux/sched.h     |    1 	1 +	0 -	0 !
 kernel/irq/chip.c         |    1 	1 +	0 -	0 !
 kernel/irq/handle.c       |   26 	25 +	1 -	0 !
 kernel/irq/manage.c       |   97 	90 +	7 -	0 !
 kernel/irq/migration.c    |    3 	2 +	1 -	0 !
 kernel/sched.c            |    3 	2 +	1 -	0 !
 8 files changed, 133 insertions(+), 12 deletions(-)

Index: b/include/linux/interrupt.h
===================================================================
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -95,6 +95,7 @@ typedef irqreturn_t (*irq_handler_t)(int
  * @thread_fn:	interupt handler function for threaded interrupts
  * @thread:	thread pointer for threaded interrupts
  * @thread_flags:	flags related to @thread
+ * @thread_mask:	bit mask to account for forced threads
  */
 struct irqaction {
 	irq_handler_t handler;
@@ -107,6 +108,7 @@ struct irqaction {
 	irq_handler_t thread_fn;
 	struct task_struct *thread;
 	unsigned long thread_flags;
+	unsigned long thread_mask;
 };
 
 extern irqreturn_t no_action(int cpl, void *dev_id);
@@ -323,6 +325,7 @@ static inline int disable_irq_wake(unsig
 
 #ifndef __ARCH_SET_SOFTIRQ_PENDING
 #define set_softirq_pending(x) (local_softirq_pending() = (x))
+// FIXME: PREEMPT_RT: set_bit()?
 #define or_softirq_pending(x)  (local_softirq_pending() |= (x))
 #endif
 
@@ -371,9 +374,15 @@ struct softirq_action
 	void	(*action)(struct softirq_action *);
 };
 
-#define __raise_softirq_irqoff(nr) \
+#ifdef CONFIG_PREEMPT_HARDIRQS
+# define __raise_softirq_irqoff(nr) raise_softirq_irqoff(nr)
+# define __do_raise_softirq_irqoff(nr) \
 	do { or_softirq_pending(1UL << (nr)); } while (0)
-#define __do_raise_softirq_irqoff(nr) __raise_softirq_irqoff(nr)
+#else
+# define __raise_softirq_irqoff(nr) \
+	do { or_softirq_pending(1UL << (nr)); } while (0)
+# define __do_raise_softirq_irqoff(nr) __raise_softirq_irqoff(nr)
+#endif
 
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
Index: b/include/linux/irq.h
===================================================================
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -201,6 +201,7 @@ struct irq_desc {
 #endif
 #endif
 	atomic_t		threads_active;
+	unsigned long		forced_threads_active;
 	wait_queue_head_t       wait_for_threads;
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry	*dir;
Index: b/include/linux/sched.h
===================================================================
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1799,6 +1799,7 @@ extern void thread_group_times(struct ta
 
 /* Flags in the extra_flags field */
 #define PFE_SOFTIRQ	0x00000001	/* softirq context */
+#define PFE_HARDIRQ	0x00000002	/* hardirq thread */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: b/kernel/irq/chip.c
===================================================================
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -309,6 +309,7 @@ static unsigned int default_startup(unsi
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
+	desc->status &= ~IRQ_MASKED;
 	desc->chip->enable(irq);
 	return 0;
 }
Index: b/kernel/irq/handle.c
===================================================================
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -360,6 +360,25 @@ static void warn_no_thread(unsigned int 
 	       "but no thread function available.", irq, action->name);
 }
 
+/*
+ * Momentary workaround until I have a brighter idea how to handle the
+ * accounting of forced threaded (shared) handlers.
+ */
+irqreturn_t handle_irq_action(unsigned int irq, struct irqaction *action)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (desc->status & IRQ_ONESHOT) {
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&desc->lock, flags);
+		desc->forced_threads_active |= action->thread_mask;
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+		return IRQ_WAKE_THREAD;
+	}
+	return action->handler(irq, action->dev_id);
+}
+
 /**
  * handle_IRQ_event - irq action chain handler
  * @irq:	the interrupt number
@@ -377,7 +396,7 @@ irqreturn_t handle_IRQ_event(unsigned in
 
 	do {
 		trace_irq_handler_entry(irq, action);
-		ret = action->handler(irq, action->dev_id);
+		ret = handle_irq_action(irq, action);
 		trace_irq_handler_exit(irq, action, ret);
 
 		switch (ret) {
@@ -454,6 +473,11 @@ unsigned int __do_IRQ(unsigned int irq)
 	struct irqaction *action;
 	unsigned int status;
 
+#ifdef CONFIG_PREEMPT_RT
+	printk(KERN_WARNING "__do_IRQ called for irq %d. "
+	       "PREEMPT_RT will crash your system soon\n", irq);
+	printk(KERN_WARNING "I hope you have a fire-extinguisher handy!\n");
+#endif
 	kstat_incr_irqs_this_cpu(irq, desc);
 
 	if (CHECK_IRQ_PER_CPU(desc->status)) {
Index: b/kernel/irq/manage.c
===================================================================
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -280,7 +280,8 @@ void __enable_irq(struct irq_desc *desc,
 			goto err_out;
 		/* Prevent probing on this irq: */
 		desc->status = status | IRQ_NOPROBE;
-		check_irq_resend(desc, irq);
+		if (!desc->forced_threads_active)
+			check_irq_resend(desc, irq);
 		/* fall-through */
 	}
 	default:
@@ -464,7 +465,81 @@ static irqreturn_t irq_nested_primary_ha
 	return IRQ_NONE;
 }
 
-static int irq_wait_for_interrupt(struct irqaction *action)
+#ifdef CONFIG_PREEMPT_HARDIRQS
+/*
+ * If the caller does not request irq threading then the handler
+ * becomes the thread function and we use the above handler as the
+ * primary hardirq context handler.
+ */
+static void preempt_hardirq_setup(struct irqaction *new)
+{
+	if (new->thread_fn || (new->flags & IRQF_NODELAY))
+		return;
+
+	new->flags |= IRQF_ONESHOT;
+	new->thread_fn = new->handler;
+	new->handler = irq_default_primary_handler;
+}
+
+#else
+static inline void preempt_hardirq_setup(struct irqaction *new) { }
+#endif
+
+/*
+ * forced threaded interrupts need to unmask the interrupt line
+ */
+static int preempt_hardirq_thread_done(struct irq_desc *desc,
+					struct irqaction *action)
+{
+	unsigned long masked;
+
+	if (!(desc->status & IRQ_ONESHOT))
+		return 0;
+again:
+	raw_spin_lock_irq(&desc->lock);
+	/*
+	 * Be careful. The hardirq handler might be running on the
+	 * other CPU.
+	 */
+	if (desc->status & IRQ_INPROGRESS) {
+		raw_spin_unlock_irq(&desc->lock);
+		cpu_relax();
+		goto again;
+	}
+
+	/*
+	 * Now check again, whether the thread should run. Otherwise
+	 * we would clear the forced_threads_active bit which was just
+	 * set.
+	 */
+	if (test_bit(IRQTF_RUNTHREAD, &action->thread_flags)) {
+		raw_spin_unlock_irq(&desc->lock);
+		return 1;
+	}
+
+	masked = desc->forced_threads_active;
+	desc->forced_threads_active &= ~action->thread_mask;
+
+	/*
+	 * Unmask the interrupt line when this is the last active
+	 * thread and the interrupt is not disabled.
+	 */
+	if (masked && !desc->forced_threads_active &&
+	    !(desc->status & IRQ_DISABLED)) {
+		if (desc->chip->unmask)
+			desc->chip->unmask(action->irq);
+		/*
+		 * Do we need to call check_irq_resend() here ?
+		 * No. check_irq_resend needs only to be checked when
+		 * we go from IRQ_DISABLED to IRQ_ENABLED state.
+		 */
+	}
+	raw_spin_unlock_irq(&desc->lock);
+	return 0;
+}
+
+static int
+irq_wait_for_interrupt(struct irq_desc *desc, struct irqaction *action)
 {
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -558,9 +633,10 @@ static int irq_thread(void *data)
 	int wake, oneshot = desc->status & IRQ_ONESHOT;
 
 	sched_setscheduler(current, SCHED_FIFO, &param);
+	current->extra_flags |= PFE_HARDIRQ;
 	current->irqaction = action;
 
-	while (!irq_wait_for_interrupt(action)) {
+	while (!irq_wait_for_interrupt(desc, action)) {
 
 		irq_thread_check_affinity(desc, action);
 
@@ -630,7 +706,7 @@ __setup_irq(unsigned int irq, struct irq
 {
 	struct irqaction *old, **old_ptr;
 	const char *old_name = NULL;
-	unsigned long flags;
+	unsigned long flags, thread_mask = 0;
 	int nested, shared = 0;
 	int ret;
 
@@ -656,9 +732,8 @@ __setup_irq(unsigned int irq, struct irq
 		rand_initialize_irq(irq);
 	}
 
-	/* Oneshot interrupts are not allowed with shared */
-	if ((new->flags & IRQF_ONESHOT) && (new->flags & IRQF_SHARED))
-		return -EINVAL;
+	/* Preempt-RT setup for forced threading */
+	preempt_hardirq_setup(new);
 
 	/*
 	 * Check whether the interrupt nests into another interrupt
@@ -725,12 +800,20 @@ __setup_irq(unsigned int irq, struct irq
 
 		/* add new interrupt at end of irq queue */
 		do {
+			thread_mask |= old->thread_mask;
 			old_ptr = &old->next;
 			old = *old_ptr;
 		} while (old);
 		shared = 1;
 	}
 
+	/*
+	 * Setup the thread mask for this irqaction. No risk that ffz
+	 * will fail. If we have 32 resp. 64 devices sharing one irq
+	 * then .....
+	 */
+	new->thread_mask = 1 << ffz(thread_mask);
+
 	if (!shared) {
 		irq_chip_set_defaults(desc->chip);
 
Index: b/kernel/irq/migration.c
===================================================================
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -66,7 +66,8 @@ void move_native_irq(int irq)
 	 * If the irq is already in progress, it should be masked.
 	 * If we unmask it, we might cause an interrupt storm on RT.
 	 */
-	if (unlikely(desc->status & IRQ_INPROGRESS))
+	if (unlikely((desc->status & IRQ_INPROGRESS) ||
+		     desc->forced_threads_active))
 		mask = 0;
 
 	if (mask)
Index: b/kernel/sched.c
===================================================================
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -5147,7 +5147,8 @@ void account_system_time(struct task_str
 
 	/* Add system time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
-	if (hardirq_count() - hardirq_offset)
+	if ((hardirq_count() - hardirq_offset) ||
+	    (p->extra_flags & PFE_HARDIRQ))
 		cpustat->irq = cputime64_add(cpustat->irq, tmp);
 	else if (softirq_count() || (p->extra_flags & PFE_SOFTIRQ))
 		cpustat->softirq = cputime64_add(cpustat->softirq, tmp);

--------------080508050701070100010300--
