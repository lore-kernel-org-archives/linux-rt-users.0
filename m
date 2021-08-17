Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237C9C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 14:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE7D60F14
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 14:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhHQOk4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 10:40:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60956 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbhHQOky (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Aug 2021 10:40:54 -0400
Date:   Tue, 17 Aug 2021 16:40:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629211220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jD5QrDzoUlwgmKT1L4ik250SzOJtPAV7eUaF5P748YM=;
        b=PkMVUQGyZsaJRoYBJ3gtm5yRX6CkFmXK+dk6khXmyk5pHa1Q77foqp+xhMYmvTLYYwOaSI
        neglHj8c6COsZ5IeqyXulmPKOXKUwSX/sGRSxQnTB/ZMqRMWujAkUr6dXal6EZgRcOsjM2
        OnXoXSx5YFvaGJguwB7GENDjC+/wjcQ6ZsLH7lJkncgRQp9ttR0PesjxpBNU9CFPLVIDWA
        b8ReGmEoguqVptk2GaOGry0Z6o7AXBwwQrsW2c3vHAbIT+y+/xZbDB2jehG2qSd9FG6VT6
        d7HvU20SIP3ZzMlVoKfiN1RAfMmxnJiS1sBLwjfoITwxS2iRz9CegSieMGYZwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629211220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jD5QrDzoUlwgmKT1L4ik250SzOJtPAV7eUaF5P748YM=;
        b=D7fovlxYAnlhodjSoHwf1NV98x3UK6cGLhONMXcQJm5S7dl+uCGmUoNFWcCuhrvXdzTkGa
        pHzrAON0b3rvhZCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>, Scott Wood <swood@redhat.com>
Subject: [PATCH] rcutorture: Avoid problematic critical section nesting on RT
Message-ID: <20210817144018.nqssoq475vitrqlv@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-2-valentin.schneider@arm.com>
 <20210817121345.5iyj5epemczn3a52@linutronix.de>
 <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Scott Wood <swood@redhat.com>

rcutorture was generating some nesting scenarios that are not
reasonable.  Constrain the state selection to avoid them.

Example:

1. rcu_read_lock()
2. local_irq_disable()
3. rcu_read_unlock()
4. local_irq_enable()

If the thread is preempted between steps 1 and 2,
rcu_read_unlock_special.b.blocked will be set, but it won't be
acted on in step 3 because IRQs are disabled.  Thus, reporting of the
quiescent state will be delayed beyond the local_irq_enable().

For now, these scenarios will continue to be tested on non-PREEMPT_RT
kernels, until debug checks are added to ensure that they are not
happening elsewhere.

Signed-off-by: Scott Wood <swood@redhat.com>
[valentin.schneider@arm.com: Don't disable BH in atomic context]
[bigeasy: remove 'preempt_disable(); local_bh_disable(); preempt_enable();
 local_bh_enable();' from the examples because this works on RT now. ]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
I folded Valentin's bits.
I removed the unbalanced preempt_disable()/migrate_disable() part from
the description because it is supported now by the migrate disable
implementation. I didn't find it explicit in code/ patch except as part
of local_bh_disable().


 kernel/rcu/rcutorture.c |   94 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 14 deletions(-)
---
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -61,10 +61,13 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck
 #define RCUTORTURE_RDR_RBH	 0x08	/*  ... rcu_read_lock_bh(). */
 #define RCUTORTURE_RDR_SCHED	 0x10	/*  ... rcu_read_lock_sched(). */
 #define RCUTORTURE_RDR_RCU	 0x20	/*  ... entering another RCU reader. */
-#define RCUTORTURE_RDR_NBITS	 6	/* Number of bits defined above. */
+#define RCUTORTURE_RDR_ATOM_BH	 0x40	/*  ... disabling bh while atomic */
+#define RCUTORTURE_RDR_ATOM_RBH	 0x80	/*  ... RBH while atomic */
+#define RCUTORTURE_RDR_NBITS	 8	/* Number of bits defined above. */
 #define RCUTORTURE_MAX_EXTEND	 \
 	(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
-	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
+	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED | \
+	 RCUTORTURE_RDR_ATOM_BH | RCUTORTURE_RDR_ATOM_RBH)
 #define RCUTORTURE_RDR_MAX_LOOPS 0x7	/* Maximum reader extensions. */
 					/* Must be power of two minus one. */
 #define RCUTORTURE_RDR_MAX_SEGS (RCUTORTURE_RDR_MAX_LOOPS + 3)
@@ -1429,31 +1432,53 @@ static void rcutorture_one_extend(int *r
 	WARN_ON_ONCE((idxold >> RCUTORTURE_RDR_SHIFT) > 1);
 	rtrsp->rt_readstate = newstate;
 
-	/* First, put new protection in place to avoid critical-section gap. */
+	/*
+	 * First, put new protection in place to avoid critical-section gap.
+	 * Disable preemption around the ATOM disables to ensure that
+	 * in_atomic() is true.
+	 */
 	if (statesnew & RCUTORTURE_RDR_BH)
 		local_bh_disable();
+	if (statesnew & RCUTORTURE_RDR_RBH)
+		rcu_read_lock_bh();
 	if (statesnew & RCUTORTURE_RDR_IRQ)
 		local_irq_disable();
 	if (statesnew & RCUTORTURE_RDR_PREEMPT)
 		preempt_disable();
-	if (statesnew & RCUTORTURE_RDR_RBH)
-		rcu_read_lock_bh();
 	if (statesnew & RCUTORTURE_RDR_SCHED)
 		rcu_read_lock_sched();
+	preempt_disable();
+	if (statesnew & RCUTORTURE_RDR_ATOM_BH)
+		local_bh_disable();
+	if (statesnew & RCUTORTURE_RDR_ATOM_RBH)
+		rcu_read_lock_bh();
+	preempt_enable();
 	if (statesnew & RCUTORTURE_RDR_RCU)
 		idxnew = cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;
 
-	/* Next, remove old protection, irq first due to bh conflict. */
+	/*
+	 * Next, remove old protection, in decreasing order of strength
+	 * to avoid unlock paths that aren't safe in the stronger
+	 * context.  Disable preemption around the ATOM enables in
+	 * case the context was only atomic due to IRQ disabling.
+	 */
+	preempt_disable();
 	if (statesold & RCUTORTURE_RDR_IRQ)
 		local_irq_enable();
-	if (statesold & RCUTORTURE_RDR_BH)
+	if (statesold & RCUTORTURE_RDR_ATOM_BH)
 		local_bh_enable();
+	if (statesold & RCUTORTURE_RDR_ATOM_RBH)
+		rcu_read_unlock_bh();
+	preempt_enable();
 	if (statesold & RCUTORTURE_RDR_PREEMPT)
 		preempt_enable();
-	if (statesold & RCUTORTURE_RDR_RBH)
-		rcu_read_unlock_bh();
 	if (statesold & RCUTORTURE_RDR_SCHED)
 		rcu_read_unlock_sched();
+	if (statesold & RCUTORTURE_RDR_BH)
+		local_bh_enable();
+	if (statesold & RCUTORTURE_RDR_RBH)
+		rcu_read_unlock_bh();
+
 	if (statesold & RCUTORTURE_RDR_RCU) {
 		bool lockit = !statesnew && !(torture_random(trsp) & 0xffff);
 
@@ -1496,6 +1521,12 @@ rcutorture_extend_mask(int oldmask, stru
 	int mask = rcutorture_extend_mask_max();
 	unsigned long randmask1 = torture_random(trsp) >> 8;
 	unsigned long randmask2 = randmask1 >> 3;
+	unsigned long preempts = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
+	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
+	unsigned long nonatomic_bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
+	unsigned long atomic_bhs = RCUTORTURE_RDR_ATOM_BH |
+				   RCUTORTURE_RDR_ATOM_RBH;
+	unsigned long tmp;
 
 	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
 	/* Mostly only one bit (need preemption!), sometimes lots of bits. */
@@ -1503,11 +1534,46 @@ rcutorture_extend_mask(int oldmask, stru
 		mask = mask & randmask2;
 	else
 		mask = mask & (1 << (randmask2 % RCUTORTURE_RDR_NBITS));
-	/* Can't enable bh w/irq disabled. */
-	if ((mask & RCUTORTURE_RDR_IRQ) &&
-	    ((!(mask & RCUTORTURE_RDR_BH) && (oldmask & RCUTORTURE_RDR_BH)) ||
-	     (!(mask & RCUTORTURE_RDR_RBH) && (oldmask & RCUTORTURE_RDR_RBH))))
-		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
+
+	/*
+	 * Can't enable bh w/irq disabled.
+	 */
+	tmp = atomic_bhs | nonatomic_bhs;
+	if (mask & RCUTORTURE_RDR_IRQ)
+		mask |= oldmask & tmp;
+
+	/*
+	 * Ideally these sequences would be detected in debug builds
+	 * (regardless of RT), but until then don't stop testing
+	 * them on non-RT.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/*
+		 * Can't disable bh in atomic context if bh was already
+		 * disabled by another task on the same CPU. Instead of
+		 * attempting to track this, just avoid disabling bh in atomic
+		 * context.
+		 */
+		mask &= ~atomic_bhs;
+		/*
+		 * Can't release the outermost rcu lock in an irq disabled
+		 * section without preemption also being disabled, if irqs
+		 * had ever been enabled during this RCU critical section
+		 * (could leak a special flag and delay reporting the qs).
+		 */
+		if ((oldmask & RCUTORTURE_RDR_RCU) &&
+		    (mask & RCUTORTURE_RDR_IRQ) &&
+		    !(mask & preempts))
+			mask |= RCUTORTURE_RDR_RCU;
+
+		/* Can't modify non-atomic bh in atomic context */
+		tmp = nonatomic_bhs;
+		if (oldmask & preempts_irq)
+			mask &= ~tmp;
+		if ((oldmask | mask) & preempts_irq)
+			mask |= oldmask & tmp;
+	}
+
 	return mask ?: RCUTORTURE_RDR_RCU;
 }
 
