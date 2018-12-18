From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of
 memory allocated in cpu hotplug prepare state
Date: Tue, 18 Dec 2018 12:37:00 +0100
Message-ID: <20181218113700.GC16284@hirez.programming.kicks-ass.net>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
 <20181218110209.GD15430@hirez.programming.kicks-ass.net>
 <20181218111637.b53u5pi3nxnyldaq@linutronix.de>
 <20181218113119.GG15430@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: zhe.he@windriver.com, acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        jolsa@kernel.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        mingo@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218113119.GG15430@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Dec 18, 2018 at 12:31:19PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 18, 2018 at 12:16:37PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2018-12-18 12:02:09 [+0100], Peter Zijlstra wrote:
> > > On Tue, Dec 18, 2018 at 06:30:33PM +0800, zhe.he@windriver.com wrote:
> > > > Besides, in preempt-rt full mode, the freeing can happen in atomic context and
> > > > thus cause the following BUG.
> > > 
> > > Hurm, I though we fixed all those long ago..
> > > 
> > > And no, the patch is horrible; that's what we have things like
> > > x86_pmu::cpu_dead() for.
> > 
> > ehm, you say we keep memory allocation +free on CPU up/down?
> 
> Sure, why not?

I suspect the below is all we really need.

---
 arch/x86/events/intel/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 40e12cfc87f6..daafb893449b 100644
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
