From: Gary Robertson <gary.robertson@linaro.org>
Subject: Re: PREEMPT_RT with Full Tickless
Date: Sat, 12 Dec 2015 14:11:02 -0600
Message-ID: <CAF7YWnzyxECC=iKhVHoJXQrb_QH8pqvcm0LC9Fq43NviuSM=hg@mail.gmail.com>
References: <CANv7uPSimVG=GfQ5W_HDq0UYUokK-Y2WvSPTXc3MFd7eLXqYVQ@mail.gmail.com>
 <1449844577.4882.5.camel@gmail.com> <20151211175023.GN6720@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	GeHao Kang <kanghao0928@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, jason.low2@hp.com,
	RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35060 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbbLLULY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Dec 2015 15:11:24 -0500
Received: by lfdl133 with SMTP id l133so97749975lfd.2
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Dec 2015 12:11:22 -0800 (PST)
In-Reply-To: <20151211175023.GN6720@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Dec 11, 2015 at 11:50 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Mike Galbraith | 2015-12-11 15:36:17 [+0100]:
>
>>On Fri, 2015-12-11 at 19:29 +0800, GeHao Kang wrote:
>>> When I enable CONFIG_PREEMPT_RT_FULL and CONFIG_NO_HZ_FULL
>>> in Linux Kernel v4.1.12-rt12, I find the tick on the nohz_full cpu
>>> never stops.
>>


Also - since in RT the tick timer interrupt results in a schedulable
thread running to handle the software interrupt work stimulated by the
tick - upon exit from the interrupt handler there are always at least
2 runnable threads in the CPU running the tick if there was a runnable
task interrupted by the tick event.  Therefore the scheduler is still
needed on that CPU, the CPU is ineligible to enter full tickless mode,
and another tick timer event is scheduled.  Below is an ftrace snippet
from an isolation test of an Linaro Networking Group kernel with the
RT patch applied.  It is a v4.1.10 kernel running on a dual-core ARM
Cortex A15 armv7a platform and compiled with
CONFIG_NO_HZ_FULL_ALL=y... so CPU 1 is designated for full tickless
operation when possible.  The cpuhog process is affined to the
isolated CPU and runs a tight loop with no system calls so it is
always runnable.  The snippet below shows two tick cycles but this
condition persists indefinitely.

# tracer: function
#
# entries-in-buffer/entries-written: 34219/132331   #P:2
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            |/  _-----=> need-resched_lazy
#                            || / _---=> hardirq/softirq
#                            ||| / _--=> preempt-depth
#                            |||| /_--=> preempt-lazy-depth
#                            |||||  _-=> migrate-disable
#                            ||||| /    delay
#           TASK-PID   CPU#  ||||||    TIMESTAMP  FUNCTION
#              | |       |   ||||||       |         |
          cpuhog-1800  [001] dn..1..  1103.211867: tick_stop:
success=no msg=more than 1 task in runqueue

          cpuhog-1800  [001] dn..3..  1103.211870: sched_stat_runtime:
comm=cpuhog pid=1800 runtime=12083 [ns] vruntime=90040150190 [ns]
          cpuhog-1800  [001] d...3..  1103.211872: sched_switch:
prev_comm=cpuhog prev_pid=1800 prev_prio=120 prev_state=R ==>
next_comm=ksoftirqd/1 next_pid=18 next_prio=98
     ksoftirqd/1-18    [001] ....111  1103.211880: softirq_entry:
vec=1 [action=TIMER]
     ksoftirqd/1-18    [001] ....111  1103.211883: softirq_exit: vec=1
[action=TIMER]
     ksoftirqd/1-18    [001] d...3..  1103.211889: sched_stat_wait:
comm=cpuhog pid=1800 delay=37834 [ns]
     ksoftirqd/1-18    [001] d...3..  1103.211891: sched_switch:
prev_comm=ksoftirqd/1 prev_pid=18 prev_prio=98 prev_state=S ==>
next_comm=cpuhog next_pid=1800 next_prio=120
          cpuhog-1800  [001] d..h1..  1103.216830: irq_handler_entry:
irq=49 name=arch_timer
          cpuhog-1800  [001] d..h2..  1103.216832: hrtimer_cancel:
hrtimer=ee7a5c98
          cpuhog-1800  [001] d..h1..  1103.216834:
hrtimer_expire_entry: hrtimer=ee7a5c98 function=tick_sched_timer
now=1103195005858
          cpuhog-1800  [001] d..h2..  1103.216836: sched_stat_runtime:
comm=cpuhog pid=1800 runtime=4949166 [ns] vruntime=90045099356 [ns]
          cpuhog-1800  [001] d..h1..  1103.216839: softirq_raise:
vec=1 [action=TIMER]
          cpuhog-1800  [001] d..h1..  1103.216841:
hrtimer_expire_exit: hrtimer=ee7a5c98
          cpuhog-1800  [001] d..h2..  1103.216843: hrtimer_start:
hrtimer=ee7a5c98 function=tick_sched_timer expires=1103200000000
softexpires=1103200000000
          cpuhog-1800  [001] d..h1..  1103.216845: irq_handler_exit:
irq=49 ret=handled
          cpuhog-1800  [001] d...3..  1103.216849:
tick_nohz_full_kick_cpu <-enqueue_top_rt_rq
          cpuhog-1800  [001] dn..3..  1103.216853: sched_wakeup:
comm=ksoftirqd/1 pid=18 prio=98 success=1 target_cpu=001
          cpuhog-1800  [001] dn..1..  1103.216855: tick_nohz_irq_exit <-irq_exit
          cpuhog-1800  [001] dn..1..  1103.216856: tick_stop:
success=no msg=more than 1 task in runqueue

          cpuhog-1800  [001] dn..1..  1103.216862: tick_nohz_irq_exit <-irq_exit
          cpuhog-1800  [001] dn..1..  1103.216863: tick_stop:
success=no msg=more than 1 task in runqueue

          cpuhog-1800  [001] dn..3..  1103.216866: sched_stat_runtime:
comm=cpuhog pid=1800 runtime=12209 [ns] vruntime=90045111565 [ns]
          cpuhog-1800  [001] d...3..  1103.216868: sched_switch:
prev_comm=cpuhog prev_pid=1800 prev_prio=120 prev_state=R ==>
next_comm=ksoftirqd/1 next_pid=18 next_prio=98
     ksoftirqd/1-18    [001] ....111  1103.216876: softirq_entry:
vec=1 [action=TIMER]
     ksoftirqd/1-18    [001] ....111  1103.216879: softirq_exit: vec=1
[action=TIMER]
     ksoftirqd/1-18    [001] d...3..  1103.216885: sched_stat_wait:
comm=cpuhog pid=1800 delay=34791 [ns]
     ksoftirqd/1-18    [001] d...3..  1103.216887: sched_switch:
prev_comm=ksoftirqd/1 prev_pid=18 prev_prio=98 prev_state=S ==>
next_comm=cpuhog next_pid=1800 next_prio=120
          cpuhog-1800  [001] d..h1..  1103.221830: irq_handler_entry:
irq=49 name=arch_timer
          cpuhog-1800  [001] d..h2..  1103.221832: hrtimer_cancel:
hrtimer=ee7a5c98
          cpuhog-1800  [001] d..h1..  1103.221834:
hrtimer_expire_entry: hrtimer=ee7a5c98 function=tick_sched_timer
now=1103200005650
          cpuhog-1800  [001] d..h2..  1103.221836: sched_stat_runtime:
comm=cpuhog pid=1800 runtime=4952959 [ns] vruntime=90050064524 [ns]
          cpuhog-1800  [001] d..h1..  1103.221839: softirq_raise:
vec=1 [action=TIMER]
          cpuhog-1800  [001] d..h1..  1103.221841:
hrtimer_expire_exit: hrtimer=ee7a5c98
          cpuhog-1800  [001] d..h2..  1103.221843: hrtimer_start:
hrtimer=ee7a5c98 function=tick_sched_timer expires=1103205000000
softexpires=1103205000000
          cpuhog-1800  [001] d..h1..  1103.221845: irq_handler_exit:
irq=49 ret=handled
          cpuhog-1800  [001] d...3..  1103.221849:
tick_nohz_full_kick_cpu <-enqueue_top_rt_rq
          cpuhog-1800  [001] dn..3..  1103.221852: sched_wakeup:
comm=ksoftirqd/1 pid=18 prio=98 success=1 target_cpu=001
          cpuhog-1800  [001] dn..1..  1103.221855: tick_nohz_irq_exit <-irq_exit
          cpuhog-1800  [001] dn..1..  1103.221856: tick_stop:
success=no msg=more than 1 task in runqueue

          cpuhog-1800  [001] dn..1..  1103.221862: tick_nohz_irq_exit <-irq_exit
          cpuhog-1800  [001] dn..1..  1103.221863: tick_stop:
success=no msg=more than 1 task in runqueue
