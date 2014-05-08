From: "Riyaz R, Syed Ismail" <SyedIsmail.RiyazR@trane.com>
Subject: Hign latencies with rt-patch on mx28 freescale board
Date: Thu, 8 May 2014 13:28:17 +0000
Message-ID: <F7D25D0F1F13E04EA375953DC5214A6002D88C07@DM1PRD7301MB016.mgdir.irco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:36301
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753300AbaEHN2Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 May 2014 09:28:25 -0400
Received: from mail180-ch1 (localhost [127.0.0.1])	by
 mail180-ch1-R.bigfish.com (Postfix) with ESMTP id CFFA12C09B4	for
 <linux-rt-users@vger.kernel.org>; Thu,  8 May 2014 13:28:24 +0000 (UTC)
Received: from CH1EHSMHS010.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.235])	by mail180-ch1.bigfish.com (Postfix) with ESMTP id
 CFB0F420080	for <linux-rt-users@vger.kernel.org>; Thu,  8 May 2014 13:28:21
 +0000 (UTC)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
Using RT-patch with linux-3.14.2 on mx28, I am getting very high latencies with a unloaded system. Note, I do not know if they were reasonable with earlier releases.
Running cyclictest without RT gives ~350 us max latency.
On one of the instances, I got the ftrace output as below, I redirect to /dev/null, so the prints itself do not affect results.
root@freescale ~$ ./cyclictest -t1 -p 80 -n -i 10000 -l 10000 -m -W  -b 3000 > /de
v/null
INFO: debugfs mountpoint: /sys/kernel/debug/tracing/
root@XL850-0 ~$ cat /sys/kernel/debug/tracing/trace
# tracer: wakeup_rt
#
# wakeup_rt latency trace v1.1.5 on 3.14.2-rt3
# --------------------------------------------------------------------
# latency: 2700 us, #314/314, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
#    -----------------
#    | task: cyclictest-1317 (uid:0 nice:0 policy:1 rt_prio:80)
#    -----------------
#
#                   _--------=> CPU#
#                  / _-------=> irqs-off
#                 | / _------=> need-resched
#                 || / _-----=> need-resched_lazy
#                 ||| / _----=> hardirq/softirq
#                 |||| / _---=> preempt-depth
#                 ||||| / _--=> preempt-lazy-depth
#                 |||||| / _-=> migrate-disable
#                 ||||||| /     delay
#  cmd     pid    |||||||| time  |   caller
#     \   /      ||||||||  \   |   /
  <idle>-0       0dn.h4..   10us+:      0:120:R   + [000]  1317: 19:S cyclictest
  <idle>-0       0dn.h4..   33us+: 0
  <idle>-0       0dn.h4..   47us+: _raw_spin_unlock <-try_to_wake_up
  <idle>-0       0dn.h4..   56us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h4..   63us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h3..   71us+: _raw_spin_unlock_irqrestore <-try_to_wake_up
  <idle>-0       0dn.h3..   78us+: do_raw_spin_unlock <-_raw_spin_unlock_irqrestore
  <idle>-0       0dn.h3..   85us+: preempt_count_sub <-_raw_spin_unlock_irqrestore
  <idle>-0       0dn.h2..   94us+: _raw_spin_lock <-__run_hrtimer
  <idle>-0       0dn.h2..  100us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3..  114us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3..  126us+: _raw_spin_unlock <-hrtimer_interrupt
  <idle>-0       0dn.h3..  133us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3..  141us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2..  148us+: tick_program_event <-hrtimer_interrupt
  <idle>-0       0dn.h2..  155us+: clockevents_program_event <-tick_program_event
  <idle>-0       0dn.h2..  163us+: ktime_get <-clockevents_program_event
  <idle>-0       0dn.h2..  174us+: clocksource_mmio_readl_down <-ktime_get
  <idle>-0       0dn.h2..  184us+: timrotv2_set_next_event <-clockevents_program_event
  <idle>-0       0dn.h2..  195us+: note_interrupt <-handle_irq_event_percpu
  <idle>-0       0dn.h2..  203us+: _raw_spin_lock <-handle_irq_event
  <idle>-0       0dn.h2..  210us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3..  219us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3..  228us+: unmask_irq <-handle_level_irq
  <idle>-0       0dn.h3..  235us+: icoll_unmask_irq <-unmask_irq
  <idle>-0       0dn.h3..  243us+: _raw_spin_unlock <-handle_level_irq
  <idle>-0       0dn.h3..  251us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3..  258us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2..  265us+: irq_exit <-handle_IRQ
  <idle>-0       0dn.h2..  273us+: preempt_count_sub <-irq_exit
  <idle>-0       0dn..2..  282us+: idle_cpu <-irq_exit
  <idle>-0       0dn..2..  291us+: rcu_irq_exit <-irq_exit
  <idle>-0       0dn..2..  299us+: T.845 <-rcu_irq_exit
  <idle>-0       0dn..2..  313us+: icoll_handle_irq <-__irq_svc
  <idle>-0       0dn..2..  321us+: irq_find_mapping <-icoll_handle_irq
  <idle>-0       0dn..2..  329us+: handle_IRQ <-icoll_handle_irq
  <idle>-0       0dn..2..  336us+: irq_enter <-handle_IRQ
  <idle>-0       0dn..2..  343us+: rcu_irq_enter <-irq_enter
  <idle>-0       0dn..2..  351us+: T.846 <-rcu_irq_enter
  <idle>-0       0dn..2..  360us+: tick_irq_enter <-irq_enter
  <idle>-0       0dn..2..  367us+: preempt_count_add <-irq_enter
  <idle>-0       0dn.h2..  374us+: generic_handle_irq <-handle_IRQ
  <idle>-0       0dn.h2..  381us+: irq_to_desc <-generic_handle_irq
  <idle>-0       0dn.h2..  389us+: handle_level_irq <-generic_handle_irq
  <idle>-0       0dn.h2..  397us+: _raw_spin_lock <-handle_level_irq
  <idle>-0       0dn.h2..  404us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3..  417us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3..  426us+: icoll_mask_irq <-handle_level_irq
  <idle>-0       0dn.h3..  435us+: icoll_ack_irq <-handle_level_irq
  <idle>-0       0dn.h3..  443us+: handle_irq_event <-handle_level_irq
  <idle>-0       0dn.h3..  451us+: _raw_spin_unlock <-handle_irq_event
  <idle>-0       0dn.h3..  458us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3..  465us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2..  472us+: handle_irq_event_percpu <-handle_irq_event
  <idle>-0       0dn.h2..  479us+: mxs_timer_interrupt <-handle_irq_event_percpu
  <idle>-0       0dn.h2..  487us+: hrtimer_interrupt <-mxs_timer_interrupt
  <idle>-0       0dn.h2..  494us+: _raw_spin_lock <-hrtimer_interrupt
  <idle>-0       0dn.h2..  501us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3..  511us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3..  520us+: ktime_get_update_offsets <-hrtimer_interrupt
  <idle>-0       0dn.h3..  532us+: clocksource_mmio_readl_down <-ktime_get_update_offsets
  <idle>-0       0dn.h3..  542us+: hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0dn.h3..  550us+: __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0dn.h3..  558us+: __remove_hrtimer <-__run_hrtimer
  <idle>-0       0dn.h3..  569us+: _raw_spin_unlock <-__run_hrtimer
  <idle>-0       0dn.h3..  577us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3..  584us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2..  591us+: sched_rt_period_timer <-__run_hrtimer
  <idle>-0       0dn.h2..  599us+: ktime_get <-sched_rt_period_timer
  <idle>-0       0dn.h2..  611us+: clocksource_mmio_readl_down <-ktime_get
  <idle>-0       0dn.h2..  621us+: hrtimer_forward <-sched_rt_period_timer
  <idle>-0       0dn.h2..  630us+: ktime_add_safe <-hrtimer_forward
  <idle>-0       0dn.h2..  638us+: ktime_add_safe <-hrtimer_forward
  <idle>-0       0dn.h2..  646us+: _raw_spin_lock <-sched_rt_period_timer
  <idle>-0       0dn.h2..  652us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3..  663us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3..  670us+: _raw_spin_lock <-sched_rt_period_timer
  <idle>-0       0dn.h3..  677us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h4..  687us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h4..  695us+: _raw_spin_unlock <-sched_rt_period_timer
  <idle>-0       0dn.h4..  703us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h4..  709us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h3..  717us+: _raw_spin_unlock <-sched_rt_period_timer
  <idle>-0       0dn.h3..  724us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3..  731us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2..  738us+: ktime_get <-sched_rt_period_timer
  <idle>-0       0dn.h2..  748us+: clocksource_mmio_readl_down <-ktime_get
  <idle>-0       0dn.h2..  756us+: hrtimer_forward <-sched_rt_period_timer
  <idle>-0       0dn.h2..  764us+: _raw_spin_lock <-__run_hrtimer
  <idle>-0       0dn.h2..  771us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3..  780us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3..  788us+: enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0dn.h3..  809us+: hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0dn.h3..  818us+: __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0dn.h3..  826us+: __remove_hrtimer <-__run_hrtimer
  <idle>-0       0dn.h3..  835us+: _raw_spin_unlock <-__run_hrtimer
  <idle>-0       0dn.h3..  843us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3..  851us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2..  858us+: tick_sched_timer <-__run_hrtimer
  <idle>-0       0dn.h2..  865us+: ktime_get <-tick_sched_timer
  <idle>-0       0dn.h2..  878us+: clocksource_mmio_readl_down <-ktime_get
  <idle>-0       0dn.h2..  886us+: tick_sched_do_timer <-tick_sched_timer
  <idle>-0       0dn.h2..  895us+: tick_do_update_jiffies64 <-tick_sched_do_timer
  <idle>-0       0dn.h2..  903us+: _raw_spin_lock <-tick_do_update_jiffies64
  <idle>-0       0dn.h2..  910us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3..  920us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3..  927us+: preempt_count_add <-tick_do_update_jiffies64
  <idle>-0       0dn.h4..  938us+: do_timer <-tick_do_update_jiffies64
  <idle>-0       0dn.h4..  946us+: calc_global_load <-do_timer
  <idle>-0       0dn.h4..  955us+: preempt_count_sub <-tick_do_update_jiffies64
  <idle>-0       0dn.h3..  962us+: _raw_spin_unlock <-tick_do_update_jiffies64
  <idle>-0       0dn.h3..  969us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3..  976us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2..  983us+: update_wall_time <-tick_do_update_jiffies64
  <idle>-0       0dn.h2..  991us+: _raw_spin_lock_irqsave <-update_wall_time
  <idle>-0       0dn.h2..  999us+: preempt_count_add <-_raw_spin_lock_irqsave
  <idle>-0       0dn.h3.. 1009us+: do_raw_spin_lock <-_raw_spin_lock_irqsave
  <idle>-0       0dn.h3.. 1017us+: clocksource_mmio_readl_down <-update_wall_time
  <idle>-0       0dn.h3.. 1027us+: ntp_tick_length <-update_wall_time
  <idle>-0       0dn.h3.. 1040us+: ntp_tick_length <-update_wall_time
  <idle>-0       0dn.h3.. 1052us+: preempt_count_add <-update_wall_time
  <idle>-0       0dn.h4.. 1068us+: T.731 <-update_wall_time
  <idle>-0       0dn.h4.. 1077us+: raw_notifier_call_chain <-T.731
  <idle>-0       0dn.h4.. 1085us+: notifier_call_chain <-raw_notifier_call_chain
  <idle>-0       0dn.h4.. 1094us+: preempt_count_sub <-update_wall_time
  <idle>-0       0dn.h3.. 1102us+: _raw_spin_unlock_irqrestore <-update_wall_time
  <idle>-0       0dn.h3.. 1109us+: do_raw_spin_unlock <-_raw_spin_unlock_irqrestore
  <idle>-0       0dn.h3.. 1116us+: preempt_count_sub <-_raw_spin_unlock_irqrestore
  <idle>-0       0dn.h2.. 1124us+: tick_sched_handle <-tick_sched_timer
  <idle>-0       0dn.h2.. 1132us+: update_process_times <-tick_sched_handle
  <idle>-0       0dn.h2.. 1139us+: account_process_tick <-update_process_times
  <idle>-0       0dn.h2.. 1148us+: scheduler_tick <-update_process_times
  <idle>-0       0dn.h2.. 1155us+: _raw_spin_lock <-scheduler_tick
  <idle>-0       0dn.h2.. 1162us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3.. 1172us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3.. 1180us+: update_rq_clock <-scheduler_tick
  <idle>-0       0dn.h3.. 1188us+: task_tick_idle <-scheduler_tick
  <idle>-0       0dn.h3.. 1195us+: update_cpu_load_active <-scheduler_tick
  <idle>-0       0dn.h3.. 1202us+: __update_cpu_load <-update_cpu_load_active
  <idle>-0       0dn.h3.. 1211us+: _raw_spin_unlock <-scheduler_tick
  <idle>-0       0dn.h3.. 1218us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3.. 1226us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2.. 1235us+: run_local_timers <-update_process_times
  <idle>-0       0dn.h2.. 1242us+: hrtimer_run_queues <-run_local_timers
  <idle>-0       0dn.h2.. 1250us+: raise_softirq <-run_local_timers
  <idle>-0       0dn.h2.. 1258us+: raise_softirq_irqoff <-raise_softirq
  <idle>-0       0dn.h2.. 1265us+: do_raise_softirq_irqoff <-raise_softirq_irqoff
  <idle>-0       0dn.h2.. 1275us+: rcu_check_callbacks <-update_process_times
  <idle>-0       0dn.h2.. 1283us+: rcu_bh_qs <-rcu_check_callbacks
  <idle>-0       0dn.h2.. 1294us+: invoke_rcu_core <-rcu_check_callbacks
  <idle>-0       0dn.h2.. 1303us+: wake_up_process <-invoke_rcu_core
  <idle>-0       0dn.h2.. 1310us+: try_to_wake_up <-wake_up_process
  <idle>-0       0dn.h2.. 1317us+: _raw_spin_lock_irqsave <-try_to_wake_up
  <idle>-0       0dn.h2.. 1325us+: preempt_count_add <-_raw_spin_lock_irqsave
  <idle>-0       0dn.h3.. 1335us+: do_raw_spin_lock <-_raw_spin_lock_irqsave
  <idle>-0       0dn.h3.. 1343us+: _raw_spin_lock <-try_to_wake_up
  <idle>-0       0dn.h3.. 1350us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h4.. 1360us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h4.. 1368us+: activate_task <-try_to_wake_up
  <idle>-0       0dn.h4.. 1375us+: enqueue_task <-activate_task
  <idle>-0       0dn.h4.. 1382us+: update_rq_clock <-enqueue_task
  <idle>-0       0dn.h4.. 1390us+: enqueue_task_rt <-enqueue_task
  <idle>-0       0dn.h4.. 1397us+: dequeue_rt_stack <-enqueue_task_rt
  <idle>-0       0dn.h4.. 1407us+: T.1436 <-try_to_wake_up
  <idle>-0       0dn.h4.. 1414us+: check_preempt_curr <-T.1436
  <idle>-0       0dn.h4.. 1422us+: resched_task <-check_preempt_curr
  <idle>-0       0dn.h4.. 1438us+: _raw_spin_unlock <-try_to_wake_up
  <idle>-0       0dn.h4.. 1445us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h4.. 1452us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h3.. 1459us+: _raw_spin_unlock_irqrestore <-try_to_wake_up
  <idle>-0       0dn.h3.. 1467us+: do_raw_spin_unlock <-_raw_spin_unlock_irqrestore
  <idle>-0       0dn.h3.. 1474us+: preempt_count_sub <-_raw_spin_unlock_irqrestore
  <idle>-0       0dn.h2.. 1485us+: run_posix_cpu_timers <-update_process_times
  <idle>-0       0dn.h2.. 1495us+: hrtimer_forward <-tick_sched_timer
  <idle>-0       0dn.h2.. 1503us+: ktime_add_safe <-hrtimer_forward
  <idle>-0       0dn.h2.. 1510us+: ktime_add_safe <-hrtimer_forward
  <idle>-0       0dn.h2.. 1517us+: _raw_spin_lock <-__run_hrtimer
  <idle>-0       0dn.h2.. 1524us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3.. 1535us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3.. 1543us+: enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0dn.h3.. 1557us+: _raw_spin_unlock <-hrtimer_interrupt
  <idle>-0       0dn.h3.. 1566us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3.. 1573us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2.. 1580us+: tick_program_event <-hrtimer_interrupt
  <idle>-0       0dn.h2.. 1588us+: clockevents_program_event <-tick_program_event
  <idle>-0       0dn.h2.. 1595us+: ktime_get <-clockevents_program_event
  <idle>-0       0dn.h2.. 1607us+: clocksource_mmio_readl_down <-ktime_get
  <idle>-0       0dn.h2.. 1617us+: timrotv2_set_next_event <-clockevents_program_event
  <idle>-0       0dn.h2.. 1627us+: note_interrupt <-handle_irq_event_percpu
  <idle>-0       0dn.h2.. 1635us+: _raw_spin_lock <-handle_irq_event
  <idle>-0       0dn.h2.. 1642us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3.. 1653us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3.. 1662us+: unmask_irq <-handle_level_irq
  <idle>-0       0dn.h3.. 1669us+: icoll_unmask_irq <-unmask_irq
  <idle>-0       0dn.h3.. 1677us+: _raw_spin_unlock <-handle_level_irq
  <idle>-0       0dn.h3.. 1685us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3.. 1692us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2.. 1699us+: irq_exit <-handle_IRQ
  <idle>-0       0dn.h2.. 1707us+: preempt_count_sub <-irq_exit
  <idle>-0       0dn..2.. 1716us+: wake_up_process <-irq_exit
  <idle>-0       0dn..2.. 1724us+: try_to_wake_up <-wake_up_process
  <idle>-0       0dn..2.. 1731us+: _raw_spin_lock_irqsave <-try_to_wake_up
  <idle>-0       0dn..2.. 1738us+: preempt_count_add <-_raw_spin_lock_irqsave
  <idle>-0       0dn..3.. 1748us+: do_raw_spin_lock <-_raw_spin_lock_irqsave
  <idle>-0       0dn..3.. 1756us+: _raw_spin_lock <-try_to_wake_up
  <idle>-0       0dn..3.. 1763us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn..4.. 1773us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn..4.. 1780us+: activate_task <-try_to_wake_up
  <idle>-0       0dn..4.. 1787us+: enqueue_task <-activate_task
  <idle>-0       0dn..4.. 1794us+: update_rq_clock <-enqueue_task
  <idle>-0       0dn..4.. 1801us+: enqueue_task_rt <-enqueue_task
  <idle>-0       0dn..4.. 1808us+: dequeue_rt_stack <-enqueue_task_rt
  <idle>-0       0dn..4.. 1817us+: T.1436 <-try_to_wake_up
  <idle>-0       0dn..4.. 1825us+: check_preempt_curr <-T.1436
  <idle>-0       0dn..4.. 1832us+: resched_task <-check_preempt_curr
  <idle>-0       0dn..4.. 1845us+: _raw_spin_unlock <-try_to_wake_up
  <idle>-0       0dn..4.. 1852us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn..4.. 1859us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn..3.. 1866us+: _raw_spin_unlock_irqrestore <-try_to_wake_up
  <idle>-0       0dn..3.. 1873us+: do_raw_spin_unlock <-_raw_spin_unlock_irqrestore
  <idle>-0       0dn..3.. 1880us+: preempt_count_sub <-_raw_spin_unlock_irqrestore
  <idle>-0       0dn..2.. 1889us+: idle_cpu <-irq_exit
  <idle>-0       0dn..2.. 1897us+: rcu_irq_exit <-irq_exit
  <idle>-0       0dn..2.. 1905us+: T.845 <-rcu_irq_exit
  <idle>-0       0.n..2.. 1920us+: rcu_idle_exit <-cpu_startup_entry
  <idle>-0       0dn..2.. 1930us+: T.846 <-rcu_idle_exit
  <idle>-0       0dn..2.. 1941us+: icoll_handle_irq <-__irq_svc
  <idle>-0       0dn..2.. 1948us+: irq_find_mapping <-icoll_handle_irq
  <idle>-0       0dn..2.. 1955us+: handle_IRQ <-icoll_handle_irq
  <idle>-0       0dn..2.. 1962us+: irq_enter <-handle_IRQ
  <idle>-0       0dn..2.. 1969us+: rcu_irq_enter <-irq_enter
  <idle>-0       0dn..2.. 1978us+: tick_irq_enter <-irq_enter
  <idle>-0       0dn..2.. 1986us+: preempt_count_add <-irq_enter
  <idle>-0       0dn.h2.. 1994us+: generic_handle_irq <-handle_IRQ
  <idle>-0       0dn.h2.. 2001us+: irq_to_desc <-generic_handle_irq
  <idle>-0       0dn.h2.. 2009us+: handle_level_irq <-generic_handle_irq
  <idle>-0       0dn.h2.. 2017us+: _raw_spin_lock <-handle_level_irq
  <idle>-0       0dn.h2.. 2031us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3.. 2046us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3.. 2056us+: icoll_mask_irq <-handle_level_irq
  <idle>-0       0dn.h3.. 2064us+: icoll_ack_irq <-handle_level_irq
  <idle>-0       0dn.h3.. 2072us+: handle_irq_event <-handle_level_irq
  <idle>-0       0dn.h3.. 2079us+: _raw_spin_unlock <-handle_irq_event
  <idle>-0       0dn.h3.. 2087us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3.. 2094us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2.. 2102us+: handle_irq_event_percpu <-handle_irq_event
  <idle>-0       0dn.h2.. 2109us+: mxs_timer_interrupt <-handle_irq_event_percpu
  <idle>-0       0dn.h2.. 2117us+: hrtimer_interrupt <-mxs_timer_interrupt
  <idle>-0       0dn.h2.. 2125us+: _raw_spin_lock <-hrtimer_interrupt
  <idle>-0       0dn.h2.. 2132us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3.. 2142us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3.. 2151us+: ktime_get_update_offsets <-hrtimer_interrupt
  <idle>-0       0dn.h3.. 2165us+: clocksource_mmio_readl_down <-ktime_get_update_offsets
  <idle>-0       0dn.h3.. 2175us+: hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0dn.h3.. 2183us+: __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0dn.h3.. 2191us+: __remove_hrtimer <-__run_hrtimer
  <idle>-0       0dn.h3.. 2201us+: _raw_spin_unlock <-__run_hrtimer
  <idle>-0       0dn.h3.. 2209us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3.. 2216us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2.. 2224us+: hrtimer_wakeup <-__run_hrtimer
  <idle>-0       0dn.h2.. 2231us+: wake_up_process <-hrtimer_wakeup
  <idle>-0       0dn.h2.. 2238us+: try_to_wake_up <-wake_up_process
  <idle>-0       0dn.h2.. 2245us+: _raw_spin_lock_irqsave <-try_to_wake_up
  <idle>-0       0dn.h2.. 2253us+: preempt_count_add <-_raw_spin_lock_irqsave
  <idle>-0       0dn.h3.. 2264us+: do_raw_spin_lock <-_raw_spin_lock_irqsave
  <idle>-0       0dn.h3.. 2271us+: _raw_spin_lock <-try_to_wake_up
  <idle>-0       0dn.h3.. 2278us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h4.. 2287us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h4.. 2294us+: activate_task <-try_to_wake_up
  <idle>-0       0dn.h4.. 2302us+: enqueue_task <-activate_task
  <idle>-0       0dn.h4.. 2309us+: update_rq_clock <-enqueue_task
  <idle>-0       0dn.h4.. 2317us+: enqueue_task_fair <-enqueue_task
  <idle>-0       0dn.h4.. 2325us+: T.781 <-enqueue_task_fair
  <idle>-0       0dn.h4.. 2333us+: T.782 <-enqueue_task_fair
  <idle>-0       0dn.h4.. 2343us+: T.1436 <-try_to_wake_up
  <idle>-0       0dn.h4.. 2350us+: check_preempt_curr <-T.1436
  <idle>-0       0dn.h4.. 2358us+: resched_task <-check_preempt_curr
  <idle>-0       0dn.h4.. 2371us+: _raw_spin_unlock <-try_to_wake_up
  <idle>-0       0dn.h4.. 2379us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h4.. 2387us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h3.. 2394us+: _raw_spin_unlock_irqrestore <-try_to_wake_up
  <idle>-0       0dn.h3.. 2401us+: do_raw_spin_unlock <-_raw_spin_unlock_irqrestore
  <idle>-0       0dn.h3.. 2409us+: preempt_count_sub <-_raw_spin_unlock_irqrestore
  <idle>-0       0dn.h2.. 2417us+: _raw_spin_lock <-__run_hrtimer
  <idle>-0       0dn.h2.. 2424us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3.. 2434us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3.. 2443us+: _raw_spin_unlock <-hrtimer_interrupt
  <idle>-0       0dn.h3.. 2450us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3.. 2457us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2.. 2465us+: tick_program_event <-hrtimer_interrupt
  <idle>-0       0dn.h2.. 2472us+: clockevents_program_event <-tick_program_event
  <idle>-0       0dn.h2.. 2479us+: ktime_get <-clockevents_program_event
  <idle>-0       0dn.h2.. 2489us+: clocksource_mmio_readl_down <-ktime_get
  <idle>-0       0dn.h2.. 2499us+: timrotv2_set_next_event <-clockevents_program_event
  <idle>-0       0dn.h2.. 2508us+: note_interrupt <-handle_irq_event_percpu
  <idle>-0       0dn.h2.. 2516us+: _raw_spin_lock <-handle_irq_event
  <idle>-0       0dn.h2.. 2523us+: preempt_count_add <-_raw_spin_lock
  <idle>-0       0dn.h3.. 2533us+: do_raw_spin_lock <-_raw_spin_lock
  <idle>-0       0dn.h3.. 2541us+: unmask_irq <-handle_level_irq
  <idle>-0       0dn.h3.. 2548us+: icoll_unmask_irq <-unmask_irq
  <idle>-0       0dn.h3.. 2556us+: _raw_spin_unlock <-handle_level_irq
  <idle>-0       0dn.h3.. 2563us+: do_raw_spin_unlock <-_raw_spin_unlock
  <idle>-0       0dn.h3.. 2570us+: preempt_count_sub <-_raw_spin_unlock
  <idle>-0       0dn.h2.. 2578us+: irq_exit <-handle_IRQ
  <idle>-0       0dn.h2.. 2585us+: preempt_count_sub <-irq_exit
  <idle>-0       0dn..2.. 2595us+: idle_cpu <-irq_exit
  <idle>-0       0dn..2.. 2603us+: rcu_irq_exit <-irq_exit
  <idle>-0       0.n..2.. 2617us+: arch_cpu_idle_exit <-cpu_startup_entry
  <idle>-0       0.n..2.. 2626us+: tick_nohz_idle_exit <-cpu_startup_entry
  <idle>-0       0.n..2.. 2635us+: schedule_preempt_disabled <-cpu_startup_entry
  <idle>-0       0.n..2.. 2642us+: preempt_count_sub <-schedule_preempt_disabled
  <idle>-0       0.n..1.. 2653us+: schedule <-schedule_preempt_disabled
  <idle>-0       0d...3.. 2685us+: __schedule
  <idle>-0       0d...3.. 2692us :      0:120:R ==> [000]  1317: 19:R cyclictest
root@freescale ~$

--Ismail

________________________________

The information contained in this message is privileged and intended only for the recipients named. If the reader is not a representative of the intended recipient, any review, dissemination or copying of this message or the information it contains is prohibited. If you have received this message in error, please immediately notify the sender, and delete the original message and attachments.

