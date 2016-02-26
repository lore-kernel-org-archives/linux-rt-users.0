From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 02/10] ARM: smp: Move clear_tasks_mm_cpumask() call to
 __cpu_die()
Date: Fri, 26 Feb 2016 16:39:13 -0500
Message-ID: <20160226213931.294002853@goodmis.org>
References: <20160226213911.445523575@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
 Russell King <linux@arm.linux.org.uk>, stable-rt@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Sekhar Nori <nsekhar@ti.com>, Carsten Emde <C.Emde@osadl.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>, philipp@peloton-tech.com,
 Austin Schuh <austin@peloton-tech.com>, John Kacur <jkacur@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org,
 linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline;
 filename=0002-ARM-smp-Move-clear_tasks_mm_cpumask-call-to-__cpu_di.patch
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-rt-users.vger.kernel.org

3.12.54-rt73-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Grygorii Strashko <grygorii.strashko@ti.com>

When running with the RT-kernel (4.1.5-rt5) on TI OMAP dra7-evm and trying
to do Suspend to RAM, the following backtrace occurs:

 Disabling non-boot CPUs ...
 PM: noirq suspend of devices complete after 7.295 msecs
 Disabling non-boot CPUs ...
 BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
 in_atomic(): 1, irqs_disabled(): 128, pid: 18, name: migration/1
 INFO: lockdep is turned off.
 irq event stamp: 122
 hardirqs last  enabled at (121): [<c06ac0ac>] _raw_spin_unlock_irqrestore+0x88/0x90
 hardirqs last disabled at (122): [<c06abed0>] _raw_spin_lock_irq+0x28/0x5c
 softirqs last  enabled at (0): [<c003d294>] copy_process.part.52+0x410/0x19d8
 softirqs last disabled at (0): [<  (null)>]   (null)
 Preemption disabled at:[<  (null)>]   (null)
  CPU: 1 PID: 18 Comm: migration/1 Tainted: G        W       4.1.4-rt3-01046-g96ac8da #204
 Hardware name: Generic DRA74X (Flattened Device Tree)
 [<c0019134>] (unwind_backtrace) from [<c0014774>] (show_stack+0x20/0x24)
 [<c0014774>] (show_stack) from [<c06a70f4>] (dump_stack+0x88/0xdc)
 [<c06a70f4>] (dump_stack) from [<c006cab8>] (___might_sleep+0x198/0x2a8)
 [<c006cab8>] (___might_sleep) from [<c06ac4dc>] (rt_spin_lock+0x30/0x70)
 [<c06ac4dc>] (rt_spin_lock) from [<c013f790>] (find_lock_task_mm+0x9c/0x174)
 [<c013f790>] (find_lock_task_mm) from [<c00409ac>] (clear_tasks_mm_cpumask+0xb4/0x1ac)
 [<c00409ac>] (clear_tasks_mm_cpumask) from [<c00166a4>] (__cpu_disable+0x98/0xbc)
 [<c00166a4>] (__cpu_disable) from [<c06a2e8c>] (take_cpu_down+0x1c/0x50)
 [<c06a2e8c>] (take_cpu_down) from [<c00f2600>] (multi_cpu_stop+0x11c/0x158)
 [<c00f2600>] (multi_cpu_stop) from [<c00f2a9c>] (cpu_stopper_thread+0xc4/0x184)
 [<c00f2a9c>] (cpu_stopper_thread) from [<c0069058>] (smpboot_thread_fn+0x18c/0x324)
 [<c0069058>] (smpboot_thread_fn) from [<c00649c4>] (kthread+0xe8/0x104)
 [<c00649c4>] (kthread) from [<c0010058>] (ret_from_fork+0x14/0x3c)
 CPU1: shutdown
 PM: Calling sched_clock_suspend+0x0/0x40
 PM: Calling timekeeping_suspend+0x0/0x2e0
 PM: Calling irq_gc_suspend+0x0/0x68
 PM: Calling fw_suspend+0x0/0x2c
 PM: Calling cpu_pm_suspend+0x0/0x28

Also, sometimes system stucks right after displaying "Disabling non-boot
CPUs ...". The root cause of above backtrace is task_lock() which takes
a sleeping lock on -RT.

To fix the issue, move clear_tasks_mm_cpumask() call from __cpu_disable()
to __cpu_die() which is called on the thread which is asking for a target
CPU to be shutdown. In addition, this change restores CPUhotplug functionality
on TI OMAP dra7-evm and CPU1 can be unplugged/plugged many times.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Austin Schuh <austin@peloton-tech.com>
Cc: <philipp@peloton-tech.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: <bigeasy@linutronix.de>
Cc: stable-rt@vger.kernel.org
Link: http://lkml.kernel.org/r/1441995683-30817-1-git-send-email-grygorii.strashko@ti.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index bd1b9e633356..2f7325963bf5 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -207,8 +207,6 @@ int __cpu_disable(void)
 	flush_cache_louis();
 	local_flush_tlb_all();
 
-	clear_tasks_mm_cpumask(cpu);
-
 	return 0;
 }
 
@@ -224,6 +222,9 @@ void __cpu_die(unsigned int cpu)
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
+
+	clear_tasks_mm_cpumask(cpu);
+
 	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
 
 	/*
-- 
2.7.0
