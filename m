Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB77BC4320A
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 16:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35D561159
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 16:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhHEQLF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 12:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhHEQLD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 12:11:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AC586113B;
        Thu,  5 Aug 2021 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628179849;
        bh=F17qokUOUa3b6nmXVeGCNW6p49nrBMdLh10as/5Lfec=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IDu0SQGKCGAcvsgYEShJJS5Sq32DHYvSZlRPN2FrQz7qgTMxpcQPgLxsRj1kVL+NZ
         137IE8zWbWdRFHjgGYaKSVMN6lyjJkak6/qCAHmwNjMGRuAiH8wQv11jl4zVUGfXCp
         LocnVLFBIKkjqdC7zrSbwfkRkH82utYp79IBi/A+NF21IXei+7elmPGzJI4QTQdZVl
         44OK/7rVgbeK6BOvpJQE2DmhZgxpMRiO2P+AtkskSmSqFSf2/QkWVMG7AtjBsxJUuy
         u873LXAcFymB838QozC3+7MqT8eQL6ThKbnZrmNcJ3REdKIYVNvmoxzYQarGJl3Ti+
         RLTquEYCPdUxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 317AF5C098A; Thu,  5 Aug 2021 09:10:49 -0700 (PDT)
Date:   Thu, 5 Aug 2021 09:10:49 -0700
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
Message-ID: <20210805161049.GK4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210803225437.3612591-1-valentin.schneider@arm.com>
 <20210803225437.3612591-3-valentin.schneider@arm.com>
 <20210803234231.GW4397@paulmck-ThinkPad-P17-Gen-1>
 <87tuk5a4yk.mognet@arm.com>
 <20210804225332.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <87mtpw9kiz.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtpw9kiz.mognet@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 05, 2021 at 12:51:48PM +0100, Valentin Schneider wrote:
> On 04/08/21 15:53, Paul E. McKenney wrote:
> > On Wed, Aug 04, 2021 at 11:18:11AM +0100, Valentin Schneider wrote:
> >>
> >> Hm so v5.13-rt1 has this commit:
> >>
> >>   5e59fba573e6 ("rcutorture: Fix testing of RCU priority boosting")
> >>
> >> which gates RCU boost torture testing under CONFIG_PREEMPT_RT. Now, AFAICT
> >> the TIMER_SOFTIRQ priority problem is there regardless of
> >> CONFIG_PREEMPT_RT, so this patch would (should?) make sense even on
> >> !CONFIG_PREEMPT_RT.
> >
> > What rcutorture scenario TREE03 does is to boot with tree.use_softirq=0
> > and threadirqs.  I see your point about timers and softirq, but this
> > does run reliably for me.
> >
> > Ah, I see why.  Commit ea6d962e80b6 ("rcutorture: Judge RCU priority
> > boosting on grace periods, not callbacks") includes boosting the priority
> > of the ksoftirqd kthreads.  But only when running rcutorture builtin,
> > not as a module.  Here is the code in rcu_torture_init():
> >
> >               // Testing RCU priority boosting requires rcutorture do
> >               // some serious abuse.  Counter this by running ksoftirqd
> >               // at higher priority.
> >               if (IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)) {
> >                       for_each_online_cpu(cpu) {
> >                               struct sched_param sp;
> >                               struct task_struct *t;
> >
> >                               t = per_cpu(ksoftirqd, cpu);
> >                               WARN_ON_ONCE(!t);
> >                               sp.sched_priority = 2;
> >                               sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> >                       }
> >               }
> >
> > I take it that you were running rcutorture as a module?
> >
> > This describes how to run it built-in, if that works for you:
> >
> > https://paulmck.livejournal.com/61432.html
> >
> > More specifically: https://paulmck.livejournal.com/57769.html
> >
> > Alternatively, the "IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)" check could be
> > removed in the above code, and the ksoftirqd kthreads could have their
> > original priority restored in rcu_torture_cleanup().
> >
> > Thoughts?
> 
> I actually run rcutorture as a builtin, but from what I can tell the above
> patch came in v5.14-rc1, and ofc I'm running my tests on v5.13-rt1... I
> should have paid closer attention to what was in the latest mainline,
> apologies for the noise. 

Not a problem, and thank you for giving rcutorture a try!

> FWIW tweaking ksoftirqd priority only when the torture module is builtin
> makes sense to me.

Very good, I will stick with the status quo, then.

							Thanx, Paul
