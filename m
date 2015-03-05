From: Brian Silverman <brian@peloton-tech.com>
Subject: CONFIG_PREEMPT_RT local_softirq_pending warning when ISR blocks
Date: Thu, 5 Mar 2015 00:16:20 -0500
Message-ID: <CAGt3f4na1EMtViiLym3JnzGbOGSMXwy9puOccOyrOWKjd4QOnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org,
	Austin Schuh <austin@peloton-tech.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I'm seeing "NOHZ: local_softirq_pending" warnings with 3.14.31-rt28
(3.14.3-rt4 too). They're mostly "NOHZ: local_softirq_pending 08"
(NET_RX) but they happen occasionally for other softirqs too (0c aka
NET_RX and NET_TX is second-most common). CONFIG_PREEMPT_RT_FULL and
CONFIG_NO_HZ_FULL(_ALL) are enabled. Heavy load on a CAN card
(sja1000) consistently triggers the messages, but they also happen
occasionally without explicitly trying to stress the system.

I got a trace showing a threaded ISR handler blocking on an rt_mutex
after raising a softirq, which results in the CPU going idle with the
softirq still pending because irq_exit() hasn't happened yet. I don't
know whether the softirq should somehow be getting run at that point,
the message is spurious in this situation, or maybe there's some other
reason this should never happen.

The task holding the rt_mutex was preempted by another ISR handler at
the same priority as the one which has the problem. I'm not quite
sure, but i think it might have been running a softirq at the time it
got preempted if that makes any difference.

Here's the parts of the trace that look relevant, split up between the
2 interesting CPUs (both hyperthreads of 1 of the 2 cores in the
system). If anybody can think of any other information that would be
useful, please do ask.

Beforehand, 000 is spending most of its time in interrupts, but bash
is doing something related to memory management on it in between.
            bash-14721 [000] ......1  6854.629126: rt_spin_lock
<-free_pcppages_bulk
            bash-14721 [000] ....1.1  6854.629126: mm_page_pcpu_drain:
page=ffffea000fa1aa40 pfn=4097705 order=0 migratetype=1
            bash-14721 [000] ......1  6854.629127:
get_pfnblock_flags_mask <-free_pcppages_bulk
            bash-14721 [000] ......1  6854.629127:
__mod_zone_page_state <-free_pcppages_bulk
            bash-14721 [000] ....1.1  6854.629127: mm_page_pcpu_drain:
page=ffffea000f572ac0 pfn=4021419 order=0 migratetype=0
            bash-14721 [000] ......1  6854.629128:
get_pfnblock_flags_mask <-free_pcppages_bulk
            bash-14721 [000] ......1  6854.629128:
__mod_zone_page_state <-free_pcppages_bulk
... # lots more virtually identical repetitions of those last 3 lines
            bash-14721 [000] ....1.1  6854.629139: mm_page_pcpu_drain:
page=ffffea000f481a80 pfn=4005994 order=0 migratetype=1
            bash-14721 [000] ......1  6854.629139:
get_pfnblock_flags_mask <-free_pcppages_bulk
            bash-14721 [000] d.....1  6854.629139: do_IRQ <-ret_from_intr
            bash-14721 [000] d.....1  6854.629139: irq_enter <-do_IRQ
... # wakes up the can1 ISR thread on 001 and the can0 one on 000
(same physical IRQ line)
            bash-14721 [000] d...3.1  6854.629261: sched_switch:
prev_comm=bash prev_pid=14721 prev_prio=120 prev_state=R+ ==>
next_comm=irq/18-can0 next_pid=2015 next_prio=28
... # runs the can0 ISR
     irq/18-can0-2015  [000] d...3..  6854.629283: sched_switch:
prev_comm=irq/18-can0 prev_pid=2015 prev_prio=28 prev_state=S ==>
next_comm=ksoftirqd/0 next_pid=3 next_prio=98
...
     ksoftirqd/0-3     [000] ....1.1  6854.629291: softirq_entry:
vec=1 [action=TIMER]
...
     ksoftirqd/0-3     [000] ....1.1  6854.629293: softirq_exit: vec=1
[action=TIMER]
...
     ksoftirqd/0-3     [000] .......  6854.629298: schedule <-smpboot_thread_fn
...
     ksoftirqd/0-3     [000] d...3..  6854.629304: sched_switch:
prev_comm=ksoftirqd/0 prev_pid=3 prev_prio=98 prev_state=S ==>
next_comm=bash next_pid=14721 next_prio=28
...
            bash-14721 [000] d...1.1  6854.629308:
smp_trace_reschedule_interrupt <-trace_reschedule_interrupt # Actually
unnecessary schedule IPI from 001?
            bash-14721 [000] d...1.1  6854.629309: irq_enter
<-smp_trace_reschedule_interrupt
...
            bash-14721 [000] ....1.1  6854.629316:
__tick_nohz_task_switch <-__schedule
            bash-14721 [000] ......1  6854.629316:
__mod_zone_page_state <-free_pcppages_bulk
            bash-14721 [000] ....1.1  6854.629317: mm_page_pcpu_drain:
page=ffffea000f57a900 pfn=4021924 order=0 migratetype=0
            bash-14721 [000] ......1  6854.629317:
get_pfnblock_flags_mask <-free_pcppages_bulk
            bash-14721 [000] ......1  6854.629317:
__mod_zone_page_state <-free_pcppages_bulk
... # more of this like it was doing before
I don't see it unlocking the problematic mutex before the trace ends.

The relevant part for 001 starts while it's running the can1 ISR.
     irq/18-can1-7228  [001] ....1.1  6854.629275: netif_rx: dev=can1
skbaddr=ffff880412d8fc00 len=16
     irq/18-can1-7228  [001] ......1  6854.629275: migrate_disable
<-netif_rx_internal
     irq/18-can1-7228  [001] ......2  6854.629275: enqueue_to_backlog
<-netif_rx_internal
     irq/18-can1-7228  [001] d.....2  6854.629276: _raw_spin_lock
<-enqueue_to_backlog
     irq/18-can1-7228  [001] d...1.2  6854.629276:
__raise_softirq_irqoff <-enqueue_to_backlog
     irq/18-can1-7228  [001] d...1.2  6854.629276:
do_raise_softirq_irqoff <-__raise_softirq_irqoff
     irq/18-can1-7228  [001] d...2.2  6854.629276: softirq_raise:
vec=3 [action=NET_RX]
... # continues handling the can1 interrupt
     irq/18-can1-7228  [001] ......6  6854.629286: rt_spin_lock
<-get_page_from_freelist
     irq/18-can1-7228  [001] ......6  6854.629287:
rt_spin_lock_slowlock <-get_page_from_freelist
     irq/18-can1-7228  [001] ......6  6854.629287: _raw_spin_lock
<-rt_spin_lock_slowlock
     irq/18-can1-7228  [001] ....1.6  6854.629287:
__try_to_take_rt_mutex <-rt_spin_lock_slowlock
     irq/18-can1-7228  [001] ....1.6  6854.629287: _raw_spin_lock_irq
<-rt_spin_lock_slowlock
     irq/18-can1-7228  [001] d...2.6  6854.629288:
_raw_spin_unlock_irq <-rt_spin_lock_slowlock
     irq/18-can1-7228  [001] ....1.6  6854.629288:
task_blocks_on_rt_mutex <-rt_spin_lock_slowlock
... # rt_mutex/scheduling stuff
     irq/18-can1-7228  [001] d...4.6  6854.629291: sched_pi_setprio:
comm=bash pid=14721 oldprio=120 newprio=28
... # more scheduler stuff
     irq/18-can1-7228  [001] d...3.6  6854.629299:
native_smp_send_reschedule <-rt_mutex_setprio
... # more scheduler stuff
     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_fair
<-__schedule
     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_stop
<-__schedule
     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_dl
<-__schedule
     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_rt
<-__schedule
     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_fair
<-__schedule
     irq/18-can1-7228  [001] d...2.6  6854.629308: pick_next_task_idle
<-__schedule
     irq/18-can1-7228  [001] d...3.6  6854.629308: sched_switch:
prev_comm=irq/18-can1 prev_pid=7228 prev_prio=28 prev_state=D ==>
next_comm=swapper/1 next_pid=0 next_prio=120
...
          <idle>-0     [001] d...1..  6854.629319:
softirq_check_pending_idle <-tick_nohz_idle_enter
My tracing_off() call is in softirq_check_pending_idle, so that's it.

Thanks,
Brian Silverman
