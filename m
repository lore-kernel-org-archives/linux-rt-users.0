From: Julia Cartwright <julia.cartwright@ni.com>
Subject: Re: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge
 latencies in cyclictest
Date: Wed, 28 Sep 2016 14:45:19 -0500
Message-ID: <20160928194519.GA32423@jcartwri.amer.corp.natinst.com>
References: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
 <20160922151205.m3cch6re77tox3aw@linutronix.de>
 <c91ce66d47ff470a94e10e2347eafe4a@FE-MBX1012.de.bosch.com>
 <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
 <20160923123224.odybv2uos6tot6it@linutronix.de>
 <ae35c863cdf246ac8da94277418921ef@FE-MBX1012.de.bosch.com>
 <20160923144140.5tkzeymamrb5qnsv@linutronix.de>
 <a5ea146cf078457ab001131ca0886b0b@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:52323 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753619AbcI1UWu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Sep 2016 16:22:50 -0400
In-Reply-To: <a5ea146cf078457ab001131ca0886b0b@FE-MBX1012.de.bosch.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Sep 26, 2016 at 11:12:19AM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
[..]
> > Nope. There is nothing that might prevents preemption (unless I missed something).
> > However if you there are a lot of posted writes writes to the HW, the read might
> > force them to occur *now* which will stall the CPU until it happens.
> > Try to comment the function(s) out to see if that spikes vanishes.
> > That igb_read_phy_reg_82580() function also invokes another one for the acquire
> > callback. 
> 
> I tried hard to identify a single function that is causing the spikes. 
> However I had no success. I could not identify a single function.
> What I did now instead was to use the kernel tracer to identify the issue.
> I run now cyclictest with only one thread by using the following command:
> 
> # cyclictest -a -i 100 -m -n -p 80 -t 1  -b 25 -f -O latency-format
> 
> Please see the attached fragment of the trace output.
> It contains the last couple of cycles from the cyclictest before it stopped because
> of the latency being larger than 25us.
> 
> I repeated that test a multiple times.
> And I noticed always igb relevant functions just before the final cycle in the cycletest.
> And for me it looks as if the calls that are in the trace from line 3621 to 3641 occur
> always before the latency exceeds the threshold.
> 
> Can you please have a look inside the attached trace file.
> Do you have any idea what might cause the issue here?

The trace data _seems_ to show that CPU0 is stuck with interrupts
disabled/handling hardirqs from 3702725us (presumably the hrtimer wakeup
for the cyclictest thread), to 3702765us when cyclictest actually gets
scheduled in, which is about 40us.

Right after the initial hrtimer wakeup event, there appears to be a
eight or so of these similar looking traces:

  kworker/-6071    0dN..1.. 3702729us : do_IRQ <-ret_from_intr
  kworker/-6071    0dN..1.. 3702729us : irq_enter <-do_IRQ
  kworker/-6071    0dN..1.. 3702729us : rcu_irq_enter <-irq_enter
  kworker/-6071    0dN..1.. 3702729us : preempt_count_add <-irq_enter
  kworker/-6071    0dN.h1.. 3702729us : exit_idle <-do_IRQ
  kworker/-6071    0dN.h1.. 3702729us : handle_irq <-do_IRQ
  kworker/-6071    0dN.h1.. 3702729us : handle_edge_irq <-handle_irq
  kworker/-6071    0dN.h1.. 3702729us : _raw_spin_lock <-handle_edge_irq
  kworker/-6071    0dN.h1.. 3702729us : preempt_count_add <-_raw_spin_lock
  kworker/-6071    0dN.h2.. 3702730us : irq_may_run <-handle_edge_irq
  kworker/-6071    0dN.h2.. 3702730us : irq_chip_ack_parent <-handle_edge_irq
  kworker/-6071    0dN.h2.. 3702730us : apic_ack_edge <-irq_chip_ack_parent
  kworker/-6071    0dN.h2.. 3702730us : __irq_complete_move <-apic_ack_edge
  kworker/-6071    0dN.h2.. 3702730us : irq_move_irq <-apic_ack_edge
  kworker/-6071    0dN.h2.. 3702730us : handle_irq_event <-handle_edge_irq
  kworker/-6071    0dN.h2.. 3702730us : preempt_count_sub <-handle_irq_event
  kworker/-6071    0dN.h1.. 3702730us : handle_irq_event_percpu <-handle_irq_event
  kworker/-6071    0dN.h1.. 3702731us : irq_default_primary_handler <-handle_irq_event_percpu
  kworker/-6071    0dN.h1.. 3702731us : __irq_wake_thread <-handle_irq_event_percpu
  kworker/-6071    0dN.h1.. 3702731us : wake_up_process <-__irq_wake_thread
  kworker/-6071    0dN.h1.. 3702731us : try_to_wake_up <-wake_up_process
  kworker/-6071    0dN.h1.. 3702731us : _raw_spin_lock_irqsave <-try_to_wake_up
  kworker/-6071    0dN.h1.. 3702731us : preempt_count_add <-_raw_spin_lock_irqsave
  kworker/-6071    0dN.h2.. 3702731us : _raw_spin_lock <-try_to_wake_up
  kworker/-6071    0dN.h2.. 3702731us : preempt_count_add <-_raw_spin_lock
  kworker/-6071    0dN.h3.. 3702731us : ttwu_do_activate.constprop.104 <-try_to_wake_up
  kworker/-6071    0dN.h3.. 3702731us : activate_task <-ttwu_do_activate.constprop.104
  kworker/-6071    0dN.h3.. 3702731us : update_rq_clock.part.91 <-activate_task
  kworker/-6071    0dN.h3.. 3702732us : enqueue_task_rt <-activate_task
  kworker/-6071    0dN.h3.. 3702732us : dequeue_rt_stack <-enqueue_task_rt
  kworker/-6071    0dN.h3.. 3702732us : dequeue_top_rt_rq <-dequeue_rt_stack
  kworker/-6071    0dN.h3.. 3702732us : update_rt_migration <-enqueue_task_rt
  kworker/-6071    0dN.h3.. 3702732us : _raw_spin_lock <-enqueue_task_rt
  kworker/-6071    0dN.h3.. 3702732us : preempt_count_add <-_raw_spin_lock
  kworker/-6071    0dN.h4.. 3702732us : preempt_count_sub <-enqueue_task_rt
  kworker/-6071    0dN.h3.. 3702732us : enqueue_top_rt_rq <-enqueue_task_rt
  kworker/-6071    0dN.h3.. 3702732us : ttwu_do_wakeup <-ttwu_do_activate.constprop.104
  kworker/-6071    0dN.h3.. 3702732us : check_preempt_curr <-ttwu_do_wakeup
  kworker/-6071    0dN.h3.. 3702732us : resched_curr <-check_preempt_curr
  kworker/-6071    0dN.h3.. 3702732us : task_woken_rt <-ttwu_do_wakeup
  kworker/-6071    0dN.h3.. 3702733us : preempt_count_sub <-try_to_wake_up
  kworker/-6071    0dN.h2.. 3702733us : _raw_spin_unlock_irqrestore <-try_to_wake_up
  kworker/-6071    0dN.h2.. 3702733us : preempt_count_sub <-_raw_spin_unlock_irqrestore
  kworker/-6071    0dN.h1.. 3702733us : note_interrupt <-handle_irq_event_percpu
  kworker/-6071    0dN.h1.. 3702733us : _raw_spin_lock <-handle_irq_event
  kworker/-6071    0dN.h1.. 3702733us : preempt_count_add <-_raw_spin_lock
  kworker/-6071    0dN.h2.. 3702733us : preempt_count_sub <-handle_edge_irq
  kworker/-6071    0dN.h1.. 3702733us : irq_exit <-do_IRQ
  kworker/-6071    0dN.h1.. 3702733us : preempt_count_sub <-irq_exit
  kworker/-6071    0dN..1.. 3702733us : rcu_irq_exit <-irq_exit

Which, looks to me to be the normal "forced primary" interrupt handling
path, which simply wakes the created irqthread.

However, what isn't clear from the data is _which_ irqthread(s) is being
woken up.  Presumably, due to the prior igb traces, it's one of the igb
interrupts, but that would be nice to confirm using the sched_wakeup
event or other means.

Similar to the PCI write-buffering cases, we've also observed that when
the PCI interconnect is bogged down with traffic from other masters,
it's possible that a read from the CPU can be stalled (in some cases,
for quite awhile, but it depends on the PCI topology, switches used,
their configurations, etc).

So, one plausible narrative here: it's conceivable that the
rd32(E1000_RXSTMPH) in igb_ptp_rx_hang() is "stuck" in the bus somewhere
presumably due to load from other masters (the trace seems to indicate
it might be as much as 20us), with CPU execution stalled awaiting it's
completion.  Meanwhile, the CPU is encountering interrupts from other
sources (local APIC, etc).  Once the read "completes", the CPU is
finally able to service all of the interrupts that have piled up, which
is why we see in the traces these 9 wakeups happening in a row.

The question is: how can we confirm/refute this, or are there other,
more plausible scenarios it's possible to run into?

   Julia
