From: Jonathan David <jonathan.david@ni.com>
Subject: Re: [RFC] e1000e: Add delays after writing to registers
Date: Fri, 6 Nov 2015 12:38:41 -0600
Message-ID: <563CF3B1.2040904@ni.com>
References: <1445465268-10347-1-git-send-email-jonathan.david@ni.com>
 <20151022055909.GA7263@icarus.home.austad.us> <5638F239.1030804@ni.com>
 <20151103194246.GA19824@sisyphus.home.austad.us> <563930CF.9090800@ni.com>
 <20151106055349.GA10665@icarus.home.austad.us>
 <alpine.DEB.2.11.1511060929430.4032@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <josh.cartwright@ni.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Henrik Austad <henrik@austad.us>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-by2on0108.outbound.protection.outlook.com ([207.46.100.108]:11422
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750985AbbKFSyz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Nov 2015 13:54:55 -0500
In-Reply-To: <alpine.DEB.2.11.1511060929430.4032@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/06/2015 05:08 AM, Thomas Gleixner wrote:
[..]
>
> Now my question is how big is the induced latency.
>

Here is one such trace we've captured.

---
cyclictest-2345  [002]    73.674891: hrtimer_init:         hrtimer=0xffff8800b5b1feb8 clockid=CLOCK_MONOTONIC mode=HRTIMER_MODE_ABS
cyclictest-2345  [002]    73.674891: function:                   do_nanosleep
cyclictest-2345  [002]    73.674891: function:                      __hrtimer_start_range_ns
cyclictest-2345  [002]    73.674891: function:                         lock_hrtimer_base.isra.24
cyclictest-2345  [002]    73.674891: function:                            _raw_spin_lock_irqsave
cyclictest-2345  [002]    73.674891: function:                         enqueue_hrtimer
cyclictest-2345  [002]    73.674891: hrtimer_start:        hrtimer=0xffff8800b5b1feb8 function=hrtimer_wakeup expires=73712055622 softexpires=73712055622
...

...
avahi-daemon-1385  [002]    73.675075: function:                               e1000e_set_rx_mode
avahi-daemon-1385  [002]    73.675078: function:                                  __kmalloc
avahi-daemon-1385  [002]    73.675079: function:                                     kmalloc_slab
avahi-daemon-1385  [002]    73.675079: function:                                  e1000e_update_mc_addr_list_generic
avahi-daemon-1385  [002]    73.675080: bputs:                e1000e_update_mc_addr_list_generic: replace MTA table
avahi-daemon-1385  [002]    73.675159: function:             smp_apic_timer_interrupt
avahi-daemon-1385  [002]    73.675159: function:                irq_enter
avahi-daemon-1385  [002]    73.675159: function:                   rcu_irq_enter
avahi-daemon-1385  [002]    73.675159: function:                exit_idle
avahi-daemon-1385  [002]    73.675159: function:                local_apic_timer_interrupt
avahi-daemon-1385  [002]    73.675159: function:                hrtimer_interrupt
avahi-daemon-1385  [002]    73.675159: function:                   _raw_spin_lock
avahi-daemon-1385  [002]    73.675159: function:                   ktime_get_update_offsets
avahi-daemon-1385  [002]    73.675159: function:                   __run_hrtimer
avahi-daemon-1385  [002]    73.675160: hrtimer_cancel:       hrtimer=0xffff8800b5b1feb8
avahi-daemon-1385  [002]    73.675160: function:                      __remove_hrtimer
avahi-daemon-1385  [002]    73.675160: hrtimer_expire_entry: hrtimer=0xffff8800b5b1feb8 now=73712084997 function=hrtimer_wakeup/0x0
---

After the wake-up timer is armed, the e1000e driver handles the network
link configuration after the NIC was reset. When the function
"e1000e_update_mc_addr_list_generic" is called, the MTA table is
rewritten (the writing of this table consists of >70 MMIO writes
followed by a read).

We see the hrtimer entry expire at the value 73712084997 near the bottom of the
trace.

73712084997ns - 73712055622ns = 29375ns

So, we see a ~29us latency, in comparison to a good case where we see about 1us.
Consistently, when we've seen large cyclictest latencies, we see that the e1000e
driver calls a function which uses e1e_flush after a large series of writes.

- JD
