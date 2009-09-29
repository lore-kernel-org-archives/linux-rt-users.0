From: Azraiyl <azraiyl@gmail.com>
Subject: Re: RT Latency on Atmel Processors
Date: Tue, 29 Sep 2009 16:27:49 +0200
Message-ID: <a9067d050909290727wc4659e8m55b55503d43979b5@mail.gmail.com>
References: <a9067d050909240502n3377f3c5gb70fcf16c58b3942@mail.gmail.com>
	 <3efb10970909241340v75375381m8f833e41ba96b733@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:50257 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZI2O1r (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Sep 2009 10:27:47 -0400
Received: by fxm18 with SMTP id 18so4509105fxm.17
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Sep 2009 07:27:49 -0700 (PDT)
In-Reply-To: <3efb10970909241340v75375381m8f833e41ba96b733@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks for your details. My problem is that my problem can be simplified as
follows: Toggle an IO with 4 KHz. I don't have an external 4 KHz clock,
therefore my idea was to depend on any timer API linux provides. While
nanosleep
and clock_nanosleep work as expected (clock_getres returns a valid result),
itimer is more like a nice random generator. But one of the problems I still
have are the Max. latencies. I tried to track them down.

With "ping -f x.x.x.x" running and the tracing subsystem activated I get the
following results (55ms Max. Latency). Personally I think that is not ok that
"time" is updated with jiffies (HZ=200 on this kernel). All of my traces look
the same (if HZ=100 then time is updated with 10000us, ...).

# cat /dfs/tracing/trace
# tracer: wakeup
#
# wakeup latency trace v1.1.5 on 2.6.29.6-rt23
# --------------------------------------------------------------------
# latency: 55000 us, #726/726, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
#    -----------------
#    | task: test-247 (uid:0 nice:0 policy:1 rt_prio:80)
#    -----------------
#
#                  _------=> CPU#
#                 / _-----=> irqs-off
#                | / _----=> need-resched
#                || / _---=> hardirq/softirq
#                ||| / _--=> preempt-depth
#                |||| /
#                |||||     delay
#  cmd     pid   ||||| time  |   caller
#     \   /      |||||   \   |   /
sirq-net-6       0d.h3    0us :      6: 50:R   + [000]   247: 19:S test
sirq-net-6       0d.h3    0us : wake_up_process <-hrtimer_wakeup
sirq-net-6       0d.h2    0us : check_preempt_curr_rt <-try_to_wake_up
sirq-net-6       0dNh1    0us : preempt_schedule <-try_to_wake_up
sirq-net-6       0dNh2    0us : hrtimer_rt_defer <-hrtimer_interrupt
sirq-net-6       0dNh2    0us : __run_hrtimer <-hrtimer_interrupt
sirq-net-6       0dNh2    0us : __remove_hrtimer <-__run_hrtimer
sirq-net-6       0dNh1    0us : preempt_schedule <-__run_hrtimer
sirq-net-6       0dNh1    0us : tick_sched_timer <-__run_hrtimer
sirq-net-6       0dNh1    0us : ktime_get <-tick_sched_timer
sirq-net-6       0dNh1    0us : tc_get_cycles <-ktime_get
sirq-net-6       0dNh1    0us : ktime_add_ns <-ktime_get
sirq-net-6       0dNh2    0us!: do_timer <-tick_sched_timer
sirq-net-6       0dNh2 5000us : update_wall_time <-do_timer
sirq-net-6       0dNh2 5000us : tc_get_cycles <-update_wall_time
sirq-net-6       0dNh2 5000us : clocksource_get_next <-update_wall_time
sirq-net-6       0dNh2 5000us : preempt_schedule <-clocksource_get_next
sirq-net-6       0dNh2 5000us : calc_global_load <-do_timer
sirq-net-6       0dNh1 5000us : preempt_schedule <-tick_sched_timer
sirq-net-6       0dNh1 5000us : update_process_times <-tick_sched_timer
sirq-net-6       0dNh1 5000us : account_process_tick <-update_process_times
sirq-net-6       0dNh1 5000us : account_system_time <-account_process_tick
sirq-net-6       0dNh1 5000us : scheduler_tick <-update_process_times
sirq-net-6       0dNh2 5000us : task_tick_rt <-scheduler_tick
sirq-net-6       0dNh2 5000us : update_curr_rt <-task_tick_rt
sirq-net-6       0dNh2 5000us : preempt_schedule <-update_curr_rt
sirq-net-6       0dNh1 5000us : preempt_schedule <-scheduler_tick
sirq-net-6       0dNh1 5000us : run_local_timers <-update_process_times
sirq-net-6       0dNh1 5000us : hrtimer_run_queues <-run_local_timers
sirq-net-6       0dNh1 5000us : raise_softirq <-run_local_timers
sirq-net-6       0dNh1 5000us : softlockup_tick <-run_local_timers
sirq-net-6       0dNh1 5000us : rcu_pending <-update_process_times
sirq-net-6       0dNh1 5000us : run_posix_cpu_timers <-update_process_times
sirq-net-6       0dNh1 5000us : hrtimer_forward <-tick_sched_timer
sirq-net-6       0dNh1 5000us : ktime_add_safe <-hrtimer_forward
sirq-net-6       0dNh1 5000us : ktime_add_safe <-hrtimer_forward
sirq-net-6       0dNh2 5000us : enqueue_hrtimer <-__run_hrtimer
sirq-net-6       0dNh1 5000us : preempt_schedule <-hrtimer_interrupt
sirq-net-6       0dNh1 5000us : tick_program_event <-hrtimer_interrupt
sirq-net-6       0dNh1 5000us : tick_dev_program_event <-tick_program_event
sirq-net-6       0dNh1 5000us : ktime_get <-tick_dev_program_event
sirq-net-6       0dNh1 5000us : tc_get_cycles <-ktime_get
sirq-net-6       0dNh1 5000us : ktime_add_ns <-ktime_get
sirq-net-6       0dNh1 5000us : clockevents_program_event
<-tick_dev_program_event
sirq-net-6       0dNh1 5000us : tc_next_event <-clockevents_program_event
sirq-net-6       0dNh1 5000us : note_interrupt <-handle_level_irq
sirq-net-6       0dNh2 5000us : at91_aic_unmask_irq <-handle_level_irq
sirq-net-6       0dNh1 5000us : preempt_schedule <-handle_level_irq
sirq-net-6       0dNh1 5000us : irq_exit <-_text
sirq-net-6       0dN.2 5000us : __do_softirq <-irq_exit
sirq-net-6       0dN.2 5000us : trigger_softirqs <-__do_softirq
sirq-net-6       0dN.. 5000us : preempt_schedule_irq <-svc_preempt
sirq-net-6       0dN.. 5000us : __schedule <-preempt_schedule_irq
sirq-net-6       0dN.. 5000us : rcu_qsctr_inc <-__schedule
sirq-net-6       0d..2 5000us : put_prev_task_rt <-__schedule
sirq-net-6       0d..2 5000us : update_curr_rt <-put_prev_task_rt
sirq-net-6       0dN.2 5000us : preempt_schedule <-update_curr_rt
sirq-net-6       0dN.2 5000us : pick_next_task_rt <-__schedule
sirq-net-6       0dN.2 5000us : pick_next_task_fair <-__schedule
sirq-net-6       0dN.2 5000us : set_next_entity <-pick_next_task_fair
sirq-net-6       0.N.1 5000us : preempt_schedule <-__schedule
sirq-net-6       0.N.1 5000us : preempt_schedule <-__schedule
sirq-net-6       0.N.1 5000us : __rcu_read_lock <-__atomic_notifier_call_chain
sirq-net-6       0.N.1 5000us : nwfpe_notify <-notifier_call_chain
sirq-net-6       0.N.1 5000us : __rcu_read_unlock <-__atomic_notifier_call_chain
 pdflush-99      0...1 5000us : finish_task_switch <-__schedule
 pdflush-99      0.... 5000us : rt_spin_lock <-pdflush
 pdflush-99      0.... 5000us : __might_sleep <-rt_spin_lock
 pdflush-99      0.... 5000us : rt_spin_lock_slowlock <-rt_spin_lock
 pdflush-99      0d..1 5000us : do_try_to_take_rt_mutex <-rt_spin_lock_slowlock
 pdflush-99      0.... 5000us : rt_spin_unlock <-pdflush
 pdflush-99      0.... 5000us : rt_spin_lock_slowunlock <-rt_spin_unlock
 pdflush-99      0.... 5000us : wb_kupdate <-pdflush
 pdflush-99      0.... 5000us : sync_supers <-wb_kupdate
 pdflush-99      0.... 5000us : rt_spin_lock <-sync_supers
 pdflush-99      0.... 5000us : __might_sleep <-rt_spin_lock
 pdflush-99      0.... 5000us : rt_spin_lock_slowlock <-rt_spin_lock
 pdflush-99      0d..1 5000us : do_try_to_take_rt_mutex <-rt_spin_lock_slowlock
 pdflush-99      0.... 5000us : rt_spin_unlock <-sync_supers
 pdflush-99      0.... 5000us : rt_spin_lock_slowunlock <-rt_spin_unlock
 pdflush-99      0.... 5000us : writeback_inodes <-wb_kupdate
 pdflush-99      0.... 5000us : __might_sleep <-writeback_inodes
 pdflush-99      0.... 5000us : rt_spin_lock <-writeback_inodes
 pdflush-99      0.... 5000us : __might_sleep <-rt_spin_lock
 pdflush-99      0.... 5000us : rt_spin_lock_slowlock <-rt_spin_lock
 pdflush-99      0d..1 5000us : do_try_to_take_rt_mutex <-rt_spin_lock_slowlock
 pdflush-99      0.... 5000us : rt_spin_unlock <-writeback_inodes
 pdflush-99      0.... 5000us : rt_spin_lock_slowunlock <-rt_spin_unlock
 pdflush-99      0.... 5000us : rt_down_read_trylock <-writeback_inodes
 pdflush-99      0.... 5000us : rt_mutex_trylock <-rt_down_read_trylock
 pdflush-99      0d..1 5000us : do_try_to_take_rt_mutex <-rt_mutex_trylock
 pdflush-99      0.... 5000us : generic_sync_sb_inodes <-writeback_inodes
 pdflush-99      0.... 5000us : rt_spin_lock <-generic_sync_sb_inodes
 pdflush-99      0.... 5000us : __might_sleep <-rt_spin_lock
 pdflush-99      0.... 5000us : rt_spin_lock_slowlock <-rt_spin_lock
 pdflush-99      0d..1 5000us : do_try_to_take_rt_mutex <-rt_spin_lock_slowlock
 pdflush-99      0.... 5000us : rt_spin_unlock <-generic_sync_sb_inodes
 pdflush-99      0.... 5000us : rt_spin_lock_slowunlock <-rt_spin_unlock
 pdflush-99      0.... 5000us : rt_up_read <-writeback_inodes
 pdflush-99      0.... 5000us : rt_mutex_unlock <-rt_up_read
 pdflush-99      0.... 5000us : rt_mutex_slowunlock <-rt_mutex_unlock
 pdflush-99      0.... 5000us : rt_spin_lock <-writeback_inodes
 pdflush-99      0.... 5000us : __might_sleep <-rt_spin_lock
 pdflush-99      0.... 5000us : rt_spin_lock_slowlock <-rt_spin_lock
 pdflush-99      0d..1 5000us : do_try_to_take_rt_mutex <-rt_spin_lock_slowlock
 pdflush-99      0.... 5000us : __put_super_and_need_restart <-writeback_inodes
 pdflush-99      0.... 5000us : rt_spin_unlock <-writeback_inodes
 pdflush-99      0.... 5000us : rt_spin_lock_slowunlock <-rt_spin_unlock
 pdflush-99      0.... 5000us : mod_timer <-wb_kupdate
 pdflush-99      0.... 5000us : lock_timer_base <-mod_timer
 pdflush-99      0.... 5000us : rt_spin_lock <-lock_timer_base
 pdflush-99      0.... 5000us : __might_sleep <-rt_spin_lock
 pdflush-99      0.... 5000us : rt_spin_lock_slowlock <-rt_spin_lock
 pdflush-99      0d..1 5000us : do_try_to_take_rt_mutex <-rt_spin_lock_slowlock
 pdflush-99      0.... 5000us : internal_add_timer <-mod_timer
 pdflush-99      0.... 5000us : rt_spin_unlock <-mod_timer
 pdflush-99      0.... 5000us : rt_spin_lock_slowunlock <-rt_spin_unlock
 pdflush-99      0.... 5000us : rt_spin_lock <-pdflush
 pdflush-99      0.... 5000us : __might_sleep <-rt_spin_lock
 pdflush-99      0.... 5000us : rt_spin_lock_slowlock <-rt_spin_lock
 pdflush-99      0d..1 5000us : do_try_to_take_rt_mutex <-rt_spin_lock_slowlock
 pdflush-99      0.... 5000us : rt_spin_unlock <-pdflush
 pdflush-99      0.... 5000us : rt_spin_lock_slowunlock <-rt_spin_unlock
 pdflush-99      0.... 5000us : schedule <-pdflush
 pdflush-99      0d... 5000us : __schedule <-schedule
 pdflush-99      0d... 5000us : rcu_qsctr_inc <-__schedule
 pdflush-99      0d..2 5000us : touch_softlockup_watchdog <-__schedule
 pdflush-99      0d..2 5000us : dequeue_task <-__schedule
 pdflush-99      0d..2 5000us : dequeue_task_fair <-dequeue_task
 pdflush-99      0d..2 5000us : update_curr <-dequeue_task_fair
 pdflush-99      0d..2 5000us : put_prev_task_fair <-__schedule
 pdflush-99      0d..2 5000us : pick_next_task_rt <-__schedule
 pdflush-99      0d..2 5000us : pick_next_task_fair <-__schedule
 pdflush-99      0d..2 5000us : pick_next_task_idle <-__schedule
 pdflush-99      0...1 5000us : __rcu_read_lock <-__atomic_notifier_call_chain
 pdflush-99      0...1 5000us : nwfpe_notify <-notifier_call_chain
 pdflush-99      0...1 5000us : __rcu_read_unlock <-__atomic_notifier_call_chain
  <idle>-0       0...1 5000us : finish_task_switch <-__schedule
  <idle>-0       0...1 5000us : default_idle <-cpu_idle
  <idle>-0       0d..2 5000us : _text <-__irq_svc
  <idle>-0       0d..2 5000us : irq_enter <-_text
  <idle>-0       0d..2 5000us : idle_cpu <-irq_enter
  <idle>-0       0d.h2 5000us : tick_check_idle <-irq_enter
  <idle>-0       0d.h2 5000us : irq_to_desc <-_text
  <idle>-0       0d.h2 5000us : handle_level_irq <-_text
  <idle>-0       0d.h3 5000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 5000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 5000us : redirect_hardirq <-handle_level_irq
  <idle>-0       0d.h2 5000us : handle_IRQ_event <-handle_level_irq
  <idle>-0       0d.h2 5000us : ch2_irq <-handle_IRQ_event
  <idle>-0       0d.h2 5000us : hrtimer_interrupt <-ch2_irq
  <idle>-0       0d.h2 5000us : ktime_get <-hrtimer_interrupt
  <idle>-0       0d.h2 5000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 5000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 5000us : hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0d.h3 5000us : __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0d.h3 5000us : __remove_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 5000us : tick_sched_timer <-__run_hrtimer
  <idle>-0       0d.h2 5000us : ktime_get <-tick_sched_timer
  <idle>-0       0d.h2 5000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 5000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 5000us!: do_timer <-tick_sched_timer
  <idle>-0       0d.h3 10000us : update_wall_time <-do_timer
  <idle>-0       0d.h3 10000us : tc_get_cycles <-update_wall_time
  <idle>-0       0d.h3 10000us : clocksource_get_next <-update_wall_time
  <idle>-0       0d.h3 10000us : calc_global_load <-do_timer
  <idle>-0       0d.h2 10000us : update_process_times <-tick_sched_timer
  <idle>-0       0d.h2 10000us : account_process_tick <-update_process_times
  <idle>-0       0d.h2 10000us : scheduler_tick <-update_process_times
  <idle>-0       0d.h2 10000us : run_local_timers <-update_process_times
  <idle>-0       0d.h2 10000us : hrtimer_run_queues <-run_local_timers
  <idle>-0       0d.h2 10000us : raise_softirq <-run_local_timers
  <idle>-0       0d.h2 10000us : softlockup_tick <-run_local_timers
  <idle>-0       0d.h2 10000us : rcu_pending <-update_process_times
  <idle>-0       0d.h2 10000us : run_posix_cpu_timers <-update_process_times
  <idle>-0       0d.h2 10000us : hrtimer_forward <-tick_sched_timer
  <idle>-0       0d.h2 10000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h2 10000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h3 10000us : enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 10000us : tick_program_event <-hrtimer_interrupt
  <idle>-0       0d.h2 10000us : tick_dev_program_event <-tick_program_event
  <idle>-0       0d.h2 10000us : ktime_get <-tick_dev_program_event
  <idle>-0       0d.h2 10000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 10000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h2 10000us : clockevents_program_event
<-tick_dev_program_event
  <idle>-0       0d.h2 10000us : tc_next_event <-clockevents_program_event
  <idle>-0       0d.h2 10000us : note_interrupt <-handle_level_irq
  <idle>-0       0d.h3 10000us : at91_aic_unmask_irq <-handle_level_irq
  <idle>-0       0d.h2 10000us : irq_exit <-_text
  <idle>-0       0d..3 10000us : __do_softirq <-irq_exit
  <idle>-0       0d..3 10000us : trigger_softirqs <-__do_softirq
  <idle>-0       0...1 10000us : default_idle <-cpu_idle
  <idle>-0       0d..2 10000us : _text <-__irq_svc
  <idle>-0       0d..2 10000us : irq_enter <-_text
  <idle>-0       0d..2 10000us : idle_cpu <-irq_enter
  <idle>-0       0d.h2 10000us : tick_check_idle <-irq_enter
  <idle>-0       0d.h2 10000us : irq_to_desc <-_text
  <idle>-0       0d.h2 10000us : handle_level_irq <-_text
  <idle>-0       0d.h3 10000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 10000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 10000us : redirect_hardirq <-handle_level_irq
  <idle>-0       0d.h2 10000us : handle_IRQ_event <-handle_level_irq
  <idle>-0       0d.h2 10000us : ch2_irq <-handle_IRQ_event
  <idle>-0       0d.h2 10000us : hrtimer_interrupt <-ch2_irq
  <idle>-0       0d.h2 10000us : ktime_get <-hrtimer_interrupt
  <idle>-0       0d.h2 10000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 10000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 10000us : hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0d.h3 10000us : __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0d.h3 10000us : __remove_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 10000us : tick_sched_timer <-__run_hrtimer
  <idle>-0       0d.h2 10000us : ktime_get <-tick_sched_timer
  <idle>-0       0d.h2 10000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 10000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 10000us!: do_timer <-tick_sched_timer
  <idle>-0       0d.h3 15000us : update_wall_time <-do_timer
  <idle>-0       0d.h3 15000us : tc_get_cycles <-update_wall_time
  <idle>-0       0d.h3 15000us : clocksource_get_next <-update_wall_time
  <idle>-0       0d.h3 15000us : calc_global_load <-do_timer
  <idle>-0       0d.h2 15000us : update_process_times <-tick_sched_timer
  <idle>-0       0d.h2 15000us : account_process_tick <-update_process_times
  <idle>-0       0d.h2 15000us : scheduler_tick <-update_process_times
  <idle>-0       0d.h2 15000us : run_local_timers <-update_process_times
  <idle>-0       0d.h2 15000us : hrtimer_run_queues <-run_local_timers
  <idle>-0       0d.h2 15000us : raise_softirq <-run_local_timers
  <idle>-0       0d.h2 15000us : softlockup_tick <-run_local_timers
  <idle>-0       0d.h2 15000us : rcu_pending <-update_process_times
  <idle>-0       0d.h2 15000us : run_posix_cpu_timers <-update_process_times
  <idle>-0       0d.h2 15000us : hrtimer_forward <-tick_sched_timer
  <idle>-0       0d.h2 15000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h2 15000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h3 15000us : enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 15000us : tick_program_event <-hrtimer_interrupt
  <idle>-0       0d.h2 15000us : tick_dev_program_event <-tick_program_event
  <idle>-0       0d.h2 15000us : ktime_get <-tick_dev_program_event
  <idle>-0       0d.h2 15000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 15000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h2 15000us : clockevents_program_event
<-tick_dev_program_event
  <idle>-0       0d.h2 15000us : tc_next_event <-clockevents_program_event
  <idle>-0       0d.h2 15000us : note_interrupt <-handle_level_irq
  <idle>-0       0d.h3 15000us : at91_aic_unmask_irq <-handle_level_irq
  <idle>-0       0d.h2 15000us : irq_exit <-_text
  <idle>-0       0d..3 15000us : __do_softirq <-irq_exit
  <idle>-0       0d..3 15000us : trigger_softirqs <-__do_softirq
  <idle>-0       0...1 15000us : default_idle <-cpu_idle
  <idle>-0       0d..2 15000us : _text <-__irq_svc
  <idle>-0       0d..2 15000us : irq_enter <-_text
  <idle>-0       0d..2 15000us : idle_cpu <-irq_enter
  <idle>-0       0d.h2 15000us : tick_check_idle <-irq_enter
  <idle>-0       0d.h2 15000us : irq_to_desc <-_text
  <idle>-0       0d.h2 15000us : handle_level_irq <-_text
  <idle>-0       0d.h3 15000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 15000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 15000us : redirect_hardirq <-handle_level_irq
  <idle>-0       0d.h2 15000us : handle_IRQ_event <-handle_level_irq
  <idle>-0       0d.h2 15000us : ch2_irq <-handle_IRQ_event
  <idle>-0       0d.h2 15000us : hrtimer_interrupt <-ch2_irq
  <idle>-0       0d.h2 15000us : ktime_get <-hrtimer_interrupt
  <idle>-0       0d.h2 15000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 15000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 15000us : hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0d.h3 15000us : __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0d.h3 15000us : __remove_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 15000us : tick_sched_timer <-__run_hrtimer
  <idle>-0       0d.h2 15000us : ktime_get <-tick_sched_timer
  <idle>-0       0d.h2 15000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 15000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 15000us!: do_timer <-tick_sched_timer
  <idle>-0       0d.h3 20000us : update_wall_time <-do_timer
  <idle>-0       0d.h3 20000us : tc_get_cycles <-update_wall_time
  <idle>-0       0d.h3 20000us : clocksource_get_next <-update_wall_time
  <idle>-0       0d.h3 20000us : calc_global_load <-do_timer
  <idle>-0       0d.h2 20000us : update_process_times <-tick_sched_timer
  <idle>-0       0d.h2 20000us : account_process_tick <-update_process_times
  <idle>-0       0d.h2 20000us : scheduler_tick <-update_process_times
  <idle>-0       0d.h2 20000us : run_local_timers <-update_process_times
  <idle>-0       0d.h2 20000us : hrtimer_run_queues <-run_local_timers
  <idle>-0       0d.h2 20000us : raise_softirq <-run_local_timers
  <idle>-0       0d.h2 20000us : softlockup_tick <-run_local_timers
  <idle>-0       0d.h2 20000us : rcu_pending <-update_process_times
  <idle>-0       0d.h2 20000us : run_posix_cpu_timers <-update_process_times
  <idle>-0       0d.h2 20000us : hrtimer_forward <-tick_sched_timer
  <idle>-0       0d.h2 20000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h2 20000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h3 20000us : enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 20000us : tick_program_event <-hrtimer_interrupt
  <idle>-0       0d.h2 20000us : tick_dev_program_event <-tick_program_event
  <idle>-0       0d.h2 20000us : ktime_get <-tick_dev_program_event
  <idle>-0       0d.h2 20000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 20000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h2 20000us : clockevents_program_event
<-tick_dev_program_event
  <idle>-0       0d.h2 20000us : tc_next_event <-clockevents_program_event
  <idle>-0       0d.h2 20000us : note_interrupt <-handle_level_irq
  <idle>-0       0d.h3 20000us : at91_aic_unmask_irq <-handle_level_irq
  <idle>-0       0d.h2 20000us : irq_exit <-_text
  <idle>-0       0d..3 20000us : __do_softirq <-irq_exit
  <idle>-0       0d..3 20000us : trigger_softirqs <-__do_softirq
  <idle>-0       0...1 20000us : default_idle <-cpu_idle
  <idle>-0       0d..2 20000us : _text <-__irq_svc
  <idle>-0       0d..2 20000us : irq_enter <-_text
  <idle>-0       0d..2 20000us : idle_cpu <-irq_enter
  <idle>-0       0d.h2 20000us : tick_check_idle <-irq_enter
  <idle>-0       0d.h2 20000us : irq_to_desc <-_text
  <idle>-0       0d.h2 20000us : handle_level_irq <-_text
  <idle>-0       0d.h3 20000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 20000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 20000us : redirect_hardirq <-handle_level_irq
  <idle>-0       0d.h3 20000us : wake_up_process <-redirect_hardirq
  <idle>-0       0d.h3 20000us : try_to_wake_up <-wake_up_process
  <idle>-0       0d.h3 20000us : task_rq_lock <-try_to_wake_up
  <idle>-0       0d.h4 20000us : activate_task <-try_to_wake_up
  <idle>-0       0d.h4 20000us : enqueue_task <-activate_task
  <idle>-0       0d.h4 20000us : enqueue_task_rt <-enqueue_task
  <idle>-0       0d.h4 20000us : dequeue_rt_stack <-enqueue_task_rt
  <idle>-0       0d.h4 20000us : check_preempt_curr_idle <-try_to_wake_up
  <idle>-0       0dNh3 20000us : preempt_schedule <-try_to_wake_up
  <idle>-0       0dNh2 20000us : preempt_schedule <-handle_level_irq
  <idle>-0       0dNh2 20000us : irq_exit <-_text
  <idle>-0       0dN.3 20000us : __do_softirq <-irq_exit
  <idle>-0       0dN.3 20000us : trigger_softirqs <-__do_softirq
  <idle>-0       0dN.. 20000us : __schedule <-cpu_idle
  <idle>-0       0dN.. 20000us : rcu_qsctr_inc <-__schedule
  <idle>-0       0d..2 20000us : put_prev_task_idle <-__schedule
  <idle>-0       0d..2 20000us : pick_next_task_rt <-__schedule
  <idle>-0       0d..2 20000us : pick_next_task_fair <-__schedule
  <idle>-0       0d..2 20000us : pick_next_task_idle <-__schedule
  <idle>-0       0...1 20000us : default_idle <-cpu_idle
  <idle>-0       0d..2 20000us : _text <-__irq_svc
  <idle>-0       0d..2 20000us : irq_enter <-_text
  <idle>-0       0d..2 20000us : idle_cpu <-irq_enter
  <idle>-0       0d.h2 20000us : tick_check_idle <-irq_enter
  <idle>-0       0d.h2 20000us : irq_to_desc <-_text
  <idle>-0       0d.h2 20000us : handle_level_irq <-_text
  <idle>-0       0d.h3 20000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 20000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 20000us : redirect_hardirq <-handle_level_irq
  <idle>-0       0d.h2 20000us : handle_IRQ_event <-handle_level_irq
  <idle>-0       0d.h2 20000us : ch2_irq <-handle_IRQ_event
  <idle>-0       0d.h2 20000us : hrtimer_interrupt <-ch2_irq
  <idle>-0       0d.h2 20000us : ktime_get <-hrtimer_interrupt
  <idle>-0       0d.h2 20000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 20000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 20000us : hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0d.h3 20000us : __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0d.h3 20000us : __remove_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 20000us : tick_sched_timer <-__run_hrtimer
  <idle>-0       0d.h2 20000us : ktime_get <-tick_sched_timer
  <idle>-0       0d.h2 20000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 20000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 20000us!: do_timer <-tick_sched_timer
  <idle>-0       0d.h3 25000us : update_wall_time <-do_timer
  <idle>-0       0d.h3 25000us : tc_get_cycles <-update_wall_time
  <idle>-0       0d.h3 25000us : clocksource_get_next <-update_wall_time
  <idle>-0       0d.h3 25000us : calc_global_load <-do_timer
  <idle>-0       0d.h2 25000us : update_process_times <-tick_sched_timer
  <idle>-0       0d.h2 25000us : account_process_tick <-update_process_times
  <idle>-0       0d.h2 25000us : scheduler_tick <-update_process_times
  <idle>-0       0d.h2 25000us : run_local_timers <-update_process_times
  <idle>-0       0d.h2 25000us : hrtimer_run_queues <-run_local_timers
  <idle>-0       0d.h2 25000us : raise_softirq <-run_local_timers
  <idle>-0       0d.h2 25000us : softlockup_tick <-run_local_timers
  <idle>-0       0d.h2 25000us : rcu_pending <-update_process_times
  <idle>-0       0d.h2 25000us : run_posix_cpu_timers <-update_process_times
  <idle>-0       0d.h2 25000us : hrtimer_forward <-tick_sched_timer
  <idle>-0       0d.h2 25000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h2 25000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h3 25000us : enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 25000us : tick_program_event <-hrtimer_interrupt
  <idle>-0       0d.h2 25000us : tick_dev_program_event <-tick_program_event
  <idle>-0       0d.h2 25000us : ktime_get <-tick_dev_program_event
  <idle>-0       0d.h2 25000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 25000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h2 25000us : clockevents_program_event
<-tick_dev_program_event
  <idle>-0       0d.h2 25000us : tc_next_event <-clockevents_program_event
  <idle>-0       0d.h2 25000us : note_interrupt <-handle_level_irq
  <idle>-0       0d.h3 25000us : at91_aic_unmask_irq <-handle_level_irq
  <idle>-0       0d.h2 25000us : irq_exit <-_text
  <idle>-0       0d..3 25000us : __do_softirq <-irq_exit
  <idle>-0       0d..3 25000us : trigger_softirqs <-__do_softirq
  <idle>-0       0...1 25000us : default_idle <-cpu_idle
  <idle>-0       0d..2 25000us : _text <-__irq_svc
  <idle>-0       0d..2 25000us : irq_enter <-_text
  <idle>-0       0d..2 25000us : idle_cpu <-irq_enter
  <idle>-0       0d.h2 25000us : tick_check_idle <-irq_enter
  <idle>-0       0d.h2 25000us : irq_to_desc <-_text
  <idle>-0       0d.h2 25000us : handle_level_irq <-_text
  <idle>-0       0d.h3 25000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 25000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 25000us : redirect_hardirq <-handle_level_irq
  <idle>-0       0d.h2 25000us : handle_IRQ_event <-handle_level_irq
  <idle>-0       0d.h2 25000us : ch2_irq <-handle_IRQ_event
  <idle>-0       0d.h2 25000us : hrtimer_interrupt <-ch2_irq
  <idle>-0       0d.h2 25000us : ktime_get <-hrtimer_interrupt
  <idle>-0       0d.h2 25000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 25000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 25000us : hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0d.h3 25000us : __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0d.h3 25000us : __remove_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 25000us : tick_sched_timer <-__run_hrtimer
  <idle>-0       0d.h2 25000us : ktime_get <-tick_sched_timer
  <idle>-0       0d.h2 25000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 25000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 25000us!: do_timer <-tick_sched_timer
  <idle>-0       0d.h3 30000us : update_wall_time <-do_timer
  <idle>-0       0d.h3 30000us : tc_get_cycles <-update_wall_time
  <idle>-0       0d.h3 30000us : clocksource_get_next <-update_wall_time
  <idle>-0       0d.h3 30000us : calc_global_load <-do_timer
  <idle>-0       0d.h2 30000us : update_process_times <-tick_sched_timer
  <idle>-0       0d.h2 30000us : account_process_tick <-update_process_times
  <idle>-0       0d.h2 30000us : scheduler_tick <-update_process_times
  <idle>-0       0d.h2 30000us : run_local_timers <-update_process_times
  <idle>-0       0d.h2 30000us : hrtimer_run_queues <-run_local_timers
  <idle>-0       0d.h2 30000us : raise_softirq <-run_local_timers
  <idle>-0       0d.h2 30000us : softlockup_tick <-run_local_timers
  <idle>-0       0d.h2 30000us : rcu_pending <-update_process_times
  <idle>-0       0d.h2 30000us : run_posix_cpu_timers <-update_process_times
  <idle>-0       0d.h2 30000us : hrtimer_forward <-tick_sched_timer
  <idle>-0       0d.h2 30000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h2 30000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h3 30000us : enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 30000us : tick_program_event <-hrtimer_interrupt
  <idle>-0       0d.h2 30000us : tick_dev_program_event <-tick_program_event
  <idle>-0       0d.h2 30000us : ktime_get <-tick_dev_program_event
  <idle>-0       0d.h2 30000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 30000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h2 30000us : clockevents_program_event
<-tick_dev_program_event
  <idle>-0       0d.h2 30000us : tc_next_event <-clockevents_program_event
  <idle>-0       0d.h2 30000us : note_interrupt <-handle_level_irq
  <idle>-0       0d.h3 30000us : at91_aic_unmask_irq <-handle_level_irq
  <idle>-0       0d.h2 30000us : irq_exit <-_text
  <idle>-0       0d..3 30000us : __do_softirq <-irq_exit
  <idle>-0       0d..3 30000us : trigger_softirqs <-__do_softirq
  <idle>-0       0...1 30000us : default_idle <-cpu_idle
  <idle>-0       0d..2 30000us : _text <-__irq_svc
  <idle>-0       0d..2 30000us : irq_enter <-_text
  <idle>-0       0d..2 30000us : idle_cpu <-irq_enter
  <idle>-0       0d.h2 30000us : tick_check_idle <-irq_enter
  <idle>-0       0d.h2 30000us : irq_to_desc <-_text
  <idle>-0       0d.h2 30000us : handle_level_irq <-_text
  <idle>-0       0d.h3 30000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 30000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 30000us : redirect_hardirq <-handle_level_irq
  <idle>-0       0d.h2 30000us : handle_IRQ_event <-handle_level_irq
  <idle>-0       0d.h2 30000us : ch2_irq <-handle_IRQ_event
  <idle>-0       0d.h2 30000us : hrtimer_interrupt <-ch2_irq
  <idle>-0       0d.h2 30000us : ktime_get <-hrtimer_interrupt
  <idle>-0       0d.h2 30000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 30000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 30000us : hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0d.h3 30000us : __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0d.h3 30000us : __remove_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 30000us : tick_sched_timer <-__run_hrtimer
  <idle>-0       0d.h2 30000us : ktime_get <-tick_sched_timer
  <idle>-0       0d.h2 30000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 30000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 30000us!: do_timer <-tick_sched_timer
  <idle>-0       0d.h3 35000us : update_wall_time <-do_timer
  <idle>-0       0d.h3 35000us : tc_get_cycles <-update_wall_time
  <idle>-0       0d.h3 35000us : clocksource_get_next <-update_wall_time
  <idle>-0       0d.h3 35000us : calc_global_load <-do_timer
  <idle>-0       0d.h2 35000us : update_process_times <-tick_sched_timer
  <idle>-0       0d.h2 35000us : account_process_tick <-update_process_times
  <idle>-0       0d.h2 35000us : scheduler_tick <-update_process_times
  <idle>-0       0d.h2 35000us : run_local_timers <-update_process_times
  <idle>-0       0d.h2 35000us : hrtimer_run_queues <-run_local_timers
  <idle>-0       0d.h2 35000us : raise_softirq <-run_local_timers
  <idle>-0       0d.h2 35000us : softlockup_tick <-run_local_timers
  <idle>-0       0d.h2 35000us : rcu_pending <-update_process_times
  <idle>-0       0d.h2 35000us : run_posix_cpu_timers <-update_process_times
  <idle>-0       0d.h2 35000us : hrtimer_forward <-tick_sched_timer
  <idle>-0       0d.h2 35000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h2 35000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h3 35000us : enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 35000us : tick_program_event <-hrtimer_interrupt
  <idle>-0       0d.h2 35000us : tick_dev_program_event <-tick_program_event
  <idle>-0       0d.h2 35000us : ktime_get <-tick_dev_program_event
  <idle>-0       0d.h2 35000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 35000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h2 35000us : clockevents_program_event
<-tick_dev_program_event
  <idle>-0       0d.h2 35000us : tc_next_event <-clockevents_program_event
  <idle>-0       0d.h2 35000us : note_interrupt <-handle_level_irq
  <idle>-0       0d.h3 35000us : at91_aic_unmask_irq <-handle_level_irq
  <idle>-0       0d.h2 35000us : irq_exit <-_text
  <idle>-0       0d..3 35000us : __do_softirq <-irq_exit
  <idle>-0       0d..3 35000us : trigger_softirqs <-__do_softirq
  <idle>-0       0...1 35000us : default_idle <-cpu_idle
  <idle>-0       0d..2 35000us : _text <-__irq_svc
  <idle>-0       0d..2 35000us : irq_enter <-_text
  <idle>-0       0d..2 35000us : idle_cpu <-irq_enter
  <idle>-0       0d.h2 35000us : tick_check_idle <-irq_enter
  <idle>-0       0d.h2 35000us : irq_to_desc <-_text
  <idle>-0       0d.h2 35000us : handle_level_irq <-_text
  <idle>-0       0d.h3 35000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 35000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 35000us : redirect_hardirq <-handle_level_irq
  <idle>-0       0d.h2 35000us : handle_IRQ_event <-handle_level_irq
  <idle>-0       0d.h2 35000us : ch2_irq <-handle_IRQ_event
  <idle>-0       0d.h2 35000us : hrtimer_interrupt <-ch2_irq
  <idle>-0       0d.h2 35000us : ktime_get <-hrtimer_interrupt
  <idle>-0       0d.h2 35000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 35000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 35000us : hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0d.h3 35000us : __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0d.h3 35000us : __remove_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 35000us : tick_sched_timer <-__run_hrtimer
  <idle>-0       0d.h2 35000us : ktime_get <-tick_sched_timer
  <idle>-0       0d.h2 35000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 35000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 35000us!: do_timer <-tick_sched_timer
  <idle>-0       0d.h3 40000us : update_wall_time <-do_timer
  <idle>-0       0d.h3 40000us : tc_get_cycles <-update_wall_time
  <idle>-0       0d.h3 40000us : clocksource_get_next <-update_wall_time
  <idle>-0       0d.h3 40000us : calc_global_load <-do_timer
  <idle>-0       0d.h2 40000us : update_process_times <-tick_sched_timer
  <idle>-0       0d.h2 40000us : account_process_tick <-update_process_times
  <idle>-0       0d.h2 40000us : scheduler_tick <-update_process_times
  <idle>-0       0d.h2 40000us : run_local_timers <-update_process_times
  <idle>-0       0d.h2 40000us : hrtimer_run_queues <-run_local_timers
  <idle>-0       0d.h2 40000us : raise_softirq <-run_local_timers
  <idle>-0       0d.h2 40000us : softlockup_tick <-run_local_timers
  <idle>-0       0d.h2 40000us : rcu_pending <-update_process_times
  <idle>-0       0d.h2 40000us : run_posix_cpu_timers <-update_process_times
  <idle>-0       0d.h2 40000us : hrtimer_forward <-tick_sched_timer
  <idle>-0       0d.h2 40000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h2 40000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h3 40000us : enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 40000us : tick_program_event <-hrtimer_interrupt
  <idle>-0       0d.h2 40000us : tick_dev_program_event <-tick_program_event
  <idle>-0       0d.h2 40000us : ktime_get <-tick_dev_program_event
  <idle>-0       0d.h2 40000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 40000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h2 40000us : clockevents_program_event
<-tick_dev_program_event
  <idle>-0       0d.h2 40000us : tc_next_event <-clockevents_program_event
  <idle>-0       0d.h2 40000us : note_interrupt <-handle_level_irq
  <idle>-0       0d.h3 40000us : at91_aic_unmask_irq <-handle_level_irq
  <idle>-0       0d.h2 40000us : irq_exit <-_text
  <idle>-0       0d..3 40000us : __do_softirq <-irq_exit
  <idle>-0       0d..3 40000us : trigger_softirqs <-__do_softirq
  <idle>-0       0...1 40000us : default_idle <-cpu_idle
  <idle>-0       0d..2 40000us : _text <-__irq_svc
  <idle>-0       0d..2 40000us : irq_enter <-_text
  <idle>-0       0d..2 40000us : idle_cpu <-irq_enter
  <idle>-0       0d.h2 40000us : tick_check_idle <-irq_enter
  <idle>-0       0d.h2 40000us : irq_to_desc <-_text
  <idle>-0       0d.h2 40000us : handle_level_irq <-_text
  <idle>-0       0d.h3 40000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 40000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 40000us : redirect_hardirq <-handle_level_irq
  <idle>-0       0d.h2 40000us : handle_IRQ_event <-handle_level_irq
  <idle>-0       0d.h2 40000us : ch2_irq <-handle_IRQ_event
  <idle>-0       0d.h2 40000us : hrtimer_interrupt <-ch2_irq
  <idle>-0       0d.h2 40000us : ktime_get <-hrtimer_interrupt
  <idle>-0       0d.h2 40000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 40000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 40000us : hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0d.h3 40000us : __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0d.h3 40000us : __remove_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 40000us : tick_sched_timer <-__run_hrtimer
  <idle>-0       0d.h2 40000us : ktime_get <-tick_sched_timer
  <idle>-0       0d.h2 40000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 40000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 40000us!: do_timer <-tick_sched_timer
  <idle>-0       0d.h3 45000us : update_wall_time <-do_timer
  <idle>-0       0d.h3 45000us : tc_get_cycles <-update_wall_time
  <idle>-0       0d.h3 45000us : clocksource_get_next <-update_wall_time
  <idle>-0       0d.h3 45000us : calc_global_load <-do_timer
  <idle>-0       0d.h2 45000us : update_process_times <-tick_sched_timer
  <idle>-0       0d.h2 45000us : account_process_tick <-update_process_times
  <idle>-0       0d.h2 45000us : scheduler_tick <-update_process_times
  <idle>-0       0d.h2 45000us : run_local_timers <-update_process_times
  <idle>-0       0d.h2 45000us : hrtimer_run_queues <-run_local_timers
  <idle>-0       0d.h2 45000us : raise_softirq <-run_local_timers
  <idle>-0       0d.h2 45000us : softlockup_tick <-run_local_timers
  <idle>-0       0d.h2 45000us : rcu_pending <-update_process_times
  <idle>-0       0d.h2 45000us : run_posix_cpu_timers <-update_process_times
  <idle>-0       0d.h2 45000us : hrtimer_forward <-tick_sched_timer
  <idle>-0       0d.h2 45000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h2 45000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h3 45000us : enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 45000us : tick_program_event <-hrtimer_interrupt
  <idle>-0       0d.h2 45000us : tick_dev_program_event <-tick_program_event
  <idle>-0       0d.h2 45000us : ktime_get <-tick_dev_program_event
  <idle>-0       0d.h2 45000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 45000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h2 45000us : clockevents_program_event
<-tick_dev_program_event
  <idle>-0       0d.h2 45000us : tc_next_event <-clockevents_program_event
  <idle>-0       0d.h2 45000us : note_interrupt <-handle_level_irq
  <idle>-0       0d.h3 45000us : at91_aic_unmask_irq <-handle_level_irq
  <idle>-0       0d.h2 45000us : irq_exit <-_text
  <idle>-0       0d..3 45000us : __do_softirq <-irq_exit
  <idle>-0       0d..3 45000us : trigger_softirqs <-__do_softirq
  <idle>-0       0...1 45000us : default_idle <-cpu_idle
  <idle>-0       0d..2 45000us : _text <-__irq_svc
  <idle>-0       0d..2 45000us : irq_enter <-_text
  <idle>-0       0d..2 45000us : idle_cpu <-irq_enter
  <idle>-0       0d.h2 45000us : tick_check_idle <-irq_enter
  <idle>-0       0d.h2 45000us : irq_to_desc <-_text
  <idle>-0       0d.h2 45000us : handle_level_irq <-_text
  <idle>-0       0d.h3 45000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 45000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 45000us : redirect_hardirq <-handle_level_irq
  <idle>-0       0d.h2 45000us : handle_IRQ_event <-handle_level_irq
  <idle>-0       0d.h2 45000us : ch2_irq <-handle_IRQ_event
  <idle>-0       0d.h2 45000us : hrtimer_interrupt <-ch2_irq
  <idle>-0       0d.h2 45000us : ktime_get <-hrtimer_interrupt
  <idle>-0       0d.h2 45000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 45000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 45000us : hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0d.h3 45000us : __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0d.h3 45000us : __remove_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 45000us : tick_sched_timer <-__run_hrtimer
  <idle>-0       0d.h2 45000us : ktime_get <-tick_sched_timer
  <idle>-0       0d.h2 45000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 45000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 45000us!: do_timer <-tick_sched_timer
  <idle>-0       0d.h3 50000us : update_wall_time <-do_timer
  <idle>-0       0d.h3 50000us : tc_get_cycles <-update_wall_time
  <idle>-0       0d.h3 50000us : clocksource_get_next <-update_wall_time
  <idle>-0       0d.h3 50000us : calc_global_load <-do_timer
  <idle>-0       0d.h2 50000us : update_process_times <-tick_sched_timer
  <idle>-0       0d.h2 50000us : account_process_tick <-update_process_times
  <idle>-0       0d.h2 50000us : scheduler_tick <-update_process_times
  <idle>-0       0d.h2 50000us : run_local_timers <-update_process_times
  <idle>-0       0d.h2 50000us : hrtimer_run_queues <-run_local_timers
  <idle>-0       0d.h2 50000us : raise_softirq <-run_local_timers
  <idle>-0       0d.h2 50000us : softlockup_tick <-run_local_timers
  <idle>-0       0d.h2 50000us : rcu_pending <-update_process_times
  <idle>-0       0d.h2 50000us : run_posix_cpu_timers <-update_process_times
  <idle>-0       0d.h2 50000us : hrtimer_forward <-tick_sched_timer
  <idle>-0       0d.h2 50000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h2 50000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h3 50000us : enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 50000us : tick_program_event <-hrtimer_interrupt
  <idle>-0       0d.h2 50000us : tick_dev_program_event <-tick_program_event
  <idle>-0       0d.h2 50000us : ktime_get <-tick_dev_program_event
  <idle>-0       0d.h2 50000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 50000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h2 50000us : clockevents_program_event
<-tick_dev_program_event
  <idle>-0       0d.h2 50000us : tc_next_event <-clockevents_program_event
  <idle>-0       0d.h2 50000us : note_interrupt <-handle_level_irq
  <idle>-0       0d.h3 50000us : at91_aic_unmask_irq <-handle_level_irq
  <idle>-0       0d.h2 50000us : irq_exit <-_text
  <idle>-0       0d..3 50000us : __do_softirq <-irq_exit
  <idle>-0       0d..3 50000us : trigger_softirqs <-__do_softirq
  <idle>-0       0...1 50000us : default_idle <-cpu_idle
  <idle>-0       0d..2 50000us : _text <-__irq_svc
  <idle>-0       0d..2 50000us : irq_enter <-_text
  <idle>-0       0d..2 50000us : idle_cpu <-irq_enter
  <idle>-0       0d.h2 50000us : tick_check_idle <-irq_enter
  <idle>-0       0d.h2 50000us : irq_to_desc <-_text
  <idle>-0       0d.h2 50000us : handle_level_irq <-_text
  <idle>-0       0d.h3 50000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 50000us : at91_aic_mask_irq <-handle_level_irq
  <idle>-0       0d.h3 50000us : redirect_hardirq <-handle_level_irq
  <idle>-0       0d.h2 50000us : handle_IRQ_event <-handle_level_irq
  <idle>-0       0d.h2 50000us : ch2_irq <-handle_IRQ_event
  <idle>-0       0d.h2 50000us : hrtimer_interrupt <-ch2_irq
  <idle>-0       0d.h2 50000us : ktime_get <-hrtimer_interrupt
  <idle>-0       0d.h2 50000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 50000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h3 50000us : hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0d.h3 50000us : __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0d.h3 50000us : __remove_hrtimer <-__run_hrtimer
  <idle>-0       0d.h2 50000us : sched_rt_period_timer <-__run_hrtimer
  <idle>-0       0d.h2 50000us : ktime_get <-sched_rt_period_timer
  <idle>-0       0d.h2 50000us : tc_get_cycles <-ktime_get
  <idle>-0       0d.h2 50000us : ktime_add_ns <-ktime_get
  <idle>-0       0d.h2 50000us : hrtimer_forward <-sched_rt_period_timer
  <idle>-0       0d.h2 50000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0d.h2 50000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0dNh2 50000us : preempt_schedule <-sched_rt_period_timer
  <idle>-0       0dNh2 50000us : ktime_get <-sched_rt_period_timer
  <idle>-0       0dNh2 50000us : tc_get_cycles <-ktime_get
  <idle>-0       0dNh2 50000us : ktime_add_ns <-ktime_get
  <idle>-0       0dNh2 50000us : hrtimer_forward <-sched_rt_period_timer
  <idle>-0       0dNh3 50000us : enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0dNh3 50000us : hrtimer_rt_defer <-hrtimer_interrupt
  <idle>-0       0dNh3 50000us : __run_hrtimer <-hrtimer_interrupt
  <idle>-0       0dNh3 50000us : __remove_hrtimer <-__run_hrtimer
  <idle>-0       0dNh2 50000us : preempt_schedule <-__run_hrtimer
  <idle>-0       0dNh2 50000us : tick_sched_timer <-__run_hrtimer
  <idle>-0       0dNh2 50000us : ktime_get <-tick_sched_timer
  <idle>-0       0dNh2 50000us : tc_get_cycles <-ktime_get
  <idle>-0       0dNh2 50000us : ktime_add_ns <-ktime_get
  <idle>-0       0dNh3 50000us!: do_timer <-tick_sched_timer
  <idle>-0       0dNh3 55000us : update_wall_time <-do_timer
  <idle>-0       0dNh3 55000us : tc_get_cycles <-update_wall_time
  <idle>-0       0dNh3 55000us : second_overflow <-update_wall_time
  <idle>-0       0dNh3 55000us : clocksource_get_next <-update_wall_time
  <idle>-0       0dNh3 55000us : preempt_schedule <-clocksource_get_next
  <idle>-0       0dNh3 55000us : calc_global_load <-do_timer
  <idle>-0       0dNh2 55000us : preempt_schedule <-tick_sched_timer
  <idle>-0       0dNh2 55000us : update_process_times <-tick_sched_timer
  <idle>-0       0dNh2 55000us : account_process_tick <-update_process_times
  <idle>-0       0dNh2 55000us : scheduler_tick <-update_process_times
  <idle>-0       0dNh2 55000us : preempt_schedule <-scheduler_tick
  <idle>-0       0dNh2 55000us : run_local_timers <-update_process_times
  <idle>-0       0dNh2 55000us : hrtimer_run_queues <-run_local_timers
  <idle>-0       0dNh2 55000us : raise_softirq <-run_local_timers
  <idle>-0       0dNh2 55000us : softlockup_tick <-run_local_timers
  <idle>-0       0dNh2 55000us : rcu_pending <-update_process_times
  <idle>-0       0dNh2 55000us : run_posix_cpu_timers <-update_process_times
  <idle>-0       0dNh2 55000us : hrtimer_forward <-tick_sched_timer
  <idle>-0       0dNh2 55000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0dNh2 55000us : ktime_add_safe <-hrtimer_forward
  <idle>-0       0dNh3 55000us : enqueue_hrtimer <-__run_hrtimer
  <idle>-0       0dNh2 55000us : preempt_schedule <-hrtimer_interrupt
  <idle>-0       0dNh2 55000us : tick_program_event <-hrtimer_interrupt
  <idle>-0       0dNh2 55000us : tick_dev_program_event <-tick_program_event
  <idle>-0       0dNh2 55000us : ktime_get <-tick_dev_program_event
  <idle>-0       0dNh2 55000us : tc_get_cycles <-ktime_get
  <idle>-0       0dNh2 55000us : ktime_add_ns <-ktime_get
  <idle>-0       0dNh2 55000us : clockevents_program_event
<-tick_dev_program_event
  <idle>-0       0dNh2 55000us : tc_next_event <-clockevents_program_event
  <idle>-0       0dNh2 55000us : note_interrupt <-handle_level_irq
  <idle>-0       0dNh3 55000us : at91_aic_unmask_irq <-handle_level_irq
  <idle>-0       0dNh2 55000us : preempt_schedule <-handle_level_irq
  <idle>-0       0dNh2 55000us : irq_exit <-_text
  <idle>-0       0dN.3 55000us : __do_softirq <-irq_exit
  <idle>-0       0dN.3 55000us : trigger_softirqs <-__do_softirq
  <idle>-0       0dN.. 55000us : __schedule <-cpu_idle
  <idle>-0       0dN.. 55000us : rcu_qsctr_inc <-__schedule
  <idle>-0       0d..2 55000us : put_prev_task_idle <-__schedule
  <idle>-0       0d..2 55000us : pick_next_task_rt <-__schedule
  <idle>-0       0...2 55000us : cpu_idle <-rest_init
  <idle>-0       0...2 55000us :      0:140:R ==> [000]   247: 19:R test
