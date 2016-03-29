From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH -rt] kernel/time: unbreak nohz in -rt
Date: Tue, 29 Mar 2016 16:10:14 -0400
Message-ID: <20160329161014.15d568be@redhat.com>
References: <20160321151238.43fdfc1d@redhat.com>
	<20160329162556.GF13334@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, riel@redhat.com,
	tglx@linutronix.de, fweisbec@gmail.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40151 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758049AbcC2UKS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 16:10:18 -0400
In-Reply-To: <20160329162556.GF13334@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 29 Mar 2016 18:25:56 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Luiz Capitulino | 2016-03-21 15:12:38 [-0400]:
> 
> >nohz support (nohz-full and nohz-idle) is currently
> >broken in the RT kernel. Meaning that, the tick is
> >never de-activated even when a core is idle or when
> >nohz_full= is passed.
> >
> >The reason for this is that get_next_timer_interrupt()
> >in the RT kernel *always* returns "basem + TICK_NSEC"
> >which translates to "there's a timer firing in the
> >next tick". This causes tick_nohz_stop_sched_tick()
> >to never deactivate the tick.
> >
> >This patch is like tylenol, it doesn't fix the problem, it
> >just reliefs the symptons by making tick_nohz_stop_sched_tick()
> >succeed if: 1. a core doesn't have any legacy timers
> >pending and 2. there's no hrtimer firing in the next tick.
> >
> >Also, note that this issue has another side effect: it
> >causes the ktimersoftd thread to always take 1%-2% of CPU
> >time on all cores, even if they are idle. As it turns out,
> >the tick handling code path unconditionally raises the
> >TIMER_SOFTIRQ line. This is an upstream kernel behavior.
> >I believe people are not noticing the CPU usage because
> >nohz-idle papers over this problem.
> 
> Unless this gets an ack-by tglx I will not consider it.

Thomas?

> Last time it was
> decided that we first rework the timer wheel before getting full-nohz
> fixed for -RT.

Is there anyone working on it? What needs to be done?

> This patch disables interrupts to read an integer which should be safe
> without interrupts disabled.

I think you're right, it shouldn't be necessary to disable
interrupts.

> What are the implications if the value
> changes after read (say after the interrupt enable)?
> 
> >Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> 
> Sebastian
> 

