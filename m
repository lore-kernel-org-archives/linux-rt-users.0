From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch v2] rt,nohz_full: fix nohz_full for PREEMPT_RT_FULL
Date: Fri, 10 Apr 2015 16:24:12 +0200
Message-ID: <1428675852.4309.108.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
	 <1424258514.3819.39.camel@gmail.com> <20150309134535.GA13768@linutronix.de>
	 <1425911771.30469.8.camel@gmail.com> <1425980136.3507.17.camel@gmail.com>
	 <1426153093.4190.2.camel@gmail.com> <1426222405.17611.7.camel@gmail.com>
	 <20150410141552.GC3057@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150410141552.GC3057@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2015-04-10 at 16:15 +0200, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2015-03-13 05:53:25 [+0100]:
> 
> > First of all, a task being ticked and trying to shut the tick down 
> > will
> > fail to do so due to having just awakened ksoftirqd, so let 
> > ksoftirqd
> > try to do that after SOFTIRQ_TIMER processing.  Secondly, should 
> > the
> > tick be shut down, we may livelock in hrtimer-cancel() because in -
> > rt
> > a callback may be running.  Break the loop, and let 
> > tick_nohz_restart()
> > know that the timer is busy so it can bail.
> 
> So with this patch
>     http://marc.info/?l=linux-rt-users&m=142866940327602&w=2
> 
> you could drop the hrtimer hacks. Is this the remaining part all 
> that is
> required or we shorten the following patch a little more?

It's better to let the task that awakened ksoftirqd do the subtracting 
instead of waiting for ksoftirqd to try again after waker fails, so it 
wants to know that ksoftirqd is running due to that timer wakeup.

If you remove the hrtimer bit, you should quickly meet the livelock.

        -Mike
