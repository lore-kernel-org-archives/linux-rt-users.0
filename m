From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: tick_sched_timer taking much time on arm9/3.10-rt?
Date: Wed, 29 Jan 2014 16:49:39 +0100
Message-ID: <20140129154939.GQ26766@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38132 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbaA2Ptl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Jan 2014 10:49:41 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1W8XOV-000398-Oa
	for linux-rt-users@vger.kernel.org; Wed, 29 Jan 2014 16:49:39 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.82)
	(envelope-from <ukl@pengutronix.de>)
	id 1W8XOV-0000Vm-Nw
	for linux-rt-users@vger.kernel.org; Wed, 29 Jan 2014 16:49:39 +0100
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

the tests were done on a 450 MHz ARM9 (Freescale i.MX28) with
        while :; do hackbench; done
        for i in $(seq -w 1 20); do cyclictest -m -n -p99 -l100000 -h800 -q > /tmp/bench_$i.hist; done
on 3.10.27-rt25.

The first diagram is what I got with NO_HZ + NO_HZ_IDLE, the second and third
is HZ_PERIODIC + !NO_HZ. On the first diagram you can clearly see two
mountains, with the smaller one being more or less a small copy of the
bigger. On the second diagram this effect isn't that clear, but still it's
there; the third shows it again more clearly. (The first was taken on an
earlier kernel version, but I saw the same effect on 3.10.27-rt25, just
didn't keep the histograms.)

I used the default interval for cyclictest, i.e. 1000 us. So with
HZ=100 there expire 10 timers in cyclictest per jiffie update. In 3 of
20 histograms I see this effect with the two mountains. One of them
is the 2nd diagram in the attachment, the others are similar. The two
peeks are at:

        22161 samples @ [131, 135] us
         1963 samples @ [220, 224] us

This corresponds approximately to the 1:10 ratio between cyclictest
timers and jiffie updates.

Increasing HZ to 500 (and so 1:2 ratio between jiffie updates and timer
expiries) the two mountains are approximately of equal height, peeks at:

        13025 samples @ [132, 136] us
        15007 samples @ [230, 234] us

see third diagram. The time between the peeks seems to be more or less
identical, so that it doesn't scale with HZ. But the height of the
mountains (i.e. the count) roughly matches the 1:2 ratio.

The explanation I have that not all histograms show this effect---they
show just one such mountain with at most very few cycles with bigger
times---is that it only happens when the jiffies update and the
cyclictest timer expiry happen concurrently enough. The phase
shift between jiffie update and cyclictest timer keeps stable over a
long time because HZ is a divider of the cyclictest frequency. So it
seems reasonable that you either get a smaller mountain with a size
corresponding to HZ or no 2nd mountain at all.

I created a trace with cyclictest -b (and a kernel built with ftrace on,
so the numbers are bigger) and the relevant section is available below,
(tell me if you want to see more context). What you can see is that
after the irq corresponding to cyclictest's timer expiry the following
things happen apart from the normal schedule stuff:

  tick_sched_timer taking 604 us
  another irq triggers taking 261 us

I was surprised to see tick_sched_timer taking so much time, but I fail
to see something pathological in the trace (apart from the long time of
course). Also I expected an ARM9 with 450 MHz to show better latencies.

Comparing with today's measurement on the i.MX27 (ARM9, 400 MHz) in the
OSADL lab
(https://www.osadl.org/Latency-plot-of-system-in-rack-2-slot.qa-latencyplot-r2s1.0.html,
01/29/14 13:23:12) the first two peeks have approximately the same
distance as on my i.MX28. Then the difference is I don't have latencies
that low, it starts at ~80 us for me, but at ~50 on the system in the
test lab. But maybe this is not a valid comparison as the i.MX27 runs
2.6.33-rt which is very different from 3.10-rt.

Did someone else see similar results? As I don't see the effect on all
histograms, maybe you just tested once for a long time and were lucky
not to hit this case? Are you less surprised or do you see the culprit
somewhere else? Do you have further debugging ideas?

Thanks for your time
Uwe
	
cyclicte-623     0....1.. 19616215us+: SyS_clock_nanosleep <-ret_fast_syscall
cyclicte-623     0....1.. 19616223us+: clockid_to_kclock <-SyS_clock_nanosleep
cyclicte-623     0....1.. 19616230us+: common_nsleep <-SyS_clock_nanosleep
cyclicte-623     0....1.. 19616236us+: hrtimer_nanosleep <-common_nsleep
cyclicte-623     0....1.. 19616242us+: hrtimer_init <-hrtimer_nanosleep
cyclicte-623     0....1.. 19616250us+: ktime_add_safe <-hrtimer_nanosleep
cyclicte-623     0....1.. 19616256us+: do_nanosleep <-hrtimer_nanosleep
cyclicte-623     0....1.. 19616263us+: hrtimer_start_range_ns <-do_nanosleep
cyclicte-623     0....1.. 19616268us+: __hrtimer_start_range_ns <-hrtimer_start_range_ns
cyclicte-623     0d...1.. 19616274us+: add_preempt_count <-__hrtimer_start_range_ns
cyclicte-623     0d...2.. 19616280us+: ktime_get <-__hrtimer_start_range_ns
cyclicte-623     0d...2.. 19616287us+: clocksource_mmio_readl_down <-ktime_get
cyclicte-623     0d...2.. 19616295us+: enqueue_hrtimer <-__hrtimer_start_range_ns
cyclicte-623     0d...2.. 19616302us+: hrtimer_reprogram <-__hrtimer_start_range_ns
cyclicte-623     0d...2.. 19616309us+: tick_program_event <-hrtimer_reprogram
cyclicte-623     0d...2.. 19616314us+: clockevents_program_event <-tick_program_event
cyclicte-623     0d...2.. 19616321us+: ktime_get <-clockevents_program_event
cyclicte-623     0d...2.. 19616327us+: clocksource_mmio_readl_down <-ktime_get
cyclicte-623     0d...4.. 19616340us+: add_preempt_count <-ring_buffer_lock_reserve
cyclicte-623     0d...5.. 19616346us+: sub_preempt_count <-ring_buffer_lock_reserve

---------------------- cyclictest sets up the next wakeup and schedules
cyclicte-623     0d...1.. 19616351us+: clockevents_program_event: delta = 487041, force = 0
cyclicte-623     0d...4.. 19616366us+: add_preempt_count <-ring_buffer_lock_reserve
cyclicte-623     0d...5.. 19616372us+: sub_preempt_count <-ring_buffer_lock_reserve
cyclicte-623     0d...1.. 19616376us+: clockevents_program_event: delta = 487041, clc = 11688
cyclicte-623     0d...2.. 19616387us+: timrotv2_set_next_event <-clockevents_program_event
cyclicte-623     0....2.. 19616394us+: sub_preempt_count <-__hrtimer_start_range_ns
cyclicte-623     0....1.. 19616400us+: schedule <-do_nanosleep
cyclicte-623     0....1.. 19616407us+: __schedule <-schedule
cyclicte-623     0....1.. 19616413us+: add_preempt_count <-__schedule
cyclicte-623     0....2.. 19616419us+: rcu_note_context_switch <-__schedule
cyclicte-623     0d...2.. 19616426us+: add_preempt_count <-__schedule
cyclicte-623     0d...3.. 19616432us+: deactivate_task <-__schedule
cyclicte-623     0d...3.. 19616438us+: dequeue_task <-deactivate_task
cyclicte-623     0d...3.. 19616443us+: update_rq_clock <-dequeue_task
cyclicte-623     0d...3.. 19616451us+: dequeue_task_rt <-dequeue_task
cyclicte-623     0d...3.. 19616457us+: update_curr_rt <-dequeue_task_rt
cyclicte-623     0d...3.. 19616463us+: cpuacct_charge <-update_curr_rt
cyclicte-623     0d...3.. 19616469us+: __rcu_read_lock <-cpuacct_charge
cyclicte-623     0d...3.. 19616476us+: __rcu_read_unlock <-cpuacct_charge
cyclicte-623     0d...3.. 19616483us+: add_preempt_count <-update_curr_rt
cyclicte-623     0d...4.. 19616489us+: sub_preempt_count <-update_curr_rt
cyclicte-623     0d...3.. 19616495us+: dequeue_rt_stack <-dequeue_task_rt
cyclicte-623     0d...3.. 19616502us+: put_prev_task_rt <-__schedule
cyclicte-623     0d...3.. 19616508us+: update_curr_rt <-put_prev_task_rt
cyclicte-623     0d...3.. 19616515us+: pick_next_task_stop <-__schedule
cyclicte-623     0d...3.. 19616520us+: pick_next_task_rt <-__schedule
cyclicte-623     0d...3.. 19616537us+: atomic_notifier_call_chain <-__switch_to
cyclicte-623     0d...3.. 19616551us+: __atomic_notifier_call_chain <-atomic_notifier_call_chain
cyclicte-623     0d...3.. 19616558us+: __rcu_read_lock <-__atomic_notifier_call_chain
cyclicte-623     0d...3.. 19616565us+: notifier_call_chain <-__atomic_notifier_call_chain
cyclicte-623     0d...3.. 19616571us+: __rcu_read_unlock <-__atomic_notifier_call_chain
---------------------- 

irq/215--41      0d...3.. 19616578us+: finish_task_switch.constprop.87 <-__schedule
irq/215--41      0....3.. 19616585us+: sub_preempt_count <-finish_task_switch.constprop.87
irq/215--41      0....2.. 19616591us+: sub_preempt_count <-__schedule
irq/215--41      0....1.. 19616598us+: kthread_should_stop <-irq_thread
irq/215--41      0....1.. 19616605us+: irq_forced_thread_fn <-irq_thread
irq/215--41      0....1.. 19616611us+: local_bh_disable <-irq_forced_thread_fn
irq/215--41      0....1.. 19616616us+: mxs_auart_irq_handle <-irq_forced_thread_fn
irq/215--41      0....1.. 19616624us+: mxs_auart_tx_chars <-mxs_auart_irq_handle
irq/215--41      0....1.. 19616644us+: uart_write_wakeup <-mxs_auart_tx_chars
irq/215--41      0....1.. 19616651us+: tty_wakeup <-uart_write_wakeup
irq/215--41      0....1.. 19616657us+: __wake_up <-tty_wakeup
irq/215--41      0....1.. 19616663us+: rt_spin_lock <-__wake_up
irq/215--41      0....1.. 19616669us+: rt_spin_lock_slowlock <-rt_spin_lock
irq/215--41      0....1.. 19616675us+: add_preempt_count <-rt_spin_lock_slowlock
irq/215--41      0....2.. 19616682us+: __try_to_take_rt_mutex <-rt_spin_lock_slowlock
irq/215--41      0....2.. 19616689us+: sub_preempt_count <-rt_spin_lock_slowlock
irq/215--41      0....1.. 19616696us+: __wake_up_common <-__wake_up
irq/215--41      0....1.. 19616702us+: default_wake_function <-__wake_up_common
irq/215--41      0....1.. 19616707us+: try_to_wake_up <-default_wake_function
irq/215--41      0d...1.. 19616713us+: add_preempt_count <-try_to_wake_up
irq/215--41      0....2.. 19616720us+: sub_preempt_count <-try_to_wake_up
irq/215--41      0....1.. 19616727us+: rt_spin_unlock <-__wake_up
irq/215--41      0....1.. 19616733us+: rt_spin_lock_slowunlock <-rt_spin_unlock
irq/215--41      0....1.. 19616738us+: add_preempt_count <-rt_spin_lock_slowunlock
irq/215--41      0....2.. 19616744us+: __rt_spin_lock_slowunlock <-rt_spin_lock_slowunlock
irq/215--41      0....2.. 19616750us+: sub_preempt_count <-__rt_spin_lock_slowunlock
irq/215--41      0....1.. 19616758us+: irq_finalize_oneshot <-irq_forced_thread_fn
irq/215--41      0d...1.. 19616764us+: add_preempt_count <-irq_finalize_oneshot
irq/215--41      0d...2.. 19616771us+: unmask_irq <-irq_finalize_oneshot
irq/215--41      0d...2.. 19616778us+: icoll_unmask_irq <-unmask_irq
irq/215--41      0....2.. 19616785us+: sub_preempt_count <-irq_finalize_oneshot
irq/215--41      0....1.. 19616792us+: local_bh_enable <-irq_forced_thread_fn
irq/215--41      0....1.. 19616799us+: note_interrupt <-irq_thread
irq/215--41      0....1.. 19616807us+: add_interrupt_randomness <-irq_thread
irq/215--41      0....1.. 19616813us+: read_current_timer <-add_interrupt_randomness
irq/215--41      0....1.. 19616822us+: wake_threads_waitq <-irq_thread
irq/215--41      0....1.. 19616828us+: kthread_should_stop <-irq_thread
irq/215--41      0....1.. 19616833us+: schedule <-irq_thread
irq/215--41      0....1.. 19616840us+: __schedule <-schedule
irq/215--41      0....1.. 19616846us+: add_preempt_count <-__schedule
irq/215--41      0....2.. 19616853us+: rcu_note_context_switch <-__schedule
irq/215--41      0d...2.. 19616859us+: add_preempt_count <-__schedule
irq/215--41      0d...3.. 19616864us+: deactivate_task <-__schedule
irq/215--41      0d...3.. 19616870us+: dequeue_task <-deactivate_task
irq/215--41      0d...3.. 19616876us+: update_rq_clock <-dequeue_task
irq/215--41      0d...3.. 19616883us+: dequeue_task_rt <-dequeue_task
irq/215--41      0d...3.. 19616889us+: update_curr_rt <-dequeue_task_rt
irq/215--41      0d...3.. 19616895us+: cpuacct_charge <-update_curr_rt
irq/215--41      0d...3.. 19616900us+: __rcu_read_lock <-cpuacct_charge
irq/215--41      0d...3.. 19616906us+: __rcu_read_unlock <-cpuacct_charge
irq/215--41      0d...3.. 19616912us+: add_preempt_count <-update_curr_rt
irq/215--41      0d...4.. 19616918us+: sub_preempt_count <-update_curr_rt
irq/215--41      0d...3.. 19616924us+: dequeue_rt_stack <-dequeue_task_rt
irq/215--41      0d...3.. 19616931us+: put_prev_task_rt <-__schedule
irq/215--41      0d...3.. 19616937us+: update_curr_rt <-put_prev_task_rt
irq/215--41      0d...3.. 19616942us+: pick_next_task_fair <-__schedule
irq/215--41      0d...3.. 19616949us+: clear_buddies <-pick_next_task_fair
irq/215--41      0d...3.. 19616956us+: __dequeue_entity <-pick_next_task_fair
irq/215--41      0d...3.. 19616963us+: clear_buddies <-pick_next_task_fair
irq/215--41      0d...3.. 19616969us+: __dequeue_entity <-pick_next_task_fair
irq/215--41      0d...3.. 19616976us+: clear_buddies <-pick_next_task_fair
irq/215--41      0d...3.. 19616981us+: __dequeue_entity <-pick_next_task_fair
irq/215--41      0d...3.. 19616988us+: clear_buddies <-pick_next_task_fair
irq/215--41      0d...3.. 19616993us+: __dequeue_entity <-pick_next_task_fair
irq/215--41      0d...3.. 19617011us+: atomic_notifier_call_chain <-__switch_to
irq/215--41      0d...3.. 19617018us+: __atomic_notifier_call_chain <-atomic_notifier_call_chain
irq/215--41      0d...3.. 19617023us+: __rcu_read_lock <-__atomic_notifier_call_chain
irq/215--41      0d...3.. 19617029us+: notifier_call_chain <-__atomic_notifier_call_chain
irq/215--41      0d...3.. 19617035us+: __rcu_read_unlock <-__atomic_notifier_call_chain
hackbenc-536     0d...3.. 19617043us+: finish_task_switch.constprop.87 <-__schedule

----------------------- timer irq triggers
hackbenc-536     0d...3.. 19617052us+: icoll_handle_irq <-__irq_svc
hackbenc-536     0d...3.. 19617059us+: irq_find_mapping <-icoll_handle_irq
hackbenc-536     0d...3.. 19617067us+: irq_linear_revmap <-irq_find_mapping
hackbenc-536     0d...3.. 19617073us+: handle_IRQ <-icoll_handle_irq
hackbenc-536     0d...3.. 19617079us+: irq_enter <-handle_IRQ
hackbenc-536     0d...3.. 19617084us+: rcu_irq_enter <-irq_enter
hackbenc-536     0d...3.. 19617092us+: add_preempt_count <-irq_enter
hackbenc-536     0d..h3.. 19617099us+: generic_handle_irq <-handle_IRQ
hackbenc-536     0d..h3.. 19617105us+: irq_to_desc <-generic_handle_irq
hackbenc-536     0d..h3.. 19617113us+: handle_level_irq <-generic_handle_irq
hackbenc-536     0d..h3.. 19617119us+: add_preempt_count <-handle_level_irq
hackbenc-536     0d..h4.. 19617126us+: icoll_mask_irq <-handle_level_irq
hackbenc-536     0d..h4.. 19617133us+: icoll_ack_irq <-handle_level_irq
hackbenc-536     0d..h4.. 19617140us+: handle_irq_event <-handle_level_irq
hackbenc-536     0d..h4.. 19617146us+: sub_preempt_count <-handle_irq_event
hackbenc-536     0d..h3.. 19617152us+: handle_irq_event_percpu <-handle_irq_event
hackbenc-536     0d..h3.. 19617159us+: mxs_timer_interrupt <-handle_irq_event_percpu
hackbenc-536     0d..h3.. 19617166us+: hrtimer_interrupt <-mxs_timer_interrupt
hackbenc-536     0d..h3.. 19617173us+: add_preempt_count <-hrtimer_interrupt
hackbenc-536     0d..h4.. 19617179us+: ktime_get_update_offsets <-hrtimer_interrupt
hackbenc-536     0d..h4.. 19617186us+: clocksource_mmio_readl_down <-ktime_get_update_offsets

----------------------- normal wakeup
hackbenc-536     0d..h4.. 19617197us+: __run_hrtimer <-hrtimer_interrupt
hackbenc-536     0d..h4.. 19617203us+: __remove_hrtimer <-__run_hrtimer
hackbenc-536     0d..h4.. 19617211us+: sub_preempt_count <-__run_hrtimer
hackbenc-536     0d..h3.. 19617217us+: hrtimer_wakeup <-__run_hrtimer
hackbenc-536     0d..h3.. 19617223us+: wake_up_process <-hrtimer_wakeup
hackbenc-536     0d..h3.. 19617230us+: try_to_wake_up <-wake_up_process
hackbenc-536     0d..h3.. 19617236us+: add_preempt_count <-try_to_wake_up
hackbenc-536     0d..h4.. 19617242us+: add_preempt_count <-try_to_wake_up
hackbenc-536     0d..h5.. 19617248us+: activate_task <-try_to_wake_up
hackbenc-536     0d..h5.. 19617254us+: enqueue_task <-activate_task
hackbenc-536     0d..h5.. 19617260us+: update_rq_clock <-enqueue_task
hackbenc-536     0d..h5.. 19617268us+: enqueue_task_rt <-enqueue_task
hackbenc-536     0d..h5.. 19617274us+: dequeue_rt_stack <-enqueue_task_rt
hackbenc-536     0d..h5.. 19617282us+: ttwu_do_wakeup.constprop.86 <-try_to_wake_up
hackbenc-536     0d..h5.. 19617287us+: check_preempt_curr <-ttwu_do_wakeup.constprop.86
hackbenc-536     0dN.h5.. 19617299us+: sub_preempt_count <-try_to_wake_up
hackbenc-536     0dN.h4.. 19617307us+: sub_preempt_count <-try_to_wake_up
hackbenc-536     0dN.h3.. 19617314us+: add_preempt_count <-__run_hrtimer

----------------------- tick_sched_timer (update jiffies) -> 604 us
hackbenc-536     0dN.h4.. 19617321us+: __run_hrtimer <-hrtimer_interrupt
hackbenc-536     0dN.h4.. 19617327us+: __remove_hrtimer <-__run_hrtimer
hackbenc-536     0dN.h4.. 19617336us+: sub_preempt_count <-__run_hrtimer
hackbenc-536     0dN.h3.. 19617343us+: tick_sched_timer <-__run_hrtimer
hackbenc-536     0dN.h3.. 19617350us+: ktime_get <-tick_sched_timer
hackbenc-536     0dN.h3.. 19617357us+: clocksource_mmio_readl_down <-ktime_get
hackbenc-536     0dN.h3.. 19617366us+: tick_sched_do_timer <-tick_sched_timer
hackbenc-536     0dN.h3.. 19617373us+: tick_do_update_jiffies64 <-tick_sched_do_timer
hackbenc-536     0dN.h3.. 19617380us+: add_preempt_count <-tick_do_update_jiffies64
hackbenc-536     0dN.h4.. 19617386us+: add_preempt_count <-tick_do_update_jiffies64
hackbenc-536     0dN.h5.. 19617394us+: do_timer <-tick_do_update_jiffies64
hackbenc-536     0dN.h5.. 19617401us+: add_preempt_count <-do_timer
hackbenc-536     0dN.h6.. 19617408us+: clocksource_mmio_readl_down <-do_timer
hackbenc-536     0dN.h6.. 19617416us+: ntp_tick_length <-do_timer
hackbenc-536     0dN.h6.. 19617427us+: ntp_tick_length <-do_timer
hackbenc-536     0dN.h6.. 19617436us+: add_preempt_count <-do_timer
hackbenc-536     0dN.h7.. 19617444us+: update_pvclock_gtod.constprop.11 <-do_timer
hackbenc-536     0dN.h7.. 19617450us+: raw_notifier_call_chain <-update_pvclock_gtod.constprop.11
hackbenc-536     0dN.h7.. 19617457us+: __raw_notifier_call_chain <-raw_notifier_call_chain
hackbenc-536     0dN.h7.. 19617464us+: notifier_call_chain <-__raw_notifier_call_chain
hackbenc-536     0dN.h7.. 19617471us+: sub_preempt_count <-do_timer
hackbenc-536     0dN.h6.. 19617477us+: sub_preempt_count <-do_timer
hackbenc-536     0dN.h5.. 19617485us+: calc_global_load <-do_timer
hackbenc-536     0dN.h5.. 19617492us+: sub_preempt_count <-tick_do_update_jiffies64
hackbenc-536     0dN.h4.. 19617499us+: sub_preempt_count <-tick_do_update_jiffies64
hackbenc-536     0dN.h3.. 19617505us+: tick_sched_handle <-tick_sched_timer
hackbenc-536     0dN.h3.. 19617512us+: update_process_times <-tick_sched_handle
hackbenc-536     0dN.h3.. 19617519us+: account_process_tick <-update_process_times
hackbenc-536     0dN.h3.. 19617525us+: account_system_time <-account_process_tick
hackbenc-536     0dN.h3.. 19617533us+: in_serving_softirq <-account_system_time
hackbenc-536     0dN.h3.. 19617541us+: cpuacct_account_field <-account_system_time
hackbenc-536     0dN.h3.. 19617547us+: __rcu_read_lock <-cpuacct_account_field
hackbenc-536     0dN.h3.. 19617565us+: __rcu_read_unlock <-cpuacct_account_field
hackbenc-536     0dN.h3.. 19617575us+: acct_account_cputime <-account_system_time
hackbenc-536     0dN.h3.. 19617583us+: __acct_update_integrals <-acct_account_cputime
hackbenc-536     0dN.h3.. 19617591us+: jiffies_to_timeval <-__acct_update_integrals
hackbenc-536     0dN.h3.. 19617600us+: scheduler_tick <-update_process_times
hackbenc-536     0dN.h3.. 19617606us+: add_preempt_count <-scheduler_tick
hackbenc-536     0dN.h4.. 19617613us+: update_rq_clock <-scheduler_tick
hackbenc-536     0dN.h4.. 19617619us+: __update_cpu_load <-scheduler_tick
hackbenc-536     0dN.h4.. 19617628us+: task_tick_fair <-scheduler_tick
hackbenc-536     0dN.h4.. 19617635us+: update_curr <-task_tick_fair
hackbenc-536     0dN.h4.. 19617642us+: update_min_vruntime <-update_curr
hackbenc-536     0dN.h4.. 19617652us+: cpuacct_charge <-update_curr
hackbenc-536     0dN.h4.. 19617659us+: __rcu_read_lock <-cpuacct_charge
hackbenc-536     0dN.h4.. 19617666us+: __rcu_read_unlock <-cpuacct_charge
hackbenc-536     0dN.h4.. 19617673us+: update_cfs_shares <-task_tick_fair
hackbenc-536     0dN.h4.. 19617681us+: sched_slice <-task_tick_fair
hackbenc-536     0dN.h4.. 19617688us+: calc_delta_mine <-sched_slice
hackbenc-536     0dN.h4.. 19617695us+: calc_delta_mine <-sched_slice
hackbenc-536     0dN.h4.. 19617702us+: calc_delta_mine <-sched_slice
hackbenc-536     0dN.h4.. 19617709us+: calc_delta_mine <-sched_slice
hackbenc-536     0dN.h4.. 19617716us+: resched_task_lazy <-task_tick_fair
hackbenc-536     0dNLh4.. 19617722us+: clear_buddies <-task_tick_fair
hackbenc-536     0dNLh4.. 19617729us+: update_curr <-task_tick_fair
hackbenc-536     0dNLh4.. 19617735us+: update_min_vruntime <-update_curr
hackbenc-536     0dNLh4.. 19617742us+: update_cfs_shares <-task_tick_fair
hackbenc-536     0dNLh4.. 19617749us+: update_curr <-task_tick_fair
hackbenc-536     0dNLh4.. 19617756us+: update_min_vruntime <-update_curr
hackbenc-536     0dNLh4.. 19617762us+: update_cfs_shares <-task_tick_fair
hackbenc-536     0dNLh4.. 19617769us+: sched_slice <-task_tick_fair
hackbenc-536     0dNLh4.. 19617775us+: calc_delta_mine <-sched_slice
hackbenc-536     0dNLh4.. 19617781us+: calc_delta_mine <-sched_slice
hackbenc-536     0dNLh4.. 19617788us+: update_curr <-task_tick_fair
hackbenc-536     0dNLh4.. 19617794us+: update_min_vruntime <-update_curr
hackbenc-536     0dNLh4.. 19617800us+: update_cfs_shares <-task_tick_fair
hackbenc-536     0dNLh4.. 19617807us+: sub_preempt_count <-scheduler_tick
hackbenc-536     0dNLh3.. 19617815us+: run_local_timers <-update_process_times
hackbenc-536     0dNLh3.. 19617821us+: hrtimer_run_queues <-run_local_timers
hackbenc-536     0dNLh3.. 19617829us+: raise_softirq <-run_local_timers
hackbenc-536     0dNLh3.. 19617836us+: raise_softirq_irqoff <-raise_softirq
hackbenc-536     0dNLh3.. 19617842us+: do_raise_softirq_irqoff <-raise_softirq_irqoff
hackbenc-536     0dNLh3.. 19617851us+: rcu_check_callbacks <-update_process_times
hackbenc-536     0dNLh3.. 19617862us+: cpu_needs_another_gp <-rcu_check_callbacks
hackbenc-536     0dNLh3.. 19617871us+: cpu_needs_another_gp <-rcu_check_callbacks
hackbenc-536     0dNLh3.. 19617879us+: cpu_needs_another_gp <-rcu_check_callbacks
hackbenc-536     0dNLh3.. 19617887us+: run_posix_cpu_timers <-update_process_times
hackbenc-536     0dNLh3.. 19617895us+: hrtimer_forward <-tick_sched_timer
hackbenc-536     0dNLh3.. 19617903us+: ktime_add_safe <-hrtimer_forward
hackbenc-536     0dNLh3.. 19617911us+: ktime_add_safe <-hrtimer_forward
hackbenc-536     0dNLh3.. 19617919us+: add_preempt_count <-__run_hrtimer
hackbenc-536     0dNLh4.. 19617925us+: enqueue_hrtimer <-__run_hrtimer

-------------------------------------- back to normal scheduling
hackbenc-536     0dNLh4.. 19617937us+: sub_preempt_count <-hrtimer_interrupt
hackbenc-536     0dNLh3.. 19617944us+: tick_program_event <-hrtimer_interrupt
hackbenc-536     0dNLh3.. 19617950us+: clockevents_program_event <-tick_program_event
hackbenc-536     0dNLh3.. 19617957us+: ktime_get <-clockevents_program_event
hackbenc-536     0dNLh3.. 19617964us+: clocksource_mmio_readl_down <-ktime_get
hackbenc-536     0dNLh5.. 19617984us+: add_preempt_count <-ring_buffer_lock_reserve
hackbenc-536     0dNLh6.. 19617992us+: sub_preempt_count <-ring_buffer_lock_reserve
hackbenc-536     0dNLh2.. 19617996us+: clockevents_program_event: delta = 8986933, force = 0
hackbenc-536     0dNLh5.. 19618018us+: add_preempt_count <-ring_buffer_lock_reserve
hackbenc-536     0dNLh6.. 19618025us+: sub_preempt_count <-ring_buffer_lock_reserve
hackbenc-536     0dNLh2.. 19618029us+: clockevents_program_event: delta = 8986933, clc = 215686
hackbenc-536     0dNLh3.. 19618043us+: timrotv2_set_next_event <-clockevents_program_event
hackbenc-536     0dNLh3.. 19618052us+: note_interrupt <-handle_irq_event_percpu
hackbenc-536     0dNLh3.. 19618061us+: add_preempt_count <-handle_irq_event
hackbenc-536     0dNLh4.. 19618070us+: cond_unmask_irq <-handle_level_irq
hackbenc-536     0dNLh4.. 19618077us+: icoll_unmask_irq <-cond_unmask_irq
hackbenc-536     0dNLh4.. 19618084us+: sub_preempt_count <-handle_level_irq
hackbenc-536     0dNLh3.. 19618091us+: irq_exit <-handle_IRQ
hackbenc-536     0dNLh3.. 19618097us+: sub_preempt_count <-irq_exit
hackbenc-536     0dNL.3.. 19618105us+: wakeup_softirqd <-irq_exit
hackbenc-536     0dNL.3.. 19618111us+: wake_up_process <-wakeup_softirqd
hackbenc-536     0dNL.3.. 19618117us+: try_to_wake_up <-wake_up_process
hackbenc-536     0dNL.3.. 19618123us+: add_preempt_count <-try_to_wake_up
hackbenc-536     0dNL.4.. 19618129us+: add_preempt_count <-try_to_wake_up
hackbenc-536     0dNL.5.. 19618136us+: activate_task <-try_to_wake_up
hackbenc-536     0dNL.5.. 19618142us+: enqueue_task <-activate_task
hackbenc-536     0dNL.5.. 19618148us+: update_rq_clock <-enqueue_task
hackbenc-536     0dNL.5.. 19618155us+: enqueue_task_rt <-enqueue_task
hackbenc-536     0dNL.5.. 19618161us+: dequeue_rt_stack <-enqueue_task_rt
hackbenc-536     0dNL.5.. 19618169us+: ttwu_do_wakeup.constprop.86 <-try_to_wake_up
hackbenc-536     0dNL.5.. 19618176us+: check_preempt_curr <-ttwu_do_wakeup.constprop.86
hackbenc-536     0dNL.5.. 19618188us+: sub_preempt_count <-try_to_wake_up
hackbenc-536     0dNL.4.. 19618195us+: sub_preempt_count <-try_to_wake_up
hackbenc-536     0dNL.3.. 19618202us+: idle_cpu <-irq_exit
hackbenc-536     0dNL.3.. 19618209us+: rcu_irq_exit <-irq_exit

----------------------- another irq -> 261us
hackbenc-536     0dNL.3.. 19618219us+: icoll_handle_irq <-__irq_svc
hackbenc-536     0dNL.3.. 19618227us+: irq_find_mapping <-icoll_handle_irq
hackbenc-536     0dNL.3.. 19618233us+: irq_linear_revmap <-irq_find_mapping
hackbenc-536     0dNL.3.. 19618240us+: handle_IRQ <-icoll_handle_irq
hackbenc-536     0dNL.3.. 19618247us+: irq_enter <-handle_IRQ
hackbenc-536     0dNL.3.. 19618253us+: rcu_irq_enter <-irq_enter
hackbenc-536     0dNL.3.. 19618260us+: add_preempt_count <-irq_enter
hackbenc-536     0dNLh3.. 19618267us+: generic_handle_irq <-handle_IRQ
hackbenc-536     0dNLh3.. 19618273us+: irq_to_desc <-generic_handle_irq
hackbenc-536     0dNLh3.. 19618281us+: handle_level_irq <-generic_handle_irq
hackbenc-536     0dNLh3.. 19618288us+: add_preempt_count <-handle_level_irq
hackbenc-536     0dNLh4.. 19618295us+: icoll_mask_irq <-handle_level_irq
hackbenc-536     0dNLh4.. 19618302us+: icoll_ack_irq <-handle_level_irq
hackbenc-536     0dNLh4.. 19618310us+: handle_irq_event <-handle_level_irq
hackbenc-536     0dNLh4.. 19618316us+: sub_preempt_count <-handle_irq_event
hackbenc-536     0dNLh3.. 19618324us+: handle_irq_event_percpu <-handle_irq_event
hackbenc-536     0dNLh3.. 19618331us+: irq_default_primary_handler <-handle_irq_event_percpu
hackbenc-536     0dNLh3.. 19618339us+: wake_up_process <-handle_irq_event_percpu
hackbenc-536     0dNLh3.. 19618347us+: try_to_wake_up <-wake_up_process
hackbenc-536     0dNLh3.. 19618353us+: add_preempt_count <-try_to_wake_up
hackbenc-536     0dNLh4.. 19618360us+: add_preempt_count <-try_to_wake_up
hackbenc-536     0dNLh5.. 19618366us+: activate_task <-try_to_wake_up
hackbenc-536     0dNLh5.. 19618372us+: enqueue_task <-activate_task
hackbenc-536     0dNLh5.. 19618378us+: update_rq_clock <-enqueue_task
hackbenc-536     0dNLh5.. 19618384us+: enqueue_task_rt <-enqueue_task
hackbenc-536     0dNLh5.. 19618391us+: dequeue_rt_stack <-enqueue_task_rt
hackbenc-536     0dNLh5.. 19618398us+: ttwu_do_wakeup.constprop.86 <-try_to_wake_up
hackbenc-536     0dNLh5.. 19618405us+: check_preempt_curr <-ttwu_do_wakeup.constprop.86
hackbenc-536     0dNLh5.. 19618414us+: sub_preempt_count <-try_to_wake_up
hackbenc-536     0dNLh4.. 19618421us+: sub_preempt_count <-try_to_wake_up
hackbenc-536     0dNLh3.. 19618428us+: note_interrupt <-handle_irq_event_percpu
hackbenc-536     0dNLh3.. 19618436us+: add_preempt_count <-handle_irq_event
hackbenc-536     0dNLh4.. 19618442us+: cond_unmask_irq <-handle_level_irq
hackbenc-536     0dNLh4.. 19618448us+: sub_preempt_count <-handle_level_irq
hackbenc-536     0dNLh3.. 19618455us+: irq_exit <-handle_IRQ
hackbenc-536     0dNLh3.. 19618461us+: sub_preempt_count <-irq_exit
hackbenc-536     0dNL.3.. 19618468us+: wakeup_softirqd <-irq_exit
hackbenc-536     0dNL.3.. 19618473us+: idle_cpu <-irq_exit
hackbenc-536     0dNL.3.. 19618480us+: rcu_irq_exit <-irq_exit

----------------------- schedule to cyclictest
hackbenc-536     0.NL.3.. 19618488us+: sub_preempt_count <-finish_task_switch.constprop.87
hackbenc-536     0.NL.2.. 19618496us+: add_preempt_count <-finish_task_switch.constprop.87
hackbenc-536     0.NL.3.. 19618554us+: sub_preempt_count <-finish_task_switch.constprop.87
hackbenc-536     0.NL.2.. 19618579us+: sub_preempt_count <-__schedule
hackbenc-536     0.NL.1.. 19618587us+: add_preempt_count <-__schedule
hackbenc-536     0.NL.2.. 19618593us+: rcu_note_context_switch <-__schedule
hackbenc-536     0dNL.2.. 19618603us+: add_preempt_count <-__schedule
hackbenc-536     0dNL.3.. 19618610us+: update_rq_clock <-__schedule
hackbenc-536     0dNL.3.. 19618617us+: put_prev_task_fair <-__schedule
hackbenc-536     0dNL.3.. 19618623us+: update_curr <-put_prev_task_fair
hackbenc-536     0dNL.3.. 19618631us+: __enqueue_entity <-put_prev_task_fair
hackbenc-536     0dNL.3.. 19618642us+: update_curr <-put_prev_task_fair
hackbenc-536     0dNL.3.. 19618649us+: __enqueue_entity <-put_prev_task_fair
hackbenc-536     0dNL.3.. 19618656us+: update_curr <-put_prev_task_fair
hackbenc-536     0dNL.3.. 19618663us+: __enqueue_entity <-put_prev_task_fair
hackbenc-536     0dNL.3.. 19618670us+: update_curr <-put_prev_task_fair
hackbenc-536     0dNL.3.. 19618676us+: __enqueue_entity <-put_prev_task_fair
hackbenc-536     0dNL.3.. 19618683us+: pick_next_task_stop <-__schedule
hackbenc-536     0dNL.3.. 19618690us+: pick_next_task_rt <-__schedule
hackbenc-536     0d...3.. 19618714us+: atomic_notifier_call_chain <-__switch_to
hackbenc-536     0d...3.. 19618730us+: __atomic_notifier_call_chain <-atomic_notifier_call_chain
hackbenc-536     0d...3.. 19618739us+: __rcu_read_lock <-__atomic_notifier_call_chain
hackbenc-536     0d...3.. 19618746us+: notifier_call_chain <-__atomic_notifier_call_chain
hackbenc-536     0d...3.. 19618752us+: __rcu_read_unlock <-__atomic_notifier_call_chain

cyclicte-623     0d...3.. 19618760us+: finish_task_switch.constprop.87 <-__schedule
cyclicte-623     0....3.. 19618768us+: sub_preempt_count <-finish_task_switch.constprop.87
cyclicte-623     0....2.. 19618774us+: add_preempt_count <-finish_task_switch.constprop.87
cyclicte-623     0....3.. 19618810us+: sub_preempt_count <-finish_task_switch.constprop.87
cyclicte-623     0....2.. 19618833us+: sub_preempt_count <-__schedule
cyclicte-623     0....1.. 19618843us+: hrtimer_cancel <-do_nanosleep
cyclicte-623     0....1.. 19618849us+: hrtimer_try_to_cancel <-hrtimer_cancel
cyclicte-623     0d...1.. 19618855us+: add_preempt_count <-hrtimer_try_to_cancel
cyclicte-623     0....2.. 19618863us+: sub_preempt_count <-hrtimer_try_to_cancel
cyclicte-623     0....1.. 19618884us+: SyS_clock_gettime <-ret_fast_syscall
cyclicte-623     0....1.. 19618891us+: clockid_to_kclock <-SyS_clock_gettime
cyclicte-623     0....1.. 19618898us+: posix_ktime_get_ts <-SyS_clock_gettime
cyclicte-623     0....1.. 19618903us+: ktime_get_ts <-posix_ktime_get_ts
cyclicte-623     0....1.. 19618911us!: clocksource_mmio_readl_down <-ktime_get_ts
cyclicte-623     0....1.. 19619032us+: SyS_write <-ret_fast_syscall
cyclicte-623     0....1.. 19619046us+: fget_light <-SyS_write
cyclicte-623     0....1.. 19619053us+: __rcu_read_lock <-fget_light
cyclicte-623     0....1.. 19619060us+: __rcu_read_unlock <-fget_light
cyclicte-623     0....1.. 19619066us+: vfs_write <-SyS_write
cyclicte-623     0....1.. 19619073us+: rw_verify_area <-vfs_write
cyclicte-623     0....1.. 19619082us+: __sb_start_write <-vfs_write
cyclicte-623     0....1.. 19619088us+: add_preempt_count <-__sb_start_write
cyclicte-623     0....2.. 19619095us+: sub_preempt_count <-__sb_start_write
cyclicte-623     0....1.. 19619104us+: get_user_pages_fast <-tracing_mark_write
cyclicte-623     0....1.. 19619110us+: rt_down_read <-get_user_pages_fast
cyclicte-623     0....1.. 19619117us+: __rt_down_read.isra.0 <-rt_down_read
cyclicte-623     0....1.. 19619124us+: rt_mutex_lock <-__rt_down_read.isra.0
cyclicte-623     0....1.. 19619130us+: rt_mutex_slowlock <-rt_mutex_lock
cyclicte-623     0....1.. 19619135us+: add_preempt_count <-rt_mutex_slowlock
cyclicte-623     0....2.. 19619142us+: __try_to_take_rt_mutex <-rt_mutex_slowlock
cyclicte-623     0....2.. 19619150us+: sub_preempt_count <-rt_mutex_slowlock
cyclicte-623     0....1.. 19619157us+: get_user_pages <-get_user_pages_fast
cyclicte-623     0....1.. 19619164us+: __get_user_pages <-get_user_pages
cyclicte-623     0....1.. 19619171us+: __get_user_pages.part.80 <-__get_user_pages
cyclicte-623     0....1.. 19619177us+: find_extend_vma <-__get_user_pages.part.80
cyclicte-623     0....1.. 19619183us+: find_vma <-find_extend_vma
cyclicte-623     0....1.. 19619193us+: _cond_resched <-__get_user_pages.part.80
cyclicte-623     0....1.. 19619200us+: follow_page_mask <-__get_user_pages.part.80
cyclicte-623     0....1.. 19619208us+: rt_spin_lock <-follow_page_mask
cyclicte-623     0....1.. 19619215us+: rt_spin_lock_slowlock <-rt_spin_lock
cyclicte-623     0....1.. 19619221us+: add_preempt_count <-rt_spin_lock_slowlock
cyclicte-623     0....2.. 19619226us+: __try_to_take_rt_mutex <-rt_spin_lock_slowlock
cyclicte-623     0....2.. 19619232us+: sub_preempt_count <-rt_spin_lock_slowlock
cyclicte-623     0....1.. 19619239us+: vm_normal_page <-follow_page_mask
cyclicte-623     0....1.. 19619247us+: mark_page_accessed <-follow_page_mask
cyclicte-623     0....1.. 19619253us+: rt_spin_unlock <-follow_page_mask
cyclicte-623     0....1.. 19619259us+: rt_spin_lock_slowunlock <-rt_spin_unlock
cyclicte-623     0....1.. 19619264us+: add_preempt_count <-rt_spin_lock_slowunlock
cyclicte-623     0....2.. 19619270us+: __rt_spin_lock_slowunlock <-rt_spin_lock_slowunlock
cyclicte-623     0....2.. 19619276us+: sub_preempt_count <-__rt_spin_lock_slowunlock
cyclicte-623     0....1.. 19619283us+: __flush_anon_page <-__get_user_pages.part.80
cyclicte-623     0....1.. 19619314us+: flush_dcache_page <-__get_user_pages.part.80
cyclicte-623     0....1.. 19619332us+: page_mapping <-flush_dcache_page
cyclicte-623     0....1.. 19619339us+: __flush_dcache_page <-flush_dcache_page
cyclicte-623     0....1.. 19619362us+: rt_up_read <-get_user_pages_fast
cyclicte-623     0....1.. 19619380us+: rt_mutex_unlock <-rt_up_read
cyclicte-623     0....1.. 19619387us+: add_preempt_count <-rt_mutex_unlock
cyclicte-623     0....2.. 19619394us+: sub_preempt_count <-rt_mutex_unlock
cyclicte-623     0....1.. 19619402us+: pagefault_disable <-tracing_mark_write
cyclicte-623     0....2.. 19619409us+: add_preempt_count <-ring_buffer_lock_reserve
cyclicte-623     0....3.. 19619414us+: sub_preempt_count <-ring_buffer_lock_reserve
cyclicte-623     0....... 19619418us+: tracing_mark_write: hit latency threshold (2000 > 2097)
cyclicte-623     0....1.. 19619432us+: pagefault_enable <-tracing_mark_write
cyclicte-623     0....1.. 19619438us+: put_page <-tracing_mark_write
cyclicte-623     0....1.. 19619446us+: __fsnotify_parent <-vfs_write
cyclicte-623     0....1.. 19619452us+: fsnotify <-vfs_write
cyclicte-623     0....1.. 19619458us+: __srcu_read_lock <-fsnotify
cyclicte-623     0....1.. 19619464us+: add_preempt_count <-__srcu_read_lock
cyclicte-623     0....2.. 19619470us+: sub_preempt_count <-__srcu_read_lock
cyclicte-623     0....1.. 19619478us+: __srcu_read_unlock <-fsnotify
cyclicte-623     0....1.. 19619485us+: __sb_end_write <-vfs_write
cyclicte-623     0....1.. 19619491us+: add_preempt_count <-__sb_end_write
cyclicte-623     0....2.. 19619497us+: sub_preempt_count <-__sb_end_write
cyclicte-623     0....1.. 19619504us+: fput <-SyS_write
cyclicte-623     0....1.. 19619522us+: SyS_write <-ret_fast_syscall
cyclicte-623     0....1.. 19619529us+: fget_light <-SyS_write
cyclicte-623     0....1.. 19619534us+: __rcu_read_lock <-fget_light
cyclicte-623     0....1.. 19619541us+: __rcu_read_unlock <-fget_light
cyclicte-623     0....1.. 19619547us+: vfs_write <-SyS_write
cyclicte-623     0....1.. 19619554us+: rw_verify_area <-vfs_write
cyclicte-623     0....1.. 19619561us+: __sb_start_write <-vfs_write
cyclicte-623     0....1.. 19619567us+: add_preempt_count <-__sb_start_write
cyclicte-623     0....2.. 19619573us+: sub_preempt_count <-__sb_start_write
cyclicte-623     0....1.. 19619587us+: _mutex_lock <-rb_simple_write
cyclicte-623     0....1.. 19619593us+: rt_mutex_lock <-_mutex_lock
cyclicte-623     0....1.. 19619599us+: rt_mutex_slowlock <-rt_mutex_lock
cyclicte-623     0....1.. 19619605us+: add_preempt_count <-rt_mutex_slowlock
cyclicte-623     0....2.. 19619611us+: __try_to_take_rt_mutex <-rt_mutex_slowlock
cyclicte-623     0....2.. 19619618us : sub_preempt_count <-rt_mutex_slowlock

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ew6BAiZeqk4r7MaW
Content-Type: application/pdf
Content-Disposition: attachment; filename="bench-i.mx28-3.10.27-rt25.pdf"
Content-Transfer-Encoding: base64

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
ka7jXhfXhNdwlHVoRg6PHJpHy23PJZULeHl0gMzSH1raw1XLIYOjg9wHJoQe8rCkIiOPkQ2z
BLdiC9ppvPVg9n9r0t9Oc6pBjyeHu87TGIyk+zuv0Ih/yLqgXhvSg/7B2Pc6Lbm1l0yoDluB
3nc6LjjOcj9hEPv18n9JvQazCmVuZHN0cmVhbQplbmRvYmoKNCAwIG9iagogICAyODA2CmVu
ZG9iagoyIDAgb2JqCjw8CiAgIC9FeHRHU3RhdGUgPDwKICAgICAgL2EwIDw8IC9DQSAxIC9j
YSAxID4+CiAgID4+CiAgIC9Gb250IDw8CiAgICAgIC9mLTAtMCA1IDAgUgogICA+Pgo+Pgpl
bmRvYmoKNiAwIG9iago8PCAvVHlwZSAvUGFnZQogICAvUGFyZW50IDEgMCBSCiAgIC9NZWRp
YUJveCBbIDAgMCAzNjAgMjE2IF0KICAgL0NvbnRlbnRzIDMgMCBSCiAgIC9Hcm91cCA8PAog
ICAgICAvVHlwZSAvR3JvdXAKICAgICAgL1MgL1RyYW5zcGFyZW5jeQogICAgICAvSSB0cnVl
CiAgICAgIC9DUyAvRGV2aWNlUkdCCiAgID4+CiAgIC9SZXNvdXJjZXMgMiAwIFIKPj4KZW5k
b2JqCjggMCBvYmoKPDwgL0xlbmd0aCA5IDAgUgogICAvRmlsdGVyIC9GbGF0ZURlY29kZQo+
PgpzdHJlYW0KeJylWlmPXjUSfb+/4vL2oaFvvC8P8wKDBpAgLP0wAiGEOgGBsogko9H8e8pV
x8vtJJ+dhCClq9rHVXVcZZd989em9vLn+3/vD35V++8vN3UYv/9vM/tX9Ks/t59+3tWh9keb
PdL+9f7Xrnn8TfnL6LDfPd2sOaLfdfJHyHl/uttwOJeb4sn+w/7d9kag84d2aYQ6/QasuPji
9/3T2y3xz4SxR/DGOrebcCiVjDf77dPtwW836kaRrdvftotWH9/+uZE3Stks5ptgKB5rlKWf
8oC/MOTz207LlYhjOrITt4+gTFMsRDxA7WGVXsHCqBoNqiVj6mToKkaMBM/L0A1BsWBsgMLg
HAujtqRezx+RV0xWYM2eEXk9eVw6nI8u6vdMHq8H/EW/Q/L4cPiBYBYXYm0wkDvDiTEXD+/1
YA6KBYMDFCbnWBg198oDihWj5n55zLEwqo6k9JBFUKwYbdCaRyfs9USK6sha+RzeM5GiHfAX
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
T3dFn+s05NpcaFz6XFXR58rne05TDHN/8O3zu+1v9W6gSQplbmRzdHJlYW0KZW5kb2JqCjkg
MCBvYmoKICAgMjIzOQplbmRvYmoKNyAwIG9iago8PAogICAvRXh0R1N0YXRlIDw8CiAgICAg
IC9hMCA8PCAvQ0EgMSAvY2EgMSA+PgogICA+PgogICAvRm9udCA8PAogICAgICAvZi0wLTAg
NSAwIFIKICAgPj4KPj4KZW5kb2JqCjEwIDAgb2JqCjw8IC9UeXBlIC9QYWdlCiAgIC9QYXJl
bnQgMSAwIFIKICAgL01lZGlhQm94IFsgMCAwIDM2MCAyMTYgXQogICAvQ29udGVudHMgOCAw
IFIKICAgL0dyb3VwIDw8CiAgICAgIC9UeXBlIC9Hcm91cAogICAgICAvUyAvVHJhbnNwYXJl
bmN5CiAgICAgIC9JIHRydWUKICAgICAgL0NTIC9EZXZpY2VSR0IKICAgPj4KICAgL1Jlc291
cmNlcyA3IDAgUgo+PgplbmRvYmoKMTIgMCBvYmoKPDwgL0xlbmd0aCAxMyAwIFIKICAgL0Zp
bHRlciAvRmxhdGVEZWNvZGUKPj4Kc3RyZWFtCnicpVrZrh7FEb6fp5jcHZScofflIjdJUACJ
EIgvIhBCyBgE8iJsoihvn+qqr7p7ju2/x7ZtyVM1XevU1t3/b5vZ29+v/75//IPZf361mcPF
/b+b2z+nV79u3363m8PsP27+KPsX+2+75fX37T9n0/742ebdkeNuSzxSrfuz3acjhNoRT/d/
7V9tbyQM8bChzKTBvoFWVHz58/6XR1vhZ6LxR4rOh7C7dBhTXHT7o2fbxz/dm3tDsh79tN1Z
89GjXzfSxhhfRXwHHNnjnfH0VCf6Oyb55NFwyw2LczlqELWPZFxHXLB4IvWHN/YKLYSaWaC5
JMycBN2kESEp8mcYgoC4IGwihcA1LYT6FnojfgS+IlIJNXpmytvBE8oRYg7ZvmfwRDvR39l3
CJ6Yjjg5mMELtnYyOHdFJ8JCPmK0kzggLgicSCFyTQuh7kF6AHFFqHuYHmtaCDVHMXaKIiCu
CO2kGkcn2tuBlM1RrYk1vWcgZT/R37l3CCQfJhcTcMFSkMC1t2lEiCNK4j8EAXFB2EQKgWta
CDWnFGHwikBzTpEVnQizhVePwAHigsBBqoFzor0dONUf4UMCp6aJ/s6/Q+BY+6AoAHHFYvuw
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
yDzr4hycYcwE+JphDAWqzjQU8PfdeHDW2UJ8HiJiOnUFdTqIcGFI02zaPjsXlikvQuoDrBDk
Mb9CyhgQ8BVCxnep0m2ech+QvmS7BUVzRYI8VPiudF9V9l2dYKkwvaVHHRP0JrphpDfpEKc7
lqnvRDn138b2jl/Gsb8biGVniO5BZ1DE6FvnJbd4ySw88VJE7ynnJbd44ScMg5f+LE/siyeu
D84FPvh056vt/wrSS18KZW5kc3RyZWFtCmVuZG9iagoxMyAwIG9iagogICAyNDcwCmVuZG9i
agoxMSAwIG9iago8PAogICAvRXh0R1N0YXRlIDw8CiAgICAgIC9hMCA8PCAvQ0EgMSAvY2Eg
MSA+PgogICA+PgogICAvRm9udCA8PAogICAgICAvZi0wLTAgNSAwIFIKICAgPj4KPj4KZW5k
b2JqCjE0IDAgb2JqCjw8IC9UeXBlIC9QYWdlCiAgIC9QYXJlbnQgMSAwIFIKICAgL01lZGlh
Qm94IFsgMCAwIDM2MCAyMTYgXQogICAvQ29udGVudHMgMTIgMCBSCiAgIC9Hcm91cCA8PAog
ICAgICAvVHlwZSAvR3JvdXAKICAgICAgL1MgL1RyYW5zcGFyZW5jeQogICAgICAvSSB0cnVl
CiAgICAgIC9DUyAvRGV2aWNlUkdCCiAgID4+CiAgIC9SZXNvdXJjZXMgMTEgMCBSCj4+CmVu
ZG9iagoxNSAwIG9iago8PCAvTGVuZ3RoIDE2IDAgUgogICAvRmlsdGVyIC9GbGF0ZURlY29k
ZQogICAvTGVuZ3RoMSAxMDE0MAo+PgpzdHJlYW0KeJzlent8FEW2f1Wfru55T/dkJs9JZibJ
JIQAiQkBAmjaCMjDxSgBAQUDhoisXsCIPAKbAJIQgQ0PEzUgjAiIATEiiwkg4hp5Ba7ehfiT
K66LoOhuRNaLjw1J5Z7uCYh7H//+Pr/Pb3rOdFd1d9V5fs+pSgglhFhIBQHif+SJaXPOv7ul
jpC4oYQIkx95+ik/eSw+l5D4FwihvGTOo0/M7f/0LEJ82Ca7Hn18YUlf56Rv8Ho3IbFrZ86Y
VtwFI6oI8Q/DvgEzscPWJJVjezG2k2c+8dSCTypin8F2CNtNj89+ZBoRavsTEpiI7UNPTFsw
R9wozSUk0Y1t/5wnZ8wZIv8dLxPxGTaTCKSE14klbBtyK5NYzSZeJ9J1amLlgkgyWs6230aU
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
dwXZ7mLY1eBiu4LQ4ILXkOnXOmAnh1c57OCw3QXbOLyy1cFeyYKtDni5GEL4SKgOtnDY/JKN
bebwkg02bYxhm4phY73CNsZAvQIvWuAFDs/X2dnzHOrsUIsv1dbBcxsc7LlesMEB6ztg3dqD
bB2HtTVT2NqDsLZCrPl9kNVMgRpN/H0Q1nBYvaofW81hVT94FsV89k6oXmll1W5YaYUq7Kgq
hkrUVGUQVqjwDIfly1S2nMMyFZZyqOBQzkHr/t2SJex3HJYsgcXFUFboYWVBWMRhIYcFDphv
g6ctMI/DUx1Q2gFPdsDcDpjDYTaHf+HweAB+y2GWms9mjYPHOMxcAo9io4TDDA7FHB7hMJ3D
tMFQ1AFTbTCFw4McJnOYNNHCJnXARAs8EBnDHsiCCRzG48zj86HQA+OowsZFw/1uuG90BLuP
A9Zw93IY+xuFjeXwGwXu4TAG74zhMHqUwkZHwKh4OxulwEg73M1hRB0Mr4NhHO7CJd5dHZB/
EO4cAxqHPA533O5id7jh9qFOdrsLhg6xs6FatxOG2GEwh1wOgwa62aAOGDhAYQPdMCDHygYo
kGOF/gmQbYes26wsi8NtVsjMsLJMO2RYoV9fM+unQF8z9MmC9N5Bll4MvdNcrHcQ0lzQKzXI
et0JqUFICVpZihOCVkjmkMQh0QkBlDPgAn8x+DogAUVIKIZ4O3hRg14OcR0Qmw8x2IjhEF0M
UaipKA6R+FJkDHg4uDlEcHDhAy4OKsqq5oOyBJzF4OBgt0UyOwcbPm2LBCsHiwJmDiZ8zMRB
doNUDCLeFNEDPIC9wDFLKUzoC1QBwoE20eIVa2j6/wsf8n+bgf/1E/+fXzJ2KwplbmRzdHJl
YW0KZW5kb2JqCjE2IDAgb2JqCiAgIDczNjAKZW5kb2JqCjE3IDAgb2JqCjw8IC9MZW5ndGgg
MTggMCBSCiAgIC9GaWx0ZXIgL0ZsYXRlRGVjb2RlCj4+CnN0cmVhbQp4nF2TT2+jMBDF73wK
H7uHCuKM7VZCkVbtJYf9o83uBwB7SJEaQA455NuvH6/qSnsAfoxnnt+YoX45vh6ncTX1zzzH
k65mGKeU9TrfclTT63mcqp01aYzrx9t2j5duqepSfLpfV70cp2Gu2tbUv8ridc138/A1zb1+
qYwx9Y+cNI/T2Tz8eTkxdLoty7tedFpNUx0OJulQ5L51y/fuoqbeih+PqayP6/2xlP3L+H1f
1NjtfUdLcU56XbqouZvOWrVNczDtMBwqndJ/a+JY0g/xrctVu9+V1KYpj8INuQFbsgXvyXuw
kAXsyA7syR4cyKGwpabdNJ8Yfyrsqemh6QdyMdwGagZoemVcEee+Afv6yHgE07+Hf89aj9rw
zPxneKC+hb5PzElg5njkBPYb0G+gt7B5474e+1r6sfBjqWOhI2QBO/bo0KOQBew6xjucA/P3
yLfsxaIXob5AX+hZ4NmRHdj2zO+RQ/8C/0KfAp9CTdk0eSaCM3H8Fg7fwrFfh36F/Qr6tTzP
8sDwfEwJxgjz/jmf8ZZzGc3tp9hmEtM4Tvr53yzzgqrt+guSXtquCmVuZHN0cmVhbQplbmRv
YmoKMTggMCBvYmoKICAgNDMwCmVuZG9iagoxOSAwIG9iago8PCAvVHlwZSAvRm9udERlc2Ny
aXB0b3IKICAgL0ZvbnROYW1lIC9QU1lZTVYrRGVqYVZ1U2FucwogICAvRm9udEZhbWlseSAo
RGVqYVZ1IFNhbnMpCiAgIC9GbGFncyAzMgogICAvRm9udEJCb3ggWyAtMTAyMCAtNDE1IDE2
ODAgMTE2NiBdCiAgIC9JdGFsaWNBbmdsZSAwCiAgIC9Bc2NlbnQgOTI4CiAgIC9EZXNjZW50
IC0yMzUKICAgL0NhcEhlaWdodCAxMTY2CiAgIC9TdGVtViA4MAogICAvU3RlbUggODAKICAg
L0ZvbnRGaWxlMiAxNSAwIFIKPj4KZW5kb2JqCjUgMCBvYmoKPDwgL1R5cGUgL0ZvbnQKICAg
L1N1YnR5cGUgL1RydWVUeXBlCiAgIC9CYXNlRm9udCAvUFNZWU1WK0RlamFWdVNhbnMKICAg
L0ZpcnN0Q2hhciAzMgogICAvTGFzdENoYXIgMTIxCiAgIC9Gb250RGVzY3JpcHRvciAxOSAw
IFIKICAgL0VuY29kaW5nIC9XaW5BbnNpRW5jb2RpbmcKICAgL1dpZHRocyBbIDMxNyA0MDAg
MCAwIDAgMCAwIDAgMCAwIDAgODM3IDMxNyAzNjAgMzE3IDMzNiA2MzYgNjM2IDYzNiA2MzYg
NjM2IDYzNiA2MzYgNjM2IDYzNiAwIDAgMCAwIDgzNyAwIDAgMCAwIDAgNjk4IDc3MCA2MzEg
MCAwIDc1MSAyOTQgMCAwIDU1NyA4NjIgNzQ4IDc4NyA2MDMgMCA2OTQgMCAwIDAgMCAwIDY4
NSAwIDY4NSAwIDAgMCAwIDUwMCAwIDYxMiAwIDU0OSA2MzQgNjE1IDAgMCAwIDI3NyAwIDAg
Mjc3IDk3NCA2MzMgNjExIDAgMCA0MTEgNTIwIDM5MiA2MzMgMCAwIDAgNTkxIF0KICAgIC9U
b1VuaWNvZGUgMTcgMCBSCj4+CmVuZG9iagoxIDAgb2JqCjw8IC9UeXBlIC9QYWdlcwogICAv
S2lkcyBbIDYgMCBSIDEwIDAgUiAxNCAwIFIgXQogICAvQ291bnQgMwo+PgplbmRvYmoKMjAg
MCBvYmoKPDwgL0NyZWF0b3IgKGNhaXJvIDEuMTIuMTYgKGh0dHA6Ly9jYWlyb2dyYXBoaWNz
Lm9yZykpCiAgIC9Qcm9kdWNlciAoY2Fpcm8gMS4xMi4xNiAoaHR0cDovL2NhaXJvZ3JhcGhp
Y3Mub3JnKSkKPj4KZW5kb2JqCjIxIDAgb2JqCjw8IC9UeXBlIC9DYXRhbG9nCiAgIC9QYWdl
cyAxIDAgUgo+PgplbmRvYmoKeHJlZgowIDIyCjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAx
NzU3NiAwMDAwMCBuIAowMDAwMDAyOTIxIDAwMDAwIG4gCjAwMDAwMDAwMTUgMDAwMDAgbiAK
MDAwMDAwMjg5OCAwMDAwMCBuIAowMDAwMDE3MDkyIDAwMDAwIG4gCjAwMDAwMDMwMzAgMDAw
MDAgbiAKMDAwMDAwNTU4MyAwMDAwMCBuIAowMDAwMDAzMjQ0IDAwMDAwIG4gCjAwMDAwMDU1
NjAgMDAwMDAgbiAKMDAwMDAwNTY5MiAwMDAwMCBuIAowMDAwMDA4NDgwIDAwMDAwIG4gCjAw
MDAwMDU5MDcgMDAwMDAgbiAKMDAwMDAwODQ1NiAwMDAwMCBuIAowMDAwMDA4NTkwIDAwMDAw
IG4gCjAwMDAwMDg4MDcgMDAwMDAgbiAKMDAwMDAxNjI2NCAwMDAwMCBuIAowMDAwMDE2Mjg4
IDAwMDAwIG4gCjAwMDAwMTY3OTcgMDAwMDAgbiAKMDAwMDAxNjgyMCAwMDAwMCBuIAowMDAw
MDE3NjU1IDAwMDAwIG4gCjAwMDAwMTc3ODUgMDAwMDAgbiAKdHJhaWxlcgo8PCAvU2l6ZSAy
MgogICAvUm9vdCAyMSAwIFIKICAgL0luZm8gMjAgMCBSCj4+CnN0YXJ0eHJlZgoxNzgzOAol
JUVPRgo=

--ew6BAiZeqk4r7MaW--
