Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:53497 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424524AbeCBJnq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Mar 2018 04:43:46 -0500
Date: Fri, 2 Mar 2018 10:43:43 +0100
From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: RT-thread on cpu0 affects performance of RT-thread on isolated
 cpu1
Message-ID: <20180302094343.xjyr6hndg4yrjxpo@linutronix.de>
References: <1431882400.9091188.1519852270876.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1431882400.9091188.1519852270876.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Yann le Chevoir <yann.le-chevoir@grenoble-inp.org>
Cc: linux-rt-users@vger.kernel.org

On 2018-02-28 22:11:10 [+0100], Yann le Chevoir wrote:
> Hello,
Hi,

> I am an engineering student and I try to proof that a 4000Hz hard real-time
> application can run on an ARM board rather than on a more powerful machine.
> 
> I work with an IMX6 dual-core and PREEMPT_RT patch-4.1.38-rt46.
> I expected that my 4000Hz thread will perform better if it is the only one
> on core1, so I put the boot argument isolcpus=1 and bound my thread to cpu1.
> 
> With the isolcpus=1, note that it remains these processes on core1:
> 
>    PID    PSR    RTPRIO    CMD
>    16     1      99        [migration/1]
>    17     1      -         [rcuc/1]
>    18     1      1         [ktimersoftd/1]
>    19     1      -         [ksoftirqd/1]
>    20     1      99        [posixcputmr/1]
>    21     1      -         [kworker/1:0]
>    22     1      -         [kworker/1:0H]
> 
> I tried several permutations in my kernel configuration and boot args
> (rcu_nocbs is an example) and none affected the results I describe below.

In general with isolcpus you should be able to get most task off CPU1.
The rcu_nocbs option should get the RCU callbacks off CPU1. And then you
can change the IRQ affinity to CPU0. But this looks good.

> I use a script to stress Linux. I expected that only cpu0 will be stressed
> as cpu1 is isolated. But it has an impact on thread on cpu1 too.
> I think it is normal.

The CPU-caches might be shared. Locks which which are held by CPU0 and
required by CPU1 will also slow down CPU1.
The sched_switch tracer should show you if anything of your "script to
stress" migrates to CPU1 and/or if the "delays" CPU1. That would make
your task on CPU1 go from state R to D and back to R.

> First, as I draw it (in red) on “expected_behavior.png”, I expected much less
> variations in the Latency and especially the Execution time.
> (My thread always does the same thing).

You could try cyclictest and compare its latency. However from the plot
it looks at about 25us so it is not that bad.

> How can we explain so much time variations? As I said, I tried to deactivate
> all interrupts on cpu1 (rcu and others processes above) but I am not very
> familiar with that.
As I suggested above, run sched_switch, measure the latency and if you
hit an execution time of 150us then tell your application to disable the
trace (a write '0' to the tracing_on sysfs file would do it) and then
you can look at the trace and see if got interrupted by anything.

> Then, I am even more surprised when, trying to debug that, I decided to put
> another thread on core0 and it improved the behavior of the thread on core1!

If you put more load on the system and the numbers improve then this
might be because the caches are filled with the "right" data. Also it
might prevent power management from doing its job. 

> My application looks like:

…
> thread1(){
> 
>      struct timespec start, stop, next, interval = 250us;
> 
>      /* Initialization of the periodicity */
>      clock_gettime(CLOCK_REALTIME, &next);

CLOCK_MONOTONIC is what you want.
>      next += interval;
> 
>      while(1){
>           /*Releases at specified rate*/
>           clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &next, NULL);

I know, error checking is hard. But You should check if the above
returned an error and since you "just" looked at the time, you should
check if next <= now.

>           /*Get time to check jitter and execution time*/
>           clock_gettime(CLOCK_REALTIME, &start);
>           do_job();
>           /*Get time to check execution time*/
>           clock_gettime(CLOCK_REALTIME, &stop);
>           do_stat(); //jitter = start-next; exec_time = stop-start
>           next += interval;
>      }
> 
> }


> thread0(){
>     struct timespec next, interval = 250us;
> 
>      /* Initialization of the periodicity */
>      clock_gettime(CLOCK_REALTIME, &next);
>      next += interval;
> 
>      while(1){
>           /*Releases at specified rate*/
>           clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &next, NULL);
>           usleep(100);
>           /****************************************************************
>            * Without sleeping 100us, only the Latency of the other thread *
>            * (on cpu1) is improved.                                       *
>            * Sleeping 100us in this new 4000Hz thread (cpu0) improved     *
>            * the execution time of the other thread (on cpu1)...          *
>            ****************************************************************/

I'm not sure but it looks like the usleep() is implemented as a
busy loop. A busy loop of 100us isn't *that* bad but if all RT tasks
take around 950us then the scheduler will prevent all RT tasks from
running (in order to prevent a possible lockup).

>           next += interval;
>      }
> 
> }
> 
> As you can see in “background_thread_on_core_0.png”, the Latency and the
> Execution time (of the thread on core1) are improved (in comparison with
> “no_background_thread.png”) when there is a new 4000Hz thread on cpu0
> AND when this thread does something...
> 
> I tried a lot of permutations and I do not understand:
> - If the new thread (cpu0) is at 5000Hz (>4000Hz), then observations
>   are the same (performance of the thread on cpu1 improves)
> - If the new thread is at 2000HZ (<4000Hz), then there is no improvement...
> 
> - If the new thread (4000Hz on cpu0) does something (even sleeping enough
>   time), then the Execution time of the thread on cpu1 improves.
> - If the new thread does nothing (or do too few stuff), then, ONLY the
>   Latency of the thread on cpu1 is improved...
> 
> Do you have any experience with that, any idea to debug?

- tracing to see if the scheduler puts another task on while your RT is
  running
- tracing to see if an interrupts fires which prevents your task from
  running. This should only be the timer interrupt since everything else
  should be only on CPU0.
- check if any power management is on and try to disable it.
- as time basis, try not to use a random time but start with usec = 25
  or 50 or so. You should be able to avoid the HZ timer.

> I wonder if the scheduler or the clock tick are bound to cpu0 and if it
> can play a role in the responsiveness of the thread on cpu1 (isolated one).
> 
> Thanks,
> 
> Regards,
> 
> Yann

Sebastian
