Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:54912 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLGLoy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Dec 2018 06:44:54 -0500
Date: Fri, 7 Dec 2018 12:44:50 +0100
From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: outliers when measuring boost msqueues latency v4.14.79-rt47
 RT-Preempt
Message-ID: <20181207114450.pypgcipls27f3izw@linutronix.de>
References: <VI1PR06MB44627C92EA94534421191FEBCEA90@VI1PR06MB4462.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR06MB44627C92EA94534421191FEBCEA90@VI1PR06MB4462.eurprd06.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Andreas Hoefler <andreas.hoefler@ch.abb.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2018-12-06 12:08:00 [+0000], Andreas Hoefler wrote:
> Hi everyone
Hi,

> I have a test application which measures the latency for sending and receiving boost message queues under a certain cpu load.
> There are two background load tasks with rt priority -20 pinned to either of the two cores of an ARMv71 in order to consume a certain amount of cpu load e.g. 40% each.
> My sending and receiving threads have both rt prio -49 FIFO, using a semaphore mechanism with a mutex with attribute PTHREAD_MUTEX_ADAPTIVE and PTHREAD_PRIO_INHERIT for signaling when the message was received and is ready to get the next one. Nothing else is running besides that.
> Apparently  I see (pretty much periodically) outliers of up  to 30ms (compared to around 10us per send and receive).

I'm not sure of PTHREAD_MUTEX_ADAPTIVE makes any difference. I don't
know what the semaphore does. If you trace the sys_futex syscall you
should only see FUTEX_LOCK_PI and FUTEX_UNLOCK_PI and no FUTEX_WAIT or
FUTEX_WAKE for the two threads.

> I traced it with LTTng with all kernel events and some userspace events enabled and this is what I observe: 
> -	The Background load gets interrupted as it should by the higher priority sending and receiving threads
> -	Periodically I see a sudden stop in either the receiving or the sending thread, in no particular section of the code.
> -	During this period one of the threads is in "wait for CPU" state
> -	In all cases there seems to be the IRQ19 (arch_timer) which triggers either of the threads to continue (but appeared several times in between)
> 
> I am writing because this used to work fine on an older version (not sure but I think it was 4.4.32) where max latencies of about 100us occurred.
> Currently I am testing with Linux am57xx-evm 4.14.79-rt47-gda0d0b490c #8 SMP PREEMPT RT Fri Nov 23 14:32:07 CET 2018 armv7l GNU/Linux. (TI Sitara)

So with HZ=1000 you should have one timer tick each ms. That means for
your 30ms outliner you should see ~29-30 of those. Unless you have NO_HZ
and the CPU wend idle for a longer period of time. Is there no timer for
30ms and the suddenly the one timer wakes the application up? "wait for
CPU" sounds like something got interrupted and something else is busy.
A sched_switch tracer + sched_wakeup events might reveal what happens in
between.

> Thanx a lot
> Andy

Sebastian
