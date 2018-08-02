From: Mike Galbraith <efault@gmx.de>
Subject: [rt-patch 1/3 v2] arm64/acpi/perf: move pmu allocation to an early
 CPU up hook
Date: Thu, 02 Aug 2018 15:45:13 +0200
Message-ID: <1533217513.11791.19.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de> <1532769235.5926.0.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532769235.5926.0.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

(bah, make a clean The End to adventures in arm-land)

RT cannot allocate while irqs are disabled.

  BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
  in_atomic(): 0, irqs_disabled(): 128, pid: 25, name: cpuhp/0
  CPU: 0 PID: 25 Comm: cpuhp/0 Not tainted 4.16.18-rt10-rt #2
  Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.32 08/22/2017
  Call trace:
   dump_backtrace+0x0/0x188
   show_stack+0x24/0x30
   dump_stack+0x9c/0xd0
   ___might_sleep+0x124/0x188
   rt_spin_lock+0x40/0x80
   pcpu_alloc+0x104/0x7a0
   __alloc_percpu_gfp+0x38/0x48
   __armpmu_alloc+0x44/0x168
   armpmu_alloc_atomic+0x1c/0x28
   arm_pmu_acpi_cpu_starting+0x1cc/0x210
   cpuhp_invoke_callback+0xb8/0x820
   cpuhp_thread_fun+0xc0/0x1e0
   smpboot_thread_fn+0x1ac/0x2c8
   kthread+0x134/0x138
   ret_from_fork+0x10/0x18

Do the allocation and other preparation for probe along with the other
CPUHP_PERF_{ARCH}_PREPARE stages, where we'll be preemptible, thus no
longer requiring a GFP_ATOMIC allocation either.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 drivers/perf/arm_pmu_acpi.c |   12 ++++++------
 include/linux/cpuhotplug.h  |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -135,10 +135,10 @@ static struct arm_pmu *arm_pmu_acpi_find
 		return pmu;
 	}
 
-	pmu = armpmu_alloc_atomic();
+	pmu = armpmu_alloc();
 	if (!pmu) {
 		pr_warn("Unable to allocate PMU for CPU%d\n",
-			smp_processor_id());
+			raw_smp_processor_id());
 		return NULL;
 	}
 
@@ -185,7 +185,7 @@ static bool pmu_irq_matches(struct arm_p
  * coming up. The perf core won't open events while a hotplug event is in
  * progress.
  */
-static int arm_pmu_acpi_cpu_starting(unsigned int cpu)
+static int arm_pmu_acpi_cpu_prepare(unsigned int cpu)
 {
 	struct arm_pmu *pmu;
 	struct pmu_hw_events __percpu *hw_events;
@@ -283,9 +283,9 @@ static int arm_pmu_acpi_init(void)
 	if (ret)
 		return ret;
 
-	ret = cpuhp_setup_state(CPUHP_AP_PERF_ARM_ACPI_STARTING,
-				"perf/arm/pmu_acpi:starting",
-				arm_pmu_acpi_cpu_starting, NULL);
+	ret = cpuhp_setup_state(CPUHP_PERF_ARM_PMU_ACPI_PREPARE,
+				"perf/arm/pmu_acpi:prepare",
+				arm_pmu_acpi_cpu_prepare, NULL);
 
 	return ret;
 }
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -29,6 +29,7 @@ enum cpuhp_state {
 	CPUHP_PERF_PREPARE,
 	CPUHP_PERF_X86_PREPARE,
 	CPUHP_PERF_X86_AMD_UNCORE_PREP,
+	CPUHP_PERF_ARM_PMU_ACPI_PREPARE,
 	CPUHP_PERF_BFIN,
 	CPUHP_PERF_POWER,
 	CPUHP_PERF_SUPERH,
@@ -114,7 +115,6 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
 	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
-	CPUHP_AP_PERF_ARM_ACPI_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
