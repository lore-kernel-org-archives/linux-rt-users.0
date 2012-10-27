From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: loading pages to memory causes high latency
Date: Sat, 27 Oct 2012 11:56:03 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210271147280.2756@ionos>
References: <508ACFCF.8040001@meduna.org> <alpine.LFD.2.02.1210262254560.2756@ionos> <alpine.LFD.2.02.1210271029370.2756@ionos> <508BA412.5020708@meduna.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37180 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab2J0J4G (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2012 05:56:06 -0400
In-Reply-To: <508BA412.5020708@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 27 Oct 2012, Stanislav Meduna wrote:
> On 27.10.2012 10:38, Thomas Gleixner wrote:
> 
> > There is not much we can do about that unless we want to do a major
> > surgery on that pata driver code.
> > 
> > So either you disable the throttler or you reconfigure the pata irq
> > thread to SCHED_OTHER, which will slow it down a bit, but avoids the
> > hogging of the machine with a RT task going wild.
> 
> Thank you for the analysis. Yep I'll reconfigure it to SCHED_OTHER -
> file access is a totally low-prio thing in my application and I was more
> afraid of a possibility where someone fetching logfiles or something
> like that will bring the application to the knees.
> 
> BTW what granularity does the throttler have? I cannot live with
> 50 ms lag once in a second, but in my case I can well live with
> 5 ms lag once in 100 ms (even if that means that the throttler
> would be activated more often).

The granularity is microseconds. 

sched_rt_period  defaults to 1000000	== 1.00s
sched_rt_runtime defaults to  950000	== 0.95s

The mechanics of the throttler is that it gives SCHED_OTHER a chance
to run for sched_rt_period - sched_rt_runtime (default 0.05s == 50ms)
if RT tasks hogged the cpu for more than sched_rt_runtime in a row.

This is a safety belt, so you have a chance to kill your RT task which
got lost in a while(1) loop :)

> Right now I have
> 
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ=y
> CONFIG_HZ=1000
> CONFIG_SCHED_HRTICK=y
> 
> and lacking better choices my clock source is TSC. I admit that
> I do not know what precisely each setting does - the NO_HZ combined
> with HZ=1000 looks a bit weird ;)

HZ is the scheduler tick frequency. That's used for timeslicing
SCHED_OTHER tasks.

NO_HZ is only affecting idle. When the machine goes idle and the next
timer expires AFTER the next scheduler tick, then the scheduler tick
is stopped and the timer device is armed to the timer expiry. That's a
power saving feature as it allows the CPU to stay in deeper
powerstates for a longer time, instead of waking up with HZ frequency
just to see that there is nothing to do, which is silly as we know
that right when we go idle :)

Thanks,

	tglx
