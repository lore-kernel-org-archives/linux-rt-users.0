From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [rfc patch-3.18.7-rt1] rt/nohz_full: Fix can_stop_full_tick() gripe
 within softirq
Date: Wed, 18 Feb 2015 12:27:40 +0100
Message-ID: <1424258860.3819.43.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
	 <1424258514.3819.39.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424258514.3819.39.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The shuts gripe up.

[   57.170576] ------------[ cut here ]------------
[   57.170583] WARNING: CPU: 3 PID: 71 at kernel/time/tick-sched.c:167 can_stop_full_tick+0x1ae/0x260()
[   57.170617] CPU: 3 PID: 71 Comm: sirq-timer/3 Not tainted 3.18.7-rt1 #4
[   57.170617] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.404 11/06/2014
[   57.170618]  0000000000000009 ffff88040b21fc48 ffffffff815bb722 0000000000000002
[   57.170619]  0000000000000000 ffff88040b21fc88 ffffffff810512f1 ffff88040b21fcc8
[   57.170620]  ffff88041eccd360 ffff88041ecc0000 000000000000000b 0000000000000000
[   57.170620] Call Trace:
[   57.170624]  [<ffffffff815bb722>] dump_stack+0x4f/0x9e
[   57.170626]  [<ffffffff810512f1>] warn_slowpath_common+0x81/0xc0
[   57.170628]  [<ffffffff810513ea>] warn_slowpath_null+0x1a/0x20
[   57.170628]  [<ffffffff810c1f2e>] can_stop_full_tick+0x1ae/0x260
[   57.170629]  [<ffffffff810c2071>] __tick_nohz_full_check+0x71/0xb0
[   57.170630]  [<ffffffff810c20be>] nohz_full_kick_work_func+0xe/0x10
[   57.170631]  [<ffffffff81115d3f>] irq_work_run_list+0x3f/0x60
[   57.170632]  [<ffffffff8111617e>] irq_work_tick+0x3e/0x90
[   57.170634]  [<ffffffff810b04c5>] run_timer_softirq+0x35/0x2f0
[   57.170635]  [<ffffffff8107f0a2>] ? __vtime_account_system+0x32/0x40
[   57.170637]  [<ffffffff81055794>] do_current_softirqs.isra.11+0x1c4/0x3c0
[   57.170638]  [<ffffffff81055a55>] run_ksoftirqd+0x25/0x40
[   57.170639]  [<ffffffff810723dd>] smpboot_thread_fn+0x1dd/0x340
[   57.170640]  [<ffffffff81072200>] ? smpboot_register_percpu_thread+0x100/0x100
[   57.170641]  [<ffffffff8106e4ab>] kthread+0xbb/0xe0
[   57.170642]  [<ffffffff8106e3f0>] ? kthread_worker_fn+0x190/0x190
[   57.170644]  [<ffffffff815c1cac>] ret_from_fork+0x7c/0xb0
[   57.170644]  [<ffffffff8106e3f0>] ? kthread_worker_fn+0x190/0x190
[   57.170645] ---[ end trace 0000000000000002 ]---

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/time/tick-sched.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -222,6 +222,8 @@ void __tick_nohz_full_check(void)
 
 static void nohz_full_kick_work_func(struct irq_work *work)
 {
+	if (in_serving_softirq())
+		return;
 	__tick_nohz_full_check();
 }
 
