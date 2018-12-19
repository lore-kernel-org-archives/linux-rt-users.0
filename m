From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] perf/x86/intel: Delay memory deallocation until
 x86_pmu_dead_cpu()
Date: Wed, 19 Dec 2018 17:53:50 +0100
Message-ID: <20181219165350.6s3jvyxbibpvlhtq@linutronix.de>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
 <20181218110209.GD15430@hirez.programming.kicks-ass.net>
 <20181218111637.b53u5pi3nxnyldaq@linutronix.de>
 <20181218113119.GG15430@hirez.programming.kicks-ass.net>
 <20181218113700.GC16284@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: zhe.he@windriver.com, acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        jolsa@kernel.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        mingo@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218113700.GC16284@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

intel_pmu_cpu_prepare() allocated memory for ->shared_regs among other
members of struct cpu_hw_events. This memory is released in
intel_pmu_cpu_dying() which is wrong. The counterpart of the
intel_pmu_cpu_prepare() callback is x86_pmu_dead_cpu().

Otherwise if the CPU fails on the UP path between CPUHP_PERF_X86_PREPARE
and CPUHP_AP_PERF_X86_STARTING then it won't release the memory but
allocate new memory on the next attempt to online the CPU (leaking the
old memory).
Also, if the CPU down path fails between CPUHP_AP_PERF_X86_STARTING and
CPUHP_PERF_X86_PREPARE then the CPU will go back online but never
allocate the memory that was released in x86_pmu_dying_cpu().

Make the memory allocation/free symmetrical in regard to the CPU hotplug
notifier by moving the deallocation to intel_pmu_cpu_dead().

This started in commit
   a7e3ed1e47011 ("perf: Add support for supplementary event registers").

Cc: stable@vger.kernel.org
Reported-by: He Zhe <zhe.he@windriver.com>
Fixes: a7e3ed1e47011 ("perf: Add support for supplementary event registers").
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[bigeasy: patch description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/events/intel/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ecc3e34ca955f..90b6718ff861d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3558,6 +3558,14 @@ static void free_excl_cntrs(int cpu)
 }
 
 static void intel_pmu_cpu_dying(int cpu)
+{
+	fini_debug_store_on_cpu(cpu);
+
+	if (x86_pmu.counter_freezing)
+		disable_counter_freeze();
+}
+
+static void intel_pmu_cpu_dead(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	struct intel_shared_regs *pc;
@@ -3570,11 +3578,6 @@ static void intel_pmu_cpu_dying(int cpu)
 	}
 
 	free_excl_cntrs(cpu);
-
-	fini_debug_store_on_cpu(cpu);
-
-	if (x86_pmu.counter_freezing)
-		disable_counter_freeze();
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
@@ -3663,6 +3666,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
 };
 
 static struct attribute *intel_pmu_attrs[];
@@ -3703,6 +3707,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
+
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
 };
-- 
2.20.1
