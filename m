From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Wed, 31 Oct 2012 21:08:45 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1210311949400.2756@ionos>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Alexander Shishkin <virtuoso@slind.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <johnstul@us.ibm.com>
To: Scot Salmon <scot.salmon@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59466 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759725Ab2JaUIu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Oct 2012 16:08:50 -0400
In-Reply-To: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 31 Oct 2012, Scot Salmon wrote:
> I described a more concrete use case to Thomas that is not solved by 
> timerfd.  We have multiple devices running control loops using 
> clock_nanosleep and TIMER_ABSTIME to get good periodic wakeups.  The 
> clocks need to be synchronized across the controllers so that the loops 
> themselves can be in sync.  In order to use a synchronized clock we have 
> to use CLOCK_REALTIME.  But if the control loop starts, and then the time 
> sync protocol kicks in and shifts the clock, that breaks the control loop, 
> the most obvious case being if time shifts backwards and a loop that 
> should be running at 100us takes 100us + some arbitrary amount of time 
> shift, potentially measured in minutes or even days.  timerfd has the 
> behavior I need, but its performance is much worse than clock_nanosleep, 
> we believe because the wakeup goes through ksoftirqd.

With less conference induced brain damage I think your problem needs
to be solved differently.

What you are concerned about is keeping the machines in sync on a
common global timeline. Though your more fundamental requirement is
that you get the wakeup on each machine in the given cycle time. The
global synchronization mechanism just adjusts that local periodic
schedule.

So when you start up a control process on a node you align the cycle
time of this node to the global CLOCK_REALTIME timeline. That's why
you decided to use CLOCK_REALTIME in the first place, but then as you
observed correctly this sucks due to the nature of CLOCK_REALTIME
which can be affected by leap seconds, daylight saving changes and
other interesting events.

So ideally you should use CLOCK_MONOTONIC for scheduling your periodic
timeline, but you can't as you do not have a proper correlation
between CLOCK_REALTIME, which provides your global synchronization,
and the machine local CLOCK_MONOTONIC.

What you really want is an atomic readout facility for CLOCK_MONOTONIC
and CLOCK_REALTIME. That allows you to align the CLOCK_MONOTONIC based
timer with the global CLOCK_REALTIME based time line and in the event
that the CLOCK_REALTIME clock was set and jumped forward/backward you
have full software control over the aligning mechanism including the
ability to do sanity checking.

Lets look at an example.

T1   1000
     1050	<--- Time correction resets global time to 1000
T2   1100

Now you have the problem when your wakeup is actually happening. 50 us
delta is not a huge amount of time to propagate this to all CPUs and
all involved distributed systems. So what happens if system 1 sees
that update right away, but system 2 sees it just at the real timer
wakeup point? Then suddenly your loops are off by 50us for at least
one cycle. Not what you want, right?

So in the CLOCK_MONOTONIC case you still maintain the accuracy of your
periodic 100us event. The accuracy of CLOCK_MONOTONIC across (NTP/PTP)
time synced systems is way better than any mechanism which relies on
"timely" notification of CLOCK_REALTIME changes.

The minimal clock skew adjustments which affect the global
CLOCK_REALTIME are propagated to CLOCK_MONOTONIC as well, so you don't
have to worry about that at all. All what you need to be concerned
about is the time jump issue. But then again CLOCK_MONOTONIC will not
follow those time jumps and therefor maintain your XXXus periods for
quite some time with accurate synchronous behaviour.

With an atomic readout of CLOCK_MONOTONIC and CLOCK_REALTIME you can
be clever and safe about adjusting to a 50us or whatever large scale
global time line change. You can actually verify in your cluster
whether this was a legitimate change or just the random typo of the
sysadmin and you can agree on how to deal with the time jump in a
coordinated way, i.e. jumping forward sychronously on a given time
stamp or gradually adjusting it in microsecond steps.

Thanks,

	tglx

