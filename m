From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [Patch 2/2] TSC: several enhancements on callers of
	mark_tsc_unstable()
Date: Tue, 7 Apr 2009 11:36:03 -0300
Message-ID: <20090407143603.GE1833@unix.sh>
References: <20090407143141.GC1833@unix.sh> <20090407143354.GD1833@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:41055 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbZDGOgK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2009 10:36:10 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2755827rvb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Apr 2009 07:36:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090407143354.GD1833@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patch is a backport from Linus' linux-2.6 git tree of various
enhancements related to the functions that could eventually call
mark_tsc_unstable().

Kernel 2.6.24.7-rt27 has been marking TSC as unstable in several machines
where it is, in fact, stable and constant.

Signed-off-by: Luis Claudio R. Goncalves <lclaudio@redhat.com>

---
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1ff88c7..184cb50 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -259,8 +259,10 @@ static void __cpuinit init_amd(struct cpuinfo_x86 *c)
 
 	if (cpuid_eax(0x80000000) >= 0x80000007) {
 		c->x86_power = cpuid_edx(0x80000007);
-		if (c->x86_power & (1<<8))
+		if (c->x86_power & (1<<8)) {
 			set_bit(X86_FEATURE_CONSTANT_TSC, c->x86_capability);
+			set_bit(X86_FEATURE_NONSTOP_TSC, c->x86_capability);
+		}
 	}
 
 #ifdef CONFIG_X86_HT
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index cc8c501..450f7f1 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -211,6 +211,15 @@ static void __cpuinit init_intel(struct cpuinfo_x86 *c)
 		(c->x86 == 0x6 && c->x86_model >= 0x0e))
 		set_bit(X86_FEATURE_CONSTANT_TSC, c->x86_capability);
 
+	/*
+	* c->x86_power is 8000_0007 edx. Bit 8 is TSC runs at constant rate
+	* with P/T states and does not stop in deep C-states
+	*/
+	if (c->x86_power & (1 << 8)) {
+		set_bit(X86_FEATURE_NONSTOP_TSC, c->x86_capability);
+		set_bit(X86_FEATURE_CONSTANT_TSC, c->x86_capability);
+	}
+
 	if (cpu_has_ds) {
 		unsigned int l1;
 		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
diff --git a/arch/x86/kernel/setup_64.c b/arch/x86/kernel/setup_64.c
index 30d94d1..167d62b 100644
--- a/arch/x86/kernel/setup_64.c
+++ b/arch/x86/kernel/setup_64.c
@@ -663,8 +663,10 @@ static void __cpuinit init_amd(struct cpuinfo_x86 *c)
 	display_cacheinfo(c);
 
 	/* c->x86_power is 8000_0007 edx. Bit 8 is constant TSC */
-	if (c->x86_power & (1<<8))
+	if (c->x86_power & (1<<8)) {
 		set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
+		set_bit(X86_FEATURE_NONSTOP_TSC, &c->x86_capability);
+	}
 
 	/* Multi core CPU? */
 	if (c->extended_cpuid_level >= 0x80000008)
@@ -810,8 +812,10 @@ static void __cpuinit init_intel(struct cpuinfo_x86 *c)
 	if (c->x86 == 15)
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
 	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
-	    (c->x86 == 0x6 && c->x86_model >= 0x0e))
+	    (c->x86 == 0x6 && c->x86_model >= 0x0e)) {
 		set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
+		set_bit(X86_FEATURE_NONSTOP_TSC, &c->x86_capability);
+	}
 	if (c->x86 == 6)
 		set_bit(X86_FEATURE_REP_GOOD, &c->x86_capability);
 	if (c->x86 == 15)
diff --git a/arch/x86/kernel/tsc_32.c b/arch/x86/kernel/tsc_32.c
index 1feecd4..0aa43ed 100644
--- a/arch/x86/kernel/tsc_32.c
+++ b/arch/x86/kernel/tsc_32.c
@@ -214,6 +214,9 @@ time_cpufreq_notifier(struct notifier_block *nb, unsigned long val, void *data)
 {
 	struct cpufreq_freqs *freq = data;
 
+	if (cpu_has(&cpu_data(freq->cpu), X86_FEATURE_CONSTANT_TSC))
+		return 0;
+
 	if (!ref_freq) {
 		if (!freq->old){
 			ref_freq = freq->new;
diff --git a/arch/x86/kernel/tsc_64.c b/arch/x86/kernel/tsc_64.c
index 5d24959..72a389e 100644
--- a/arch/x86/kernel/tsc_64.c
+++ b/arch/x86/kernel/tsc_64.c
@@ -215,27 +215,26 @@ void __init tsc_calibrate(void)
  */
 __cpuinit int unsynchronized_tsc(void)
 {
-	if (tsc_unstable)
+	if (!cpu_has_tsc || tsc_unstable)
 		return 1;
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_SMP
 	if (apic_is_clustered_box())
 		return 1;
 #endif
-	/* Most intel systems have synchronized TSCs except for
-	   multi node systems */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
-#ifdef CONFIG_ACPI
-		/* But TSC doesn't tick in C3 so don't use it there */
-		if (acpi_gbl_FADT.header.length > 0 &&
-		    acpi_gbl_FADT.C3latency < 1000)
-			return 1;
-#endif
+	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
 		return 0;
+	/*
+	 * Intel systems are normally all synchronized.
+	 * Exceptions must mark TSC as unstable:
+	 */
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+		/* assume multi socket systems are not synchronized: */
+		if (num_possible_cpus() > 1)
+			tsc_unstable = 1;
 	}
 
-	/* Assume multi socket systems are not synchronized */
-	return num_present_cpus() > 1;
+	return tsc_unstable;
 }
 
 int __init notsc_setup(char *s)
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e5d21e4..a91246a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -516,7 +516,8 @@ static void acpi_processor_idle(void)
 
 #if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
 		/* TSC halts in C2, so notify users */
-		mark_tsc_unstable("possible TSC halt in C2");
+		if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+			mark_tsc_unstable("possible TSC halt in C2");
 #endif
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks = ticks_elapsed(t1, t2);
@@ -579,7 +580,8 @@ static void acpi_processor_idle(void)
 
 #if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
 		/* TSC halts in C3, so notify users */
-		mark_tsc_unstable("TSC halts in C3");
+		if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+			mark_tsc_unstable("TSC halts in C3");
 #endif
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks = ticks_elapsed(t1, t2);
@@ -1456,7 +1458,8 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 
 #if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
 	/* TSC could halt in idle, so notify users */
-	mark_tsc_unstable("TSC halts in idle");;
+	if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+		mark_tsc_unstable("TSC halts in idle");;
 #endif
 	sleep_ticks = ticks_elapsed(t1, t2);
 
@@ -1567,7 +1570,8 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 
 #if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
 	/* TSC could halt in idle, so notify users */
-	mark_tsc_unstable("TSC halts in idle");
+	if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+		mark_tsc_unstable("TSC halts in idle");
 #endif
 	sleep_ticks = ticks_elapsed(t1, t2);
 	/* Tell the scheduler how much we idled: */
diff --git a/include/asm-x86/cpufeature_32.h b/include/asm-x86/cpufeature_32.h
index 49f14b4..bdc6e27 100644
--- a/include/asm-x86/cpufeature_32.h
+++ b/include/asm-x86/cpufeature_32.h
@@ -84,6 +84,8 @@
 #define X86_FEATURE_REP_GOOD   (3*32+16) /* rep microcode works well on this CPU */
 #define X86_FEATURE_MFENCE_RDTSC (3*32+17) /* "" Mfence synchronizes RDTSC */
 #define X86_FEATURE_LFENCE_RDTSC (3*32+18) /* "" Lfence synchronizes RDTSC */
+#define X86_FEATURE_TSC_RELIABLE (3*32+23) /* TSC is known to be reliable */
+#define X86_FEATURE_NONSTOP_TSC (3*32+24) /* TSC does not stop in C states */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
---

-- 
[ Luis Claudio R. Goncalves             Red Hat  -  Realtime Team ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

