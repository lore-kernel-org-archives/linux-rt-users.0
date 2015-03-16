From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch v2] rt,nohz_full: fix nohz_full for PREEMPT_RT_FULL
Date: Mon, 16 Mar 2015 21:24:09 +0100
Message-ID: <20150316202409.GF28130@linutronix.de>
References: <20150216111822.GA21649@linutronix.de>
 <1424258514.3819.39.camel@gmail.com>
 <20150309134535.GA13768@linutronix.de>
 <1425911771.30469.8.camel@gmail.com>
 <1425980136.3507.17.camel@gmail.com>
 <1426153093.4190.2.camel@gmail.com>
 <1426222405.17611.7.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426222405.17611.7.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2015-03-13 05:53:25 [+0100]:

>First of all, a task being ticked and trying to shut the tick down will
>fail to do so due to having just awakened ksoftirqd, so let ksoftirqd
>try to do that after SOFTIRQ_TIMER processing.  Secondly, should the
>tick be shut down, we may livelock in hrtimer-cancel() because in -rt
>a callback may be running.  Break the loop, and let tick_nohz_restart()
>know that the timer is busy so it can bail.

I am a bit undecided on that one. I included it in the series but did
not enable it yet.
Just so we are on the same page here: you boot your machine with
something like
    "isolcpus=1-31 rcu_nocbs=1-31 nohz_full=1-31"
and pin all kernel threads to CPU0, right?

What you do is that you accept the fact that the timer-softirq is
scheduled for no reason and then you try to disable the tick from within
the timer-softirq. I assumed that it would work get the "expired timer"
somehow.

>Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>

Sebastian
