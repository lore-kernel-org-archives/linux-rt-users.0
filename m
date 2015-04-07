From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 7 Apr 2015 14:04:03 +0200
Message-ID: <20150407120403.GN21418@twins.programming.kicks-ass.net>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
 <1428369962-74723-1-git-send-email-tmac@hp.com>
 <1428369962-74723-2-git-send-email-tmac@hp.com>
 <alpine.DEB.2.11.1504071255410.3845@nanos>
 <1428407236.3152.81.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:42223 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbDGMET (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2015 08:04:19 -0400
Content-Disposition: inline
In-Reply-To: <1428407236.3152.81.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 07, 2015 at 01:47:16PM +0200, Mike Galbraith wrote:
> On Tue, 2015-04-07 at 13:23 +0200, Thomas Gleixner wrote:
> > On Mon, 6 Apr 2015, Thavatchai Makphaibulchoke wrote:
> > 
> > > This patch fixes the problem that the ownership of a mutex acquired
> > > by an interrupt handler(IH) gets incorrectly attributed to the
> > > interrupted thread.
> > 
> > An hard interrupt handler is not allowed to take a mutex. End of
> > story, nothing to fix here.
> 
> Well, the patch that started this thread..
> 
> timers-do-not-raise-softirq-unconditionally.patch

Aah, that is the problem..

@@ -1454,8 +1452,32 @@ static void run_timer_softirq(struct softirq_action *h)
  */
 void run_local_timers(void)
 {
+	struct tvec_base *base = __this_cpu_read(tvec_bases);
+
 	hrtimer_run_queues();
-	raise_softirq(TIMER_SOFTIRQ);
+	/*
+	 * We can access this lockless as we are in the timer
+	 * interrupt. If there are no timers queued, nothing to do in
+	 * the timer softirq.
+	 */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	if (!spin_do_trylock(&base->lock)) {
+		raise_softirq(TIMER_SOFTIRQ);
+		return;
+	}
+#endif
+	if (!base->active_timers)
+		goto out;
+
+	/* Check whether the next pending timer has expired */
+	if (time_before_eq(base->next_timer, jiffies))
+		raise_softirq(TIMER_SOFTIRQ);
+out:
+#ifdef CONFIG_PREEMPT_RT_FULL
+	rt_spin_unlock_after_trylock_in_irq(&base->lock);
+#endif
+	/* The ; ensures that gcc won't complain in the !RT case */
+	;
 }

That smells like something we should be able to do without a lock.

If we use {READ,WRITE}_ONCE() on those two fields (->active_timers and
->next_timer) we should be able to do this without the spinlock.

Races here aren't really a problem I think, if you manage to install a
timer at the current jiffy and have already missed the tick you're in
the same boat. You get to wait for the next tick.

