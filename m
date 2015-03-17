From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch v2] rt,nohz_full: fix nohz_full for PREEMPT_RT_FULL
Date: Tue, 17 Mar 2015 02:53:53 +0100
Message-ID: <1426557233.20938.8.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
	 <1424258514.3819.39.camel@gmail.com> <20150309134535.GA13768@linutronix.de>
	 <1425911771.30469.8.camel@gmail.com> <1425980136.3507.17.camel@gmail.com>
	 <1426153093.4190.2.camel@gmail.com> <1426222405.17611.7.camel@gmail.com>
	 <20150316202409.GF28130@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38761 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbCQBx4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Mar 2015 21:53:56 -0400
In-Reply-To: <20150316202409.GF28130@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2015-03-16 at 21:24 +0100, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2015-03-13 05:53:25 [+0100]:
> 
> >First of all, a task being ticked and trying to shut the tick down will
> >fail to do so due to having just awakened ksoftirqd, so let ksoftirqd
> >try to do that after SOFTIRQ_TIMER processing.  Secondly, should the
> >tick be shut down, we may livelock in hrtimer-cancel() because in -rt
> >a callback may be running.  Break the loop, and let tick_nohz_restart()
> >know that the timer is busy so it can bail.
> 
> I am a bit undecided on that one. I included it in the series but did
> not enable it yet.
> Just so we are on the same page here: you boot your machine with
> something like
>     "isolcpus=1-31 rcu_nocbs=1-31 nohz_full=1-31"
> and pin all kernel threads to CPU0, right?

No, I only declare the nohz_full set, do the isolation via cpusets.

> What you do is that you accept the fact that the timer-softirq is
> scheduled for no reason and then you try to disable the tick from within
> the timer-softirq. I assumed that it would work get the "expired timer"
> somehow.

Yup, it works around that otherwise crippling wakeup.  If I re-apply..

     timers-do-not-raise-softirq-unconditionally.patch

..the workaround is not needed of course, but the livelock fix still is.
I haven't yet tested that in 3.18-rt though, only 4.0-rt, but I presume
it'll be the same deal there when I do.

	-Mike

