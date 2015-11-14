From: <yanjiang.jin@windriver.com>
Subject: [RT PATCH] sched: rt: fix two possible deadlocks in push_irq_work_func
Date: Sat, 14 Nov 2015 10:53:18 +0800
Message-ID: <1447469598-31876-1-git-send-email-yanjiang.jin@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <yanjiang.jin@windriver.com>, <linux-kernel@vger.kernel.org>,
	<jinyanjiang@gmail.com>, <stable-rt@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
To: <mingo@redhat.com>, <rostedt@goodmis.org>, <bigeasy@linutronix.de>,
	<peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:52086 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbKNC4K (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Nov 2015 21:56:10 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Yanjiang Jin <yanjiang.jin@windriver.com>

This can only happen in RT kernel due to run_timer_softirq() calls
irq_work_tick() when CONFIG_PREEMPT_RT_FULL is enabled as below:

static void run_timer_softirq(struct softirq_action *h)
{
........
if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
        irq_work_tick();
endif
........
}

Use raw_spin_{un,}lock_irq{save,restore} in push_irq_work_func() to
prevent following potentially deadlock scenario:

=================================
[ INFO: inconsistent lock state ]
4.1.12-rt8-WR8.0.0.0_preempt-rt #27 Not tainted
---------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
ksoftirqd/3/30 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&rt_rq->push_lock) at: [<ffffffff801c879c>] push_irq_work_func+0xb4/0x190
{IN-HARDIRQ-W} state was registered at:
  [<ffffffff801d89ec>] __lock_acquire+0xd9c/0x1a00
  [<ffffffff801da09c>] lock_acquire+0x104/0x338
  [<ffffffff809be9c4>] _raw_spin_lock+0x4c/0x68
  [<ffffffff801c879c>] push_irq_work_func+0xb4/0x190
  [<ffffffff80272ca0>] irq_work_run_list+0x90/0xe8
  [<ffffffff80272f08>] irq_work_run+0x38/0x80
  [<ffffffff809bff2c>] smp_call_function_interrupt+0x24/0x30
  [<ffffffff80148074>] octeon_78xx_call_function_interrupt+0x1c/0x30
  [<ffffffff801e68c8>] handle_irq_event_percpu+0x110/0x620
  [<ffffffff801ebb04>] handle_percpu_irq+0xac/0xf0
  [<ffffffff801e5c64>] generic_handle_irq+0x44/0x58
  [<ffffffff809bfefc>] do_IRQ+0x24/0x30
  [<ffffffff801074c4>] plat_irq_dispatch+0xdc/0x138
  [<ffffffff8014f000>] ret_from_irq+0x0/0x4
  [<ffffffff809bee94>] _raw_spin_unlock_irqrestore+0x94/0xc8
  [<ffffffff801b6904>] try_to_wake_up+0x9c/0x3e8
  [<ffffffff80204c1c>] call_timer_fn+0xf4/0x570
  [<ffffffff802052b4>] run_timer_softirq+0x21c/0x508
  [<ffffffff8017ecc4>] do_current_softirqs+0x364/0x888
  [<ffffffff8017f8d0>] run_ksoftirqd+0x38/0x68
  [<ffffffff801aa24c>] smpboot_thread_fn+0x2ac/0x3a0
  [<ffffffff801a53c8>] kthread+0xe0/0xf8
  [<ffffffff8014f09c>] ret_from_kernel_thread+0x14/0x1c
irq event stamp: 7091
hardirqs last  enabled at (7091): restore_partial+0x74/0x14c
hardirqs last disabled at (7090): handle_int+0x11c/0x13c
softirqs last  enabled at (0): copy_process.part.6+0x544/0x1a08
softirqs last disabled at (0): [<          (null)>]           (null)

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&rt_rq->push_lock);
  <Interrupt>
    lock(&rt_rq->push_lock);

 *** DEADLOCK ***

1 lock held by ksoftirqd/3/30:
 #0:  (&per_cpu(local_softirq_locks[i], __cpu).lock){+.+...}, at:
 [<ffffffff8017eabc>] do_current_softirqs+0x15c/0x888

stack backtrace:
CPU: 3 PID: 30 Comm: ksoftirqd/3 4.1.12-rt8-WR8.0.0.0_preempt-rt #27
Stack : 8000000026bf1500 ffffffff80d8e158 0000000000000004 ffffffff80d90000
  0000000000000000 ffffffff80d90000 0000000000000000 0000000000000000
  0000000000000003 0000000000000004 ffffffff80d90000 ffffffff801e4830
  0000000000000000 ffffffff81c60000 0000000000000000 ffffffff809b5550
  0000000b00000004 0000000000000000 ffffffff801e4d30 ffffffff80fa5e08
  ffffffff80bb3bd0 0000000000000003 000000000000001e ffffffff80fbce98
  0000000000000002 0000000000000000 0000000000000000 ffffffff809b5550
  800000040ccbf8c8 800000040ccbf7b0 ffffffff80ce9987 ffffffff809b8b30
  800000040ccb6320 ffffffff801e5b54 0b1512ba6ee00000 ffffffff80ba73b8
  0000000000000003 ffffffff80155f68 0000000000000000 0000000000000000
	  ...
Call Trace:
[<ffffffff80155f68>] show_stack+0x98/0xb8
[<ffffffff809b8b30>] dump_stack+0x88/0xac
[<ffffffff801d6c2c>] print_usage_bug+0x25c/0x328
[<ffffffff801d74f4>] mark_lock+0x7fc/0x888
[<ffffffff801d856c>] __lock_acquire+0x91c/0x1a00
[<ffffffff801da09c>] lock_acquire+0x104/0x338
[<ffffffff809be9c4>] _raw_spin_lock+0x4c/0x68
[<ffffffff801c879c>] push_irq_work_func+0xb4/0x190
[<ffffffff80272ca0>] irq_work_run_list+0x90/0xe8
[<ffffffff802731ac>] irq_work_tick+0x44/0x78
[<ffffffff8020510c>] run_timer_softirq+0x74/0x508
[<ffffffff8017ecc4>] do_current_softirqs+0x364/0x888
[<ffffffff8017f8d0>] run_ksoftirqd+0x38/0x68
[<ffffffff801aa24c>] smpboot_thread_fn+0x2ac/0x3a0
[<ffffffff801a53c8>] kthread+0xe0/0xf8
[<ffffffff8014f09c>] ret_from_kernel_thread+0x14/0x1c

=================================
[ INFO: inconsistent lock state ]
4.1.12-rt8-WR8.0.0.0_preempt-rt #29 Not tainted
---------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
ksoftirqd/3/29 [HC0[0]:SC0[0]:HE1:SE1] takes:
(&rq->lock){?...-.}, at: [<ffffffff801c8780>] push_irq_work_func+0x98/0x198
{IN-HARDIRQ-W} state was registered at:
  [<ffffffff801d89fc>] __lock_acquire+0xd9c/0x1a00
  [<ffffffff801da0ac>] lock_acquire+0x104/0x338
  [<ffffffff809bd604>] _raw_spin_lock+0x4c/0x68
  [<ffffffff801b3ce0>] scheduler_tick+0x58/0x100
  [<ffffffff80205538>] update_process_times+0x38/0x68
  [<ffffffff80218f48>] tick_handle_periodic+0x40/0xb8
  [<ffffffff801596a4>] c0_compare_interrupt+0x6c/0x98
  [<ffffffff801e68d8>] handle_irq_event_percpu+0x110/0x620
  [<ffffffff801ebb14>] handle_percpu_irq+0xac/0xf0
  [<ffffffff801e5c74>] generic_handle_irq+0x44/0x58
  [<ffffffff809beb3c>] do_IRQ+0x24/0x30
  [<ffffffff8010748c>] plat_irq_dispatch+0xa4/0x138
  [<ffffffff8014f000>] ret_from_irq+0x0/0x4
  [<ffffffff8010106c>] prom_putchar+0x34/0x68
  [<ffffffff801685c4>] early_console_write+0x54/0xa0
  [<ffffffff801e256c>] call_console_drivers.constprop.13+0x174/0x3a0
  [<ffffffff801e42a8>] console_unlock+0x388/0x5a0
  [<ffffffff80e6ff74>] con_init+0x29c/0x2e0
  [<ffffffff80e6f450>] console_init+0x3c/0x54
  [<ffffffff80e39a70>] start_kernel+0x36c/0x594
irq event stamp: 14847
hardirqs last  enabled at (14847): do_current_softirqs+0x284/0x888
hardirqs last disabled at (14846): do_current_softirqs+0x194/0x888
softirqs last  enabled at (0):  copy_process.part.6+0x544/0x1a08
softirqs last disabled at (0): [<          (null)>]           (null)

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&rq->lock);
  <Interrupt>
    lock(&rq->lock);

 *** DEADLOCK ***

1 lock held by ksoftirqd/3/29:
 #0:  (&per_cpu(local_softirq_locks[i], __cpu).lock){+.+...}, at:
 [<ffffffff8017eabc>] do_current_softirqs+0x15c/0x888

stack backtrace:
CPU: 3 PID: 29 Comm: ksoftirqd/3 4.1.12-rt8-WR8.0.0.0_preempt-rt #29
Stack : 8000000026bf3a80 ffffffff80d8e158 0000000000000004 ffffffff80d90000
  0000000000000000 ffffffff80d90000 0000000000000000 0000000000000000
  0000000000000003 0000000000000004 ffffffff80d90000 ffffffff801e4840
  0000000000000000 ffffffff81c60000 0000000000000000 ffffffff809b4190
  0000000b00000004 0000000000000000 ffffffff801e4d40 ffffffff80fa4e08
  ffffffff80bb2ad0 0000000000000003 000000000000001d ffffffff80fbce98
  0000000000000002 0000000000000000 0000000000000000 ffffffff809b4190
  800000040ccbb8b8 800000040ccbb7a0 ffffffff80ce9987 ffffffff809b7770
  800000040ccb0000 ffffffff801e5b64 0cd35bb58ca00000 ffffffff80ba62b8
  0000000000000003 ffffffff80155f68 0000000000000000 0000000000000000
	  ...
Call Trace:
[<ffffffff80155f68>] show_stack+0x98/0xb8
[<ffffffff809b7770>] dump_stack+0x88/0xac
[<ffffffff801d6c3c>] print_usage_bug+0x25c/0x328
[<ffffffff801d7504>] mark_lock+0x7fc/0x888
[<ffffffff801d857c>] __lock_acquire+0x91c/0x1a00
[<ffffffff801da0ac>] lock_acquire+0x104/0x338
[<ffffffff809bd604>] _raw_spin_lock+0x4c/0x68
[<ffffffff801c8780>] push_irq_work_func+0x98/0x198
[<ffffffff802718e0>] irq_work_run_list+0x90/0xe8
[<ffffffff80271dec>] irq_work_tick+0x44/0x78
[<ffffffff80203d4c>] run_timer_softirq+0x74/0x508
[<ffffffff8017ecc4>] do_current_softirqs+0x364/0x888
[<ffffffff8017f8d0>] run_ksoftirqd+0x38/0x68
[<ffffffff801aa24c>] smpboot_thread_fn+0x2ac/0x3a0
[<ffffffff801a53c8>] kthread+0xe0/0xf8
[<ffffffff8014f09c>] ret_from_kernel_thread+0x14/0x1c

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 kernel/sched/rt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 637aa20..43457a0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1894,6 +1894,7 @@ static void try_to_push_tasks(void *arg)
 	struct rq *rq, *src_rq;
 	int this_cpu;
 	int cpu;
+	unsigned long flags;
 
 	this_cpu = rt_rq->push_cpu;
 
@@ -1905,13 +1906,13 @@ static void try_to_push_tasks(void *arg)
 
 again:
 	if (has_pushable_tasks(rq)) {
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock_irqsave(&rq->lock, flags);
 		push_rt_task(rq);
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock_irqrestore(&rq->lock, flags);
 	}
 
 	/* Pass the IPI to the next rt overloaded queue */
-	raw_spin_lock(&rt_rq->push_lock);
+	raw_spin_lock_irqsave(&rt_rq->push_lock, flags);
 	/*
 	 * If the source queue changed since the IPI went out,
 	 * we need to restart the search from that CPU again.
@@ -1925,7 +1926,7 @@ again:
 
 	if (cpu >= nr_cpu_ids)
 		rt_rq->push_flags &= ~RT_PUSH_IPI_EXECUTING;
-	raw_spin_unlock(&rt_rq->push_lock);
+	raw_spin_unlock_irqrestore(&rt_rq->push_lock, flags);
 
 	if (cpu >= nr_cpu_ids)
 		return;
-- 
1.9.1

