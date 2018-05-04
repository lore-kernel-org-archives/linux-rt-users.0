From: Mike Galbraith <efault@gmx.de>
Subject: [patch-rt] sched,fair: Fix CFS bandwidth control  lockdep DEADLOCK
 report
Date: Fri, 04 May 2018 08:14:38 +0200
Message-ID: <1525414478.6761.5.camel@gmx.de>
References: <20180503162934.b2ly6jz4a5tydaag@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180503162934.b2ly6jz4a5tydaag@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

CFS bandwidth control yields the inversion gripe below, moving
handling quells it.

========================================================
WARNING: possible irq lock inversion dependency detected
4.16.7-rt1-rt #2 Tainted: G            E   
--------------------------------------------------------
sirq-hrtimer/0/15 just changed the state of lock:
 (&cfs_b->lock){+...}, at: [<000000009adb5cf7>] sched_cfs_period_timer+0x28/0x140
but this lock was taken by another, HARDIRQ-safe lock in the past:
 (&rq->lock){-...}
and interrupts could create inverse lock ordering between them.
other info that might help us debug this:
 Possible interrupt unsafe locking scenario: 
       CPU0                    CPU1
       ----                    ----
  lock(&cfs_b->lock);
                               local_irq_disable();
                               lock(&rq->lock);
                               lock(&cfs_b->lock);
  <Interrupt>
    lock(&rq->lock);
*** DEADLOCK *** 
1 lock held by sirq-hrtimer/0/15:
 #0:  (&per_cpu(local_softirq_locks[i], __cpu).lock){+.+.}, at: [<0000000061d5600a>] do_current_softirqs+0x170/0x660
the shortest dependencies between 2nd lock and 1st lock:
 -> (&rq->lock){-...} ops: 67919540 {
    IN-HARDIRQ-W at:
                      _raw_spin_lock+0x38/0x50
                      scheduler_tick+0x4c/0x110
                      update_process_times+0x21/0x50
                      tick_periodic+0x2b/0x100
                      tick_handle_periodic+0x1f/0x60
                      timer_interrupt+0x14/0x20
                      __handle_irq_event_percpu+0x5f/0x3f0
                      handle_irq_event_percpu+0x37/0x70
                      handle_irq_event+0x37/0x60
                      handle_edge_irq+0xbe/0x1e0
                      handle_irq+0x1f/0x30
                      do_IRQ+0x65/0x130
                      ret_from_intr+0x0/0x22
                      timer_irq_works+0x60/0x10e
                      setup_IO_APIC+0x620/0x7e3
                      x86_late_time_init+0x17/0x1c
                      start_kernel+0x410/0x4b3
                      secondary_startup_64+0xa5/0xb0
    INITIAL USE at:
                     _raw_spin_lock_irqsave+0x4f/0x70
                     rq_attach_root+0x18/0xe0
                     sched_init+0x2ea/0x413
                     start_kernel+0x282/0x4b3
                     secondary_startup_64+0xa5/0xb0
  }
  ... key      at: [<000000000ab3ac7a>] __key.69727+0x0/0x8
  ... acquired at:
   lock_acquire+0xbd/0x250
   _raw_spin_lock+0x38/0x50
   rq_online_fair+0x9a/0x190
   set_rq_online+0x4c/0x60
   rq_attach_root+0xac/0xe0
   sched_init+0x2ea/0x413
   start_kernel+0x282/0x4b3
   secondary_startup_64+0xa5/0xb0 
-> (&cfs_b->lock){+...} ops: 56 {
   HARDIRQ-ON-W at:
                    _raw_spin_lock+0x38/0x50
                    sched_cfs_period_timer+0x28/0x140
                    __hrtimer_run_queues+0x10e/0x5f0
                    hrtimer_run_softirq+0x83/0xc0
                    do_current_softirqs+0x292/0x660
                    run_ksoftirqd+0x27/0x70
                    smpboot_thread_fn+0x27f/0x330
                    kthread+0x103/0x140
                    ret_from_fork+0x3a/0x50
   INITIAL USE at:
                   _raw_spin_lock+0x38/0x50
                   rq_online_fair+0x9a/0x190
                   set_rq_online+0x4c/0x60
                   rq_attach_root+0xac/0xe0
                   sched_init+0x2ea/0x413
                   start_kernel+0x282/0x4b3
                   secondary_startup_64+0xa5/0xb0
 }
 ... key      at: [<00000000bf5d5ec7>] __key.47691+0x0/0x8
 ... acquired at:
   __lock_acquire+0x1e6/0x770
   lock_acquire+0xbd/0x250
   _raw_spin_lock+0x38/0x50
   sched_cfs_period_timer+0x28/0x140
   __hrtimer_run_queues+0x10e/0x5f0
   hrtimer_run_softirq+0x83/0xc0
   do_current_softirqs+0x292/0x660
   run_ksoftirqd+0x27/0x70
   smpboot_thread_fn+0x27f/0x330
   kthread+0x103/0x140
   ret_from_fork+0x3a/0x50 
stack backtrace:
CPU: 0 PID: 15 Comm: sirq-hrtimer/0 Tainted: G            E    4.16.7-rt1-rt #2
Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
Call Trace:
 dump_stack+0x78/0xab
 print_irq_inversion_bug.part.38+0x19f/0x1aa
 check_usage_backwards+0x11b/0x120
 ? check_usage_forwards+0x130/0x130
 mark_lock+0x17c/0x280
 __lock_acquire+0x1e6/0x770
 lock_acquire+0xbd/0x250
 ? sched_cfs_period_timer+0x28/0x140
 _raw_spin_lock+0x38/0x50
 ? sched_cfs_period_timer+0x28/0x140
 sched_cfs_period_timer+0x28/0x140
 ? sched_cfs_slack_timer+0xc0/0xc0
 __hrtimer_run_queues+0x10e/0x5f0
 hrtimer_run_softirq+0x83/0xc0
 do_current_softirqs+0x292/0x660
 run_ksoftirqd+0x27/0x70
 smpboot_thread_fn+0x27f/0x330
 kthread+0x103/0x140
 ? smpboot_register_percpu_thread_cpumask+0x100/0x100
 ? kthread_delayed_work_timer_fn+0x90/0x90
 ret_from_fork+0x3a/0x50

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 kernel/sched/fair.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5007,9 +5007,9 @@ void init_cfs_bandwidth(struct cfs_bandw
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 }
 
