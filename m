Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C2EC4338F
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Aug 2021 16:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59068613D0
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Aug 2021 16:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhHWQEx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:04:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41610 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhHWQEw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Aug 2021 12:04:52 -0400
Date:   Mon, 23 Aug 2021 18:04:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629734648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Y40OIFsS2zjjqBQGHzmlqktrTeUvADgXtYy0PA2r/9o=;
        b=R5Xt2Qn9/OCy1LAkz1JNmqYMbu/5PS+lcrCEs/YmlBGdUCWEXVh/+hqidzAgUTkzvhBIK0
        10KQn0IUo84IH5W0iAynOPmQ8NZQ3ygFeJ2KP1Ry+6mT1GsqxqBFmtho3PV1mOmyrrUDQH
        GVm/vQgDYSa4eKep2+abGDCSDPpJaJdvoSyo7ii2wPu339S+0DeylTRQoxiipLeyzQ2iYi
        Gmg4F1QmGe8gpL8Rr3IBJb7lPjUXk9iAlJ84ZQ+ALd5Oi43bx+4BJvOo3/z8OCWNnhmPwL
        Eju61QL99Hp1z0lPCvK+4G/bX1uUpUB20NKfgucGBU0evZHstB8gcXRbFDIezA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629734648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Y40OIFsS2zjjqBQGHzmlqktrTeUvADgXtYy0PA2r/9o=;
        b=3EK3ZG/oGoLFjdcncqdY9W5XnvJdme+yqGC6MuwQJYDh06t6UnHA2G0M6ykEcMwxcm1iHg
        2ud/+Lo6P0zwrECg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rc7-rt13
Message-ID: <20210823160407.5e6xkvnfrz5f3ygw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rc7-rt13 patch set. 

Changes since v5.14-rc7-rt12:

  - A change to ww_mutex code to avoid a crash in non-RT. Reported by
    Guenter Roeck.

  - The patch for rcu-torture has been updated to address review
    comments.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

     - Clark Williams reported issues in i915 (execlists_dequeue_irq())

     - Clark Williams reported issues with kcov enabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

The delta patch against v5.14-rc7-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14-rc7-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rc7-rt13

The RT patch against v5.14-rc7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rc7-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rc7-rt13.tar.xz

Sebastian

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 05b68931622d1..2c70213934cd4 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -614,7 +614,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	debug_mutex_lock_common(lock, &waiter);
 	waiter.task = current;
-	if (ww_ctx)
+	if (use_ww_ctx)
 		waiter.ww_ctx = ww_ctx;
 
 	lock_contended(&lock->dep_map, ip);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f01368a05374d..d2ef535530b10 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -61,13 +61,10 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@
 #define RCUTORTURE_RDR_RBH	 0x08	/*  ... rcu_read_lock_bh(). */
 #define RCUTORTURE_RDR_SCHED	 0x10	/*  ... rcu_read_lock_sched(). */
 #define RCUTORTURE_RDR_RCU	 0x20	/*  ... entering another RCU reader. */
-#define RCUTORTURE_RDR_ATOM_BH	 0x40	/*  ... disabling bh while atomic */
-#define RCUTORTURE_RDR_ATOM_RBH	 0x80	/*  ... RBH while atomic */
-#define RCUTORTURE_RDR_NBITS	 8	/* Number of bits defined above. */
+#define RCUTORTURE_RDR_NBITS	 6	/* Number of bits defined above. */
 #define RCUTORTURE_MAX_EXTEND	 \
 	(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
-	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED | \
-	 RCUTORTURE_RDR_ATOM_BH | RCUTORTURE_RDR_ATOM_RBH)
+	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
 #define RCUTORTURE_RDR_MAX_LOOPS 0x7	/* Maximum reader extensions. */
 					/* Must be power of two minus one. */
 #define RCUTORTURE_RDR_MAX_SEGS (RCUTORTURE_RDR_MAX_LOOPS + 3)
@@ -1432,11 +1429,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	WARN_ON_ONCE((idxold >> RCUTORTURE_RDR_SHIFT) > 1);
 	rtrsp->rt_readstate = newstate;
 
-	/*
-	 * First, put new protection in place to avoid critical-section gap.
-	 * Disable preemption around the ATOM disables to ensure that
-	 * in_atomic() is true.
-	 */
+	/* First, put new protection in place to avoid critical-section gap. */
 	if (statesnew & RCUTORTURE_RDR_BH)
 		local_bh_disable();
 	if (statesnew & RCUTORTURE_RDR_RBH)
@@ -1447,29 +1440,18 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		preempt_disable();
 	if (statesnew & RCUTORTURE_RDR_SCHED)
 		rcu_read_lock_sched();
-	preempt_disable();
-	if (statesnew & RCUTORTURE_RDR_ATOM_BH)
-		local_bh_disable();
-	if (statesnew & RCUTORTURE_RDR_ATOM_RBH)
-		rcu_read_lock_bh();
-	preempt_enable();
 	if (statesnew & RCUTORTURE_RDR_RCU)
 		idxnew = cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;
 
 	/*
 	 * Next, remove old protection, in decreasing order of strength
 	 * to avoid unlock paths that aren't safe in the stronger
-	 * context.  Disable preemption around the ATOM enables in
-	 * case the context was only atomic due to IRQ disabling.
+	 * context. Namely: BH can not be enabled with disabled interrupts.
+	 * Additionally PREEMPT_RT requires that BH is enabled in preemptible
+	 * context.
 	 */
-	preempt_disable();
 	if (statesold & RCUTORTURE_RDR_IRQ)
 		local_irq_enable();
-	if (statesold & RCUTORTURE_RDR_ATOM_BH)
-		local_bh_enable();
-	if (statesold & RCUTORTURE_RDR_ATOM_RBH)
-		rcu_read_unlock_bh();
-	preempt_enable();
 	if (statesold & RCUTORTURE_RDR_PREEMPT)
 		preempt_enable();
 	if (statesold & RCUTORTURE_RDR_SCHED)
@@ -1478,7 +1460,6 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		local_bh_enable();
 	if (statesold & RCUTORTURE_RDR_RBH)
 		rcu_read_unlock_bh();
-
 	if (statesold & RCUTORTURE_RDR_RCU) {
 		bool lockit = !statesnew && !(torture_random(trsp) & 0xffff);
 
@@ -1523,10 +1504,7 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 	unsigned long randmask2 = randmask1 >> 3;
 	unsigned long preempts = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
 	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
-	unsigned long nonatomic_bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
-	unsigned long atomic_bhs = RCUTORTURE_RDR_ATOM_BH |
-				   RCUTORTURE_RDR_ATOM_RBH;
-	unsigned long tmp;
+	unsigned long bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
 
 	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
 	/* Mostly only one bit (need preemption!), sometimes lots of bits. */
@@ -1538,9 +1516,8 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 	/*
 	 * Can't enable bh w/irq disabled.
 	 */
-	tmp = atomic_bhs | nonatomic_bhs;
 	if (mask & RCUTORTURE_RDR_IRQ)
-		mask |= oldmask & tmp;
+		mask |= oldmask & bhs;
 
 	/*
 	 * Ideally these sequences would be detected in debug builds
@@ -1548,30 +1525,11 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 	 * them on non-RT.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		/*
-		 * Can't disable bh in atomic context if bh was already
-		 * disabled by another task on the same CPU. Instead of
-		 * attempting to track this, just avoid disabling bh in atomic
-		 * context.
-		 */
-		mask &= ~atomic_bhs;
-		/*
-		 * Can't release the outermost rcu lock in an irq disabled
-		 * section without preemption also being disabled, if irqs
-		 * had ever been enabled during this RCU critical section
-		 * (could leak a special flag and delay reporting the qs).
-		 */
-		if ((oldmask & RCUTORTURE_RDR_RCU) &&
-		    (mask & RCUTORTURE_RDR_IRQ) &&
-		    !(mask & preempts))
-			mask |= RCUTORTURE_RDR_RCU;
-
-		/* Can't modify non-atomic bh in atomic context */
-		tmp = nonatomic_bhs;
+		/* Can't modify BH in atomic context */
 		if (oldmask & preempts_irq)
-			mask &= ~tmp;
+			mask &= ~bhs;
 		if ((oldmask | mask) & preempts_irq)
-			mask |= oldmask & tmp;
+			mask |= oldmask & bhs;
 	}
 
 	return mask ?: RCUTORTURE_RDR_RCU;
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927b..9f7d0bdbffb18 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
