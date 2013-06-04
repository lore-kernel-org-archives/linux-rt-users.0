From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/1] ARM mm: Fix RT life lock on ASID rollover
Date: Tue, 04 Jun 2013 23:12:56 +0200
Message-ID: <20130604212217.241724859@osadl.org>
References: <20130604211255.861340476@osadl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Will Deacon <will.deacon@arm.com>,
	Carsten Emde <C.Emde@osadl.org>
To: RT-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:53931 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144Ab3FDVcS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Jun 2013 17:32:18 -0400
Content-Disposition: inline; filename=arm-mm-remove-IPI-broadcasting-on-ASID-rollover.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The original mechanism to synchronize all online CPUs after ASID
reallocation used an IPI mechanism with IRQs enabled. This is a valid
mechanism in mainline. An RT kernel, however, may hang forever due to a
life lock between sending the IPI and waiting for the ASID lock to be
freed. Such hangers were observed and analyzed using JTAG hardware
debugging on an OMAP4430 board. Mean uptime was about two days with a
maximum of seven days observed once.

In 2012, Will Deacon provided a new ASID rollover synchronization
mechanism without IPI broadcasting. This *improved* a suboptimal
implementation in mainline - but it *fixed* a disastrous bug in RT
kernels that was extremely hard to decode.

After applying this backport of Will's original patch that appeared in
3.8, the test system no longer crashes; current uptime is 17 days.

Note that this patch applies to the most recent 3.0 RT kernel
3.0.80-rt108. The RT kernels 3.2, 3.4 and 3.6 need to be patched as well
in a similar way. From 3.8 onwards, RT kernels are ok.

Original commits:

37f47e3d62533c931b04cb409f2eb299e6342331
ARM: 7658/1: mm: fix race updating mm->context.id on ASID rollover

bf51bb82ccd9a74e9702d06107b23e54b27a5707
ARM: mm: use bitmap operations when allocating new ASIDs

4b883160835faf38c9356f0885cf491a1e661e88
ARM: mm: avoid taking ASID spinlock on fastpath

b5466f8728527a05a493cc4abe9e6f034a1bbaab
ARM: mm: remove IPI broadcasting on ASID rollover

ASIDs are allocated to MMU contexts based on a rolling counter. This
means that after 255 allocations we must invalidate all existing ASIDs
via an expensive IPI mechanism to synchronise all of the online CPUs and
ensure that all tasks execute with an ASID from the new generation.

This patch changes the rollover behaviour so that we rely instead on the
hardware broadcasting of the TLB invalidation to avoid the IPI calls.
This works by keeping track of the active ASID on each core, which is
then reserved in the case of a rollover so that currently scheduled
tasks can continue to run. For cores without hardware TLB broadcasting,
we keep track of pending flushes in a cpumask, so cores can flush their
local TLB before scheduling a new mm.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
 arch/arm/include/asm/mmu.h         |   13 -
 arch/arm/include/asm/mmu_context.h |   83 ++++------
 arch/arm/include/asm/tlbflush.h    |  263 ++++++++++++++--------------------
 arch/arm/mm/alignment.c            |    1 
 arch/arm/mm/context.c              |  284 +++++++++++++++++++++++--------------
 5 files changed, 324 insertions(+), 320 deletions(-)

Index: linux-3.0.80-rt108/arch/arm/include/asm/mmu.h
===================================================================
--- linux-3.0.80-rt108.orig/arch/arm/include/asm/mmu.h
+++ linux-3.0.80-rt108/arch/arm/include/asm/mmu.h
@@ -5,18 +5,15 @@
 
 typedef struct {
 #ifdef CONFIG_CPU_HAS_ASID
-	unsigned int id;
-	raw_spinlock_t id_lock;
+	atomic64_t	id;
 #endif
-	unsigned int kvm_seq;
+	unsigned int	kvm_seq;
 } mm_context_t;
 
 #ifdef CONFIG_CPU_HAS_ASID
-#define ASID(mm)	((mm)->context.id & 255)
-
-/* init_mm.context.id_lock should be initialized. */
-#define INIT_MM_CONTEXT(name)                                                 \
-	.context.id_lock    = __RAW_SPIN_LOCK_UNLOCKED(name.context.id_lock),
+#define ASID_BITS	8
+#define ASID_MASK	((~0ULL) << ASID_BITS)
+#define ASID(mm)	((mm)->context.id.counter & ~ASID_MASK)
 #else
 #define ASID(mm)	(0)
 #endif
Index: linux-3.0.80-rt108/arch/arm/include/asm/mmu_context.h
===================================================================
--- linux-3.0.80-rt108.orig/arch/arm/include/asm/mmu_context.h
+++ linux-3.0.80-rt108/arch/arm/include/asm/mmu_context.h
@@ -23,66 +23,52 @@ void __check_kvm_seq(struct mm_struct *m
 
 #ifdef CONFIG_CPU_HAS_ASID
 
-/*
- * On ARMv6, we have the following structure in the Context ID:
- *
- * 31                         7          0
- * +-------------------------+-----------+
- * |      process ID         |   ASID    |
- * +-------------------------+-----------+
- * |              context ID             |
- * +-------------------------------------+
- *
- * The ASID is used to tag entries in the CPU caches and TLBs.
- * The context ID is used by debuggers and trace logic, and
- * should be unique within all running processes.
- */
-#define ASID_BITS		8
-#define ASID_MASK		((~0) << ASID_BITS)
-#define ASID_FIRST_VERSION	(1 << ASID_BITS)
+void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk);
+#define init_new_context(tsk,mm)	({ atomic64_set(&mm->context.id, 0); 0; })
 
-extern unsigned int cpu_last_asid;
-#ifdef CONFIG_SMP
-DECLARE_PER_CPU(struct mm_struct *, current_mm);
-#endif
+DECLARE_PER_CPU(atomic64_t, active_asids);
 
-void __init_new_context(struct task_struct *tsk, struct mm_struct *mm);
-void __new_context(struct mm_struct *mm);
+#else	/* !CONFIG_CPU_HAS_ASID */
 
-static inline void check_context(struct mm_struct *mm)
-{
-	/*
-	 * This code is executed with interrupts enabled. Therefore,
-	 * mm->context.id cannot be updated to the latest ASID version
-	 * on a different CPU (and condition below not triggered)
-	 * without first getting an IPI to reset the context. The
-	 * alternative is to take a read_lock on mm->context.id_lock
-	 * (after changing its type to rwlock_t).
-	 */
-	if (unlikely((mm->context.id ^ cpu_last_asid) >> ASID_BITS))
-		__new_context(mm);
+#ifdef CONFIG_MMU
 
+static inline void check_and_switch_context(struct mm_struct *mm,
+					    struct task_struct *tsk)
+{
 	if (unlikely(mm->context.kvm_seq != init_mm.context.kvm_seq))
 		__check_kvm_seq(mm);
-}
-
-#define init_new_context(tsk,mm)	(__init_new_context(tsk,mm),0)
 
-#else
+	if (irqs_disabled())
+		/*
+		 * cpu_switch_mm() needs to flush the VIVT caches. To avoid
+		 * high interrupt latencies, defer the call and continue
+		 * running with the old mm. Since we only support UP systems
+		 * on non-ASID CPUs, the old mm will remain valid until the
+		 * finish_arch_post_lock_switch() call.
+		 */
+		set_ti_thread_flag(task_thread_info(tsk), TIF_SWITCH_MM);
+	else
+		cpu_switch_mm(mm->pgd, mm);
+}
 
-static inline void check_context(struct mm_struct *mm)
+#define finish_arch_post_lock_switch \
+	finish_arch_post_lock_switch
+static inline void finish_arch_post_lock_switch(void)
 {
-#ifdef CONFIG_MMU
-	if (unlikely(mm->context.kvm_seq != init_mm.context.kvm_seq))
-		__check_kvm_seq(mm);
-#endif
+	if (test_and_clear_thread_flag(TIF_SWITCH_MM)) {
+		struct mm_struct *mm = current->mm;
+		cpu_switch_mm(mm->pgd, mm);
+	}
 }
 
+#endif	/* CONFIG_MMU */
+
 #define init_new_context(tsk,mm)	0
 
-#endif
+#endif	/* CONFIG_CPU_HAS_ASID */
 
 #define destroy_context(mm)		do { } while(0)
+#define activate_mm(prev,next)		switch_mm(prev, next, NULL)
 
 /*
  * This is called when "tsk" is about to enter lazy TLB mode.
@@ -118,12 +104,7 @@ switch_mm(struct mm_struct *prev, struct
 		__flush_icache_all();
 #endif
 	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {
-#ifdef CONFIG_SMP
-		struct mm_struct **crt_mm = &per_cpu(current_mm, cpu);
-		*crt_mm = next;
-#endif
-		check_context(next);
-		cpu_switch_mm(next->pgd, next);
+		check_and_switch_context(next, tsk);
 		if (cache_is_vivt())
 			cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	}
Index: linux-3.0.80-rt108/arch/arm/include/asm/tlbflush.h
===================================================================
--- linux-3.0.80-rt108.orig/arch/arm/include/asm/tlbflush.h
+++ linux-3.0.80-rt108/arch/arm/include/asm/tlbflush.h
@@ -14,7 +14,6 @@
 
 #include <asm/glue.h>
 
-#define TLB_V3_PAGE	(1 << 0)
 #define TLB_V4_U_PAGE	(1 << 1)
 #define TLB_V4_D_PAGE	(1 << 2)
 #define TLB_V4_I_PAGE	(1 << 3)
@@ -22,7 +21,6 @@
 #define TLB_V6_D_PAGE	(1 << 5)
 #define TLB_V6_I_PAGE	(1 << 6)
 
-#define TLB_V3_FULL	(1 << 8)
 #define TLB_V4_U_FULL	(1 << 9)
 #define TLB_V4_D_FULL	(1 << 10)
 #define TLB_V4_I_FULL	(1 << 11)
@@ -34,16 +32,15 @@
 #define TLB_V6_D_ASID	(1 << 17)
 #define TLB_V6_I_ASID	(1 << 18)
 
-#define TLB_BTB		(1 << 28)
+#define TLB_V6_BP	(1 << 19)
 
 /* Unified Inner Shareable TLB operations (ARMv7 MP extensions) */
-#define TLB_V7_UIS_PAGE	(1 << 19)
-#define TLB_V7_UIS_FULL (1 << 20)
-#define TLB_V7_UIS_ASID (1 << 21)
-
-/* Inner Shareable BTB operation (ARMv7 MP extensions) */
-#define TLB_V7_IS_BTB	(1 << 22)
+#define TLB_V7_UIS_PAGE	(1 << 20)
+#define TLB_V7_UIS_FULL (1 << 21)
+#define TLB_V7_UIS_ASID (1 << 22)
+#define TLB_V7_UIS_BP	(1 << 23)
 
+#define TLB_BARRIER	(1 << 28)
 #define TLB_L2CLEAN_FR	(1 << 29)		/* Feroceon */
 #define TLB_DCLEAN	(1 << 30)
 #define TLB_WB		(1 << 31)
@@ -53,12 +50,11 @@
  *	=============
  *
  *	We have the following to choose from:
- *	  v3    - ARMv3
  *	  v4    - ARMv4 without write buffer
  *	  v4wb  - ARMv4 with write buffer without I TLB flush entry instruction
  *	  v4wbi - ARMv4 with write buffer with I TLB flush entry instruction
  *	  fr    - Feroceon (v4wbi with non-outer-cacheable page table walks)
- *	  fa    - Faraday (v4 with write buffer with UTLB and branch target buffer (BTB))
+ *	  fa    - Faraday (v4 with write buffer with UTLB)
  *	  v6wbi - ARMv6 with write buffer with I TLB flush entry instruction
  *	  v7wbi - identical to v6wbi
  */
@@ -69,21 +65,6 @@
 #define MULTI_TLB 1
 #endif
 
-#define v3_tlb_flags	(TLB_V3_FULL | TLB_V3_PAGE)
-
-#ifdef CONFIG_CPU_TLB_V3
-# define v3_possible_flags	v3_tlb_flags
-# define v3_always_flags	v3_tlb_flags
-# ifdef _TLB
-#  define MULTI_TLB 1
-# else
-#  define _TLB v3
-# endif
-#else
-# define v3_possible_flags	0
-# define v3_always_flags	(-1UL)
-#endif
-
 #define v4_tlb_flags	(TLB_V4_U_FULL | TLB_V4_U_PAGE)
 
 #ifdef CONFIG_CPU_TLB_V4WT
@@ -99,7 +80,7 @@
 # define v4_always_flags	(-1UL)
 #endif
 
-#define fa_tlb_flags	(TLB_WB | TLB_BTB | TLB_DCLEAN | \
+#define fa_tlb_flags	(TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
 			 TLB_V4_U_FULL | TLB_V4_U_PAGE)
 
 #ifdef CONFIG_CPU_TLB_FA
@@ -166,10 +147,11 @@
 # define v4wb_always_flags	(-1UL)
 #endif
 
-#define v6wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_BTB | \
+#define v6wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
 			 TLB_V6_I_FULL | TLB_V6_D_FULL | \
 			 TLB_V6_I_PAGE | TLB_V6_D_PAGE | \
-			 TLB_V6_I_ASID | TLB_V6_D_ASID)
+			 TLB_V6_I_ASID | TLB_V6_D_ASID | \
+			 TLB_V6_BP)
 
 #ifdef CONFIG_CPU_TLB_V6
 # define v6wbi_possible_flags	v6wbi_tlb_flags
@@ -184,10 +166,12 @@
 # define v6wbi_always_flags	(-1UL)
 #endif
 
-#define v7wbi_tlb_flags_smp	(TLB_WB | TLB_DCLEAN | TLB_V7_IS_BTB | \
-			 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | TLB_V7_UIS_ASID)
-#define v7wbi_tlb_flags_up	(TLB_WB | TLB_DCLEAN | TLB_BTB | \
-			 TLB_V6_U_FULL | TLB_V6_U_PAGE | TLB_V6_U_ASID)
+#define v7wbi_tlb_flags_smp	(TLB_WB | TLB_BARRIER | \
+				 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | \
+				 TLB_V7_UIS_ASID | TLB_V7_UIS_BP)
+#define v7wbi_tlb_flags_up	(TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
+				 TLB_V6_U_FULL | TLB_V6_U_PAGE | \
+				 TLB_V6_U_ASID | TLB_V6_BP)
 
 #ifdef CONFIG_CPU_TLB_V7
 
@@ -302,8 +286,7 @@ extern struct cpu_tlb_fns cpu_tlb;
  * implemented the "%?" method, but this has been discontinued due to too
  * many people getting it wrong.
  */
-#define possible_tlb_flags	(v3_possible_flags | \
-				 v4_possible_flags | \
+#define possible_tlb_flags	(v4_possible_flags | \
 				 v4wbi_possible_flags | \
 				 fr_possible_flags | \
 				 v4wb_possible_flags | \
@@ -311,8 +294,7 @@ extern struct cpu_tlb_fns cpu_tlb;
 				 v6wbi_possible_flags | \
 				 v7wbi_possible_flags)
 
-#define always_tlb_flags	(v3_always_flags & \
-				 v4_always_flags & \
+#define always_tlb_flags	(v4_always_flags & \
 				 v4wbi_always_flags & \
 				 fr_always_flags & \
 				 v4wb_always_flags & \
@@ -322,6 +304,21 @@ extern struct cpu_tlb_fns cpu_tlb;
 
 #define tlb_flag(f)	((always_tlb_flags & (f)) || (__tlb_flag & possible_tlb_flags & (f)))
 
+#define __tlb_op(f, insnarg, arg)					\
+	do {								\
+		if (always_tlb_flags & (f))				\
+			asm("mcr " insnarg				\
+			    : : "r" (arg) : "cc");			\
+		else if (possible_tlb_flags & (f))			\
+			asm("tst %1, %2\n\t"				\
+			    "mcrne " insnarg				\
+			    : : "r" (arg), "r" (__tlb_flag), "Ir" (f)	\
+			    : "cc");					\
+	} while (0)
+
+#define tlb_op(f, regs, arg)	__tlb_op(f, "p15, 0, %0, " regs, arg)
+#define tlb_l2_op(f, regs, arg)	__tlb_op(f, "p15, 1, %0, " regs, arg)
+
 static inline void local_flush_tlb_all(void)
 {
 	const int zero = 0;
@@ -330,26 +327,12 @@ static inline void local_flush_tlb_all(v
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (tlb_flag(TLB_V3_FULL))
-		asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (zero) : "cc");
-	if (tlb_flag(TLB_V4_U_FULL | TLB_V6_U_FULL))
-		asm("mcr p15, 0, %0, c8, c7, 0" : : "r" (zero) : "cc");
-	if (tlb_flag(TLB_V4_D_FULL | TLB_V6_D_FULL))
-		asm("mcr p15, 0, %0, c8, c6, 0" : : "r" (zero) : "cc");
-	if (tlb_flag(TLB_V4_I_FULL | TLB_V6_I_FULL))
-		asm("mcr p15, 0, %0, c8, c5, 0" : : "r" (zero) : "cc");
-	if (tlb_flag(TLB_V7_UIS_FULL))
-		asm("mcr p15, 0, %0, c8, c3, 0" : : "r" (zero) : "cc");
+	tlb_op(TLB_V4_U_FULL | TLB_V6_U_FULL, "c8, c7, 0", zero);
+	tlb_op(TLB_V4_D_FULL | TLB_V6_D_FULL, "c8, c6, 0", zero);
+	tlb_op(TLB_V4_I_FULL | TLB_V6_I_FULL, "c8, c5, 0", zero);
+	tlb_op(TLB_V7_UIS_FULL, "c8, c3, 0", zero);
 
-	if (tlb_flag(TLB_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero) : "cc");
-		dsb();
-		isb();
-	}
-	if (tlb_flag(TLB_V7_IS_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
+	if (tlb_flag(TLB_BARRIER)) {
 		dsb();
 		isb();
 	}
@@ -364,42 +347,26 @@ static inline void local_flush_tlb_mm(st
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
-		if (tlb_flag(TLB_V3_FULL))
-			asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (zero) : "cc");
-		if (tlb_flag(TLB_V4_U_FULL))
-			asm("mcr p15, 0, %0, c8, c7, 0" : : "r" (zero) : "cc");
-		if (tlb_flag(TLB_V4_D_FULL))
-			asm("mcr p15, 0, %0, c8, c6, 0" : : "r" (zero) : "cc");
-		if (tlb_flag(TLB_V4_I_FULL))
-			asm("mcr p15, 0, %0, c8, c5, 0" : : "r" (zero) : "cc");
+	if (possible_tlb_flags & (TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL)) {
+		if (cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
+			tlb_op(TLB_V4_U_FULL, "c8, c7, 0", zero);
+			tlb_op(TLB_V4_D_FULL, "c8, c6, 0", zero);
+			tlb_op(TLB_V4_I_FULL, "c8, c5, 0", zero);
+		}
+		put_cpu();
 	}
-	put_cpu();
 
-	if (tlb_flag(TLB_V6_U_ASID))
-		asm("mcr p15, 0, %0, c8, c7, 2" : : "r" (asid) : "cc");
-	if (tlb_flag(TLB_V6_D_ASID))
-		asm("mcr p15, 0, %0, c8, c6, 2" : : "r" (asid) : "cc");
-	if (tlb_flag(TLB_V6_I_ASID))
-		asm("mcr p15, 0, %0, c8, c5, 2" : : "r" (asid) : "cc");
-	if (tlb_flag(TLB_V7_UIS_ASID))
+	tlb_op(TLB_V6_U_ASID, "c8, c7, 2", asid);
+	tlb_op(TLB_V6_D_ASID, "c8, c6, 2", asid);
+	tlb_op(TLB_V6_I_ASID, "c8, c5, 2", asid);
 #ifdef CONFIG_ARM_ERRATA_720789
-		asm("mcr p15, 0, %0, c8, c3, 0" : : "r" (zero) : "cc");
+	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 0", zero);
 #else
-		asm("mcr p15, 0, %0, c8, c3, 2" : : "r" (asid) : "cc");
+	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 2", asid);
 #endif
 
-	if (tlb_flag(TLB_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero) : "cc");
+	if (tlb_flag(TLB_BARRIER))
 		dsb();
-	}
-	if (tlb_flag(TLB_V7_IS_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
-		dsb();
-		isb();
-	}
 }
 
 static inline void
@@ -413,43 +380,26 @@ local_flush_tlb_page(struct vm_area_stru
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
-		if (tlb_flag(TLB_V3_PAGE))
-			asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (uaddr) : "cc");
-		if (tlb_flag(TLB_V4_U_PAGE))
-			asm("mcr p15, 0, %0, c8, c7, 1" : : "r" (uaddr) : "cc");
-		if (tlb_flag(TLB_V4_D_PAGE))
-			asm("mcr p15, 0, %0, c8, c6, 1" : : "r" (uaddr) : "cc");
-		if (tlb_flag(TLB_V4_I_PAGE))
-			asm("mcr p15, 0, %0, c8, c5, 1" : : "r" (uaddr) : "cc");
+	if (possible_tlb_flags & (TLB_V4_U_PAGE|TLB_V4_D_PAGE|TLB_V4_I_PAGE|TLB_V4_I_FULL) &&
+	    cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
+		tlb_op(TLB_V4_U_PAGE, "c8, c7, 1", uaddr);
+		tlb_op(TLB_V4_D_PAGE, "c8, c6, 1", uaddr);
+		tlb_op(TLB_V4_I_PAGE, "c8, c5, 1", uaddr);
 		if (!tlb_flag(TLB_V4_I_PAGE) && tlb_flag(TLB_V4_I_FULL))
 			asm("mcr p15, 0, %0, c8, c5, 0" : : "r" (zero) : "cc");
 	}
 
-	if (tlb_flag(TLB_V6_U_PAGE))
-		asm("mcr p15, 0, %0, c8, c7, 1" : : "r" (uaddr) : "cc");
-	if (tlb_flag(TLB_V6_D_PAGE))
-		asm("mcr p15, 0, %0, c8, c6, 1" : : "r" (uaddr) : "cc");
-	if (tlb_flag(TLB_V6_I_PAGE))
-		asm("mcr p15, 0, %0, c8, c5, 1" : : "r" (uaddr) : "cc");
-	if (tlb_flag(TLB_V7_UIS_PAGE))
+	tlb_op(TLB_V6_U_PAGE, "c8, c7, 1", uaddr);
+	tlb_op(TLB_V6_D_PAGE, "c8, c6, 1", uaddr);
+	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", uaddr);
 #ifdef CONFIG_ARM_ERRATA_720789
-		asm("mcr p15, 0, %0, c8, c3, 3" : : "r" (uaddr & PAGE_MASK) : "cc");
+	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 3", uaddr & PAGE_MASK);
 #else
-		asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (uaddr) : "cc");
+	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 1", uaddr);
 #endif
 
-	if (tlb_flag(TLB_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero) : "cc");
+	if (tlb_flag(TLB_BARRIER))
 		dsb();
-	}
-	if (tlb_flag(TLB_V7_IS_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
-		dsb();
-		isb();
-	}
 }
 
 static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
@@ -462,40 +412,52 @@ static inline void local_flush_tlb_kerne
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (tlb_flag(TLB_V3_PAGE))
-		asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V4_U_PAGE))
-		asm("mcr p15, 0, %0, c8, c7, 1" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V4_D_PAGE))
-		asm("mcr p15, 0, %0, c8, c6, 1" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V4_I_PAGE))
-		asm("mcr p15, 0, %0, c8, c5, 1" : : "r" (kaddr) : "cc");
+	tlb_op(TLB_V4_U_PAGE, "c8, c7, 1", kaddr);
+	tlb_op(TLB_V4_D_PAGE, "c8, c6, 1", kaddr);
+	tlb_op(TLB_V4_I_PAGE, "c8, c5, 1", kaddr);
 	if (!tlb_flag(TLB_V4_I_PAGE) && tlb_flag(TLB_V4_I_FULL))
 		asm("mcr p15, 0, %0, c8, c5, 0" : : "r" (zero) : "cc");
 
-	if (tlb_flag(TLB_V6_U_PAGE))
-		asm("mcr p15, 0, %0, c8, c7, 1" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V6_D_PAGE))
-		asm("mcr p15, 0, %0, c8, c6, 1" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V6_I_PAGE))
-		asm("mcr p15, 0, %0, c8, c5, 1" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V7_UIS_PAGE))
-		asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (kaddr) : "cc");
-
-	if (tlb_flag(TLB_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero) : "cc");
+	tlb_op(TLB_V6_U_PAGE, "c8, c7, 1", kaddr);
+	tlb_op(TLB_V6_D_PAGE, "c8, c6, 1", kaddr);
+	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", kaddr);
+	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 1", kaddr);
+
+	if (tlb_flag(TLB_BARRIER)) {
 		dsb();
 		isb();
 	}
-	if (tlb_flag(TLB_V7_IS_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
-		dsb();
+}
+
+static inline void local_flush_bp_all(void)
+{
+	const int zero = 0;
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	if (tlb_flag(TLB_V7_UIS_BP))
+		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
+	else if (tlb_flag(TLB_V6_BP))
+		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero));
+
+	if (tlb_flag(TLB_BARRIER))
 		isb();
-	}
 }
 
+#ifdef CONFIG_ARM_ERRATA_798181
+static inline void dummy_flush_tlb_a15_erratum(void)
+{
+	/*
+	 * Dummy TLBIMVAIS. Using the unmapped address 0 and ASID 0.
+	 */
+	asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
+	dsb();
+}
+#else
+static inline void dummy_flush_tlb_a15_erratum(void)
+{
+}
+#endif
+
 /*
  *	flush_pmd_entry
  *
@@ -509,35 +471,26 @@ static inline void local_flush_tlb_kerne
  *	these operations.  This is typically used when we are removing
  *	PMD entries.
  */
-static inline void flush_pmd_entry(pmd_t *pmd)
+static inline void flush_pmd_entry(void *pmd)
 {
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
-	if (tlb_flag(TLB_DCLEAN))
-		asm("mcr	p15, 0, %0, c7, c10, 1	@ flush_pmd"
-			: : "r" (pmd) : "cc");
-
-	if (tlb_flag(TLB_L2CLEAN_FR))
-		asm("mcr	p15, 1, %0, c15, c9, 1  @ L2 flush_pmd"
-			: : "r" (pmd) : "cc");
+	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
+	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
 
 	if (tlb_flag(TLB_WB))
 		dsb();
 }
 
-static inline void clean_pmd_entry(pmd_t *pmd)
+static inline void clean_pmd_entry(void *pmd)
 {
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
-	if (tlb_flag(TLB_DCLEAN))
-		asm("mcr	p15, 0, %0, c7, c10, 1	@ flush_pmd"
-			: : "r" (pmd) : "cc");
-
-	if (tlb_flag(TLB_L2CLEAN_FR))
-		asm("mcr	p15, 1, %0, c15, c9, 1  @ L2 flush_pmd"
-			: : "r" (pmd) : "cc");
+	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
+	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
 }
 
+#undef tlb_op
 #undef tlb_flag
 #undef always_tlb_flags
 #undef possible_tlb_flags
@@ -555,6 +508,7 @@ static inline void clean_pmd_entry(pmd_t
 #define flush_tlb_kernel_page	local_flush_tlb_kernel_page
 #define flush_tlb_range		local_flush_tlb_range
 #define flush_tlb_kernel_range	local_flush_tlb_kernel_range
+#define flush_bp_all		local_flush_bp_all
 #else
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
@@ -562,6 +516,7 @@ extern void flush_tlb_page(struct vm_are
 extern void flush_tlb_kernel_page(unsigned long kaddr);
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+extern void flush_bp_all(void);
 #endif
 
 /*
Index: linux-3.0.80-rt108/arch/arm/mm/alignment.c
===================================================================
--- linux-3.0.80-rt108.orig/arch/arm/mm/alignment.c
+++ linux-3.0.80-rt108/arch/arm/mm/alignment.c
@@ -819,6 +819,7 @@ do_alignment(unsigned long addr, unsigne
 		break;
 
 	case 0x08000000:	/* ldm or stm, or thumb-2 32bit instruction */
+		offset.un = 0;
 		if (thumb2_32b)
 			handler = do_alignment_t32_to_handler(&instr, regs, &offset);
 		else
Index: linux-3.0.80-rt108/arch/arm/mm/context.c
===================================================================
--- linux-3.0.80-rt108.orig/arch/arm/mm/context.c
+++ linux-3.0.80-rt108/arch/arm/mm/context.c
@@ -2,6 +2,9 @@
  *  linux/arch/arm/mm/context.c
  *
  *  Copyright (C) 2002-2003 Deep Blue Solutions Ltd, all rights reserved.
+ *  Copyright (C) 2012 ARM Limited
+ *
+ *  Author: Will Deacon <will.deacon@arm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,144 +17,211 @@
 #include <linux/percpu.h>
 
 #include <asm/mmu_context.h>
+#include <asm/smp_plat.h>
+#include <asm/thread_notify.h>
 #include <asm/tlbflush.h>
 
-static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
-unsigned int cpu_last_asid = ASID_FIRST_VERSION;
-#ifdef CONFIG_SMP
-DEFINE_PER_CPU(struct mm_struct *, current_mm);
-#endif
-
 /*
- * We fork()ed a process, and we need a new context for the child
- * to run in.  We reserve version 0 for initial tasks so we will
- * always allocate an ASID. The ASID 0 is reserved for the TTBR
- * register changing sequence.
+ * On ARMv6, we have the following structure in the Context ID:
+ *
+ * 31                         7          0
+ * +-------------------------+-----------+
+ * |      process ID         |   ASID    |
+ * +-------------------------+-----------+
+ * |              context ID             |
+ * +-------------------------------------+
+ *
+ * The ASID is used to tag entries in the CPU caches and TLBs.
+ * The context ID is used by debuggers and trace logic, and
+ * should be unique within all running processes.
+ *
+ * In big endian operation, the two 32 bit words are swapped if accesed by
+ * non 64-bit operations.
  */
-void __init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	mm->context.id = 0;
-	raw_spin_lock_init(&mm->context.id_lock);
-}
+#define ASID_FIRST_VERSION	(1ULL << ASID_BITS)
+#define NUM_USER_ASIDS		(ASID_FIRST_VERSION - 1)
 
-static void flush_context(void)
-{
-	/* set the reserved ASID before flushing the TLB */
-	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (0));
-	isb();
-	local_flush_tlb_all();
-	if (icache_is_vivt_asid_tagged()) {
-		__flush_icache_all();
-		dsb();
-	}
-}
+#define ASID_TO_IDX(asid)	((asid & ~ASID_MASK) - 1)
+#define IDX_TO_ASID(idx)	((idx + 1) & ~ASID_MASK)
 
-#ifdef CONFIG_SMP
+static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
+static atomic64_t asid_generation = ATOMIC64_INIT(ASID_FIRST_VERSION);
+static DECLARE_BITMAP(asid_map, NUM_USER_ASIDS);
+
+DEFINE_PER_CPU(atomic64_t, active_asids);
+static DEFINE_PER_CPU(u64, reserved_asids);
+static cpumask_t tlb_flush_pending;
 
-static void set_mm_context(struct mm_struct *mm, unsigned int asid)
+#ifdef CONFIG_ARM_LPAE
+static void cpu_set_reserved_ttbr0(void)
 {
-	unsigned long flags;
+	unsigned long ttbl = __pa(swapper_pg_dir);
+	unsigned long ttbh = 0;
 
 	/*
-	 * Locking needed for multi-threaded applications where the
-	 * same mm->context.id could be set from different CPUs during
-	 * the broadcast. This function is also called via IPI so the
-	 * mm->context.id_lock has to be IRQ-safe.
+	 * Set TTBR0 to swapper_pg_dir which contains only global entries. The
+	 * ASID is set to 0.
 	 */
-	raw_spin_lock_irqsave(&mm->context.id_lock, flags);
-	if (likely((mm->context.id ^ cpu_last_asid) >> ASID_BITS)) {
-		/*
-		 * Old version of ASID found. Set the new one and
-		 * reset mm_cpumask(mm).
-		 */
-		mm->context.id = asid;
-		cpumask_clear(mm_cpumask(mm));
-	}
-	raw_spin_unlock_irqrestore(&mm->context.id_lock, flags);
+	asm volatile(
+	"	mcrr	p15, 0, %0, %1, c2		@ set TTBR0\n"
+	:
+	: "r" (ttbl), "r" (ttbh));
+	isb();
+}
+#else
+static void cpu_set_reserved_ttbr0(void)
+{
+	u32 ttb;
+	/* Copy TTBR1 into TTBR0 */
+	asm volatile(
+	"	mrc	p15, 0, %0, c2, c0, 1		@ read TTBR1\n"
+	"	mcr	p15, 0, %0, c2, c0, 0		@ set TTBR0\n"
+	: "=r" (ttb));
+	isb();
+}
+#endif
 
-	/*
-	 * Set the mm_cpumask(mm) bit for the current CPU.
-	 */
-	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+static int contextidr_notifier(struct notifier_block *unused, unsigned long cmd,
+			       void *t)
+{
+	u32 contextidr;
+	pid_t pid;
+	struct thread_info *thread = t;
+
+	if (cmd != THREAD_NOTIFY_SWITCH)
+		return NOTIFY_DONE;
+
+	pid = task_pid_nr(thread->task) << ASID_BITS;
+	asm volatile(
+	"	mrc	p15, 0, %0, c13, c0, 1\n"
+	"	and	%0, %0, %2\n"
+	"	orr	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c13, c0, 1\n"
+	: "=r" (contextidr), "+r" (pid)
+	: "I" (~ASID_MASK));
+	isb();
+
+	return NOTIFY_OK;
 }
 
-/*
- * Reset the ASID on the current CPU. This function call is broadcast
- * from the CPU handling the ASID rollover and holding cpu_asid_lock.
- */
-static void reset_context(void *info)
+static struct notifier_block contextidr_notifier_block = {
+	.notifier_call = contextidr_notifier,
+};
+
+static int __init contextidr_notifier_init(void)
 {
-	unsigned int asid;
-	unsigned int cpu = smp_processor_id();
-	struct mm_struct *mm = per_cpu(current_mm, cpu);
+	return thread_register_notifier(&contextidr_notifier_block);
+}
+arch_initcall(contextidr_notifier_init);
+#endif
 
-	/*
-	 * Check if a current_mm was set on this CPU as it might still
-	 * be in the early booting stages and using the reserved ASID.
-	 */
-	if (!mm)
-		return;
+static void flush_context(unsigned int cpu)
+{
+	int i;
+	u64 asid;
 
-	smp_rmb();
-	asid = cpu_last_asid + cpu + 1;
+	/* Update the list of reserved ASIDs and the ASID bitmap. */
+	bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
+	for_each_possible_cpu(i) {
+		if (i == cpu) {
+			asid = 0;
+		} else {
+			asid = atomic64_xchg(&per_cpu(active_asids, i), 0);
+			__set_bit(ASID_TO_IDX(asid), asid_map);
+		}
+		per_cpu(reserved_asids, i) = asid;
+	}
 
-	flush_context();
-	set_mm_context(mm, asid);
+	/* Queue a TLB invalidate and flush the I-cache if necessary. */
+	if (!tlb_ops_need_broadcast())
+		cpumask_set_cpu(cpu, &tlb_flush_pending);
+	else
+		cpumask_setall(&tlb_flush_pending);
 
-	/* set the new ASID */
-	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (mm->context.id));
-	isb();
+	if (icache_is_vivt_asid_tagged())
+		__flush_icache_all();
 }
 
-#else
-
-static inline void set_mm_context(struct mm_struct *mm, unsigned int asid)
+static int is_reserved_asid(u64 asid)
 {
-	mm->context.id = asid;
-	cpumask_copy(mm_cpumask(mm), cpumask_of(smp_processor_id()));
+	int cpu;
+	for_each_possible_cpu(cpu)
+		if (per_cpu(reserved_asids, cpu) == asid)
+			return 1;
+	return 0;
 }
 
-#endif
+static u64 new_context(struct mm_struct *mm, unsigned int cpu)
+{
+	u64 asid = atomic64_read(&mm->context.id);
+	u64 generation = atomic64_read(&asid_generation);
+
+	if (asid != 0 && is_reserved_asid(asid)) {
+		/*
+		 * Our current ASID was active during a rollover, we can
+		 * continue to use it and this was just a false alarm.
+		 */
+		asid = generation | (asid & ~ASID_MASK);
+	} else {
+		/*
+		 * Allocate a free ASID. If we can't find one, take a
+		 * note of the currently active ASIDs and mark the TLBs
+		 * as requiring flushes.
+		 */
+		asid = find_first_zero_bit(asid_map, NUM_USER_ASIDS);
+		if (asid == NUM_USER_ASIDS) {
+			generation = atomic64_add_return(ASID_FIRST_VERSION,
+							 &asid_generation);
+			flush_context(cpu);
+			asid = find_first_zero_bit(asid_map, NUM_USER_ASIDS);
+		}
+		__set_bit(asid, asid_map);
+		asid = generation | IDX_TO_ASID(asid);
+		cpumask_clear(mm_cpumask(mm));
+	}
+
+	return asid;
+}
 
-void __new_context(struct mm_struct *mm)
+void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 {
-	unsigned int asid;
+	unsigned long flags;
+	unsigned int cpu = smp_processor_id();
+	u64 asid;
+
+	if (unlikely(mm->context.kvm_seq != init_mm.context.kvm_seq))
+		__check_kvm_seq(mm);
 
-	raw_spin_lock(&cpu_asid_lock);
-#ifdef CONFIG_SMP
 	/*
-	 * Check the ASID again, in case the change was broadcast from
-	 * another CPU before we acquired the lock.
+	 * Required during context switch to avoid speculative page table
+	 * walking with the wrong TTBR.
 	 */
-	if (unlikely(((mm->context.id ^ cpu_last_asid) >> ASID_BITS) == 0)) {
-		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
-		raw_spin_unlock(&cpu_asid_lock);
-		return;
+	cpu_set_reserved_ttbr0();
+
+	asid = atomic64_read(&mm->context.id);
+	if (!((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS)
+	    && atomic64_xchg(&per_cpu(active_asids, cpu), asid))
+		goto switch_mm_fastpath;
+
+	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+	/* Check that our ASID belongs to the current generation. */
+	asid = atomic64_read(&mm->context.id);
+	if ((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS) {
+		asid = new_context(mm, cpu);
+		atomic64_set(&mm->context.id, asid);
 	}
-#endif
-	/*
-	 * At this point, it is guaranteed that the current mm (with
-	 * an old ASID) isn't active on any other CPU since the ASIDs
-	 * are changed simultaneously via IPI.
-	 */
-	asid = ++cpu_last_asid;
-	if (asid == 0)
-		asid = cpu_last_asid = ASID_FIRST_VERSION;
 
-	/*
-	 * If we've used up all our ASIDs, we need
-	 * to start a new version and flush the TLB.
-	 */
-	if (unlikely((asid & ~ASID_MASK) == 0)) {
-		asid = cpu_last_asid + smp_processor_id() + 1;
-		flush_context();
-#ifdef CONFIG_SMP
-		smp_wmb();
-		smp_call_function(reset_context, NULL, 1);
-#endif
-		cpu_last_asid += NR_CPUS;
+	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending)) {
+		local_flush_bp_all();
+		local_flush_tlb_all();
+		dummy_flush_tlb_a15_erratum();
 	}
 
-	set_mm_context(mm, asid);
-	raw_spin_unlock(&cpu_asid_lock);
+	atomic64_set(&per_cpu(active_asids, cpu), asid);
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
+	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+
+switch_mm_fastpath:
+	cpu_switch_mm(mm->pgd, mm);
 }

