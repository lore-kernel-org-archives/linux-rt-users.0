Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81881C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51139611C3
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhIJTMC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:12:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40430 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhIJTMB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Sep 2021 15:12:01 -0400
Date:   Fri, 10 Sep 2021 21:10:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631301049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8khTX1CvTlgTlIcJkxq/qvesJRVMriFMuCA/F24/omM=;
        b=Td+JiNWVNoPcLbf+9TD2s2w6i4vDy95bxYl4BiGUtSogGgLwaLTAy0yVdFHSanvGaieGKn
        Z0Z95CBex9+J6OiObBS2WJnSU32/j/rBMoDCDHFORwBlgWhqmhPU854PP3DPMRNPkt0jXI
        18rpOJr19GEIztzsj7lr/RVWzj6nrxzTya4wlqExhViNBObxmWXsm/23maP9JUObLcz6F8
        aipNfsYdn3tU0T1k4xwEzQhyAV8vOXp+l6FmCVu61prYdJ/m1UhAdGlMAL4R6v+IHofanL
        5Hz/nGIkO4MtGsCHmWauespkneZTpgJJ4cIILyGeNxjFSzNUZ4zItr5N+QnhVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631301049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8khTX1CvTlgTlIcJkxq/qvesJRVMriFMuCA/F24/omM=;
        b=QZJbOfIJ+YU3PkLQoWlrCBnVsF2hbuF7aAes9JCa8p40p04ww74MKXSHEaOG4Hd0sj8rJF
        j8RJQr905wHxSCBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14.1-rt21
Message-ID: <20210910191047.ciathkkvyw63v5jm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14.1-rt21 patch set. 

Changes since v5.14.1-rt20:

  - The irq_work_sync() function sleep-waits instead of busy-poll on
    PREEMPT_RT on work-items which are not invoked in hardirq context.

  - Clark Williams reported issues in i915. Both have been addressed and
    I hope for some feedback :)

  - In v5.14-rt17 lockdep was taught to recognise read-locks. A last
    minute change made the patch futile. A new version has been added.

  - A patch to various drivers (acrn, smack, mt8195) to remove unused
    variables which cause compile warning.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

The delta patch against v5.14.1-rt20 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14.1-rt20-rt21.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14.1-rt21

The RT patch against v5.14.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14.1-rt21.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14.1-rt21.tar.xz

Sebastian

diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index 38cc42783dfb2..594dec2f76954 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -318,10 +318,9 @@ void __intel_breadcrumbs_park(struct intel_breadcrumbs *b)
 	/* Kick the work once more to drain the signalers, and disarm the irq */
 	irq_work_sync(&b->irq_work);
 	while (READ_ONCE(b->irq_armed) && !atomic_read(&b->active)) {
-		local_irq_disable();
-		signal_irq_work(&b->irq_work);
-		local_irq_enable();
+		irq_work_queue(&b->irq_work);
 		cond_resched();
+		irq_work_sync(&b->irq_work);
 	}
 }
 
diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index fc77592d88a96..2ec1dd352960b 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -1265,7 +1265,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 	 * and context switches) submission.
 	 */
 
-	spin_lock(&engine->active.lock);
+	spin_lock_irq(&engine->active.lock);
 
 	/*
 	 * If the queue is higher priority than the last
@@ -1365,7 +1365,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 				 * Even if ELSP[1] is occupied and not worthy
 				 * of timeslices, our queue might be.
 				 */
-				spin_unlock(&engine->active.lock);
+				spin_unlock_irq(&engine->active.lock);
 				return;
 			}
 		}
@@ -1391,7 +1391,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 
 		if (last && !can_merge_rq(last, rq)) {
 			spin_unlock(&ve->base.active.lock);
-			spin_unlock(&engine->active.lock);
+			spin_unlock_irq(&engine->active.lock);
 			return; /* leave this for another sibling */
 		}
 
@@ -1552,7 +1552,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 	 * interrupt for secondary ports).
 	 */
 	execlists->queue_priority_hint = queue_prio(execlists);
-	spin_unlock(&engine->active.lock);
+	spin_unlock_irq(&engine->active.lock);
 
 	/*
 	 * We can skip poking the HW if we ended up with exactly the same set
@@ -1578,13 +1578,6 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 	}
 }
 
-static void execlists_dequeue_irq(struct intel_engine_cs *engine)
-{
-	local_irq_disable(); /* Suspend interrupts across request submission */
-	execlists_dequeue(engine);
-	local_irq_enable(); /* flush irq_work (e.g. breadcrumb enabling) */
-}
-
 static void clear_ports(struct i915_request **ports, int count)
 {
 	memset_p((void **)ports, NULL, count);
@@ -2377,7 +2370,7 @@ static void execlists_submission_tasklet(struct tasklet_struct *t)
 	}
 
 	if (!engine->execlists.pending[0]) {
-		execlists_dequeue_irq(engine);
+		execlists_dequeue(engine);
 		start_timeslice(engine);
 	}
 
diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
index df5184979b282..d4ad211dce7a3 100644
--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -17,7 +17,6 @@
 #include "acrn_drv.h"
 
 static LIST_HEAD(acrn_irqfd_clients);
-static DEFINE_MUTEX(acrn_irqfds_mutex);
 
 /**
  * struct hsm_irqfd - Properties of HSM irqfd
diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index dbbef90897895..cfc3804ec9a09 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -3,6 +3,7 @@
 #define _LINUX_IRQ_WORK_H
 
 #include <linux/smp_types.h>
+#include <linux/rcuwait.h>
 
 /*
  * An entry can be in one of four states:
@@ -16,11 +17,13 @@
 struct irq_work {
 	struct __call_single_node node;
 	void (*func)(struct irq_work *);
+	struct rcuwait irqwait;
 };
 
 #define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
 	.node = { .u_flags = (_flags), },			\
 	.func = (_func),					\
+	.irqwait = __RCUWAIT_INITIALIZER(irqwait),		\
 }
 
 #define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
@@ -46,6 +49,11 @@ static inline bool irq_work_is_busy(struct irq_work *work)
 	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
 }
 
+static inline bool irq_work_is_hard(struct irq_work *work)
+{
+       return atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ;
+}
+
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
 
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 0ec825dbe9f05..14c2aba4c9479 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -181,6 +181,10 @@ void irq_work_single(void *arg)
 	 * else claimed it meanwhile.
 	 */
 	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
+
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt())
+		rcuwait_wake_up(&work->irqwait);
 }
 
 static void irq_work_run_list(struct llist_head *list)
@@ -247,6 +251,14 @@ void irq_work_tick_soft(void)
 void irq_work_sync(struct irq_work *work)
 {
 	lockdep_assert_irqs_enabled();
+	might_sleep();
+
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt()) {
+		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
+				   TASK_UNINTERRUPTIBLE);
+		return;
+	}
 
 	while (irq_work_is_busy(work))
 		cpu_relax();
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6f22ad3617c9a..2997bfea10c7e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5366,7 +5366,7 @@ int __lock_is_held(const struct lockdep_map *lock, int read)
 		struct held_lock *hlock = curr->held_locks + i;
 
 		if (match_held_lock(hlock, lock)) {
-			if (read == -1 || hlock->read == !!read)
+			if (read == -1 || !!hlock->read == read)
 				return LOCK_STATE_HELD;
 
 			return LOCK_STATE_NOT_HELD;
diff --git a/localversion-rt b/localversion-rt
index e095ab8197147..6c6cde1c29e3d 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt20
+-rt21
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 223a6da0e6dc5..10793526187c0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -51,8 +51,10 @@
 #define SMK_RECEIVING	1
 #define SMK_SENDING	2
 
+#ifdef SMACK_IPV6_PORT_LABELING
 static DEFINE_MUTEX(smack_ipv6_lock);
 static LIST_HEAD(smk_ipv6_port_list);
+#endif
 struct kmem_cache *smack_rule_cache;
 int smack_enabled;
 
@@ -2603,7 +2605,6 @@ static void smk_ipv6_port_label(struct socket *sock, struct sockaddr *address)
 	mutex_unlock(&smack_ipv6_lock);
 	return;
 }
-#endif
 
 /**
  * smk_ipv6_port_check - check Smack port access
@@ -2666,6 +2667,7 @@ static int smk_ipv6_port_check(struct sock *sk, struct sockaddr_in6 *address,
 
 	return smk_ipv6_check(skp, object, address, act);
 }
+#endif
 
 /**
  * smack_inode_setsecurity - set smack xattrs
@@ -2852,8 +2854,9 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 			rc = smk_ipv6_check(ssp->smk_out, rsp, sip,
 					    SMK_CONNECTING);
 		}
-		if (__is_defined(SMACK_IPV6_PORT_LABELING))
+#ifdef SMACK_IPV6_PORT_LABELING
 			rc = smk_ipv6_port_check(sock->sk, sip, SMK_CONNECTING);
+#endif
 
 		return rc;
 	}
diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index 3cb2adf420bbf..35c3174c035d7 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -288,7 +288,6 @@ const struct snd_soc_dai_ops mtk_afe_fe_ops = {
 };
 EXPORT_SYMBOL_GPL(mtk_afe_fe_ops);
 
-static DEFINE_MUTEX(irqs_lock);
 int mtk_dynamic_irq_acquire(struct mtk_base_afe *afe)
 {
 	int i;
