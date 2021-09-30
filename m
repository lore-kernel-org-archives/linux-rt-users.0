Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3956DC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0565361528
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350312AbhI3Ne4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:34:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50186 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350234AbhI3Nez (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 09:34:55 -0400
Date:   Thu, 30 Sep 2021 15:33:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633008792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+JYleO64s20bK7ms1IRFd0KdnYnGYEL2oNhy3I5zCPw=;
        b=Jtwv6nUJOx10ENuVcfXB2h1pOvQ+r25Hbgac84jb43pDpvBcg/1q40z1uY01nJ9BPOvlNL
        Mns2JClWHQzCXAwOs5wTMlTewAWFOiPPTSg3tzL+PKKgB6+Cc/Gw0wSnOxXlcuAkt4hDqW
        FkBoeG86T0HMLwj8DDekxn+cAq8uvCUOGIAXj+h3T6rwuAvLoxyzUnolmGHboegMLwsTUN
        KDTqqguhd7SnVj/XOiQUdVrC/aN0NaD3Pd67OuNCx3uqt9dKQC1Ys6ZVuPNTiyuOJ+PTV+
        D+gK9yQpVfVKzs3jBqsI1C+ITYKALeqnN33dGh/D6SnRfByu1p6ZvMSQHNrftQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633008792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+JYleO64s20bK7ms1IRFd0KdnYnGYEL2oNhy3I5zCPw=;
        b=kvtUpgj202E6fhxiIMHFzHFwkAQh3UZoRLnZFqEP3AA6U10X9+mQRt2CK0K/WLnyAOkASc
        ORneWfEold1jY7Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15-rc3-rt6
Message-ID: <20210930133310.tuixerkxa4ha4abd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15-rc3-rt6 patch set. 

Changes since v5.15-rc3-rt5:

  - A sequence counter in networking's bridge code was not annotated
    properly. Reported by Mike Galbraith patch by Thomas Gleixner.

  - Temporary export force_irqthreads_key so the i915 driver compiles as
    a module.

  - Dropped all need-resched checks from irq_poll and added a BH off/on
    section around the place that may raise softirqs in the CPU hotplug
    notifier. This is an equivalent replacement for the former checks.

  - Synchronize various patches (irq_work, sched, zsmalloc) with what
    has been posted upstream.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

The delta patch against v5.15-rc3-rt5 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15-rc3-rt5-rt6.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15-rc3-rt6

The RT patch against v5.15-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15-rc3-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15-rc3-rt6.tar.xz

Sebastian

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index cfc3804ec9a09..3ae8ba3fad3af 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -51,7 +51,7 @@ static inline bool irq_work_is_busy(struct irq_work *work)
 
 static inline bool irq_work_is_hard(struct irq_work *work)
 {
-       return atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ;
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ;
 }
 
 bool irq_work_queue(struct irq_work *work);
diff --git a/kernel/exit.c b/kernel/exit.c
index acd7aa9700db3..1d099609568db 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -60,11 +60,11 @@
 #include <linux/writeback.h>
 #include <linux/shm.h>
 #include <linux/kcov.h>
-#include <linux/kprobes.h>
 #include <linux/random.h>
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
 #include <linux/io_uring.h>
+#include <linux/kprobes.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 894e4db1fffcc..ac072b1d1a2d2 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -26,6 +26,7 @@
 
 #if defined(CONFIG_IRQ_FORCED_THREADING) && !defined(CONFIG_PREEMPT_RT)
 DEFINE_STATIC_KEY_FALSE(force_irqthreads_key);
+EXPORT_SYMBOL_GPL(force_irqthreads_key);
 
 static int __init setup_forced_irqthreads(char *arg)
 {
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 14c2aba4c9479..ee27f56381ee2 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -61,8 +61,8 @@ static void __irq_work_queue_local(struct irq_work *work)
 	if (work_flags & IRQ_WORK_LAZY)
 		lazy_work = true;
 	else if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
-		!(work_flags & IRQ_WORK_HARD_IRQ))
-			lazy_work = true;
+		 !(work_flags & IRQ_WORK_HARD_IRQ))
+		lazy_work = true;
 	else
 		lazy_work = false;
 
@@ -122,7 +122,6 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 
 		if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ)) {
 			if (llist_add(&work->node.llist, &per_cpu(lazy_list, cpu)))
-				/* && tick_nohz_tick_stopped_cpu(cpu) */
 				arch_send_call_function_single_ipi(cpu);
 		} else {
 			__smp_call_single_queue(cpu, &work->node.llist);
@@ -143,9 +142,9 @@ bool irq_work_needs_cpu(void)
 
 	raised = this_cpu_ptr(&raised_list);
 	lazy = this_cpu_ptr(&lazy_list);
-
-	if (llist_empty(raised) && llist_empty(lazy))
-		return false;
+	if (llist_empty(raised) || arch_irq_work_has_interrupt())
+		if (llist_empty(lazy))
+			return false;
 
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
@@ -192,12 +191,12 @@ static void irq_work_run_list(struct llist_head *list)
 	struct irq_work *work, *tmp;
 	struct llist_node *llnode;
 
-#ifndef CONFIG_PREEMPT_RT
 	/*
-	 * nort: On RT IRQ-work may run in SOFTIRQ context.
+	 * On PREEMPT_RT IRQ-work may run in SOFTIRQ context if it is not marked
+	 * explicitly that it needs to run in hardirq context.
 	 */
-	BUG_ON(!irqs_disabled());
-#endif
+	BUG_ON(!in_hardirq() && !IS_ENABLED(CONFIG_PREEMPT_RT));
+
 	if (llist_empty(list))
 		return;
 
@@ -213,16 +212,10 @@ static void irq_work_run_list(struct llist_head *list)
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
+	else if (!llist_empty(this_cpu_ptr(&lazy_list)))
+		raise_softirq(TIMER_SOFTIRQ);
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1ddd50f2a3d7f..5c7c0d0ad1d51 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4884,7 +4884,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 *   provided by mmdrop(),
 	 * - a sync_core for SYNC_CORE.
 	 */
-
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
 		mmdrop_sched(mm);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 27cd0052a2224..3d0157bd4e144 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -526,7 +526,6 @@ static int init_rootdomain(struct root_domain *rd)
 #ifdef HAVE_RT_PUSH_IPI
 	rd->rto_cpu = -1;
 	raw_spin_lock_init(&rd->rto_lock);
-//	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
 	rd->rto_push_work = IRQ_WORK_INIT_HARD(rto_push_irq_work_func);
 #endif
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 2364fd9acb09b..f0f26e1a00314 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -695,7 +695,6 @@ void flush_smp_call_function_from_idle(void)
 	flush_smp_call_function_queue(true);
 
 	if (local_softirq_pending()) {
-
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			do_softirq();
 		} else {
diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 7557bf7ecf1f1..2b9f797642f60 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -37,7 +37,6 @@ void irq_poll_sched(struct irq_poll *iop)
 	list_add_tail(&iop->list, this_cpu_ptr(&blk_cpu_iopoll));
 	raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
 	local_irq_restore(flags);
-	preempt_check_resched_rt();
 }
 EXPORT_SYMBOL(irq_poll_sched);
 
@@ -73,7 +72,6 @@ void irq_poll_complete(struct irq_poll *iop)
 	local_irq_save(flags);
 	__irq_poll_complete(iop);
 	local_irq_restore(flags);
-	preempt_check_resched_rt();
 }
 EXPORT_SYMBOL(irq_poll_complete);
 
@@ -98,7 +96,6 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 		}
 
 		local_irq_enable();
-		preempt_check_resched_rt();
 
 		/* Even though interrupts have been re-enabled, this
 		 * access is safe because interrupts can only add new
@@ -136,7 +133,6 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 		__raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
 
 	local_irq_enable();
-	preempt_check_resched_rt();
 }
 
 /**
@@ -195,12 +191,13 @@ static int irq_poll_cpu_dead(unsigned int cpu)
 	 * If a CPU goes away, splice its entries to the current CPU
 	 * and trigger a run of the softirq
 	 */
+	local_bh_disable();
 	local_irq_disable();
 	list_splice_init(&per_cpu(blk_cpu_iopoll, cpu),
 			 this_cpu_ptr(&blk_cpu_iopoll));
 	__raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
 	local_irq_enable();
-	preempt_check_resched_rt();
+	local_bh_enable();
 
 	return 0;
 }
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index fa1a7d8dc4ca8..d5e82e4a57ad0 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -828,8 +828,7 @@ static bool sg_miter_get_next_page(struct sg_mapping_iter *miter)
  *   stops @miter.
  *
  * Context:
- *   Don't care if @miter is stopped, or not proceeded yet.
- *   Otherwise, preemption disabled if the SG_MITER_ATOMIC is set.
+ *   Don't care.
  *
  * Returns:
  *   true if @miter contains the valid mapping.  false if end of sg
@@ -865,8 +864,7 @@ EXPORT_SYMBOL(sg_miter_skip);
  *   @miter->addr and @miter->length point to the current mapping.
  *
  * Context:
- *   Preemption disabled if SG_MITER_ATOMIC.  Preemption must stay disabled
- *   till @miter is stopped.  May sleep if !SG_MITER_ATOMIC.
+ *   May sleep if !SG_MITER_ATOMIC.
  *
  * Returns:
  *   true if @miter contains the next mapping.  false if end of sg
@@ -906,8 +904,7 @@ EXPORT_SYMBOL(sg_miter_next);
  *   need to be released during iteration.
  *
  * Context:
- *   Preemption disabled if the SG_MITER_ATOMIC is set.  Don't care
- *   otherwise.
+ *   Don't care otherwise.
  */
 void sg_miter_stop(struct sg_mapping_iter *miter)
 {
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e1..8fc605d806670 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d597df37bfb7c..22c18ac605b5f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -379,7 +379,7 @@ static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 #ifdef CONFIG_PREEMPT_RT
 static struct zsmalloc_handle *zs_get_pure_handle(unsigned long handle)
 {
-	return (void *)(handle &~((1 << OBJ_TAG_BITS) - 1));
+	return (void *)(handle & ~((1 << OBJ_TAG_BITS) - 1));
 }
 #endif
 
@@ -495,7 +495,6 @@ MODULE_ALIAS("zpool-zsmalloc");
 
 /* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
 static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
-	/* XXX remove this and use a spin_lock_t in pin_tag() */
 	.lock	= INIT_LOCAL_LOCK(lock),
 };
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3523c8c7068fd..f3d751105343c 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1677,8 +1677,6 @@ static void br_multicast_update_querier(struct net_bridge_mcast *brmctx,
 					int ifindex,
 					struct br_ip *saddr)
 {
-	lockdep_assert_held_once(&brmctx->br->multicast_lock);
-
 	write_seqcount_begin(&querier->seq);
 	querier->port_ifidx = ifindex;
 	memcpy(&querier->addr, saddr, sizeof(*saddr));
@@ -3867,13 +3865,13 @@ void br_multicast_ctx_init(struct net_bridge *br,
 
 	brmctx->ip4_other_query.delay_time = 0;
 	brmctx->ip4_querier.port_ifidx = 0;
-	seqcount_init(&brmctx->ip4_querier.seq);
+	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
 	brmctx->multicast_igmp_version = 2;
 #if IS_ENABLED(CONFIG_IPV6)
 	brmctx->multicast_mld_version = 1;
 	brmctx->ip6_other_query.delay_time = 0;
 	brmctx->ip6_querier.port_ifidx = 0;
-	seqcount_init(&brmctx->ip6_querier.seq);
+	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
 
 	timer_setup(&brmctx->ip4_mc_router_timer,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b4cef3a97f12b..e8136db44462c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -82,7 +82,7 @@ struct bridge_mcast_other_query {
 struct bridge_mcast_querier {
 	struct br_ip addr;
 	int port_ifidx;
-	seqcount_t seq;
+	seqcount_spinlock_t seq;
 };
 
 /* IGMP/MLD statistics */
