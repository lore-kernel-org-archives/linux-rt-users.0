Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942EAC4332F
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 16:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348073AbhKXQPq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 11:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbhKXQPm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 11:15:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBA7C061714;
        Wed, 24 Nov 2021 08:12:32 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637770350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78hA2G8Hq5PzgNcbacWuFgDWwnHxf/RrDAb03DfHPUs=;
        b=ePqfQ7FH3yqUTb11wQcWtBHIpn/LNmnESgD4xTaAfSRYLQz/FgA7NFsd+Mb+JKTV5GMwKh
        +YIgS1pwtJao2T/LDpz7Mbj173oYaYCqWKpyV2FWajSZZY6jOKvyzQ0m6vF2GTBTH5EnhU
        ARjFds/WGEtBEjxBaPAhHUifMFzN8Tb8U6Lkcw9h81pqtT5l3U9sYot6pVW922zQ14FUUG
        hMN/1IebE0dIYJc1icKI0FOmOX3tIYijJbmkrC7NFJjlImB7OiVSks0IC9xmdQYgaEoakm
        Kx7FUKwD3oqnxVvugYzj4+LDRxSxGxVoc+GguEIF3kW/FtL+qAIbna9x2UOQ8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637770350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78hA2G8Hq5PzgNcbacWuFgDWwnHxf/RrDAb03DfHPUs=;
        b=9BYPKIoo3JbzWzA9Lm9+SJLz/rLoJJrBz9hAEFCcccj/zFJoNa295jecKJZ/GBg8+YzuDO
        GdNBXU9OFx9ODrAw==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Clark Williams <williams@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        bigeasy@linutronix.de
Subject: [PATCH RT 2/3] irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT
Date:   Wed, 24 Nov 2021 17:12:20 +0100
Message-Id: <20211124161221.2224005-3-bigeasy@linutronix.de>
In-Reply-To: <20211124161221.2224005-1-bigeasy@linutronix.de>
References: <20211123103755.12d4b776@gandalf.local.home>
 <20211124161221.2224005-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The irq_work callback is invoked in hard IRQ context. By default all
callbacks are scheduled for invocation right away (given supported by
the architecture) except for the ones marked IRQ_WORK_LAZY which are
delayed until the next timer-tick.

While looking over the callbacks, some of them may acquire locks
(spinlock_t, rwlock_t) which are transformed into sleeping locks on
PREEMPT_RT and must not be acquired in hard IRQ context.
Changing the locks into locks which could be acquired in this context
will lead to other problems such as increased latencies if everything
in the chain has IRQ-off locks. This will not solve all the issues as
one callback has been noticed which invoked kref_put() and its callback
invokes kfree() and this can not be invoked in hardirq context.

Some callbacks are required to be invoked in hardirq context even on
PREEMPT_RT to work properly. This includes for instance the NO_HZ
callback which needs to be able to observe the idle context.

The callbacks which require to be run in hardirq have already been
marked. Use this information to split the callbacks onto the two lists
on PREEMPT_RT:
- lazy_list
  Work items which are not marked with IRQ_WORK_HARD_IRQ will be added
  to this list. Callbacks on this list will be invoked from a per-CPU
  thread.
  The handler here may acquire sleeping locks such as spinlock_t and
  invoke kfree().

- raised_list
  Work items which are marked with IRQ_WORK_HARD_IRQ will be added to
  this list. They will be invoked in hardirq context and must not
  acquire any sleeping locks.

The wake up of the per-CPU thread occurs from irq_work handler/
hardirq context. The thread runs with lowest RT priority to ensure it
runs before any SCHED_OTHER tasks do.

[bigeasy: melt tglx's irq_work_tick_soft() which splits irq_work_tick() int=
o a
	  hard and soft variant. Collected fixes over time from Steven
	  Rostedt and Mike Galbraith. Move to per-CPU threads instead of
	  softirq as suggested by PeterZ.]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211007092646.uhshe3ut2wkrcfzv@linutronix.=
de
---
 include/linux/irq_work.h |  16 +++--
 kernel/irq_work.c        | 127 +++++++++++++++++++++++++++++----------
 kernel/time/timer.c      |   2 -
 3 files changed, 104 insertions(+), 41 deletions(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 3c6d3a96bca0f..f551ba9c99d40 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -40,6 +40,16 @@ void init_irq_work(struct irq_work *work, void (*func)(s=
truct irq_work *))
 		.irqwait =3D __RCUWAIT_INITIALIZER(irqwait),	\
 }
=20
+#define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
+	.flags =3D ATOMIC_INIT(_flags),				\
+	.func =3D (_func),					\
+	.irqwait =3D __RCUWAIT_INITIALIZER(irqwait),		\
+}
+
+#define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
+#define IRQ_WORK_INIT_LAZY(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_LAZY)
+#define IRQ_WORK_INIT_HARD(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_HARD_IRQ)
+
 static inline bool irq_work_is_busy(struct irq_work *work)
 {
 	return atomic_read(&work->flags) & IRQ_WORK_BUSY;
@@ -63,10 +73,4 @@ static inline void irq_work_run(void) { }
 static inline void irq_work_single(void *arg) { }
 #endif
=20
-#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT)
-void irq_work_tick_soft(void);
-#else
-static inline void irq_work_tick_soft(void) { }
-#endif
-
 #endif /* _LINUX_IRQ_WORK_H */
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 8969aff790e21..03d09d779ee12 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -18,12 +18,37 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
+#include <linux/smpboot.h>
 #include <linux/interrupt.h>
 #include <asm/processor.h>
=20
=20
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
+static DEFINE_PER_CPU(struct task_struct *, irq_workd);
+
+static void wake_irq_workd(void)
+{
+	struct task_struct *tsk =3D __this_cpu_read(irq_workd);
+
+	if (!llist_empty(this_cpu_ptr(&lazy_list)) && tsk)
+		wake_up_process(tsk);
+}
+
+#ifdef CONFIG_SMP
+static void irq_work_wake(struct irq_work *entry)
+{
+	wake_irq_workd();
+}
+
+static DEFINE_PER_CPU(struct irq_work, irq_work_wakeup) =3D
+	IRQ_WORK_INIT_HARD(irq_work_wake);
+#endif
+
+static int irq_workd_should_run(unsigned int cpu)
+{
+	return !llist_empty(this_cpu_ptr(&lazy_list));
+}
=20
 /*
  * Claim the entry so that no one else will poke at it.
@@ -54,20 +79,28 @@ void __weak arch_irq_work_raise(void)
 static void __irq_work_queue_local(struct irq_work *work)
 {
 	struct llist_head *list;
-	bool lazy_work, realtime =3D IS_ENABLED(CONFIG_PREEMPT_RT);
+	bool rt_lazy_work =3D false;
+	bool lazy_work =3D false;
+	int work_flags;
=20
-	lazy_work =3D atomic_read(&work->flags) & IRQ_WORK_LAZY;
+	work_flags =3D atomic_read(&work->flags);
+	if (work_flags & IRQ_WORK_LAZY)
+		lazy_work =3D true;
+	else if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		 !(work_flags & IRQ_WORK_HARD_IRQ))
+		rt_lazy_work =3D true;
=20
-	/* If the work is "lazy", handle it from next tick if any */
-	if (lazy_work || (realtime && !(atomic_read(&work->flags) & IRQ_WORK_HARD=
_IRQ)))
+	if (lazy_work || rt_lazy_work)
 		list =3D this_cpu_ptr(&lazy_list);
 	else
 		list =3D this_cpu_ptr(&raised_list);
=20
-	if (llist_add(&work->llnode, list)) {
-		if (!lazy_work || tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	}
+	if (!llist_add(&work->llnode, list))
+		return;
+
+	/* If the work is "lazy", handle it from next tick if any */
+	if (!lazy_work || tick_nohz_tick_stopped())
+		arch_irq_work_raise();
 }
=20
 /* Enqueue the irq work @work on the current CPU */
@@ -110,15 +143,27 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
=20
-		if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(atomic_read(&work->flags) & IRQ_W=
ORK_HARD_IRQ)) {
-			if (llist_add(&work->llnode, &per_cpu(lazy_list, cpu)))
-				arch_send_call_function_single_ipi(cpu);
-		} else {
-			__smp_call_single_queue(cpu, &work->llnode);
+		/*
+		 * On PREEMPT_RT the items which are not marked as
+		 * IRQ_WORK_HARD_IRQ are added to the lazy list and a HARD work
+		 * item is used on the remote CPU to wake the thread.
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		    !(atomic_read(&work->flags) & IRQ_WORK_HARD_IRQ)) {
+
+			if (!llist_add(&work->llnode, &per_cpu(lazy_list, cpu)))
+				goto out;
+
+			work =3D &per_cpu(irq_work_wakeup, cpu);
+			if (!irq_work_claim(work))
+				goto out;
 		}
+
+		__smp_call_single_queue(cpu, &work->llnode);
 	} else {
 		__irq_work_queue_local(work);
 	}
+out:
 	preempt_enable();
=20
 	return true;
@@ -175,12 +220,13 @@ static void irq_work_run_list(struct llist_head *list)
 	struct irq_work *work, *tmp;
 	struct llist_node *llnode;
=20
-#ifndef CONFIG_PREEMPT_RT
 	/*
-	 * nort: On RT IRQ-work may run in SOFTIRQ context.
+	 * On PREEMPT_RT IRQ-work which is not marked as HARD will be processed
+	 * in a per-CPU thread in preemptible context. Only the items which are
+	 * marked as IRQ_WORK_HARD_IRQ will be processed in hardirq context.
 	 */
-	BUG_ON(!irqs_disabled());
-#endif
+	BUG_ON(!irqs_disabled() && !IS_ENABLED(CONFIG_PREEMPT_RT));
+
 	if (llist_empty(list))
 		return;
=20
@@ -196,16 +242,10 @@ static void irq_work_run_list(struct llist_head *list)
 void irq_work_run(void)
 {
 	irq_work_run_list(this_cpu_ptr(&raised_list));
-	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		/*
-		 * NOTE: we raise softirq via IPI for safety,
-		 * and execute in irq_work_tick() to move the
-		 * overhead from hard to soft irq context.
-		 */
-		if (!llist_empty(this_cpu_ptr(&lazy_list)))
-			raise_softirq(TIMER_SOFTIRQ);
-	} else
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else
+		wake_irq_workd();
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
=20
@@ -218,15 +258,10 @@ void irq_work_tick(void)
=20
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else
+		wake_irq_workd();
 }
=20
-#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT)
-void irq_work_tick_soft(void)
-{
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
-}
-#endif
-
 /*
  * Synchronize against the irq_work @entry, ensures the entry is not
  * currently in use.
@@ -246,3 +281,29 @@ void irq_work_sync(struct irq_work *work)
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
+
+static void run_irq_workd(unsigned int cpu)
+{
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
+}
+
+static void irq_workd_setup(unsigned int cpu)
+{
+	sched_set_fifo_low(current);
+}
+
+static struct smp_hotplug_thread irqwork_threads =3D {
+	.store                  =3D &irq_workd,
+	.setup			=3D irq_workd_setup,
+	.thread_should_run      =3D irq_workd_should_run,
+	.thread_fn              =3D run_irq_workd,
+	.thread_comm            =3D "irq_work/%u",
+};
+
+static __init int irq_work_init_threads(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		BUG_ON(smpboot_register_percpu_thread(&irqwork_threads));
+	return 0;
+}
+early_initcall(irq_work_init_threads);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index af3daf03c9177..cd67ee6d2634d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1767,8 +1767,6 @@ static __latent_entropy void run_timer_softirq(struct=
 softirq_action *h)
 {
 	struct timer_base *base =3D this_cpu_ptr(&timer_bases[BASE_STD]);
=20
-	irq_work_tick_soft();
-
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
--=20
2.34.0

