From: Stanislav Meduna <stano@meduna.org>
Subject: timerfd and softirqd [Was: Re: hrtimer: interrupt took 6742 ns, then
 RT throttling and hung machine for nearly 2 seconds]
Date: Wed, 17 Apr 2013 17:46:59 +0200
Message-ID: <516EC3F3.1080406@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:34959 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965236Ab3DQPrL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Apr 2013 11:47:11 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1USUZb-0006pT-Qt
	for linux-rt-users@vger.kernel.org; Wed, 17 Apr 2013 17:47:07 +0200
In-Reply-To: <516BF8FD.2000700@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

> Yes, we decoded that problem a week ago. Patch is available here:
>
> http://www.spinics.net/lists/linux-tip-commits/msg19100.html

hmm, I think this is something else. From my understanding this
cannot happen on a uniprocessor machine - it is only called
if (cpu != smp_processor_id()).

Could someone point me to a description how exactly the soft
interrupts work? - this is an area that I not really understand
yet. In the kernel I am using these were not yet (or again) handled
by single ksoftirqd.

I caught one of the instances with a trace. The core of the
setup is

1) Thread with a 5 ms timerfd loop, let's call it TimerT,
   RR, rtprio 45

2) ksoftirqd, FF, rtprio 37. Lower than the TimerT because I did
   not want the TimerT be blocked by e.g. net-tx/rx

3) Thread that gets triggered by TimerT, let's call him WorkT.
   RR, rtprio 25. The two use PI lock to synchronize.

4) networking and other irq threads at FF 50 default

I also hacked the throttler code to kill my task with SIGABRT
when RT throttling happens. I am not really sure whether this is
a sane thing to do, but the resulting core shows the thread
in the timerfd read(). Unfortunately I did not have syscall
tracing enabled at that point.

It is difficult to reproduce this - I got it down to once per one
or two days. I could of course try to twiddle with the priorities,
but I will never know whether it fixed the problem or just
made it less probable... Same with the kernel version - I am
using 3.4.25-rt37.


My understanding is that the HRTIMER woke TimerT, in turn the WorkT
was boosted to free the mutex, then the TimerT has done its work.
Now
- either I have a bug and the WorkT loops indefinitely. Not impossible,
  but the code is relatively simple
- or the kernel sometimes does not like a return onto timerfd read
  if the softirq that has woken it did not return yet


This is on a uniprocessor machine. I have edited the task names
and removed the PIDs and other clutter.

ksoftirqd/0 ...1.  1209.368437: softirq_entry: vec=8 [action=HRTIMER]
ksoftirqd/0 d..3.  1209.368444: sched_wakeup: comm=TimerT prio=54
ksoftirqd/0 d..3.  1209.368451: sched_switch: prev_comm=ksoftirqd/0 prev_pid=3 prev_prio=62 prev_state=R+ ==> next_comm=TimerT next_prio=54
     TimerT d..4.  1209.368458: sched_pi_setprio: comm=ksoftirqd/0 pid=3 oldprio=62 newprio=54
     TimerT d..3.  1209.368468: sched_switch: prev_comm=TimerT prev_prio=54 prev_state=D ==> next_comm=ksoftirqd/0 next_pid=3 next_prio=54
ksoftirqd/0 d..4.  1209.368475: sched_wakeup: comm=TimerT prio=54
ksoftirqd/0 d..3.  1209.368478: sched_pi_setprio: comm=ksoftirqd/0 pid=3 oldprio=54 newprio=62
ksoftirqd/0 d..3.  1209.368488: sched_switch: prev_comm=ksoftirqd/0 prev_pid=3 prev_prio=62 prev_state=R+ ==> next_comm=TimerT next_prio=54
     TimerT d..4.  1209.368506: sched_pi_setprio: comm=WorkT oldprio=74 newprio=54
     TimerT d..3.  1209.368517: sched_switch: prev_comm=TimerT prev_prio=54 prev_state=D ==> next_comm=WorkT next_prio=54
      WorkT d..4.  1209.368525: sched_wakeup: comm=TimerT prio=54
      WorkT d..3.  1209.368529: sched_pi_setprio: comm=WorkT oldprio=54 newprio=74
      WorkT d..3.  1209.368538: sched_switch: prev_comm=WorkT prev_prio=74 prev_state=R+ ==> next_comm=TimerT next_prio=54
     TimerT d.h1.  1209.369388: irq_handler_entry: irq=0 name=timer
     TimerT d.h1.  1209.369399: softirq_raise: vec=1 [action=TIMER]
     TimerT d.h1.  1209.369402: irq_handler_exit: irq=0 ret=handled
     TimerT d.h1.  1209.370388: irq_handler_entry: irq=0 name=timer
     TimerT d.h1.  1209.370398: softirq_raise: vec=1 [action=TIMER]
... only timers here, then a HRTIMER comes ...
     TimerT d.h1.  1209.373387: irq_handler_entry: irq=0 name=timer
     TimerT d.h1.  1209.373397: softirq_raise: vec=8 [action=HRTIMER]
     TimerT d.h1.  1209.373400: softirq_raise: vec=1 [action=TIMER]
     TimerT d.h1.  1209.373402: irq_handler_exit: irq=0 ret=handled
     TimerT d.h1.  1209.374387: irq_handler_entry: irq=0 name=timer
... only timers here ...
     TimerT d.h3.  1209.555024: sched_wakeup: comm=irq/5-eth0 prio=49
     TimerT d..3.  1209.555033: sched_switch: prev_comm=TimerT prev_prio=54 prev_state=R+ ==> next_comm=irq/5-eth0 next_pid=442 next_prio=49
 irq/5-eth0 d..1.  1209.555041: softirq_raise: vec=3 [action=NET_RX]
 irq/5-eth0 d..3.  1209.555054: sched_switch: prev_comm=irq/5-eth0 prev_prio=49 prev_state=S ==> next_comm=TimerT next_prio=54
... a HRTIMER much later than the 5 ms ...
     TimerT d.h1.  1210.253256: softirq_raise: vec=8 [action=HRTIMER]
... last entry ...
     TimerT d.h1.  1211.196095: irq_handler_entry: irq=0 name=timer
	
Note1: there is no
  softirq_exit: vec=8 [action=HRTIMER]
until the rt throttler kicked in. There are only two
  softirq_raise: vec=8 [action=HRTIMER]
although it should come once per 5 ms.

Note2: I call tracing_off() right in the throttling code in rt.c. The
last switch from a non-RT task was at 1209.365377 - i.e 1.8 seconds
before. Why did the throttler did not react sooner?

Thanks
-- 
                                           Stano

