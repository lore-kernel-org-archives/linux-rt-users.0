From: <Martin.Wirth@dlr.de>
Subject: Large latencies with 4.4.1-rt6
Date: Fri, 19 Feb 2016 17:02:20 +0000
Message-ID: <1A2AF5F768264E479963C4D8C015EB691B692C5C@dlrexmbx03.intra.dlr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailhost.dlr.de ([129.247.252.33]:45645 "EHLO mailhost.dlr.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1427111AbcBSRHv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Feb 2016 12:07:51 -0500
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I today switched from 4.1.15-rt17 to 4.4.1-rt6.
Now I'm seeing large latencies of more than 1 ms.
They occur sporadic ( every few minutes) and show up for example running 

cyclictest -l10000000 -m -Sp99 -i200

I tried to catch a trace and got the following: 


# tracer: preemptoff
#
# preemptoff latency trace v1.1.5 on 4.4.1-rt6+
# --------------------------------------------------------------------
# latency: 1099 us, #79/79, CPU#2 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:4)
#    -----------------
#    | task: firefox-3736 (uid:1001 nice:0 policy:0 rt_prio:0)
#    -----------------
#  => started at: worker_thread
#  => ended at:   smp_apic_timer_interrupt
#
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
   <...>-3709    2....1..    0us : schedule <-worker_thread
   <...>-3709    2d...1..    0us : preempt_count_add <-_raw_spin_lock_irq
   <...>-3709    2d...2..    0us : deactivate_task <-__schedule
   <...>-3709    2d...2..    0us : update_rq_clock.part.88 <-deactivate_task
   <...>-3709    2d...2..    1us : dequeue_task_fair <-deactivate_task
   <...>-3709    2d...2..    1us : update_curr <-dequeue_task_fair
   <...>-3709    2d...2..    1us : update_min_vruntime <-update_curr
   <...>-3709    2d...2..    1us : clear_buddies <-dequeue_task_fair
   <...>-3709    2d...2..    1us : account_entity_dequeue <-dequeue_task_fair
   <...>-3709    2d...2..    1us : update_min_vruntime <-dequeue_task_fair
   <...>-3709    2d...2..    1us : update_cfs_shares <-dequeue_task_fair
   <...>-3709    2d...2..    1us : hrtick_update <-dequeue_task_fair
   <...>-3709    2d...2..    2us : pick_next_task_fair <-__schedule
   <...>-3709    2d...2..    2us : pick_next_entity <-pick_next_task_fair
   <...>-3709    2d...2..    2us : clear_buddies <-pick_next_entity
   <...>-3709    2d...2..    2us : pick_next_entity <-pick_next_task_fair
   <...>-3709    2d...2..    2us : clear_buddies <-pick_next_entity
   <...>-3709    2d...2..    2us : set_next_entity <-pick_next_task_fair
   <...>-3709    2d...2..    2us : update_stats_wait_end <-set_next_entity
   <...>-3709    2d...2..    2us : put_prev_entity <-pick_next_task_fair
   <...>-3709    2d...2..    2us : set_next_entity <-pick_next_task_fair
   <...>-3709    2d...2..    2us : update_stats_wait_end <-set_next_entity
 firefox-3736    2d...2..    3us : finish_task_switch <-__schedule
 firefox-3736    2d...2..    3us#: _raw_spin_unlock_irq <-finish_task_switch
 firefox-3736    2d...... 1091us : smp_apic_timer_interrupt <-apic_timer_interrupt
 firefox-3736    2d...... 1092us : irq_enter <-smp_apic_timer_interrupt
 firefox-3736    2d...... 1092us : rcu_irq_enter <-irq_enter
 firefox-3736    2d...... 1092us : irqtime_account_irq <-irq_enter
 firefox-3736    2d...... 1092us : in_serving_softirq <-irqtime_account_irq
 firefox-3736    2d...... 1092us : preempt_count_add <-irq_enter
 firefox-3736    2d..h... 1093us : exit_idle <-smp_apic_timer_interrupt
 firefox-3736    2d..h... 1093us : local_apic_timer_interrupt <-smp_apic_timer_interrupt
 firefox-3736    2d..h... 1093us : hrtimer_interrupt <-local_apic_timer_interrupt
 firefox-3736    2d..h... 1093us : _raw_spin_lock <-hrtimer_interrupt
 firefox-3736    2d..h... 1093us : preempt_count_add <-_raw_spin_lock
 firefox-3736    2d..h1.. 1093us : ktime_get_update_offsets_now <-hrtimer_interrupt
 firefox-3736    2d..h1.. 1093us : __hrtimer_run_queues <-hrtimer_interrupt
 firefox-3736    2d..h1.. 1094us : __remove_hrtimer <-__hrtimer_run_queues
 firefox-3736    2d..h1.. 1094us : preempt_count_sub <-__hrtimer_run_queues
 firefox-3736    2d..h... 1094us : hrtimer_wakeup <-__hrtimer_run_queues
 firefox-3736    2d..h... 1094us : wake_up_process <-hrtimer_wakeup
 firefox-3736    2d..h... 1094us : try_to_wake_up <-wake_up_process
 firefox-3736    2d..h... 1094us : _raw_spin_lock_irqsave <-try_to_wake_up
 firefox-3736    2d..h... 1094us : preempt_count_add <-_raw_spin_lock_irqsave
 firefox-3736    2d..h1.. 1095us : _raw_spin_lock <-try_to_wake_up
 firefox-3736    2d..h1.. 1095us : preempt_count_add <-_raw_spin_lock
 firefox-3736    2d..h2.. 1095us : ttwu_do_activate.constprop.102 <-try_to_wake_up
 firefox-3736    2d..h2.. 1095us : activate_task <-ttwu_do_activate.constprop.102
 firefox-3736    2d..h2.. 1095us : update_rq_clock.part.88 <-activate_task
 firefox-3736    2d..h2.. 1095us : enqueue_task_rt <-activate_task
 firefox-3736    2d..h2.. 1095us : dequeue_rt_stack <-enqueue_task_rt
 firefox-3736    2d..h2.. 1095us : dequeue_top_rt_rq <-dequeue_rt_stack
 firefox-3736    2d..h2.. 1096us : cpupri_set <-enqueue_task_rt
 firefox-3736    2d..h2.. 1096us : update_rt_migration <-enqueue_task_rt
 firefox-3736    2d..h2.. 1096us : _raw_spin_lock <-enqueue_task_rt
 firefox-3736    2d..h2.. 1096us : preempt_count_add <-_raw_spin_lock
 firefox-3736    2d..h3.. 1096us : preempt_count_sub <-enqueue_task_rt
 firefox-3736    2d..h2.. 1096us : enqueue_top_rt_rq <-enqueue_task_rt
 firefox-3736    2d..h2.. 1096us : ttwu_do_wakeup <-ttwu_do_activate.constprop.102
 firefox-3736    2d..h2.. 1097us : check_preempt_curr <-ttwu_do_wakeup
 firefox-3736    2d..h2.. 1097us : resched_curr <-check_preempt_curr
 firefox-3736    2dN.h2.. 1097us : task_woken_rt <-ttwu_do_wakeup
 firefox-3736    2dN.h2.. 1097us : preempt_count_sub <-try_to_wake_up
 firefox-3736    2dN.h1.. 1097us : _raw_spin_unlock_irqrestore <-try_to_wake_up
 firefox-3736    2dN.h1.. 1097us : preempt_count_sub <-_raw_spin_unlock_irqrestore
 firefox-3736    2dN.h... 1097us : _raw_spin_lock <-__hrtimer_run_queues
 firefox-3736    2dN.h... 1097us : preempt_count_add <-_raw_spin_lock
 firefox-3736    2dN.h1.. 1098us : __hrtimer_get_next_event <-hrtimer_interrupt
 firefox-3736    2dN.h1.. 1098us : preempt_count_sub <-hrtimer_interrupt
 firefox-3736    2dN.h... 1098us : tick_program_event <-hrtimer_interrupt
 firefox-3736    2dN.h... 1098us : clockevents_program_event <-tick_program_event
 firefox-3736    2dN.h... 1098us : ktime_get <-clockevents_program_event
 firefox-3736    2dN.h... 1098us : lapic_next_deadline <-clockevents_program_event
 firefox-3736    2dN.h... 1099us : irq_exit <-smp_apic_timer_interrupt
 firefox-3736    2dN.h... 1099us : irqtime_account_irq <-irq_exit
 firefox-3736    2dN.h... 1099us : preempt_count_sub <-irq_exit
 firefox-3736    2dN.h... 1099us : irq_exit <-smp_apic_timer_interrupt
 firefox-3736    2dN.h... 1099us : trace_preempt_on <-smp_apic_timer_interrupt
 firefox-3736    2dN.h... 1106us : <stack trace>
 => preempt_count_sub
 => irq_exit
 => smp_apic_timer_interrupt
 => apic_timer_interrupt

This is a i7-4700EQ CPU @ 2.40GHz machine  

uname -a output is
Linux su02li 4.4.1-rt6+ #26 SMP PREEMPT RT Fri Feb 19 16:05:57 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

Does the above trace ring a bell or is it useless?

Thanks,

Martin



