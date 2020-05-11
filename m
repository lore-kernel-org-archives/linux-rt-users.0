Return-Path: <SRS0=Jm7W=6Z=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B84C54E8D
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 May 2020 12:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5FB206B7
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 May 2020 12:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0GWiuvNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEKMNp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 May 2020 08:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgEKMNp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 May 2020 08:13:45 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF90DC061A0C;
        Mon, 11 May 2020 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nJpGp+XjBtBX0npjZjYphMtwNrPQzKCV17Hxse9zC78=; b=0GWiuvNGhnpArxNb2kp8OeMixo
        CPw+oqMeHYPqGL7uYzwc+MX+OIsKNWrVoHQfpmaifsW5H/dNlzU9vl3tlNIsExK4g1zqH26L89G0o
        zhExTeSkr0WyCj6fxFWNrYHTcc5sTXoDelyjKGBvSrEJTou6rM7zmPiZySXoma4a1Hnjy7ih9x9xR
        ktkYcwbxtWfGRSFc1TNMSTNbZ78VpUWsfVD3KTn/wljLnVxFNCffbbX2BcWG5iioOZxxatqWdC7Io
        H5Q3CXbQ/6Bop8ye/gv0D5mtvt3DEvYoe9/CuBWasSGfC8ic4ZMpFzQfXu+lX7m1jp77FW1/cvcAn
        HUAfyL9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY7Iv-00054U-1V; Mon, 11 May 2020 12:13:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D76D301EFB;
        Mon, 11 May 2020 14:13:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC995200FC689; Mon, 11 May 2020 14:13:00 +0200 (CEST)
Date:   Mon, 11 May 2020 14:13:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from
 finish_task_switch()
Message-ID: <20200511121300.GB3001@hirez.programming.kicks-ass.net>
References: <20200428050242.17717-1-swood@redhat.com>
 <20200428050242.17717-2-swood@redhat.com>
 <jhjftcns35d.mognet@arm.com>
 <20200428220917.GB16027@hirez.programming.kicks-ass.net>
 <c4a8d1f044b721a2c396fa00a0244eff0b851ae4.camel@redhat.com>
 <20200428230204.GE16027@hirez.programming.kicks-ass.net>
 <89043649a64fc97dd90eb25c85bcc8f65483cf4f.camel@redhat.com>
 <20200429090533.GH13592@hirez.programming.kicks-ass.net>
 <0945b70535f11c9abd45d3a3da2e984c4b1d832b.camel@redhat.com>
 <20200511105800.GB2940@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511105800.GB2940@hirez.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, May 11, 2020 at 12:58:00PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 29, 2020 at 08:31:39PM -0500, Scott Wood wrote:
> > > If you were to do a queue_balance_callback() from somewhere in the
> > > pick_next_task() machinery, then the balance_callback() at the end of
> > > __schedule() would run it, and it'd be gone. How would
> > > rt_mutex_setprio() / __sched_setscheduler() be affected?
> > 
> > The rq lock is dropped between queue_balance_callback() and the
> > balance_callback() at the end of __schedule().  What stops
> > setprio/setscheduler on another cpu from doing the callback at that
> > point?
> 
> Hurmm.. fair point, and that might explain some issues I had a while
> back. Let me poke a little at that.

How's this?

---
 kernel/sched/core.c  | 109 ++++++++++++++++++++++++++++++---------------------
 kernel/sched/sched.h |   2 +
 2 files changed, 67 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dfb8ab61cbdd..610e9da557ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3078,6 +3078,59 @@ static inline void finish_task(struct task_struct *prev)
 #endif
 }
 
+#ifdef CONFIG_SMP
+
+/* rq->lock is NOT held, but preemption is disabled */
+static void do_balance_callbacks(struct callback_head *head)
+{
+	void (*func)(struct rq *rq);
+	struct callback_head *next;
+
+	while (head) {
+		func = (void (*)(struct rq *))head->func;
+		next = head->next;
+		head->next = NULL;
+		head = next;
+
+		func(rq);
+	}
+}
+
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	struct callback_head *head = rq->balance_callback;
+	if (head)
+		rq->balance_callback = NULL;
+}
+
+static void __balance_callbacks(struct rq *rq)
+{
+	do_balance_callbacks(splice_balance_callbacks(rq));
+}
+
+static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+	unsigned long flags;
+
+	if (unlikely(head)) {
+		raw_spin_lock_irqsave(&rq->lock, flags);
+		do_balance_callbacks(head);
+		raw_spin_unlock_irqrestore(&rq->lock, flags);
+	}
+}
+
+#else
+
+static inline void __balance_callbacks(struct rq *rq)
+{
+}
+
+static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+}
+
+#endif
+
 static inline void
 prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
@@ -3103,6 +3156,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
+	__balance_callbacks(rq));
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -3244,43 +3298,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	return rq;
 }
 
-#ifdef CONFIG_SMP
-
-/* rq->lock is NOT held, but preemption is disabled */
-static void __balance_callback(struct rq *rq)
-{
-	struct callback_head *head, *next;
-	void (*func)(struct rq *rq);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&rq->lock, flags);
-	head = rq->balance_callback;
-	rq->balance_callback = NULL;
-	while (head) {
-		func = (void (*)(struct rq *))head->func;
-		next = head->next;
-		head->next = NULL;
-		head = next;
-
-		func(rq);
-	}
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
-}
-
-static inline void balance_callback(struct rq *rq)
-{
-	if (unlikely(rq->balance_callback))
-		__balance_callback(rq);
-}
-
-#else
-
-static inline void balance_callback(struct rq *rq)
-{
-}
-
-#endif
-
 /**
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
@@ -3300,7 +3317,6 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 */
 
 	rq = finish_task_switch(prev);
-	balance_callback(rq);
 	preempt_enable();
 
 	if (current->set_child_tid)
@@ -4090,10 +4106,11 @@ static void __sched notrace __schedule(bool preempt)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-		rq_unlock_irq(rq, &rf);
-	}
 
-	balance_callback(rq);
+		rq_unpin_lock(rq, &rf);
+		__balance_callbacks(rq);
+		raw_spin_unlock_irq(&rq->lock);
+	}
 }
 
 void __noreturn do_task_dead(void)
@@ -4499,9 +4516,11 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 out_unlock:
 	/* Avoid rq from going away on us: */
 	preempt_disable();
-	__task_rq_unlock(rq, &rf);
 
-	balance_callback(rq);
+	rq_unpin_lock(rq, &rf);
+	__balance_callbacks(rq);
+	raw_spin_unlock(&rq->lock);
+
 	preempt_enable();
 }
 #else
@@ -4775,6 +4794,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int retval, oldprio, oldpolicy = -1, queued, running;
 	int new_effective_prio, policy = attr->sched_policy;
 	const struct sched_class *prev_class;
+	struct callback_head *head;
 	struct rq_flags rf;
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -5013,6 +5033,7 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();
+	head = splice_balance_callbacks(rq);
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi) {
@@ -5021,7 +5042,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	/* Run balance callbacks after we've adjusted the PI chain: */
-	balance_callback(rq);
+	balance_callbacks(head);
 	preempt_enable();
 
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d7fc4caf0dfd..3855d354760d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1189,6 +1189,8 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
+
+	SCHED_WARN_ON(rq->balance_callback);
 #endif
 }
 
