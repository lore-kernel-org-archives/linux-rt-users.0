Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48968 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932362AbeCFWHo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Mar 2018 17:07:44 -0500
Date: Tue, 6 Mar 2018 16:07:34 -0600
From: Julia Cartwright <julia@ni.com>
Subject: Re: RT-thread on cpu0 affects performance of RT-thread on isolated
 cpu1
Message-ID: <20180306220734.GG955@jcartwri.amer.corp.natinst.com>
References: <1431882400.9091188.1519852270876.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
 <20180302094343.xjyr6hndg4yrjxpo@linutronix.de>
 <2093164410.9598731.1520371010962.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2093164410.9598731.1520371010962.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Yann le Chevoir <yann.le-chevoir@grenoble-inp.org>
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>, linux-rt-users <linux-rt-users@vger.kernel.org>, Haris Okanovic <haris.okanovic@ni.com>

On Tue, Mar 06, 2018 at 10:16:50PM +0100, Yann le Chevoir wrote:
> Hello,
> 
> Thank you for helping :)
> 
> >> I am an engineering student and I try to proof that a 4000Hz hard real-time
> >> application can run on an ARM board rather than on a more powerful machine.
> >> 
> >> I work with an IMX6 dual-core and PREEMPT_RT patch-4.1.38-rt46.
> >>
[..]
>           <idle>-0     [001] d..h1..  	0	: irq_handler_entry: irq=16 name=twd
>           <idle>-0     [001] d..h1..  	2	: hrtimer_expire_entry: hrtimer=98117ef0 function=hrtimer_wakeup now=1864569754886
>           <idle>-0     [001] dn.h1..  	7	: irq_handler_exit: irq=16 ret=handled
>           <idle>-0     [001] d...2..  	13	: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=test_preempt next_pid=5583 next_prio=1
>     test_preempt-5583  [001] d...2..  	73	: sched_switch: prev_comm=test_preempt prev_pid=5583 prev_prio=1 prev_state=S ==> next_comm=swapper/1 next_pid=0 next_prio=120
>           <idle>-0     [001] d..h1..  	250	: irq_handler_entry: irq=16 name=twd
>           <idle>-0     [001] d..h1..  	253	: hrtimer_expire_entry: hrtimer=bf7af990 function=tick_sched_timer now=1864570005553
>           <idle>-0     [001] d..h1..  	259	: softirq_raise: vec=1 [action=TIMER]
>           <idle>-0     [001] d..h1..  	263	: hrtimer_expire_entry: hrtimer=98117ef0 function=hrtimer_wakeup now=1864570005553
>           <idle>-0     [001] dn.h1..  	268	: irq_handler_exit: irq=16 ret=handled
>           <idle>-0     [001] d...2..  	285	: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=test_preempt next_pid=5583 next_prio=1
>     test_preempt-5583  [001] d...2..  	353	: sched_switch: prev_comm=test_preempt prev_pid=5583 prev_prio=1 prev_state=S ==> next_comm=ktimersoftd/1 next_pid=21 next_prio=98
>    ktimersoftd/1-21    [001] .....11  	361	: softirq_entry: vec=1 [action=TIMER]
>    ktimersoftd/1-21    [001] .....11  	364	: softirq_exit: vec=1 [action=TIMER]

Unfortunately, v4.1-rt doesn't currently support NO_HZ=full, because it
didn't contain the hrtimer rework necessary to do so w/ PREEMPT_RT.
This is what's preventing the tick from being deferred (as you've
indicated, it's still ticking away at HZ).  This is the primary problem.

A secondary problem is that it appears that the issue Haris (CCed) has
been looking at applies further back than the hrtimer rework.  That is:
the TIMER_SOFTIRQ is unconditionally raised in the scheduler tick,
regardless if there is an armed timer in the queues.

   Julia
