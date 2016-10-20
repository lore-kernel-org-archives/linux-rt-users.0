From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [rfc patch] hotplug: Call mmdrop_delayed() in sched_cpu_dying() if
 PREEMPT_RT_FULL
Date: Thu, 20 Oct 2016 11:34:03 +0200
Message-ID: <1476956043.18007.15.camel@gmail.com>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

My 64 core box just passed an hour running Steven's hotplug stress
script along with stockfish and futextests (tip-rt.today w. hotplug
hacks you saw a while back), and seems content to just keep on grinding
away.  Without it, box quickly becomes a doorstop.

[  634.896901] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:931
[  634.896902] in_atomic(): 1, irqs_disabled(): 1, pid: 104, name: migration/6
[  634.896902] no locks held by migration/6/104.
[  634.896903] irq event stamp: 1208518
[  634.896907] hardirqs last  enabled at (1208517): [<ffffffff816de46c>] _raw_spin_unlock_irqrestore+0x8c/0xa0
[  634.896910] hardirqs last disabled at (1208518): [<ffffffff81146055>] multi_cpu_stop+0xc5/0x110
[  634.896912] softirqs last  enabled at (0): [<ffffffff81075dd2>] copy_process.part.32+0x672/0x1fc0
[  634.896913] softirqs last disabled at (0): [<          (null)>]           (null)
[  634.896914] Preemption disabled at:[<ffffffff8114629c>] cpu_stopper_thread+0x8c/0x120
[  634.896914] 
[  634.896915] CPU: 6 PID: 104 Comm: migration/6 Tainted: G            E   4.8.2-rt1-rt_debug #23
[  634.896916] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[  634.896918]  0000000000000000 ffff880176fb3c40 ffffffff8139c04d 0000000000000000
[  634.896919]  ffff880176fa8000 ffff880176fb3c68 ffffffff810a8102 ffffffff81c29cc0
[  634.896919]  ffff8803fc825640 ffff8803fc825640 ffff880176fb3c88 ffffffff816de754
[  634.896920] Call Trace:
[  634.896923]  [<ffffffff8139c04d>] dump_stack+0x85/0xc8
[  634.896924]  [<ffffffff810a8102>] ___might_sleep+0x152/0x250
[  634.896926]  [<ffffffff816de754>] rt_spin_lock+0x24/0x80
[  634.896928]  [<ffffffff810d67f9>] ? __lock_is_held+0x49/0x70
[  634.896929]  [<ffffffff810623ee>] pgd_free+0x1e/0xb0
[  634.896930]  [<ffffffff81074877>] __mmdrop+0x27/0xd0
[  634.896932]  [<ffffffff810b4a0d>] sched_cpu_dying+0x24d/0x2c0
[  634.896933]  [<ffffffff810b47c0>] ? sched_cpu_starting+0x60/0x60
[  634.896934]  [<ffffffff81079864>] cpuhp_invoke_callback+0xd4/0x350
[  634.896935]  [<ffffffff81079e56>] take_cpu_down+0x86/0xd0
[  634.896936]  [<ffffffff81146060>] multi_cpu_stop+0xd0/0x110
[  634.896937]  [<ffffffff81145f90>] ? cpu_stop_queue_work+0x90/0x90
[  634.896938]  [<ffffffff811462a2>] cpu_stopper_thread+0x92/0x120
[  634.896940]  [<ffffffff810a50fe>] smpboot_thread_fn+0x1de/0x360
[  634.896941]  [<ffffffff810a4f20>] ? smpboot_update_cpumask_percpu_thread+0x130/0x130
[  634.896942]  [<ffffffff810a093f>] kthread+0xef/0x110
[  634.896944]  [<ffffffff816df16f>] ret_from_fork+0x1f/0x40
[  634.896945]  [<ffffffff810a0850>] ? kthread_park+0x60/0x60
[  634.896970] smpboot: CPU 6 is now offline

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/sched/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7569,6 +7569,9 @@ int sched_cpu_dying(unsigned int cpu)
 	nohz_balance_exit_idle(cpu);
 	hrtick_clear(rq);
 	if (per_cpu(idle_last_mm, cpu)) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		mmdrop_delayed(per_cpu(idle_last_mm, cpu));
+	else
 		mmdrop(per_cpu(idle_last_mm, cpu));
 		per_cpu(idle_last_mm, cpu) = NULL;
 	}
