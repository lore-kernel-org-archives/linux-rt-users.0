From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH] preempt-rt: convert blackfin boot_lock to raw
Date: Mon, 19 Sep 2011 14:51:41 -0700
Message-ID: <4E77B96D.40101@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <tglx@linutronix.de>, <linux-rt-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


The blackfin boot_lock is used by the secondary processor startup code.
The locking task is the idle thread, which has
idle->sched_class == &idle_sched_class.
idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
lock, the attempt to wake it when the lock becomes available will fail:

try_to_wake_up()
   ...
      activate_task()
         enqueue_task()
            p->sched_class->enqueue_task(rq, p, flags)

Fix by converting boot_lock to a raw spin lock.

This has not been compile or boot tested.  The fix was needed by arm, this
patch is for all other instances of "boot_lock" in other architectures.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 arch/blackfin/mach-bf561/smp.c |   10 	5 +	5 -	0 !
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: b/arch/blackfin/mach-bf561/smp.c
===================================================================
--- a/arch/blackfin/mach-bf561/smp.c
+++ b/arch/blackfin/mach-bf561/smp.c
@@ -13,7 +13,7 @@
 #include <asm/dma.h>
 #include <asm/time.h>
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 /*
  * platform_init_cpus() - Tell the world about how many cores we
@@ -70,8 +70,8 @@ void __cpuinit platform_secondary_init(u
 
 	/* We are done with local CPU inits, unblock the boot CPU. */
 	set_cpu_online(cpu, true);
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 int __cpuinit platform_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -80,7 +80,7 @@ int __cpuinit platform_boot_secondary(un
 
 	printk(KERN_INFO "Booting Core B.\n");
 
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	if ((bfin_read_SYSCR() & COREB_SRAM_INIT) == 0) {
 		/* CoreB already running, sending ipi to wakeup it */
@@ -101,7 +101,7 @@ int __cpuinit platform_boot_secondary(un
 
 	if (cpu_online(cpu)) {
 		/* release the lock and let coreb run */
-		spin_unlock(&boot_lock);
+		raw_spin_unlock(&boot_lock);
 		return 0;
 	} else
 		panic("CPU%u: processor failed to boot\n", cpu);
