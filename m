From: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] genirq: Handle force threading of irqs with primary and
 thread handler
Date: Mon, 21 Sep 2015 11:04:31 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509211101190.5606@nanos>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-908698554-1442826272=:5606"
Cc: linux-rt-users@vger.kernel.org, msmucr@gmail.com,
	bigeasy@linutronix.de
To: Nathan Sullivan <nathan.sullivan@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35518 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbbIUJFH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 05:05:07 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-908698554-1442826272=:5606
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Force threading of interrupts does not deal with interrupts which are
requested with a primary and a threaded handler. The current policy is
to leave them alone and let the primary handler run in interrupt
context, but we set the ONESHOT flag for those interrupts as well.

Kohji Okuno debugged a problem with the SDHCI driver where the
interrupt thread waits for a hardware interrupt to trigger, which cant
work well because the hardware interrupt is masked due to the ONESHOT
flag being set. He proposed to set the ONESHOT flag only if the
interrupt does not provide a thread handler.

Though that does not work either because these interrupts can be
shared. So the other interrupt would rightfully get the ONESHOT flag
set and therefor the same situation would happen again.

To deal with this proper, we need to force thread the primary handler
of such interrupts as well. That means that the primary interrupt
handler is treated as any other primary interrupt handler which is not
marked IRQF_NO_THREAD. The threaded handler becomes a separate thread
so the SDHCI flow logic can be handled gracefully.

The same issue was reported against 4.1-rt.

Reported-by: Kohji Okuno <okuno.kohji@jp.panasonic.com>
Reported-By: Michal ¦mucr <msmucr@gmail.com>
Reported-by: Nathan Sullivan <nathan.sullivan@ni.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

This requires to revert commit: d04ea10ba1ea 'mmc: sdhci: don't provide
hard irq handler'

 include/linux/interrupt.h |    2 
 kernel/irq/manage.c       |  160 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 120 insertions(+), 42 deletions(-)

Index: linux-rt-devel/include/linux/interrupt.h
===================================================================
--- linux-rt-devel.orig/include/linux/interrupt.h
+++ linux-rt-devel/include/linux/interrupt.h
@@ -104,6 +104,7 @@ typedef irqreturn_t (*irq_handler_t)(int
  * @flags:	flags (see IRQF_* above)
  * @thread_fn:	interrupt handler function for threaded interrupts
  * @thread:	thread pointer for threaded interrupts
+ * @secondary:	pointer to secondary irqaction (force threading)
  * @thread_flags:	flags related to @thread
  * @thread_mask:	bitmask for keeping track of @thread activity
  * @dir:	pointer to the proc/irq/NN/name entry
@@ -115,6 +116,7 @@ struct irqaction {
 	struct irqaction	*next;
 	irq_handler_t		thread_fn;
 	struct task_struct	*thread;
+	struct irqaction	*secondary;
 	unsigned int		irq;
 	unsigned int		flags;
 	unsigned long		thread_flags;
Index: linux-rt-devel/kernel/irq/manage.c
===================================================================
--- linux-rt-devel.orig/kernel/irq/manage.c
+++ linux-rt-devel/kernel/irq/manage.c
@@ -772,6 +772,12 @@ static irqreturn_t irq_nested_primary_ha
 	return IRQ_NONE;
 }
 
+static irqreturn_t irq_forced_secondary_handler(int irq, void *dev_id)
+{
+	WARN(1, "Secondary action handler called for irq %d\n", irq);
+	return IRQ_NONE;
+}
+
 static int irq_wait_for_interrupt(struct irqaction *action)
 {
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -798,7 +804,8 @@ static int irq_wait_for_interrupt(struct
 static void irq_finalize_oneshot(struct irq_desc *desc,
 				 struct irqaction *action)
 {
-	if (!(desc->istate & IRQS_ONESHOT))
+	if (!(desc->istate & IRQS_ONESHOT) ||
+	    action->handler == irq_forced_secondary_handler)
 		return;
 again:
 	chip_bus_lock(desc);
@@ -960,6 +967,18 @@ static void irq_thread_dtor(struct callb
 	irq_finalize_oneshot(desc, action);
 }
 
+static void irq_wake_secondary(struct irq_desc *desc, struct irqaction *action)
+{
+	struct irqaction *secondary = action->secondary;
+
+	if (WARN_ON_ONCE(!secondary))
+		return;
+
+	raw_spin_lock_irq(&desc->lock);
+	__irq_wake_thread(desc, secondary);
+	raw_spin_unlock_irq(&desc->lock);
+}
+
 /*
  * Interrupt handler thread
  */
@@ -990,6 +1009,8 @@ static int irq_thread(void *data)
 		action_ret = handler_fn(desc, action);
 		if (action_ret == IRQ_HANDLED)
 			atomic_inc(&desc->threads_handled);
+		if (action_ret == IRQ_WAKE_THREAD)
+			irq_wake_secondary(desc, action);
 
 #ifdef CONFIG_PREEMPT_RT_FULL
 		migrate_disable();
@@ -1040,20 +1061,36 @@ void irq_wake_thread(unsigned int irq, v
 }
 EXPORT_SYMBOL_GPL(irq_wake_thread);
 
-static void irq_setup_forced_threading(struct irqaction *new)
+static int irq_setup_forced_threading(struct irqaction *new)
 {
 	if (!force_irqthreads)
-		return;
+		return 0;
 	if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
-		return;
+		return 0;
 
 	new->flags |= IRQF_ONESHOT;
 
-	if (!new->thread_fn) {
-		set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
-		new->thread_fn = new->handler;
-		new->handler = irq_default_primary_handler;
-	}
+	/*
+	 * Handle the case where we have a real primary handler and a
+	 * thread handler. We force thread them as well by creating a
+	 * secondary action.
+	 */
+	if (new->handler != irq_default_primary_handler && new->thread_fn) {
+		/* Allocate the secondary action */
+		new->secondary = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
+		if (!new->secondary)
+			return -ENOMEM;
+		new->secondary->handler = irq_forced_secondary_handler;
+		new->secondary->thread_fn = new->thread_fn;
+		new->secondary->dev_id = new->dev_id;
+		new->secondary->irq = new->irq;
+		new->secondary->name = new->name;
+	}
+	/* Deal with the primary handler */
+	set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
+	new->thread_fn = new->handler;
+	new->handler = irq_default_primary_handler;
+	return 0;
 }
 
 static int irq_request_resources(struct irq_desc *desc)
@@ -1073,6 +1110,48 @@ static void irq_release_resources(struct
 		c->irq_release_resources(d);
 }
 
+static int
+setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
+{
+	struct task_struct *t;
+	struct sched_param param = {
+		.sched_priority = MAX_USER_RT_PRIO/2,
+	};
+
+	if (!secondary) {
+		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
+				   new->name);
+	} else {
+		t = kthread_create(irq_thread, new, "irq/%d-s-%s", irq,
+				   new->name);
+		param.sched_priority += 1;
+	}
+
+	if (IS_ERR(t))
+		return PTR_ERR(t);
+
+	sched_setscheduler_nocheck(t, SCHED_FIFO, &param);
+
+	/*
+	 * We keep the reference to the task struct even if
+	 * the thread dies to avoid that the interrupt code
+	 * references an already freed task_struct.
+	 */
+	get_task_struct(t);
+	new->thread = t;
+	/*
+	 * Tell the thread to set its affinity. This is
+	 * important for shared interrupt handlers as we do
+	 * not invoke setup_affinity() for the secondary
+	 * handlers as everything is already set up. Even for
+	 * interrupts marked with IRQF_NO_BALANCE this is
+	 * correct as we want the thread to move to the cpu(s)
+	 * on which the requesting code placed the interrupt.
+	 */
+	set_bit(IRQTF_AFFINITY, &new->thread_flags);
+	return 0;
+}
+
 /*
  * Internal function to register an irqaction - typically used to
  * allocate special interrupts that are part of the architecture.
@@ -1093,6 +1172,8 @@ __setup_irq(unsigned int irq, struct irq
 	if (!try_module_get(desc->owner))
 		return -ENODEV;
 
+	new->irq = irq;
+
 	/*
 	 * Check whether the interrupt nests into another interrupt
 	 * thread.
@@ -1110,8 +1191,11 @@ __setup_irq(unsigned int irq, struct irq
 		 */
 		new->handler = irq_nested_primary_handler;
 	} else {
-		if (irq_settings_can_thread(desc))
-			irq_setup_forced_threading(new);
+		if (irq_settings_can_thread(desc)) {
+			ret = irq_setup_forced_threading(new);
+			if (ret)
+				goto out_mput;
+		}
 	}
 
 	/*
@@ -1120,37 +1204,14 @@ __setup_irq(unsigned int irq, struct irq
 	 * thread.
 	 */
 	if (new->thread_fn && !nested) {
-		struct task_struct *t;
-		static const struct sched_param param = {
-			.sched_priority = MAX_USER_RT_PRIO/2,
-		};
-
-		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
-				   new->name);
-		if (IS_ERR(t)) {
-			ret = PTR_ERR(t);
+		ret = setup_irq_thread(new, irq, false);
+		if (ret)
 			goto out_mput;
+		if (new->secondary) {
+			ret = setup_irq_thread(new->secondary, irq, true);
+			if (ret)
+				goto out_thread;
 		}
-
-		sched_setscheduler_nocheck(t, SCHED_FIFO, &param);
-
-		/*
-		 * We keep the reference to the task struct even if
-		 * the thread dies to avoid that the interrupt code
-		 * references an already freed task_struct.
-		 */
-		get_task_struct(t);
-		new->thread = t;
-		/*
-		 * Tell the thread to set its affinity. This is
-		 * important for shared interrupt handlers as we do
-		 * not invoke setup_affinity() for the secondary
-		 * handlers as everything is already set up. Even for
-		 * interrupts marked with IRQF_NO_BALANCE this is
-		 * correct as we want the thread to move to the cpu(s)
-		 * on which the requesting code placed the interrupt.
-		 */
-		set_bit(IRQTF_AFFINITY, &new->thread_flags);
 	}
 
 	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
@@ -1326,7 +1387,6 @@ __setup_irq(unsigned int irq, struct irq
 				   irq, nmsk, omsk);
 	}
 
-	new->irq = irq;
 	*old_ptr = new;
 
 	irq_pm_install_action(desc, new);
@@ -1352,6 +1412,8 @@ __setup_irq(unsigned int irq, struct irq
 	 */
 	if (new->thread)
 		wake_up_process(new->thread);
+	if (new->secondary)
+		wake_up_process(new->secondary->thread);
 
 	register_irq_proc(irq, desc);
 	new->dir = NULL;
@@ -1382,6 +1444,13 @@ out_thread:
 		kthread_stop(t);
 		put_task_struct(t);
 	}
+	if (new->secondary && new->secondary->thread) {
+		struct task_struct *t = new->secondary->thread;
+
+		new->secondary->thread = NULL;
+		kthread_stop(t);
+		put_task_struct(t);
+	}
 out_mput:
 	module_put(desc->owner);
 	return ret;
@@ -1489,9 +1558,14 @@ static struct irqaction *__free_irq(unsi
 	if (action->thread) {
 		kthread_stop(action->thread);
 		put_task_struct(action->thread);
+		if (action->secondary && action->secondary->thread) {
+			kthread_stop(action->secondary->thread);
+			put_task_struct(action->secondary->thread);
+		}
 	}
 
 	module_put(desc->owner);
+	kfree(action->secondary);
 	return action;
 }
 
@@ -1635,8 +1709,10 @@ int request_threaded_irq(unsigned int ir
 	retval = __setup_irq(irq, desc, action);
 	chip_bus_sync_unlock(desc);
 
-	if (retval)
+	if (retval) {
+		kfree(action->secondary);
 		kfree(action);
+	}
 
 #ifdef CONFIG_DEBUG_SHIRQ_FIXME
 	if (!retval && (irqflags & IRQF_SHARED)) {
--8323329-908698554-1442826272=:5606--
