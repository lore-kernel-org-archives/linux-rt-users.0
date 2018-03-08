Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:39294 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934104AbeCHRVm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Mar 2018 12:21:42 -0500
Date: Thu, 8 Mar 2018 18:21:40 +0100
From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: RT-thread on cpu0 affects performance of RT-thread on isolated
 cpu1
Message-ID: <20180308172140.6vm5hir6qljgklkv@linutronix.de>
References: <1431882400.9091188.1519852270876.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
 <20180302094343.xjyr6hndg4yrjxpo@linutronix.de>
 <2093164410.9598731.1520371010962.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2093164410.9598731.1520371010962.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Yann le Chevoir <yann.le-chevoir@grenoble-inp.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

On 2018-03-06 22:16:50 [+0100], Yann le Chevoir wrote:
> Hello,
Hi,

> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ_FULL=y
> CONFIG_NO_HZ_FULL_ALL=y

I am not sure NO_HZ_FULL is what you want. From what I know NO_HZ_FULL
has a little more overhead while calling into the kernel but is
perfectly fine if you plan to stay in userland and hardly call into the
kernel. Your application seems to be interval based and you do not stay
for longer periods of time in userland.
(not to mention what Julia said that NO_HZ_FULL is not working in the
old RT kernels).

…
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> # CONFIG_CPU_FREQ_STAT is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> ...
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
> ...
> CONFIG_ARM_IMX6Q_CPUFREQ=y
> ...
CPUFREQ may influence the latencies if it plans to switch the frequency
while you are in middle of something.

> About power management, as you can see in the kernel conf, *it is enabled*
> but *only the performance mode* is enabled.
> Indeed, I already worked on that, I first deactivated it but then my clock
> was not at its maximum.
> I succeeded in getting the max clock frequency back by doing this.

What you want to avoid is that the CPU-speed is changed at runtime while
you measure your application. If that is the case then you should be
good.

> >> thread1(){
> >> 
> >>      struct timespec start, stop, next, interval = 250us;
> >> 
> >>      /* Initialization of the periodicity */
> >>      clock_gettime(CLOCK_MONOTONIC, &next);
> >>
> >>      /* as time basis, try not to use a random time but start with usec = 25 *
> >>       * or 50 or so. You should be able to avoid the HZ timer.               */
> >>      next.tv_sec += 1;
> >>      next.tv_nsec = 250000;
> 
> Is it what you expected I did?

I said 25 or 50 us, you did 250us so no, I didn't expect that :)
The thing is with HZ=100 you get 100 ticks per second - one every 10ms.
With an offset of 250us and an interval of 250us you end up programming
your timer at the same point time as the timer which increments jiffies.
That means that your timer (and the other one) fire at the same time but
your application has to wait until the jiffies incremented. If you
program your timer 25us *after* a full second then the HZ timer
increments the jiffy at 0 and 25us *after* that timer your application's
timer should fire.

> I analyse a trace below.
> There is only the ktimersoftd/1 task which comes back every 10000us.
> I first had CONFIG_HZ=1000 so it was every 1000us then.
> I first thought it was responsible for my problems.
> But finally it seems not. I am not sure.

HZ=100 should be okay. The mod_timer() timer are less accurate with
HZ=100 than with HZ=1000. Your clock_nanosleep() is not affected by this
because you use a highres timer which is not affected by this.

> > - as time basis, try not to use a random time but start with usec = 25  
> > or 50 or so. You should be able to avoid the HZ timer.
> 
> I am confident it is what I want, but, according to the documentation,
> I am afraid:
>    "POSIX CPU timers prevent CPUs from entering adaptive-tick mode.
>    Real-time applications needing to take actions based on CPU time
>    consumption need to use other means of doing so."
> Indeed, I want to continue to use the POSIX CPU timer (sleep and gettime).

So maybe you don't want NO_HZ_FULL. As I explained above you don't spent
your whole time in userland - you do things and sleep until the next
cycle.

> I attached the trace (trace.txt) to this message.
> The trace stopped when exec_time was more than 200us.
> 
> I "normalized" (put to 0) the timestamp two times to understand what
> is going on.
> 
> What I understand:
> 
> Lines 5-8:   It is the clock_nanosleep handler.
>              It takes 13us to wake up the thread. Good.
> Line 9:      The thread took 60us to run. Very good.
> Line 10:     Let's start again 250us later. Good.
> Line 11:     tick_sched_timer... It will wake up the ktimersoftd/1.
>              I am afraid :(
> Line 15:     It tooks 35us to wake up the thread...
>              Not so bad, sometimes it is more...
> Line 16:     The thread took 68us to run. Ok.
> Lines 17-19: ktimersoftd/1 took 17us to run (370-353).
>              I think it is not so embarrassing. I am reassured :) 
> ...
> Line 69:     1000us, ok
> Line 74:     1256us, 6us late :(
> Line 77:     36us to wake up the thread, +6us = 42us jitter :( :(
> Line 78:     ***255us (1547-1292) execution time !!!***
> Line 79:     Overrun, next rdv at 1750us, 8us late...
> 
> Does this trace help?
> According to me, there is nothing on CPU1. There is just this ktimersoftd/1.

So the idea was to add +25us to your timer and start hopefully after all
this.

> Can the idle task (on cpu0) be delayed by the stress on cpu0?
The idle should ideally do nothing. It does usually the "wfi" opcode
which stands for "Wait For Interrupt". If something on CPU0 holds a lock
which is needed CPU1 then CPU1 has to wait. Looking at CPU0 and CPU1 at
the same time you could see what CPU0 is doing and then check if this
might interact with CPU1.
I'm not sure why there is a 6us delay. Also everything after that seem
to take a little longer than usual.

> Can we migrate the Linux scheduler to cpu1?
You have a runqueue per CPU. So in a sense you have a scheduler per-CPU.
Since all your task on CPU0 have the affinity mask set to CPU0 only then
the scheduler on CPU0 should never try to migrate migrate a task.

> Thanks again,
> 
> Yann

Sebastian
