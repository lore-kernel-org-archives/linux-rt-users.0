Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67280C31E5F
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 01:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD502085A
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 01:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfFSBTS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:19:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43193 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbfFSBTR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 21:19:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECEAA3082B64;
        Wed, 19 Jun 2019 01:19:16 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-83.phx2.redhat.com [10.3.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C4DB17C41;
        Wed, 19 Jun 2019 01:19:15 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [RFC PATCH RT 4/4] rcutorture: Avoid problematic critical section nesting
Date:   Tue, 18 Jun 2019 20:19:08 -0500
Message-Id: <20190619011908.25026-5-swood@redhat.com>
In-Reply-To: <20190619011908.25026-1-swood@redhat.com>
References: <20190619011908.25026-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 19 Jun 2019 01:19:17 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rcutorture was generating some nesting scenarios that are not
reasonable.  Constrain the state selection to avoid them.

Example #1:

1. preempt_disable()
2. local_bh_disable()
3. preempt_enable()
4. local_bh_enable()

On PREEMPT_RT, BH disabling takes a local lock only when called in
non-atomic context.  Thus, atomic context must be retained until after BH
is re-enabled.  Likewise, if BH is initially disabled in non-atomic
context, it cannot be re-enabled in atomic context.

Example #2:

1. rcu_read_lock()
2. local_irq_disable()
3. rcu_read_unlock()
4. local_irq_enable()

If the thread is preempted between steps 1 and 2,
rcu_read_unlock_special.b.blocked will be set, but it won't be
acted on in step 3 because IRQs are disabled.  Thus, reporting of the
quiescent state will be delayed beyond the local_irq_enable().

Example #3:

1. preempt_disable()
2. local_irq_disable()
3. preempt_enable()
4. local_irq_enable()

If need_resched is set between steps 1 and 2, then the reschedule
in step 3 will not happen.

Signed-off-by: Scott Wood <swood@redhat.com>
---
TODO: Document restrictions and add debug checks for invalid sequences.

I had been planning to resolve #1 (only as shown, not the case of
disabling preemption while non-atomic and enabling while atomic) by
changing how migrate_disable() works to avoid the split behavior, but
recently BH disabling was changed to do the same thing.  I still plan to
send the migrate disable changes as a separate patchset, for the sake of
the significant performance improvement I saw.
---
 kernel/rcu/rcutorture.c | 92 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 584b0d1da0a3..0523d9e78246 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -73,10 +73,13 @@
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
@@ -1111,31 +1114,52 @@ static void rcutorture_one_extend(int *readstate, int newstate,
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
 	if (statesold & RCUTORTURE_RDR_RCU)
 		cur_ops->readunlock(idxold >> RCUTORTURE_RDR_SHIFT);
 
@@ -1171,6 +1195,12 @@ static int rcutorture_extend_mask_max(void)
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
 	/* Most of the time lots of bits, half the time only one bit. */
@@ -1178,11 +1208,45 @@ static int rcutorture_extend_mask_max(void)
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
+	 *
+	 * Can't enable preemption with irqs disabled, if irqs had ever
+	 * been enabled during this preempt critical section (could miss
+	 * a reschedule).
+	 */
+	tmp = atomic_bhs | nonatomic_bhs | preempts;
+	if (mask & RCUTORTURE_RDR_IRQ)
+		mask |= oldmask & tmp;
+
+	/*
+	 * Can't release the outermost rcu lock in an irq disabled
+	 * section without preemption also being disabled, if irqs had
+	 * ever been enabled during this RCU critical section (could leak
+	 * a special flag and delay reporting the qs).
+	 */
+	if ((oldmask & RCUTORTURE_RDR_RCU) && (mask & RCUTORTURE_RDR_IRQ) &&
+	    !(mask & preempts))
+		mask |= RCUTORTURE_RDR_RCU;
+
+	/* Can't modify atomic bh in non-atomic context */
+	if ((oldmask & atomic_bhs) && (mask & atomic_bhs) &&
+	    !(mask & preempts_irq)) {
+		mask |= oldmask & preempts_irq;
+		if (mask & RCUTORTURE_RDR_IRQ)
+			mask |= oldmask & tmp;
+	}
+	if ((mask & atomic_bhs) && !(mask & preempts_irq))
+		mask |= RCUTORTURE_RDR_PREEMPT;
+
+	/* Can't modify non-atomic bh in atomic context */
+	tmp = nonatomic_bhs;
+	if (oldmask & preempts_irq)
+		mask &= ~tmp;
+	if ((oldmask | mask) & preempts_irq)
+		mask |= oldmask & tmp;
+
 	if ((mask & RCUTORTURE_RDR_IRQ) &&
 	    !(mask & cur_ops->ext_irq_conflict) &&
 	    (oldmask & cur_ops->ext_irq_conflict))
-- 
1.8.3.1

