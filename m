Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D47C4320A
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 22:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED96960E96
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 22:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhHDWxr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhHDWxp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 18:53:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85CF860C41;
        Wed,  4 Aug 2021 22:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628117612;
        bh=ev4UpvDYu8mIq8C3cYDsqXhIp/L+bKQKL2Gw0rAfHT4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aXE14yecsD+xHGwyDq5U01Db/6hJ60InuTSGgdOkfFA1JTHSydwLoeoIhy8AJJW30
         dEmooEFSXDADjwkrSiCpDlYwCefhLxTJE5SAgAy2LUSzm1V9hyfD+qzNOA8V+K70kA
         nM37EW4iYBfxOI0SOR5uV1LOiuXRDyEy9bu23Nb86S6e5G8zWqW4LQe5kRjm5xs2r5
         JEPEvbDol27Lt+jJt+DWZotzX0qARMdRtsgPjoEQ0FZu336tyZnIMlrmSrw8L/vZFF
         Gjqy63LGFcxaYuFcQ1SnviwEn9ZGFPJwKJhVSY5rLN54FS3Dak/+fKFR/oQ7duvyQq
         FJADt02L0rFIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 55B745C22D9; Wed,  4 Aug 2021 15:53:32 -0700 (PDT)
Date:   Wed, 4 Aug 2021 15:53:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/2] rcutorture: Nudge ksoftirqd priority for RCU boost
 testing
Message-ID: <20210804225332.GB4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210803225437.3612591-1-valentin.schneider@arm.com>
 <20210803225437.3612591-3-valentin.schneider@arm.com>
 <20210803234231.GW4397@paulmck-ThinkPad-P17-Gen-1>
 <87tuk5a4yk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuk5a4yk.mognet@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 04, 2021 at 11:18:11AM +0100, Valentin Schneider wrote:
> On 03/08/21 16:42, Paul E. McKenney wrote:
> > On Tue, Aug 03, 2021 at 11:54:37PM +0100, Valentin Schneider wrote:
> >> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >> index 680f66b65f14..3dd5fa75f469 100644
> >> --- a/kernel/rcu/rcutorture.c
> >> +++ b/kernel/rcu/rcutorture.c
> >> @@ -948,12 +948,26 @@ static int rcu_torture_boost(void *arg)
> >>      unsigned long endtime;
> >>      unsigned long oldstarttime;
> >>      struct rcu_boost_inflight rbi = { .inflight = 0 };
> >> +	struct task_struct *ksoftirqd = this_cpu_ksoftirqd();
> >>
> >>      VERBOSE_TOROUT_STRING("rcu_torture_boost started");
> >>
> >>      /* Set real-time priority. */
> >>      sched_set_fifo_low(current);
> >>
> >> +	/*
> >> +	 * Boost testing requires TIMER_SOFTIRQ to run at a higher priority
> >> +	 * than the CPU-hogging torture kthreads, otherwise said threads
> >> +	 * will never let timer expiry for the RCU GP kthread happen, which will
> >> +	 * prevent any boosting.
> >> +	 */
> >> +	if (current->normal_prio < ksoftirqd->normal_prio) {
> >
> > Would it make sense to add IS_ENABLED(CONFIG_PREEMPT_RT) to the above
> > condition?
> >
> 
> Hm so v5.13-rt1 has this commit:
> 
>   5e59fba573e6 ("rcutorture: Fix testing of RCU priority boosting")
> 
> which gates RCU boost torture testing under CONFIG_PREEMPT_RT. Now, AFAICT
> the TIMER_SOFTIRQ priority problem is there regardless of
> CONFIG_PREEMPT_RT, so this patch would (should?) make sense even on
> !CONFIG_PREEMPT_RT.

What rcutorture scenario TREE03 does is to boot with tree.use_softirq=0
and threadirqs.  I see your point about timers and softirq, but this
does run reliably for me.

Ah, I see why.  Commit ea6d962e80b6 ("rcutorture: Judge RCU priority
boosting on grace periods, not callbacks") includes boosting the priority
of the ksoftirqd kthreads.  But only when running rcutorture builtin,
not as a module.  Here is the code in rcu_torture_init():

		// Testing RCU priority boosting requires rcutorture do
		// some serious abuse.  Counter this by running ksoftirqd
		// at higher priority.
		if (IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)) {
			for_each_online_cpu(cpu) {
				struct sched_param sp;
				struct task_struct *t;

				t = per_cpu(ksoftirqd, cpu);
				WARN_ON_ONCE(!t);
				sp.sched_priority = 2;
				sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
			}
		}

I take it that you were running rcutorture as a module?

This describes how to run it built-in, if that works for you:

https://paulmck.livejournal.com/61432.html

More specifically: https://paulmck.livejournal.com/57769.html

Alternatively, the "IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)" check could be
removed in the above code, and the ksoftirqd kthreads could have their
original priority restored in rcu_torture_cleanup().

Thoughts?

							Thanx, Paul

> >> +		struct sched_param sp = { .sched_priority = 2 };
> >> +
> >> +		pr_alert("%s(): Adjusting %s priority\n", __func__, ksoftirqd->comm);
> >> +		sched_setscheduler_nocheck(ksoftirqd, SCHED_FIFO, &sp);
> >> +	}
> >> +
> >>      init_rcu_head_on_stack(&rbi.rcu);
> >>      /* Each pass through the following loop does one boost-test cycle. */
> >>      do {
> >> --
> >> 2.25.1
> >>
