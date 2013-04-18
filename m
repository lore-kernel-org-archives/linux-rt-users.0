From: Stanislav Meduna <stano@meduna.org>
Subject: timerfd read does not return [Was: Re: timerfd and softirqd]
Date: Thu, 18 Apr 2013 11:11:21 +0200
Message-ID: <516FB8B9.9090506@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:59671 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755965Ab3DRJLc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Apr 2013 05:11:32 -0400
In-Reply-To: <516EC3F3.1080406@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

from a new log that includes syscall tracing it seems that a thread
waiting in a timerfd is woken, but does not return from the read:

     TimerT d....  3825.943136: sys_read -> 0x8
...
     TimerT d....  3825.943199: sys_read(fd: 6, buf: b7633158, count: 8)
     TimerT d..3.  3825.943208: sched_switch: prev_comm=TimerT prev_prio=54 prev_state=S ==> next_comm=ksoftirqd/0 next_prio=62
ksoftirqd/0 ...1.  3825.943213: softirq_exit: vec=8 [action=HRTIMER]
...
     OtherT d.h1.  3825.947983: irq_handler_entry: irq=0 name=timer
     OtherT d.h3.  3825.947997: sched_wakeup: comm=SomeT1 prio=84 success=1
     OtherT d.h3.  3825.948005: sched_wakeup: comm=SomeT2 prio=69 success=1
     OtherT dNh1.  3825.948009: softirq_raise: vec=8 [action=HRTIMER]
     OtherT dNh1.  3825.948011: softirq_raise: vec=1 [action=TIMER]
     OtherT dNh1.  3825.948014: irq_handler_exit: irq=0 ret=handled
...
ksoftirqd/0 ...1.  3825.948034: softirq_entry: vec=1 [action=TIMER]
ksoftirqd/0 ...1.  3825.948037: softirq_exit: vec=1 [action=TIMER]
ksoftirqd/0 ...1.  3825.948039: softirq_entry: vec=8 [action=HRTIMER]
ksoftirqd/0 d..3.  3825.948047: sched_wakeup: comm=TimerT prio=54 success=1
ksoftirqd/0 d..3.  3825.948054: sched_switch: prev_comm=ksoftirqd/0 prev_prio=62 prev_state=R+ ==> next_comm=TimerT next_prio=54
     TimerT d..4.  3825.948061: sched_pi_setprio: comm=ksoftirqd/0 oldprio=62 newprio=54
     TimerT d..3.  3825.948072: sched_switch: prev_comm=TimerT prev_prio=54 prev_state=D ==> next_comm=ksoftirqd/0 next_prio=54
ksoftirqd/0 d..4.  3825.948079: sched_wakeup: comm=TimerT prio=54 success=1
ksoftirqd/0 d..3.  3825.948083: sched_pi_setprio: comm=ksoftirqd/0 oldprio=54 newprio=62
ksoftirqd/0 d..3.  3825.948093: sched_switch: prev_comm=ksoftirqd/0 prev_prio=62 prev_state=R+ ==> next_comm=TimerT next_prio=54
     TimerT d.h1.  3825.948980: irq_handler_entry: irq=0 name=timer
     TimerT d.h1.  3825.948991: softirq_raise: vec=1 [action=TIMER]
...

There is no return from the read until the RT throttler got activated.
Kernel version 3.4.25-rt37 - I'll check whether anything relevant
has changed since then.


Regards
-- 
                                            Stano

