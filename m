From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 06/14] perf/x86/intel/rapl: Make PMU lock raw
Date: Tue, 12 Jul 2016 12:48:05 -0400
Message-ID: <20160712164818.485927277@goodmis.org>
References: <20160712164759.154249453@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andi Kleen <andi.kleen@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Harish Chegondi <harish.chegondi@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Vince Weaver <vincent.weaver@maine.edu>,
	<stable-rt@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0006-perf-x86-intel-rapl-Make-PMU-lock-raw.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.72-rt76-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

Upstream commit: a208749c6426 ("perf/x86/intel/rapl: Make PMU lock raw")

This lock is taken in hard interrupt context even on Preempt-RT. Make it raw
so RT does not have to patch it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Harish Chegondi <harish.chegondi@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org
Cc: stable-rt@vger.kernel.org
Link: http://lkml.kernel.org/r/20160222221012.669411833@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/kernel/cpu/perf_event_intel_rapl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_intel_rapl.c b/arch/x86/kernel/cpu/perf_event_intel_rapl.c
index 95700e52061d..4d270d910c33 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_rapl.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_rapl.c
@@ -98,7 +98,7 @@ static struct kobj_attribute format_attr_##_var =		\
 #define RAPL_CNTR_WIDTH 32 /* 32-bit rapl counters */
 
 struct rapl_pmu {
-	spinlock_t	 lock;
+	raw_spinlock_t	 lock;
 	int		 hw_unit;  /* 1/2^hw_unit Joule */
 	int		 n_active; /* number of active events */
 	struct list_head active_list;
@@ -188,13 +188,13 @@ static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
 	if (!pmu->n_active)
 		return HRTIMER_NORESTART;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	list_for_each_entry(event, &pmu->active_list, active_entry) {
 		rapl_event_update(event);
 	}
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 
 	hrtimer_forward_now(hrtimer, pmu->timer_interval);
 
@@ -231,9 +231,9 @@ static void rapl_pmu_event_start(struct perf_event *event, int mode)
 	struct rapl_pmu *pmu = __get_cpu_var(rapl_pmu);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 	__rapl_pmu_event_start(pmu, event);
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 }
 
 static void rapl_pmu_event_stop(struct perf_event *event, int mode)
@@ -242,7 +242,7 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	/* mark event as deactivated and stopped */
 	if (!(hwc->state & PERF_HES_STOPPED)) {
@@ -267,7 +267,7 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 }
 
 static int rapl_pmu_event_add(struct perf_event *event, int mode)
@@ -276,14 +276,14 @@ static int rapl_pmu_event_add(struct perf_event *event, int mode)
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	if (mode & PERF_EF_START)
 		__rapl_pmu_event_start(pmu, event);
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 
 	return 0;
 }
@@ -526,7 +526,7 @@ static int rapl_cpu_prepare(int cpu)
 	if (!pmu)
 		return -1;
 
-	spin_lock_init(&pmu->lock);
+	raw_spin_lock_init(&pmu->lock);
 
 	INIT_LIST_HEAD(&pmu->active_list);
 
-- 
2.8.1
