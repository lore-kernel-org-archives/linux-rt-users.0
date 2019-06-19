Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DB6C31E5B
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 01:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7B021783
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 01:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfFSBTQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:19:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbfFSBTQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 21:19:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E200D308A951;
        Wed, 19 Jun 2019 01:19:15 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-83.phx2.redhat.com [10.3.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0517B17C41;
        Wed, 19 Jun 2019 01:19:14 +0000 (UTC)
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
Subject: [RFC PATCH RT 3/4] rcu: unlock special: Treat irq and preempt disabled the same
Date:   Tue, 18 Jun 2019 20:19:07 -0500
Message-Id: <20190619011908.25026-4-swood@redhat.com>
In-Reply-To: <20190619011908.25026-1-swood@redhat.com>
References: <20190619011908.25026-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 19 Jun 2019 01:19:16 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

[Note: Just before posting this I noticed that the invoke_rcu_core stuff
 is part of the latest RCU pull request, and it has a patch that
 addresses this in a more complicated way that appears to deal with the
 bare irq-disabled sequence as well.

 Assuming we need/want to support such sequences, is the
 invoke_rcu_core() call actually going to result in scheduling any
 sooner?  resched_curr() just does the same setting of need_resched
 when it's the same cpu.
]

Since special should never be getting set inside an irqs-disabled
critical section, this is safe as long as there are no sequences of
rcu_read_lock()/local_irq_disable()/rcu_read_unlock()/local_irq_enable()
(without preempt_disable() wrapped around the IRQ disabling, as spinlocks
do).  If there are such sequences, then the grace period may be delayed
until the next time need_resched is checked.

This is needed because otherwise, in a sequence such as:
1. rcu_read_lock()
2. *preempt*, set rcu_read_unlock_special.b.blocked
3. preempt_disable()
4. rcu_read_unlock()
5. preempt_enable()

...rcu_read_unlock_special.b.blocked will not be cleared during
step 4, because of the disabled preemption.  If an interrupt is then
taken between steps 4 and 5, and that interrupt enters scheduler code
that takes pi/rq locks, and an rcu read lock inside that, then when
dropping that rcu read lock we will end up in rcu_read_unlock_special()
again -- but this time, since irqs are disabled, it will call
invoke_rcu_core() in the RT tree (regardless of PREEMPT_RT_FULL), which
calls wake_up_process().  This can cause a pi/rq lock deadlock.  An
example of interrupt code that does this is scheduler_tick().

The above sequence can be found in (at least) __lock_task_sighand() (for
!PREEMPT_RT_FULL) and d_alloc_parallel().

It's potentially an issue on non-RT as well.  While
raise_softirq_irqoff() doesn't call wake_up_process() when in_interrupt()
is true, if code between steps 4 and 5 directly calls into scheduler
code, and that code uses RCU with pi/rq lock held, wake_up_process() can
still be called.

On RT, migrate_enable() is such a codepath, so an in_interrupt() check
alone would not work on RT.  Instead, keep track of whether we've already
had an rcu_read_unlock_special() with preemption disabled but haven't yet
scheduled, and rely on the preempt_enable() yet to come instead of
calling invoke_rcu_core().

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/rcu/tree_plugin.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5d63914b3687..d7ddbcc7231c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -630,14 +630,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
 		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
 		/* Need to defer quiescent state until everything is enabled. */
-		if (irqs_were_disabled) {
-			/* Enabling irqs does not reschedule, so... */
-			invoke_rcu_core();
-		} else {
-			/* Enabling BH or preempt does reschedule, so... */
-			set_tsk_need_resched(current);
-			set_preempt_need_resched();
-		}
+		set_tsk_need_resched(current);
+		set_preempt_need_resched();
 		local_irq_restore(flags);
 		return;
 	}
-- 
1.8.3.1

