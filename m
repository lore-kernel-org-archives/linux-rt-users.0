From: Christoph Mathys <eraserix@gmail.com>
Subject: 4.4.23-rt33: High latencies when settings RCU_KTHREAD_PRIO equal or
 higher than rt application priority
Date: Wed, 19 Oct 2016 10:55:11 +0200
Message-ID: <CALqGcGopV+Za7ahfBqneXbfBPPo8GdtqNt0VppsF-5aYpmmW-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:33753 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941327AbcJSOSl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Oct 2016 10:18:41 -0400
Received: by mail-io0-f175.google.com with SMTP id q192so33161542iod.0
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Oct 2016 07:18:41 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

I changed RCU_KTHREAD_PRIO to 99 from the default setting of 1. I now
observe cyclictest latencies of above 100us (16ms was the worst so
far). Before the change the systems max latency is below 30us. The
problem shows up when cyclictest has an equal or lower priority than
the RCU threads. RCU boosting is enabled (default).

I don't see that behaviour on 3.12 with RCU_BOOST_PRIO=99. I could
reproduce the behaviour on a Intel i7 and an Intel Celeron Dualcore.
On i7 it usually happens within a couple of minutes.

Below are some excerpts from traces with cyclictest/ftrace showing the
latency spikes. I hope I did not cut out too much interesting details.

Here is a cyclictest --context excerpt. It looks like rcuc/0-11 is
running for 249us before cyclictest gets the cpu.
cyclicte-4267    0d...2.. 228623933us+: sched_switch:
prev_comm=cyclictest prev_pid=4267 prev_prio=0 prev_state=S ==>
next_comm=swapper/0 next_pid=0 next_prio=120
  <idle>-0       0d...2.. 228623945us : sched_switch:
prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==>
next_comm=compiz next_pid=3178 next_prio=120
  compiz-3178    0d...2.. 228623950us : sched_switch: prev_comm=compiz
prev_pid=3178 prev_prio=120 prev_state=S ==> next_comm=swapper/0
next_pid=0 next_prio=120
  <idle>-0       0d...2.. 228623954us+: sched_switch:
prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==>
next_comm=compiz next_pid=3178 next_prio=120
  compiz-3178    0d...2.. 228624004us+: sched_switch: prev_comm=compiz
prev_pid=3178 prev_prio=120 prev_state=S ==> next_comm=swapper/0
next_pid=0 next_prio=120
  <idle>-0       0dN.h3.. 228624031us : sched_wakeup: comm=cyclictest
pid=4267 prio=0 target_cpu=000
  <idle>-0       0d...2.. 228624032us : sched_switch:
prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==>
next_comm=cyclictest next_pid=4267 next_prio=0
cyclicte-4267    0d...2.. 228624034us+: sched_switch:
prev_comm=cyclictest prev_pid=4267 prev_prio=0 prev_state=S ==>
next_comm=swapper/0 next_pid=0 next_prio=120
  <idle>-0       0dN.h3.. 228624055us : sched_wakeup: comm=rcuc/0
pid=11 prio=0 target_cpu=000
  <idle>-0       0dN..3.. 228624056us : sched_wakeup: comm=ksoftirqd/0
pid=3 prio=120 target_cpu=000
  <idle>-0       0dN..3.. 228624057us : sched_wakeup:
comm=ktimersoftd/0 pid=4 prio=98 target_cpu=000
  <idle>-0       0d...2.. 228624057us+: sched_switch:
prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==>
next_comm=rcuc/0 next_pid=11 next_prio=0
  rcuc/0-11      0d..h311 228624131us!: sched_wakeup: comm=cyclictest
pid=4267 prio=0 target_cpu=000
  rcuc/0-11      0d...2.. 228624306us : sched_switch: prev_comm=rcuc/0
prev_pid=11 prev_prio=0 prev_state=S ==> next_comm=cyclictest
next_pid=4267 next_prio=0
cyclicte-4267    0.....11 228624313us : tracing_mark_write: hit
latency threshold (176 > 35)

Another cyclictest run, this time with function trace. The latency
here was 1904us:
  <idle>-0       0d...2.. 85742079us : sched_switch:
prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R+ ==>
next_comm=rcuc/0 next_pid=11 next_prio=0
  <idle>-0       0d...2.. 85742079us : __switch_to <-__schedule
  rcuc/0-11      0d...2.. 85742079us : finish_task_switch <-__schedule
  rcuc/0-11      0d...2.. 85742079us : _raw_spin_unlock_irq <-finish_task_switch
  rcuc/0-11      0....1.. 85742079us : kthread_should_stop <-smpboot_thread_fn
  rcuc/0-11      0....1.. 85742079us : kthread_should_park <-smpboot_thread_fn
  rcuc/0-11      0....1.. 85742079us : rcu_cpu_kthread_should_run
<-smpboot_thread_fn
  rcuc/0-11      0....... 85742079us : rcu_cpu_kthread <-smpboot_thread_fn
  rcuc/0-11      0....... 85742080us : __local_bh_disable <-rcu_cpu_kthread
  rcuc/0-11      0....... 85742080us : migrate_disable <-__local_bh_disable
  rcuc/0-11      0....11. 85742080us : pin_current_cpu <-migrate_disable
  rcuc/0-11      0.....11 85742081us : note_gp_changes <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85742081us : _raw_spin_lock_irqsave <-rcu_cpu_kthread
  rcuc/0-11      0d...111 85742081us : rcu_accelerate_cbs <-rcu_cpu_kthread
  rcuc/0-11      0d...111 85742081us : rcu_report_qs_rnp <-rcu_cpu_kthread
  rcuc/0-11      0d...111 85742081us : _raw_spin_unlock_irqrestore
<-rcu_report_qs_rnp
  rcuc/0-11      0d....11 85742081us : cpu_needs_another_gp <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85742081us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85742081us : __slab_free <-kfree
  rcuc/0-11      0.....11 85742082us : _raw_spin_lock_irqsave <-__slab_free
  rcuc/0-11      0d...111 85742082us : _raw_spin_unlock_irqrestore <-__slab_free
  rcuc/0-11      0.....11 85742082us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85742082us : __slab_free <-kfree
  rcuc/0-11      0.....11 85742082us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85742082us : __slab_free <-kfree
  rcuc/0-11      0.....11 85742082us : _raw_spin_lock_irqsave <-__slab_free
  rcuc/0-11      0d...111 85742082us : _raw_spin_unlock_irqrestore <-__slab_free
  rcuc/0-11      0.....11 85742082us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85742082us : __slab_free <-kfree
  rcuc/0-11      0.....11 85742082us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85742082us : __slab_free <-kfree

This kfree, __slab_free gets repeated thousands of times. The pattern
is occasionally broken by the timer interrupt and at least the
following fragments:
  rcuc/0-11      0.....11 85742086us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85742086us : __slab_free <-kfree
  rcuc/0-11      0.....11 85742086us : _raw_spin_lock_irqsave <-__slab_free
  rcuc/0-11      0d...111 85742086us : _raw_spin_unlock_irqrestore <-__slab_free
  rcuc/0-11      0.....11 85742086us : kfree <-rcu_cpu_kthread

Or:
  rcuc/0-11      0.....11 85742575us : __slab_free <-kfree
  rcuc/0-11      0.....11 85742575us : _raw_spin_lock_irqsave <-__slab_free
  rcuc/0-11      0d...111 85742575us : _raw_spin_unlock_irqrestore <-__slab_free
  rcuc/0-11      0.....11 85742575us : discard_slab <-__slab_free
  rcuc/0-11      0.....11 85742575us : __free_slab <-discard_slab
  rcuc/0-11      0.....11 85742575us : mod_zone_page_state <-__free_slab
  rcuc/0-11      0.....11 85742575us : __free_kmem_pages <-__free_slab
  rcuc/0-11      0.....11 85742575us : __free_pages <-__free_kmem_pages
  rcuc/0-11      0.....11 85742575us : free_hot_cold_page <-__free_pages
  rcuc/0-11      0.....11 85742575us : free_pages_prepare <-free_hot_cold_page
  rcuc/0-11      0.....11 85742576us : get_pfnblock_flags_mask
<-free_hot_cold_page
  rcuc/0-11      0.....11 85742576us : migrate_disable <-free_hot_cold_page
  rcuc/0-11      0.....12 85742576us : rt_spin_lock <-free_hot_cold_page
  rcuc/0-11      0.....12 85742576us : migrate_disable <-rt_spin_lock
  rcuc/0-11      0.....13 85742576us : rt_spin_unlock <-free_hot_cold_page
  rcuc/0-11      0.....13 85742576us : migrate_enable <-rt_spin_unlock
  rcuc/0-11      0.....12 85742576us : migrate_enable <-free_hot_cold_page
  rcuc/0-11      0.....11 85742576us : kfree <-rcu_cpu_kthread

Until after almost 2ms cyclictest finally gets a chance to run:
  rcuc/0-11      0.....11 85744013us : __slab_free <-kfree
  rcuc/0-11      0.....11 85744013us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85744013us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85744013us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85744013us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85744013us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85744014us : kfree <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85744014us : note_gp_changes <-rcu_cpu_kthread
  rcuc/0-11      0d....11 85744014us : cpu_needs_another_gp <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85744014us : __local_bh_enable <-rcu_cpu_kthread
  rcuc/0-11      0.....11 85744014us : migrate_enable <-__local_bh_enable
  rcuc/0-11      0....11. 85744014us : unpin_current_cpu <-migrate_enable
  rcuc/0-11      0....1.. 85744014us : kthread_should_stop <-smpboot_thread_fn
  rcuc/0-11      0....1.. 85744014us : kthread_should_park <-smpboot_thread_fn
  rcuc/0-11      0....1.. 85744014us : rcu_cpu_kthread_should_run
<-smpboot_thread_fn
  rcuc/0-11      0....... 85744014us : schedule <-smpboot_thread_fn
  rcuc/0-11      0....1.. 85744014us : rcu_note_context_switch <-__schedule
  rcuc/0-11      0....1.. 85744015us : rcu_sched_qs <-rcu_note_context_switch
  rcuc/0-11      0....1.. 85744015us : _raw_spin_lock_irq <-__schedule
  rcuc/0-11      0d...2.. 85744015us : deactivate_task <-__schedule
  rcuc/0-11      0d...2.. 85744015us : update_rq_clock.part.86 <-deactivate_task
  rcuc/0-11      0d...2.. 85744015us : dequeue_task_rt <-deactivate_task
  rcuc/0-11      0d...2.. 85744015us : update_curr_rt <-dequeue_task_rt
  rcuc/0-11      0d...2.. 85744015us : cpuacct_charge <-update_curr_rt
  rcuc/0-11      0d...2.. 85744015us : __rcu_read_lock <-cpuacct_charge
  rcuc/0-11      0d...2.. 85744015us : __rcu_read_unlock <-cpuacct_charge
  rcuc/0-11      0d...2.. 85744015us : sched_avg_update <-update_curr_rt
  rcuc/0-11      0d...2.. 85744015us : _raw_spin_lock <-update_curr_rt
  rcuc/0-11      0d...3.. 85744015us : balance_runtime <-update_curr_rt
  rcuc/0-11      0d...2.. 85744016us : dequeue_rt_stack <-dequeue_task_rt
  rcuc/0-11      0d...2.. 85744016us : dequeue_top_rt_rq <-dequeue_rt_stack
  rcuc/0-11      0d...2.. 85744016us : update_rt_migration <-dequeue_rt_stack
  rcuc/0-11      0d...2.. 85744016us : enqueue_top_rt_rq <-dequeue_task_rt
  rcuc/0-11      0d...2.. 85744016us : pick_next_task_stop <-__schedule
  rcuc/0-11      0d...2.. 85744016us : pick_next_task_dl <-__schedule
  rcuc/0-11      0d...2.. 85744016us : pick_next_task_rt <-__schedule
  rcuc/0-11      0d...2.. 85744016us : update_curr_rt <-pick_next_task_rt
  rcuc/0-11      0d...2.. 85744016us : put_prev_task_rt <-pick_next_task_rt
  rcuc/0-11      0d...2.. 85744016us : update_curr_rt <-put_prev_task_rt
  rcuc/0-11      0d...2.. 85744017us : sched_switch: prev_comm=rcuc/0
prev_pid=11 prev_prio=0 prev_state=S ==> next_comm=cyclictest
next_pid=4756 next_prio=0
  rcuc/0-11      0d...2.. 85744017us : __switch_to <-__schedule
cyclicte-4756    0d...2.. 85744017us : finish_task_switch <-__schedule
cyclicte-4756    0d...2.. 85744017us : _raw_spin_unlock_irq <-finish_task_switch
cyclicte-4756    0....... 85744017us : hrtimer_cancel <-do_nanosleep

Thanks!
Christoph
