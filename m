From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [Patch 1/2] backport of x86: add rdtsc barrier to TSC sync check
Date: Tue, 7 Apr 2009 11:33:54 -0300
Message-ID: <20090407143354.GD1833@unix.sh>
References: <20090407143141.GC1833@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:28700 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbZDGOeB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2009 10:34:01 -0400
Received: by rv-out-0506.google.com with SMTP id b25so315238rvf.5
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Apr 2009 07:34:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090407143141.GC1833@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This changeset is mainly a backport of upstream commit
93ce99e849433ede4ce8b410b749dc0cad1100b2 and its required
infrastructure.

| commit 93ce99e849433ede4ce8b410b749dc0cad1100b2
| Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
| Date:   Mon Nov 17 14:43:58 2008 -0800
| 
|     x86: add rdtsc barrier to TSC sync check
|     
|     Impact: fix incorrectly marked unstable TSC clock
|     
|     Patch (commit 0d12cdd "sched: improve sched_clock() performance") has
|     a regression on one of the test systems here.
|     
|     With the patch, I see:
|     
|      checking TSC synchronization [CPU#0 -> CPU#1]:
|      Measured 28 cycles TSC warp between CPUs, turning off TSC clock.
|      Marking TSC unstable due to check_tsc_sync_source failed
|     
|     Whereas, without the patch syncs pass fine on all CPUs:
|     
|      checking TSC synchronization [CPU#0 -> CPU#1]: passed.
|     
|     Due to this, TSC is marked unstable, when it is not actually unstable.
|     This is because syncs in check_tsc_wrap() goes away due to this commit.
|     
|     As per the discussion on this thread, correct way to fix this is to add
|     explicit syncs as below?
|     
|     Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
|     Signed-off-by: Ingo Molnar <mingo@elte.hu>

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

---
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 4f08c7b..f5fd23c 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -46,7 +46,9 @@ static __cpuinit void check_tsc_warp(void)
 	cycles_t start, now, prev, end;
 	int i;
 
-	start = get_cycles_sync();
+	rdtsc_barrier();
+	start = get_cycles();
+	rdtsc_barrier();
 	/*
 	 * The measurement runs for 20 msecs:
 	 */
@@ -61,18 +63,20 @@ static __cpuinit void check_tsc_warp(void)
 		 */
 		__raw_spin_lock(&sync_lock);
 		prev = last_tsc;
-		now = get_cycles_sync();
+		rdtsc_barrier();
+		now = get_cycles();
+		rdtsc_barrier();
 		last_tsc = now;
 		__raw_spin_unlock(&sync_lock);
 
 		/*
 		 * Be nice every now and then (and also check whether
-		 * measurement is done [we also insert a 100 million
+		 * measurement is done [we also insert a 10 million
 		 * loops safety exit, so we dont lock up in case the
 		 * TSC readout is totally broken]):
 		 */
 		if (unlikely(!(i & 7))) {
-			if (now > end || i > 100000000)
+			if (now > end || i > 10000000)
 				break;
 			cpu_relax();
 			touch_nmi_watchdog();
@@ -87,8 +91,10 @@ static __cpuinit void check_tsc_warp(void)
 			nr_warps++;
 			__raw_spin_unlock(&sync_lock);
 		}
-
 	}
+	if (!(now-start))
+		printk(KERN_WARNING "Warning: zero tsc calibration delta:"
+			" %lld [max: %lld]\n", now-start, end-start);
 }
 
 /*
@@ -97,7 +103,6 @@ static __cpuinit void check_tsc_warp(void)
  */
 void __cpuinit check_tsc_sync_source(int cpu)
 {
-	unsigned long flags;
 	int cpus = 2;
 
 	/*
@@ -118,11 +123,8 @@ void __cpuinit check_tsc_sync_source(int cpu)
 	/*
 	 * Wait for the target to arrive:
 	 */
-	local_save_flags(flags);
-	local_irq_enable();
 	while (atomic_read(&start_count) != cpus-1)
 		cpu_relax();
-	local_irq_restore(flags);
 	/*
 	 * Trigger the target to continue into the measurement too:
 	 */
@@ -133,24 +135,24 @@ void __cpuinit check_tsc_sync_source(int cpu)
 	while (atomic_read(&stop_count) != cpus-1)
 		cpu_relax();
 
-	/*
-	 * Reset it - just in case we boot another CPU later:
-	 */
-	atomic_set(&start_count, 0);
-
 	if (nr_warps) {
 		printk("\n");
 		printk(KERN_WARNING "Measured %Ld cycles TSC warp between CPUs,"
 				    " turning off TSC clock.\n", max_warp);
 		mark_tsc_unstable("check_tsc_sync_source failed");
-		nr_warps = 0;
-		max_warp = 0;
-		last_tsc = 0;
 	} else {
 		printk(" passed.\n");
 	}
 
 	/*
+	 * Reset it - just in case we boot another CPU later:
+	 */
+	atomic_set(&start_count, 0);
+	nr_warps = 0;
+	max_warp = 0;
+	last_tsc = 0;
+
+	/*
 	 * Let the target continue with the bootup:
 	 */
 	atomic_inc(&stop_count);
diff --git a/include/asm-x86/cpufeature_32.h b/include/asm-x86/cpufeature_32.h
index f17e688..49f14b4 100644
--- a/include/asm-x86/cpufeature_32.h
+++ b/include/asm-x86/cpufeature_32.h
@@ -82,6 +82,8 @@
 /* 14 free */
 #define X86_FEATURE_SYNC_RDTSC	(3*32+15)  /* RDTSC synchronizes the CPU */
 #define X86_FEATURE_REP_GOOD   (3*32+16) /* rep microcode works well on this CPU */
+#define X86_FEATURE_MFENCE_RDTSC (3*32+17) /* "" Mfence synchronizes RDTSC */
+#define X86_FEATURE_LFENCE_RDTSC (3*32+18) /* "" Lfence synchronizes RDTSC */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
diff --git a/include/asm-x86/processor.h b/include/asm-x86/processor.h
index 46e1c04..e1dc8fc 100644
--- a/include/asm-x86/processor.h
+++ b/include/asm-x86/processor.h
@@ -1,5 +1,23 @@
+#ifndef __ASM_PROCESSOR_H
+#define __ASM_PROCESSOR_H
+
 #ifdef CONFIG_X86_32
 # include "processor_32.h"
 #else
 # include "processor_64.h"
 #endif
+
+/*
+ * Stop RDTSC speculation. This is needed when you need to use RDTSC
+ * (or get_cycles or vread that possibly accesses the TSC) in a defined
+ * code region.
+ *
+ * (Could use an alternative three way for this if there was one.)
+ */
+static inline void rdtsc_barrier(void)
+{
+	alternative(ASM_NOP3, "mfence", X86_FEATURE_MFENCE_RDTSC);
+	alternative(ASM_NOP3, "lfence", X86_FEATURE_LFENCE_RDTSC);
+}
+
+#endif /* __ASM_PROCESSOR_H */
-- 
[ Luis Claudio R. Goncalves             Red Hat  -  Realtime Team ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

