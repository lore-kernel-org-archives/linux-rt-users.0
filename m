From: Mike Galbraith <bitbucket@online.de>
Subject: Re: 3.8.10-rt6: suspend/resume irqs enabled splat
Date: Fri, 21 Jun 2013 19:04:24 +0200
Message-ID: <1371834264.5953.39.camel@marge.simpson.net>
References: <1367473433.5808.8.camel@marge.simpson.net>
	 <20130621104940.GB21228@linutronix.de>
	 <1371819580.5992.2.camel@marge.simpson.net>
	 <51C460A8.4010800@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50695 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423203Ab3FUREa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 13:04:30 -0400
In-Reply-To: <51C460A8.4010800@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-06-21 at 16:18 +0200, Sebastian Andrzej Siewior wrote: 
> On 06/21/2013 02:59 PM, Mike Galbraith wrote:
> > On Fri, 2013-06-21 at 12:49 +0200, Sebastian Andrzej Siewior wrote: 
> >> * Mike Galbraith | 2013-05-02 07:43:53 [+0200]:
> >>
> >>> Suspend/resume works fine on laptop, but, suspend, let it sit there a
> >>> bit, then resume produces the gripe below.  Seems to be -rt specific,
> >>> 3.8.10 with only voluntary preempt/autogroup config delta doesn't gripe.
> >>
> >> Could you please check if you see those on latest RT?
> > 
> > Yup, during boot.
> 
> Argh. So I tried a few things and I still don't see it.

As I was examining the trace, your -rt12 announcement landed..

- added the missing "acpi/rt: Convert acpi_gbl_hardware lock back to a
  raw_spinlock_t", reported by Steven.

Adding only that to -rt11 seems to have cured it.

trace fwiw.

          <idle>-0     [000] d...2..   298.268799: put_prev_task_idle+0x0/0x10 <ffffffff8107d250> <-__schedule+0x133/0x770 <ffffffff81442e83>
          <idle>-0     [000] d...2..   298.268800: pick_next_task_fair+0x0/0xb0 <ffffffff8107edb0> <-__schedule+0x14b/0x770 <ffffffff81442e9b>
          <idle>-0     [000] d...2..   298.268800: pick_next_task_stop+0x0/0x40 <ffffffff81084090> <-__schedule+0x655/0x770 <ffffffff814433a5>
          <idle>-0     [000] d...2..   298.268800: pick_next_task_rt+0x0/0xc0 <ffffffff810823e0> <-__schedule+0x655/0x770 <ffffffff814433a5>
          <idle>-0     [000] d...2..   298.268801: pick_next_task_fair+0x0/0xb0 <ffffffff8107edb0> <-__schedule+0x655/0x770 <ffffffff814433a5>
          <idle>-0     [000] d...2..   298.268801: pick_next_task_idle+0x0/0x20 <ffffffff8107d230> <-__schedule+0x655/0x770 <ffffffff814433a5>
          <idle>-0     [000] d...2..   298.268802: _raw_spin_unlock_irq+0x0/0x50 <ffffffff81444d90> <-__schedule+0x66b/0x770 <ffffffff814433bb>
          <idle>-0     [000] ....2..   298.268802: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-_raw_spin_unlock_irq+0x1c/0x50 <ffffffff81444dac>
          <idle>-0     [000] ....1..   298.268802: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-__schedule+0x3f2/0x770 <ffffffff81443142>
          <idle>-0     [000] .......   298.268803: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-cpu_idle+0x6d/0x130 <ffffffff8100bf6d>
          <idle>-0     [000] ....1..   298.268803: tick_nohz_idle_enter+0x0/0x70 <ffffffff8109a070> <-cpu_idle+0x72/0x130 <ffffffff8100bf72>
          <idle>-0     [000] ....1..   298.268804: set_cpu_sd_state_idle+0x0/0x80 <ffffffff81081650> <-tick_nohz_idle_enter+0x15/0x70 <ffffffff8109a085>
          <idle>-0     [000] d...1..   298.268804: __tick_nohz_idle_enter+0x0/0xc0 <ffffffff81099df0> <-tick_nohz_idle_enter+0x3a/0x70 <ffffffff8109a0aa>
          <idle>-0     [000] d...1..   298.268804: ktime_get+0x0/0xe0 <ffffffff810915c0> <-__tick_nohz_idle_enter+0x2e/0xc0 <ffffffff81099e1e>
          <idle>-0     [000] d...1..   298.268805: read_hpet+0x0/0x20 <ffffffff8102cb40> <-ktime_get+0x54/0xe0 <ffffffff81091614>
          <idle>-0     [000] d...1..   298.268806: can_stop_idle_tick.isra.13+0x0/0x90 <ffffffff810996b0> <-__tick_nohz_idle_enter+0x53/0xc0 <ffffffff81099e43>
          <idle>-0     [000] d...1..   298.268807: tick_nohz_stop_sched_tick+0x0/0x300 <ffffffff81099af0> <-__tick_nohz_idle_enter+0x8d/0xc0 <ffffffff81099e7d>
          <idle>-0     [000] d...1..   298.268807: timekeeping_max_deferment+0x0/0x50 <ffffffff810927b0> <-tick_nohz_stop_sched_tick+0x62/0x300 <ffffffff81099b52>
          <idle>-0     [000] d...1..   298.268807: rcu_needs_cpu+0x0/0x90 <ffffffff810d0b10> <-tick_nohz_stop_sched_tick+0x7d/0x300 <ffffffff81099b6d>
          <idle>-0     [000] d...1..   298.268808: printk_needs_cpu+0x0/0x40 <ffffffff81040e20> <-tick_nohz_stop_sched_tick+0x1e8/0x300 <ffffffff81099cd8>
          <idle>-0     [000] d...1..   298.268808: get_next_timer_interrupt+0x0/0x150 <ffffffff810505b0> <-tick_nohz_stop_sched_tick+0x200/0x300 <ffffffff81099cf0>
          <idle>-0     [000] d...1..   298.268809: rt_spin_trylock+0x0/0x10 <ffffffff814448c0> <-get_next_timer_interrupt+0x58/0x150 <ffffffff81050608>
          <idle>-0     [000] d...1..   298.268809: rt_mutex_trylock+0x0/0xa0 <ffffffff81443e80> <-rt_spin_trylock+0xe/0x10 <ffffffff814448ce>
          <idle>-0     [000] d...1..   298.268809: __next_timer_interrupt+0x0/0x170 <ffffffff8104d310> <-get_next_timer_interrupt+0xb8/0x150 <ffffffff81050668>
          <idle>-0     [000] d...1..   298.268810: rt_spin_unlock+0x0/0x40 <ffffffff81444880> <-get_next_timer_interrupt+0xcd/0x150 <ffffffff8105067d>
          <idle>-0     [000] d...1..   298.268810: hrtimer_get_next_event+0x0/0xe0 <ffffffff8106d1d0> <-get_next_timer_interrupt+0xd7/0x150 <ffffffff81050687>
          <idle>-0     [000] d...1..   298.268811: _raw_spin_lock_irqsave+0x0/0x50 <ffffffff81444c20> <-hrtimer_get_next_event+0x39/0xe0 <ffffffff8106d209>
          <idle>-0     [000] d...1..   298.268811: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-_raw_spin_lock_irqsave+0x22/0x50 <ffffffff81444c42>
          <idle>-0     [000] d...2..   298.268811: _raw_spin_unlock_irqrestore+0x0/0x70 <ffffffff81444de0> <-hrtimer_get_next_event+0xd5/0xe0 <ffffffff8106d2a5>
          <idle>-0     [000] d...2..   298.268812: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-_raw_spin_unlock_irqrestore+0x2a/0x70 <ffffffff81444e0a>
          <idle>-0     [000] ....1..   298.268812: local_touch_nmi+0x0/0x20 <ffffffff81005f60> <-cpu_idle+0xaa/0x130 <ffffffff8100bfaa>
          <idle>-0     [000] d...1..   298.268813: enter_idle+0x0/0x30 <ffffffff8100be80> <-cpu_idle+0xba/0x130 <ffffffff8100bfba>
          <idle>-0     [000] d...1..   298.268813: atomic_notifier_call_chain+0x0/0x20 <ffffffff81448970> <-enter_idle+0x25/0x30 <ffffffff8100bea5>
          <idle>-0     [000] d...1..   298.268813: __atomic_notifier_call_chain+0x0/0x70 <ffffffff81448900> <-atomic_notifier_call_chain+0x16/0x20 <ffffffff81448986>
          <idle>-0     [000] d...1..   298.268814: __rcu_read_lock+0x0/0x20 <ffffffff810605d0> <-__atomic_notifier_call_chain+0x32/0x70 <ffffffff81448932>
          <idle>-0     [000] d...1..   298.268814: notifier_call_chain+0x0/0x70 <ffffffff81448890> <-__atomic_notifier_call_chain+0x48/0x70 <ffffffff81448948>
          <idle>-0     [000] d...1..   298.268815: __rcu_read_unlock+0x0/0x70 <ffffffff810623e0> <-__atomic_notifier_call_chain+0x4f/0x70 <ffffffff8144894f>
          <idle>-0     [000] d...1..   298.268816: rcu_idle_enter+0x0/0xf0 <ffffffff810cd550> <-cpu_idle+0xc5/0x130 <ffffffff8100bfc5>
          <idle>-0     [000] d...1..   298.268816: rcu_eqs_enter_common+0x0/0x240 <ffffffff810cd310> <-rcu_idle_enter+0x73/0xf0 <ffffffff810cd5c3>
          <idle>-0     [000] d...1..   298.268817: cpuidle_idle_call+0x0/0x410 <ffffffff81352070> <-cpu_idle+0xca/0x130 <ffffffff8100bfca>
          <idle>-0     [000] d...1..   298.268817: cpuidle_get_cpu_driver+0x0/0x30 <ffffffff813526d0> <-cpuidle_idle_call+0x54/0x410 <ffffffff813520c4>
          <idle>-0     [000] d...1..   298.268817: menu_select+0x0/0x3b0 <ffffffff81353a60> <-cpuidle_idle_call+0x67/0x410 <ffffffff813520d7>
          <idle>-0     [000] d...1..   298.268818: pm_qos_request+0x0/0x20 <ffffffff810876b0> <-menu_select+0x3d/0x3b0 <ffffffff81353a9d>
          <idle>-0     [000] d...1..   298.268818: menu_update+0x0/0xd0 <ffffffff81353890> <-menu_select+0x2eb/0x3b0 <ffffffff81353d4b>
          <idle>-0     [000] d...1..   298.268819: tick_nohz_get_sleep_length+0x0/0x30 <ffffffff8109a170> <-menu_select+0x86/0x3b0 <ffffffff81353ae6>
          <idle>-0     [000] d...1..   298.268819: ns_to_timespec+0x0/0x80 <ffffffff81045120> <-menu_select+0x8e/0x3b0 <ffffffff81353aee>
          <idle>-0     [000] d...1..   298.268819: nr_iowait_cpu+0x0/0x30 <ffffffff81077a80> <-menu_select+0xdc/0x3b0 <ffffffff81353b3c>
          <idle>-0     [000] d...1..   298.268820: this_cpu_load+0x0/0x20 <ffffffff81077ab0> <-menu_select+0x105/0x3b0 <ffffffff81353b65>
          <idle>-0     [000] d...1..   298.268820: nr_iowait_cpu+0x0/0x30 <ffffffff81077a80> <-menu_select+0x116/0x3b0 <ffffffff81353b76>
          <idle>-0     [000] d...1..   298.268821: get_typical_interval+0x0/0x100 <ffffffff81353960> <-menu_select+0x196/0x3b0 <ffffffff81353bf6>
          <idle>-0     [000] d...1..   298.268822: cpuidle_wrap_enter+0x0/0xa0 <ffffffff81352610> <-cpuidle_enter_tk+0x10/0x20 <ffffffff813526c0>
          <idle>-0     [000] d...1..   298.268823: ktime_get+0x0/0xe0 <ffffffff810915c0> <-cpuidle_wrap_enter+0x32/0xa0 <ffffffff81352642>
          <idle>-0     [000] d...1..   298.268823: read_hpet+0x0/0x20 <ffffffff8102cb40> <-ktime_get+0x54/0xe0 <ffffffff81091614>
          <idle>-0     [000] d...1..   298.268825: acpi_idle_enter_bm+0x0/0x21c [processor] <ffffffffa000d228> <-cpuidle_enter+0x19/0x20 <ffffffff81351a69>
          <idle>-0     [000] d...1..   298.268825: acpi_read_bit_register+0x0/0x51 <ffffffff812a8ca0> <-acpi_idle_enter_bm+0x6a/0x21c [processor] <ffffffffa000d292>
          <idle>-0     [000] d...1..   298.268825: acpi_hw_get_bit_register_info+0x0/0x38 <ffffffff812a851a> <-acpi_read_bit_register+0x18/0x51 <ffffffff812a8cb8>
          <idle>-0     [000] d...1..   298.268826: acpi_hw_register_read+0x0/0xd8 <ffffffff812a858b> <-acpi_read_bit_register+0x33/0x51 <ffffffff812a8cd3>
          <idle>-0     [000] d...1..   298.268826: acpi_hw_read_multiple+0x0/0x68 <ffffffff812a842e> <-acpi_hw_register_read+0x54/0xd8 <ffffffff812a85df>
          <idle>-0     [000] d...1..   298.268826: acpi_hw_read+0x0/0x62 <ffffffff812a83cc> <-acpi_hw_read_multiple+0x2f/0x68 <ffffffff812a845d>
          <idle>-0     [000] d...1..   298.268827: acpi_hw_validate_register+0x0/0xbc <ffffffff812a8310> <-acpi_hw_read+0x27/0x62 <ffffffff812a83f3>
          <idle>-0     [000] d...1..   298.268827: acpi_hw_read_port+0x0/0xa8 <ffffffff812a8b5d> <-acpi_hw_read+0x5b/0x62 <ffffffff812a8427>
          <idle>-0     [000] d...1..   298.268828: acpi_hw_validate_io_request+0x0/0xd1 <ffffffff812a8a8c> <-acpi_hw_read_port+0x35/0xa8 <ffffffff812a8b92>
          <idle>-0     [000] d...1..   298.268828: acpi_os_read_port+0x0/0x4a <ffffffff8128dce3> <-acpi_hw_read_port+0x47/0xa8 <ffffffff812a8ba4>
          <idle>-0     [000] d...1..   298.268831: acpi_write_bit_register+0x0/0xb0 <ffffffff812a8cf1> <-acpi_idle_enter_bm+0x7f/0x21c [processor] <ffffffffa000d2a7>
          <idle>-0     [000] d...1..   298.268831: acpi_hw_get_bit_register_info+0x0/0x38 <ffffffff812a851a> <-acpi_write_bit_register+0x1a/0xb0 <ffffffff812a8d0b>
          <idle>-0     [000] d...1..   298.268831: acpi_os_acquire_lock+0x0/0x23 <ffffffff8128e5ab> <-acpi_write_bit_register+0x33/0xb0 <ffffffff812a8d24>
          <idle>-0     [000] d...1..   298.268832: migrate_disable+0x0/0x130 <ffffffff810794c0> <-acpi_os_acquire_lock+0x16/0x23 <ffffffff8128e5c1>
          <idle>-0     [000] d...1..   298.268832: rt_spin_lock+0x0/0x30 <ffffffff81444990> <-acpi_os_acquire_lock+0x1f/0x23 <ffffffff8128e5ca>
          <idle>-0     [000] d...1..   298.268833: rt_spin_lock_slowlock+0x0/0x1ef <ffffffff814442d1> <-rt_spin_lock+0x26/0x30 <ffffffff814449b6>
          <idle>-0     [000] d...1..   298.268833: _raw_spin_lock+0x0/0x40 <ffffffff81444c70> <-rt_spin_lock_slowlock+0x36/0x1ef <ffffffff81444307>
          <idle>-0     [000] d...1..   298.268833: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-_raw_spin_lock+0x1b/0x40 <ffffffff81444c8b>
          <idle>-0     [000] d...2..   298.268834: __try_to_take_rt_mutex+0x0/0x50 <ffffffff8109e940> <-rt_spin_lock_slowlock+0x5b/0x1ef <ffffffff8144432c>
          <idle>-0     [000] d...2..   298.268834: _raw_spin_lock_irq+0x0/0x50 <ffffffff81444f50> <-rt_spin_lock_slowlock+0x88/0x1ef <ffffffff81444359>
          <idle>-0     [000] d...2..   298.268835: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-_raw_spin_lock_irq+0x21/0x50 <ffffffff81444f71>
          <idle>-0     [000] d...3..   298.268835: _raw_spin_unlock_irq+0x0/0x50 <ffffffff81444d90> <-rt_spin_lock_slowlock+0xa7/0x1ef <ffffffff81444378>
          <idle>-0     [000] ....3..   298.268836: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-_raw_spin_unlock_irq+0x1c/0x50 <ffffffff81444dac>
          <idle>-0     [000] ....2..   298.268836: task_blocks_on_rt_mutex+0x0/0x270 <ffffffff8109ee50> <-rt_spin_lock_slowlock+0xb7/0x1ef <ffffffff81444388>
          <idle>-0     [000] ....2..   298.268837: _raw_spin_lock_irqsave+0x0/0x50 <ffffffff81444c20> <-task_blocks_on_rt_mutex+0x44/0x270 <ffffffff8109ee94>
          <idle>-0     [000] d...2..   298.268837: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-_raw_spin_lock_irqsave+0x22/0x50 <ffffffff81444c42>
          <idle>-0     [000] d...3..   298.268837: __rt_mutex_adjust_prio+0x0/0x40 <ffffffff8109e710> <-task_blocks_on_rt_mutex+0x79/0x270 <ffffffff8109eec9>
          <idle>-0     [000] d...3..   298.268838: _raw_spin_unlock_irqrestore+0x0/0x70 <ffffffff81444de0> <-task_blocks_on_rt_mutex+0x103/0x270 <ffffffff8109ef53>
          <idle>-0     [000] ....3..   298.268838: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-_raw_spin_unlock_irqrestore+0x2a/0x70 <ffffffff81444e0a>
          <idle>-0     [000] ....2..   298.268839: _raw_spin_lock_irqsave+0x0/0x50 <ffffffff81444c20> <-task_blocks_on_rt_mutex+0x1cf/0x270 <ffffffff8109f01f>
          <idle>-0     [000] d...2..   298.268839: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-_raw_spin_lock_irqsave+0x22/0x50 <ffffffff81444c42>
          <idle>-0     [000] d...3..   298.268840: __rt_mutex_adjust_prio+0x0/0x40 <ffffffff8109e710> <-task_blocks_on_rt_mutex+0x20a/0x270 <ffffffff8109f05a>
          <idle>-0     [000] d...3..   298.268840: _raw_spin_unlock_irqrestore+0x0/0x70 <ffffffff81444de0> <-task_blocks_on_rt_mutex+0x228/0x270 <ffffffff8109f078>
          <idle>-0     [000] ....3..   298.268841: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-_raw_spin_unlock_irqrestore+0x2a/0x70 <ffffffff81444e0a>
          <idle>-0     [000] ....2..   298.268841: __try_to_take_rt_mutex+0x0/0x50 <ffffffff8109e940> <-rt_spin_lock_slowlock+0xd0/0x1ef <ffffffff814443a1>
          <idle>-0     [000] ....2..   298.268842: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-__raw_spin_unlock+0x11/0x50 <ffffffff8109e761>
          <idle>-0     [000] ....1..   298.268842: __rcu_read_lock+0x0/0x20 <ffffffff810605d0> <-rt_spin_lock_slowlock+0x10f/0x1ef <ffffffff814443e0>
          <idle>-0     [000] ....1..   298.268843: __rcu_read_unlock+0x0/0x70 <ffffffff810623e0> <-rt_spin_lock_slowlock+0x141/0x1ef <ffffffff81444412>
          <idle>-0     [000] ....1..   298.268844: _raw_spin_lock+0x0/0x40 <ffffffff81444c70> <-rt_spin_lock_slowlock+0x158/0x1ef <ffffffff81444429>
          <idle>-0     [000] ....1..   298.268844: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-_raw_spin_lock+0x1b/0x40 <ffffffff81444c8b>
          <idle>-0     [000] .N..2..   298.268851: _raw_spin_lock_irq+0x0/0x50 <ffffffff81444f50> <-rt_spin_lock_slowlock+0x160/0x1ef <ffffffff81444431>
          <idle>-0     [000] dN..2..   298.268851: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-_raw_spin_lock_irq+0x21/0x50 <ffffffff81444f71>
          <idle>-0     [000] dN..3..   298.268852: _raw_spin_unlock_irq+0x0/0x50 <ffffffff81444d90> <-rt_spin_lock_slowlock+0x16f/0x1ef <ffffffff81444440>
          <idle>-0     [000] .N..3..   298.268852: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-_raw_spin_unlock_irq+0x1c/0x50 <ffffffff81444dac>
          <idle>-0     [000] .N..2..   298.268853: __try_to_take_rt_mutex+0x0/0x50 <ffffffff8109e940> <-rt_spin_lock_slowlock+0xd0/0x1ef <ffffffff814443a1>
          <idle>-0     [000] .N..2..   298.268853: __try_to_take_rt_mutex.part.10+0x0/0x150 <ffffffff8109e7f0> <-__try_to_take_rt_mutex+0x45/0x50 <ffffffff8109e985>
          <idle>-0     [000] .N..2..   298.268854: _raw_spin_lock_irqsave+0x0/0x50 <ffffffff81444c20> <-__try_to_take_rt_mutex.part.10+0x89/0x150 <ffffffff8109e879>
          <idle>-0     [000] dN..2..   298.268854: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-_raw_spin_lock_irqsave+0x22/0x50 <ffffffff81444c42>
          <idle>-0     [000] dN..3..   298.268854: _raw_spin_unlock_irqrestore+0x0/0x70 <ffffffff81444de0> <-__try_to_take_rt_mutex.part.10+0xda/0x150 <ffffffff8109e8ca>
          <idle>-0     [000] .N..3..   298.268855: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-_raw_spin_unlock_irqrestore+0x2a/0x70 <ffffffff81444e0a>
          <idle>-0     [000] .N..2..   298.268855: _raw_spin_lock_irq+0x0/0x50 <ffffffff81444f50> <-rt_spin_lock_slowlock+0x17c/0x1ef <ffffffff8144444d>
          <idle>-0     [000] dN..2..   298.268856: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-_raw_spin_lock_irq+0x21/0x50 <ffffffff81444f71>
          <idle>-0     [000] dN..3..   298.268856: _raw_spin_unlock_irq+0x0/0x50 <ffffffff81444d90> <-rt_spin_lock_slowlock+0x19c/0x1ef <ffffffff8144446d>
          <idle>-0     [000] .N..3..   298.268857: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-_raw_spin_unlock_irq+0x1c/0x50 <ffffffff81444dac>
          <idle>-0     [000] .N..2..   298.268857: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-__raw_spin_unlock+0x11/0x50 <ffffffff8109e761>
          <idle>-0     [000] .N..1..   298.268858: acpi_hw_register_write+0x0/0x10a <ffffffff812a8663> <-acpi_write_bit_register+0x90/0xb0 <ffffffff812a8d81>
          <idle>-0     [000] .N..1..   298.268858: acpi_hw_write_multiple+0x0/0x31 <ffffffff812a84e9> <-acpi_hw_register_write+0x52/0x10a <ffffffff812a86b5>
          <idle>-0     [000] .N..1..   298.268858: acpi_hw_write+0x0/0x53 <ffffffff812a8496> <-acpi_hw_write_multiple+0x16/0x31 <ffffffff812a84ff>
          <idle>-0     [000] .N..1..   298.268859: acpi_hw_validate_register+0x0/0xbc <ffffffff812a8310> <-acpi_hw_write+0x27/0x53 <ffffffff812a84bd>
          <idle>-0     [000] .N..1..   298.268859: acpi_hw_write_port+0x0/0x9b <ffffffff812a8c05> <-acpi_hw_write+0x4a/0x53 <ffffffff812a84e0>
          <idle>-0     [000] .N..1..   298.268860: acpi_hw_validate_io_request+0x0/0xd1 <ffffffff812a8a8c> <-acpi_hw_write_port+0x31/0x9b <ffffffff812a8c36>
          <idle>-0     [000] .N..1..   298.268860: acpi_os_write_port+0x0/0x30 <ffffffff8128dcb3> <-acpi_hw_write_port+0x43/0x9b <ffffffff812a8c48>
          <idle>-0     [000] .N..1..   298.268862: acpi_os_release_lock+0x0/0x15 <ffffffff8128e5ce> <-acpi_write_bit_register+0xa2/0xb0 <ffffffff812a8d93>
          <idle>-0     [000] .N..1..   298.268863: rt_spin_unlock+0x0/0x40 <ffffffff81444880> <-acpi_os_release_lock+0xe/0x15 <ffffffff8128e5dc>
          <idle>-0     [000] .N..1..   298.268863: migrate_enable+0x0/0x210 <ffffffff810792b0> <-acpi_os_release_lock+0x13/0x15 <ffffffff8128e5e1>
          <idle>-0     [000] .N..1..   298.268864: acpi_idle_enter_simple+0x0/0xbe [processor] <ffffffffa000d118> <-acpi_idle_enter_bm+0xdf/0x21c [processor] <ffffffffa000d307>
          <idle>-0     [000] .N..1..   298.268864: lapic_timer_state_broadcast+0x0/0x45 [processor] <ffffffffa000cf9c> <-acpi_idle_enter_simple+0x6b/0xbe [processor] <ffffffffa000d183>
          <idle>-0     [000] .N..1..   298.268865: clockevents_notify+0x0/0x1a0 <ffffffff81097940> <-lapic_timer_state_broadcast+0x43/0x45 [processor] <ffffffffa000cfdf>
          <idle>-0     [000] .N..1..   298.268865: _raw_spin_lock_irqsave+0x0/0x50 <ffffffff81444c20> <-clockevents_notify+0x22/0x1a0 <ffffffff81097962>
          <idle>-0     [000] dN..1..   298.268865: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-_raw_spin_lock_irqsave+0x22/0x50 <ffffffff81444c42>
          <idle>-0     [000] dN..2..   298.268867: raw_notifier_call_chain+0x0/0x20 <ffffffff8106ec60> <-clockevents_notify+0x37/0x1a0 <ffffffff81097977>
          <idle>-0     [000] dN..2..   298.268867: notifier_call_chain+0x0/0x70 <ffffffff81448890> <-raw_notifier_call_chain+0x16/0x20 <ffffffff8106ec76>
          <idle>-0     [000] dN..2..   298.268868: tick_notify+0x0/0x230 <ffffffff810984a0> <-notifier_call_chain+0x4d/0x70 <ffffffff814488dd>
          <idle>-0     [000] dN..2..   298.268868: tick_broadcast_oneshot_control+0x0/0x120 <ffffffff81098dc0> <-tick_notify+0x15d/0x230 <ffffffff810985fd>
          <idle>-0     [000] dN..2..   298.268869: _raw_spin_lock_irqsave+0x0/0x50 <ffffffff81444c20> <-tick_broadcast_oneshot_control+0x83/0x120 <ffffffff81098e43>
          <idle>-0     [000] dN..2..   298.268869: add_preempt_count+0x0/0x50 <ffffffff81448a20> <-_raw_spin_lock_irqsave+0x22/0x50 <ffffffff81444c42>
          <idle>-0     [000] dN..3..   298.268870: clockevents_set_mode+0x0/0x70 <ffffffff81097ae0> <-tick_broadcast_oneshot_control+0xca/0x120 <ffffffff81098e8a>
          <idle>-0     [000] dN..3..   298.268870: lapic_timer_setup+0x0/0x30 <ffffffff81025260> <-clockevents_set_mode+0x29/0x70 <ffffffff81097b09>
          <idle>-0     [000] dN..3..   298.268870: lapic_timer_setup.part.4+0x0/0xc0 <ffffffff810251a0> <-lapic_timer_setup+0x1d/0x30 <ffffffff8102527d>
          <idle>-0     [000] dN..3..   298.268871: tick_broadcast_set_event+0x0/0x60 <ffffffff810986d0> <-tick_broadcast_oneshot_control+0xde/0x120 <ffffffff81098e9e>
          <idle>-0     [000] dN..3..   298.268872: clockevents_program_event+0x0/0x100 <ffffffff81097b80> <-tick_broadcast_set_event+0x4c/0x60 <ffffffff8109871c>
          <idle>-0     [000] dN..3..   298.268872: ktime_get+0x0/0xe0 <ffffffff810915c0> <-clockevents_program_event+0x42/0x100 <ffffffff81097bc2>
          <idle>-0     [000] dN..3..   298.268872: read_hpet+0x0/0x20 <ffffffff8102cb40> <-ktime_get+0x54/0xe0 <ffffffff81091614>
          <idle>-0     [000] dN..3..   298.268874: hpet_legacy_next_event+0x0/0x50 <ffffffff8102caa0> <-clockevents_program_event+0x74/0x100 <ffffffff81097bf4>
          <idle>-0     [000] dN..3..   298.268876: _raw_spin_unlock_irqrestore+0x0/0x70 <ffffffff81444de0> <-tick_broadcast_oneshot_control+0xa9/0x120 <ffffffff81098e69>
          <idle>-0     [000] dN..3..   298.268876: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-_raw_spin_unlock_irqrestore+0x2a/0x70 <ffffffff81444e0a>
          <idle>-0     [000] dN..2..   298.268877: _raw_spin_unlock_irqrestore+0x0/0x70 <ffffffff81444de0> <-clockevents_notify+0x4c/0x1a0 <ffffffff8109798c>
          <idle>-0     [000] .N..2..   298.268877: sub_preempt_count+0x0/0x60 <ffffffff814489c0> <-_raw_spin_unlock_irqrestore+0x2a/0x70 <ffffffff81444e0a>
          <idle>-0     [000] .N..1..   298.268880: sched_clock_cpu+0x10/0x100 <ffffffff8107c930>: POW cpu:0 !irqs_disabled()


