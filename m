Return-Path: <SRS0=oJtU=EF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F49C5517A
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Oct 2020 19:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9F7221EB
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Oct 2020 19:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZBAjqfBm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xI2Fe0qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgJ3TUR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Oct 2020 15:20:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44250 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgJ3TTF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Oct 2020 15:19:05 -0400
Date:   Fri, 30 Oct 2020 20:18:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604085534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=w23QLRvrES9I/gxowj2RxqSm8LkuZbxKSfkzxvcVP8Q=;
        b=ZBAjqfBmvlRZ6qQxVQ1ZEfBIN/vfA/fchJujGe7HePn5E4Hujzo3/5wHwOY0b2cU6aMq5Y
        DLelHMD8ZA4rjcXQMECS+cfO0vnRvhb5PPN3DWLyHK59wpulPOyfoBEAt605JrsAVNeRhZ
        i1OTX0nmiXdicdviiH8nC2M3d2yJE7Wma7/RAS/QeB0ETfl0DnfgTZhELE+vk1DrxlIk6y
        SkPG0smZph4ajYDgdyShpEiotMhr3v1yo8do0J5acvFeXgGoJos95kiKSxTTTSI//AfSBb
        drAh34Tl0mfmJKle2NXSk9kJY5E2yu3Nx3hORQ0p0xh1R4epF7c0axCSHg6V9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604085534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=w23QLRvrES9I/gxowj2RxqSm8LkuZbxKSfkzxvcVP8Q=;
        b=xI2Fe0qmNAoCRucm5eOfu42jIwnh0DztRPwGNHA1xw4IJmm1C2UUvydwYW3DawiCYBhxxw
        Z15k4YPPN9NeW+Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10-rc1-rt2
Message-ID: <20201030191853.raabwjou753fk4sh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10-rc1-rt2 patch set. 

Changes since v5.10-rc1-rt1:

  - Add Thomas Gleixner's "Preemptible variant of kmap_atomic & friends"
    series.

  - Apply patch by Paul E. McKenney which avoids a warning while a RCU
    stall is printed.

  - The last update of block-mq patches can trigger a warning if used by
    some drivers (USB storage for instance). Reported by Mike Galbraith.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.10-rc1-rt1 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10-rc1-rt1-rt2.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc1-rt2

The RT patch against v5.10-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc1-rt2.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc1-rt2.tar.xz

Sebastian

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 0a89cc9def651..d8804001d5507 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -507,6 +507,7 @@ config LINUX_RAM_BASE
 config HIGHMEM
 	bool "High Memory Support"
 	select ARCH_DISCONTIGMEM_ENABLE
+	select KMAP_LOCAL
 	help
 	  With ARC 2G:2G address split, only upper 2G is directly addressable by
 	  kernel. Enable this to potentially allow access to rest of 2G and PAE
diff --git a/arch/arc/include/asm/highmem.h b/arch/arc/include/asm/highmem.h
index 6e5eafb3afdd4..6291890eaafaf 100644
--- a/arch/arc/include/asm/highmem.h
+++ b/arch/arc/include/asm/highmem.h
@@ -15,7 +15,10 @@
 #define FIXMAP_BASE		(PAGE_OFFSET - FIXMAP_SIZE - PKMAP_SIZE)
 #define FIXMAP_SIZE		PGDIR_SIZE	/* only 1 PGD worth */
 #define KM_TYPE_NR		((FIXMAP_SIZE >> PAGE_SHIFT)/NR_CPUS)
-#define FIXMAP_ADDR(nr)		(FIXMAP_BASE + ((nr) << PAGE_SHIFT))
+
+#define FIX_KMAP_BEGIN		(0)
+#define FIX_KMAP_END		((FIXMAP_SIZE >> PAGE_SHIFT) - 1)
+#define FIXADDR_TOP		(FIXMAP_BASE + FIXMAP_SIZE - PAGE_SIZE)
 
 /* start after fixmap area */
 #define PKMAP_BASE		(FIXMAP_BASE + FIXMAP_SIZE)
@@ -29,6 +32,9 @@
 
 extern void kmap_init(void);
 
+#define arch_kmap_local_post_unmap(vaddr)			\
+	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE)
+
 static inline void flush_cache_kmaps(void)
 {
 	flush_cache_all();
diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index 1b9f473c63693..b74ae42026016 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -47,48 +47,6 @@
  */
 
 extern pte_t * pkmap_page_table;
-static pte_t * fixmap_page_table;
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	int idx, cpu_idx;
-	unsigned long vaddr;
-
-	cpu_idx = kmap_atomic_idx_push();
-	idx = cpu_idx + KM_TYPE_NR * smp_processor_id();
-	vaddr = FIXMAP_ADDR(idx);
-
-	set_pte_at(&init_mm, vaddr, fixmap_page_table + idx,
-		   mk_pte(page, prot));
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kv)
-{
-	unsigned long kvaddr = (unsigned long)kv;
-
-	if (kvaddr >= FIXMAP_BASE && kvaddr < (FIXMAP_BASE + FIXMAP_SIZE)) {
-
-		/*
-		 * Because preemption is disabled, this vaddr can be associated
-		 * with the current allocated index.
-		 * But in case of multiple live kmap_atomic(), it still relies on
-		 * callers to unmap in right order.
-		 */
-		int cpu_idx = kmap_atomic_idx();
-		int idx = cpu_idx + KM_TYPE_NR * smp_processor_id();
-
-		WARN_ON(kvaddr != FIXMAP_ADDR(idx));
-
-		pte_clear(&init_mm, kvaddr, fixmap_page_table + idx);
-		local_flush_tlb_kernel_range(kvaddr, kvaddr + PAGE_SIZE);
-
-		kmap_atomic_idx_pop();
-	}
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
 
 static noinline pte_t * __init alloc_kmap_pgtable(unsigned long kvaddr)
 {
@@ -113,5 +71,5 @@ void __init kmap_init(void)
 	pkmap_page_table = alloc_kmap_pgtable(PKMAP_BASE);
 
 	BUILD_BUG_ON(LAST_PKMAP > PTRS_PER_PTE);
-	fixmap_page_table = alloc_kmap_pgtable(FIXMAP_BASE);
+	alloc_kmap_pgtable(FIXMAP_BASE);
 }
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0318886de5297..f1fb6e092d96e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1501,6 +1501,7 @@ config HAVE_ARCH_PFN_VALID
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU
+	select KMAP_LOCAL
 	help
 	  The address space of ARM processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index 31811be38d781..99a99862c4744 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -46,19 +46,32 @@ extern pte_t *pkmap_page_table;
 
 #ifdef ARCH_NEEDS_KMAP_HIGH_GET
 extern void *kmap_high_get(struct page *page);
-#else
+
+static inline void *arch_kmap_local_high_get(struct page *page)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !cache_is_vivt())
+		return NULL;
+	return kmap_high_get(page);
+}
+#define arch_kmap_local_high_get arch_kmap_local_high_get
+
+#else /* ARCH_NEEDS_KMAP_HIGH_GET */
 static inline void *kmap_high_get(struct page *page)
 {
 	return NULL;
 }
-#endif
+#endif /* !ARCH_NEEDS_KMAP_HIGH_GET */
 
-/*
- * The following functions are already defined by <linux/highmem.h>
- * when CONFIG_HIGHMEM is not set.
- */
-#ifdef CONFIG_HIGHMEM
-extern void *kmap_atomic_pfn(unsigned long pfn);
-#endif
+#define arch_kmap_local_post_map(vaddr, pteval)				\
+	local_flush_tlb_kernel_page(vaddr)
+
+#define arch_kmap_local_pre_unmap(vaddr)				\
+do {									\
+	if (cache_is_vivt())						\
+		__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);	\
+} while (0)
+
+#define arch_kmap_local_post_unmap(vaddr)				\
+	local_flush_tlb_kernel_page(vaddr)
 
 #endif
diff --git a/arch/arm/include/asm/switch_to.h b/arch/arm/include/asm/switch_to.h
index 285e6248454fc..007d8fea71572 100644
--- a/arch/arm/include/asm/switch_to.h
+++ b/arch/arm/include/asm/switch_to.h
@@ -4,13 +4,6 @@
 
 #include <linux/thread_info.h>
 
-#if defined CONFIG_PREEMPT_RT && defined CONFIG_HIGHMEM
-void switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p);
-#else
-static inline void
-switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p) { }
-#endif
-
 /*
  * For v7 SMP cores running a preemptible kernel we may be pre-empted
  * during a TLB maintenance operation, so execute an inner-shareable dsb
@@ -33,7 +26,6 @@ extern struct task_struct *__switch_to(struct task_struct *, struct thread_info
 #define switch_to(prev,next,last)					\
 do {									\
 	__complete_pending_tlbi();					\
-	switch_kmaps(prev, next);					\
 	last = __switch_to(prev,task_thread_info(prev), task_thread_info(next));	\
 } while (0)
 
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7cb1699fbfc4f..c4ce477c52611 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_MODULES)		+= proc-syms.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
-obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_ARM_PV_FIXUP)	+= pv-fixup-asm.o
 
diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
deleted file mode 100644
index 954a115f62054..0000000000000
--- a/arch/arm/mm/highmem.c
+++ /dev/null
@@ -1,162 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mm/highmem.c -- ARM highmem support
- *
- * Author:	Nicolas Pitre
- * Created:	september 8, 2008
- * Copyright:	Marvell Semiconductors Inc.
- */
-
-#include <linux/module.h>
-#include <linux/highmem.h>
-#include <linux/interrupt.h>
-#include <asm/fixmap.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-#include "mm.h"
-
-static inline void set_fixmap_pte(int idx, pte_t pte)
-{
-	unsigned long vaddr = __fix_to_virt(idx);
-	pte_t *ptep = virt_to_kpte(vaddr);
-
-	set_pte_ext(ptep, pte, 0);
-	local_flush_tlb_kernel_page(vaddr);
-}
-
-static inline pte_t get_fixmap_pte(unsigned long vaddr)
-{
-	pte_t *ptep = virt_to_kpte(vaddr);
-
-	return *ptep;
-}
-
-static unsigned int fixmap_idx(int type)
-{
-	return FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
-}
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	pte_t pte = mk_pte(page, kmap_prot);
-	unsigned int idx;
-	unsigned long vaddr;
-	void *kmap;
-	int type;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	/*
-	 * There is no cache coherency issue when non VIVT, so force the
-	 * dedicated kmap usage for better debugging purposes in that case.
-	 */
-	if (!cache_is_vivt())
-		kmap = NULL;
-	else
-#endif
-		kmap = kmap_high_get(page);
-	if (kmap)
-		return kmap;
-
-	type = kmap_atomic_idx_push();
-
-	idx = fixmap_idx(type);
-	vaddr = __fix_to_virt(idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	/*
-	 * With debugging enabled, kunmap_atomic forces that entry to 0.
-	 * Make sure it was indeed properly unmapped.
-	 */
-	BUG_ON(!pte_none(get_fixmap_pte(vaddr)));
-#endif
-#ifdef CONFIG_PREEMPT_RT
-	current->kmap_pte[type] = pte;
-#endif
-	/*
-	 * When debugging is off, kunmap_atomic leaves the previous mapping
-	 * in place, so the contained TLB flush ensures the TLB is updated
-	 * with the new mapping.
-	 */
-	set_fixmap_pte(idx, pte);
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int idx, type;
-
-	if (kvaddr >= (void *)FIXADDR_START) {
-		type = kmap_atomic_idx();
-		idx = fixmap_idx(type);
-
-		if (cache_is_vivt())
-			__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
-#ifdef CONFIG_PREEMPT_RT
-		current->kmap_pte[type] = __pte(0);
-#endif
-#ifdef CONFIG_DEBUG_HIGHMEM
-		BUG_ON(vaddr != __fix_to_virt(idx));
-#else
-		(void) idx;  /* to kill a warning */
-#endif
-		set_fixmap_pte(idx, __pte(0));
-		kmap_atomic_idx_pop();
-	} else if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
-		/* this address was obtained through kmap_high_get() */
-		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
-	}
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	pte_t pte = pfn_pte(pfn, kmap_prot);
-	unsigned long vaddr;
-	int idx, type;
-	struct page *page = pfn_to_page(pfn);
-
-	migrate_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
-
-	type = kmap_atomic_idx_push();
-	idx = fixmap_idx(type);
-	vaddr = __fix_to_virt(idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(get_fixmap_pte(vaddr)));
-#endif
-#ifdef CONFIG_PREEMPT_RT
-	current->kmap_pte[type] = pte;
-#endif
-	set_fixmap_pte(idx, pte);
-
-	return (void *)vaddr;
-}
-
-#if defined CONFIG_PREEMPT_RT
-void switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p)
-{
-	int i;
-
-	/*
-	 * Clear @prev's kmap_atomic mappings
-	 */
-	for (i = 0; i < prev_p->kmap_idx; i++) {
-		int idx = fixmap_idx(i);
-
-		set_fixmap_pte(idx, __pte(0));
-	}
-	/*
-	 * Restore @next_p's kmap_atomic mappings
-	 */
-	for (i = 0; i < next_p->kmap_idx; i++) {
-		int idx = fixmap_idx(i);
-
-		if (!pte_none(next_p->kmap_pte[i]))
-			set_fixmap_pte(idx, next_p->kmap_pte[i]);
-	}
-}
-#endif
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 268fad5f51cf4..7a86481a22ff7 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -286,6 +286,7 @@ config NR_CPUS
 config HIGHMEM
 	bool "High Memory Support"
 	depends on !CPU_CK610
+	select KMAP_LOCAL
 	default y
 
 config FORCE_MAX_ZONEORDER
diff --git a/arch/csky/include/asm/highmem.h b/arch/csky/include/asm/highmem.h
index 14645e3d5cd52..d22f0db710346 100644
--- a/arch/csky/include/asm/highmem.h
+++ b/arch/csky/include/asm/highmem.h
@@ -32,10 +32,12 @@ extern pte_t *pkmap_page_table;
 
 #define ARCH_HAS_KMAP_FLUSH_TLB
 extern void kmap_flush_tlb(unsigned long addr);
-extern void *kmap_atomic_pfn(unsigned long pfn);
 
 #define flush_cache_kmaps() do {} while (0)
 
+#define arch_kmap_local_post_map(vaddr, pteval)	kmap_flush_tlb(vaddr)
+#define arch_kmap_local_post_unmap(vaddr)	kmap_flush_tlb(vaddr)
+
 extern void kmap_init(void);
 
 #endif /* __KERNEL__ */
diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 89c10800a002e..4161df3c6c152 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -9,8 +9,6 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-static pte_t *kmap_pte;
-
 unsigned long highstart_pfn, highend_pfn;
 
 void kmap_flush_tlb(unsigned long addr)
@@ -19,67 +17,7 @@ void kmap_flush_tlb(unsigned long addr)
 }
 EXPORT_SYMBOL(kmap_flush_tlb);
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte - idx)));
-#endif
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-	flush_tlb_one((unsigned long)vaddr);
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int idx;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	idx = KM_TYPE_NR*smp_processor_id() + kmap_atomic_idx();
-
-	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-	pte_clear(&init_mm, vaddr, kmap_pte - idx);
-	flush_tlb_one(vaddr);
-#else
-	(void) idx; /* to kill a warning */
-#endif
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte-idx, pfn_pte(pfn, PAGE_KERNEL));
-	flush_tlb_one(vaddr);
-
-	return (void *) vaddr;
-}
-
-static void __init kmap_pages_init(void)
+void __init kmap_init(void)
 {
 	unsigned long vaddr;
 	pgd_t *pgd;
@@ -96,14 +34,3 @@ static void __init kmap_pages_init(void)
 	pte = pte_offset_kernel(pmd, vaddr);
 	pkmap_page_table = pte;
 }
-
-void __init kmap_init(void)
-{
-	unsigned long vaddr;
-
-	kmap_pages_init();
-
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN);
-
-	kmap_pte = pte_offset_kernel((pmd_t *)pgd_offset_k(vaddr), vaddr);
-}
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 33925ffed68fd..7f6ca0ab4f81f 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -155,6 +155,7 @@ config XILINX_UNCACHED_SHADOW
 config HIGHMEM
 	bool "High memory support"
 	depends on MMU
+	select KMAP_LOCAL
 	help
 	  The address space of Microblaze processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
diff --git a/arch/microblaze/include/asm/highmem.h b/arch/microblaze/include/asm/highmem.h
index 284ca8fb54c1d..4418633fb1632 100644
--- a/arch/microblaze/include/asm/highmem.h
+++ b/arch/microblaze/include/asm/highmem.h
@@ -25,7 +25,6 @@
 #include <linux/uaccess.h>
 #include <asm/fixmap.h>
 
-extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 /*
@@ -52,6 +51,11 @@ extern pte_t *pkmap_page_table;
 
 #define flush_cache_kmaps()	{ flush_icache(); flush_dcache(); }
 
+#define arch_kmap_local_post_map(vaddr, pteval)	\
+	local_flush_tlb_page(NULL, vaddr);
+#define arch_kmap_local_post_unmap(vaddr)	\
+	local_flush_tlb_page(NULL, vaddr);
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
diff --git a/arch/microblaze/mm/Makefile b/arch/microblaze/mm/Makefile
index 1b16875cea704..8ced711000471 100644
--- a/arch/microblaze/mm/Makefile
+++ b/arch/microblaze/mm/Makefile
@@ -6,4 +6,3 @@
 obj-y := consistent.o init.o
 
 obj-$(CONFIG_MMU) += pgtable.o mmu_context.o fault.o
-obj-$(CONFIG_HIGHMEM) += highmem.o
diff --git a/arch/microblaze/mm/highmem.c b/arch/microblaze/mm/highmem.c
deleted file mode 100644
index 92e0890416c91..0000000000000
--- a/arch/microblaze/mm/highmem.c
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * highmem.c: virtual kernel memory mappings for high memory
- *
- * PowerPC version, stolen from the i386 version.
- *
- * Used in CONFIG_HIGHMEM systems for memory pages which
- * are not addressable by direct kernel virtual addresses.
- *
- * Copyright (C) 1999 Gerhard Wichert, Siemens AG
- *		      Gerhard.Wichert@pdb.siemens.de
- *
- *
- * Redesigned the x86 32-bit VM architecture to deal with
- * up to 16 Terrabyte physical memory. With current x86 CPUs
- * we now support up to 64 Gigabytes physical RAM.
- *
- * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
- *
- * Reworked for PowerPC by various contributors. Moved from
- * highmem.h by Benjamin Herrenschmidt (c) 2009 IBM Corp.
- */
-
-#include <linux/export.h>
-#include <linux/highmem.h>
-
-/*
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need
- * it.
- */
-#include <asm/tlbflush.h>
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-#endif
-	set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot));
-	local_flush_tlb_page(NULL, vaddr);
-
-	return (void *) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type;
-	unsigned int idx;
-
-	if (vaddr < __fix_to_virt(FIX_KMAP_END))
-		return;
-
-	type = kmap_atomic_idx();
-
-	idx = type + KM_TYPE_NR * smp_processor_id();
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-	/*
-	 * force other mappings to Oops if they'll try to access
-	 * this pte without first remap it
-	 */
-	pte_clear(&init_mm, vaddr, kmap_pte-idx);
-	local_flush_tlb_page(NULL, vaddr);
-
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 45da639bd22ca..1f4b5b34e6004 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -49,17 +49,11 @@ unsigned long lowmem_size;
 EXPORT_SYMBOL(min_low_pfn);
 EXPORT_SYMBOL(max_low_pfn);
 
-#ifdef CONFIG_HIGHMEM
-pte_t *kmap_pte;
-EXPORT_SYMBOL(kmap_pte);
-
 static void __init highmem_init(void)
 {
 	pr_debug("%x\n", (u32)PKMAP_BASE);
 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
 	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
-
-	kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
 }
 
 static void highmem_setup(void)
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e68dc7def7f64..6b762bebff33d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2718,7 +2718,8 @@ config WAR_MIPS34K_MISSED_ITLB
 #
 config HIGHMEM
 	bool "High Memory Support"
-	depends on 32BIT && CPU_SUPPORTS_HIGHMEM && SYS_SUPPORTS_HIGHMEM && !CPU_MIPS32_3_5_EVA && !PREEMPT_RT
+	depends on 32BIT && CPU_SUPPORTS_HIGHMEM && SYS_SUPPORTS_HIGHMEM && !CPU_MIPS32_3_5_EVA
+	select KMAP_LOCAL
 
 config CPU_SUPPORTS_HIGHMEM
 	bool
diff --git a/arch/mips/include/asm/highmem.h b/arch/mips/include/asm/highmem.h
index f1f788b571666..cb2e0fb8483b8 100644
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -48,11 +48,11 @@ extern pte_t *pkmap_page_table;
 
 #define ARCH_HAS_KMAP_FLUSH_TLB
 extern void kmap_flush_tlb(unsigned long addr);
-extern void *kmap_atomic_pfn(unsigned long pfn);
 
 #define flush_cache_kmaps()	BUG_ON(cpu_has_dc_aliases)
 
-extern void kmap_init(void);
+#define arch_kmap_local_post_map(vaddr, pteval)	local_flush_tlb_one(vaddr)
+#define arch_kmap_local_post_unmap(vaddr)	local_flush_tlb_one(vaddr)
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index 5fec7f45d79a8..57e2f08f00d0c 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -8,8 +8,6 @@
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 
-static pte_t *kmap_pte;
-
 unsigned long highstart_pfn, highend_pfn;
 
 void kmap_flush_tlb(unsigned long addr)
@@ -17,78 +15,3 @@ void kmap_flush_tlb(unsigned long addr)
 	flush_tlb_one(addr);
 }
 EXPORT_SYMBOL(kmap_flush_tlb);
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte - idx)));
-#endif
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-	local_flush_tlb_one((unsigned long)vaddr);
-
-	return (void*) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type __maybe_unused;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-	type = kmap_atomic_idx();
-#ifdef CONFIG_DEBUG_HIGHMEM
-	{
-		int idx = type + KM_TYPE_NR * smp_processor_id();
-
-		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-		/*
-		 * force other mappings to Oops if they'll try to access
-		 * this pte without first remap it
-		 */
-		pte_clear(&init_mm, vaddr, kmap_pte-idx);
-		local_flush_tlb_one(vaddr);
-	}
-#endif
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	preempt_disable();
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte-idx, pfn_pte(pfn, PAGE_KERNEL));
-	flush_tlb_one(vaddr);
-
-	return (void*) vaddr;
-}
-
-void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
-}
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 07e84a7749387..7e159e93f7118 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -402,9 +402,6 @@ void __init paging_init(void)
 
 	pagetable_init();
 
-#ifdef CONFIG_HIGHMEM
-	kmap_init();
-#endif
 #ifdef CONFIG_ZONE_DMA
 	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
 #endif
diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index f88a12fdf0f35..c107599524855 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -157,6 +157,7 @@ config HW_SUPPORT_UNALIGNMENT_ACCESS
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU && !CPU_CACHE_ALIASING
+	select KMAP_LOCAL
 	help
 	  The address space of Andes processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
diff --git a/arch/nds32/include/asm/highmem.h b/arch/nds32/include/asm/highmem.h
index fe986d0e6e3ff..d844c282c090c 100644
--- a/arch/nds32/include/asm/highmem.h
+++ b/arch/nds32/include/asm/highmem.h
@@ -45,11 +45,22 @@ extern pte_t *pkmap_page_table;
 extern void kmap_init(void);
 
 /*
- * The following functions are already defined by <linux/highmem.h>
- * when CONFIG_HIGHMEM is not set.
+ * FIXME: The below looks broken vs. a kmap_atomic() in task context which
+ * is interupted and another kmap_atomic() happens in interrupt context.
+ * But what do I know about nds32. -- tglx
  */
-#ifdef CONFIG_HIGHMEM
-extern void *kmap_atomic_pfn(unsigned long pfn);
-#endif
+#define arch_kmap_local_post_map(vaddr, pteval)			\
+	do {							\
+		__nds32__tlbop_inv(vaddr);			\
+		__nds32__mtsr_dsb(vaddr, NDS32_SR_TLB_VPN);	\
+		__nds32__tlbop_rwr(pteval);			\
+		__nds32__isb();					\
+	} while (0)
+
+#define arch_kmap_local_pre_unmap(vaddr, pte)			\
+	do {							\
+		__nds32__tlbop_inv(vaddr);			\
+		__nds32__isb();					\
+	} while (0)
 
 #endif
diff --git a/arch/nds32/mm/Makefile b/arch/nds32/mm/Makefile
index 897ecaf5cf54b..14fb2e8eb0368 100644
--- a/arch/nds32/mm/Makefile
+++ b/arch/nds32/mm/Makefile
@@ -3,7 +3,6 @@ obj-y				:= extable.o tlb.o fault.o init.o mmap.o \
                                    mm-nds32.o cacheflush.o proc.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
-obj-$(CONFIG_HIGHMEM)           += highmem.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_proc.o     = $(CC_FLAGS_FTRACE)
diff --git a/arch/nds32/mm/highmem.c b/arch/nds32/mm/highmem.c
deleted file mode 100644
index 4284cd59e21ad..0000000000000
--- a/arch/nds32/mm/highmem.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/export.h>
-#include <linux/highmem.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-#include <linux/interrupt.h>
-#include <linux/memblock.h>
-#include <asm/fixmap.h>
-#include <asm/tlbflush.h>
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned int idx;
-	unsigned long vaddr, pte;
-	int type;
-	pte_t *ptep;
-
-	type = kmap_atomic_idx_push();
-
-	idx = type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	pte = (page_to_pfn(page) << PAGE_SHIFT) | prot;
-	ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
-	set_pte(ptep, pte);
-
-	__nds32__tlbop_inv(vaddr);
-	__nds32__mtsr_dsb(vaddr, NDS32_SR_TLB_VPN);
-	__nds32__tlbop_rwr(pte);
-	__nds32__isb();
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	if (kvaddr >= (void *)FIXADDR_START) {
-		unsigned long vaddr = (unsigned long)kvaddr;
-		pte_t *ptep;
-		kmap_atomic_idx_pop();
-		__nds32__tlbop_inv(vaddr);
-		__nds32__isb();
-		ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
-		set_pte(ptep, 0);
-	}
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5e51b655831b3..9f011dd00d62f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -411,7 +411,8 @@ menu "Kernel options"
 
 config HIGHMEM
 	bool "High memory support"
-	depends on PPC32 && !PREEMPT_RT
+	depends on PPC32
+	select KMAP_LOCAL
 
 source "kernel/Kconfig.hz"
 
diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index 104026f7d6bc2..64af53049e138 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -29,7 +29,6 @@
 #include <asm/page.h>
 #include <asm/fixmap.h>
 
-extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 /*
@@ -60,6 +59,11 @@ extern pte_t *pkmap_page_table;
 
 #define flush_cache_kmaps()	flush_cache_all()
 
+#define arch_kmap_local_post_map(vaddr, pteval)	\
+	local_flush_tlb_page(NULL, vaddr)
+#define arch_kmap_local_post_unmap(vaddr)	\
+	local_flush_tlb_page(NULL, vaddr)
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 5e147986400d5..1c552b53aa63e 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
-obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
 obj-$(CONFIG_PPC_PTDUMP)	+= ptdump/
 obj-$(CONFIG_KASAN)		+= kasan/
diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
deleted file mode 100644
index 624b4438aff9d..0000000000000
--- a/arch/powerpc/mm/highmem.c
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * highmem.c: virtual kernel memory mappings for high memory
- *
- * PowerPC version, stolen from the i386 version.
- *
- * Used in CONFIG_HIGHMEM systems for memory pages which
- * are not addressable by direct kernel virtual addresses.
- *
- * Copyright (C) 1999 Gerhard Wichert, Siemens AG
- *		      Gerhard.Wichert@pdb.siemens.de
- *
- *
- * Redesigned the x86 32-bit VM architecture to deal with
- * up to 16 Terrabyte physical memory. With current x86 CPUs
- * we now support up to 64 Gigabytes physical RAM.
- *
- * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
- *
- * Reworked for PowerPC by various contributors. Moved from
- * highmem.h by Benjamin Herrenschmidt (c) 2009 IBM Corp.
- */
-
-#include <linux/highmem.h>
-#include <linux/module.h>
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	WARN_ON(IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !pte_none(*(kmap_pte - idx)));
-	__set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot), 1);
-	local_flush_tlb_page(NULL, vaddr);
-
-	return (void*) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr < __fix_to_virt(FIX_KMAP_END))
-		return;
-
-	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM)) {
-		int type = kmap_atomic_idx();
-		unsigned int idx;
-
-		idx = type + KM_TYPE_NR * smp_processor_id();
-		WARN_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-		/*
-		 * force other mappings to Oops if they'll try to access
-		 * this pte without first remap it
-		 */
-		pte_clear(&init_mm, vaddr, kmap_pte-idx);
-		local_flush_tlb_page(NULL, vaddr);
-	}
-
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 01ec2a252f091..375a9894063bc 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -61,11 +61,6 @@
 unsigned long long memory_limit;
 bool init_mem_is_free;
 
-#ifdef CONFIG_HIGHMEM
-pte_t *kmap_pte;
-EXPORT_SYMBOL(kmap_pte);
-#endif
-
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
@@ -235,8 +230,6 @@ void __init paging_init(void)
 
 	map_kernel_page(PKMAP_BASE, 0, __pgprot(0));	/* XXX gross */
 	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
-
-	kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
 #endif /* CONFIG_HIGHMEM */
 
 	printk(KERN_DEBUG "Top of RAM: 0x%llx, Total RAM: 0x%llx\n",
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a6ca135442f9a..e841708cb8308 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -139,6 +139,7 @@ config MMU
 config HIGHMEM
 	bool
 	default y if SPARC32
+	select KMAP_LOCAL
 
 config ZONE_DMA
 	bool
diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index 6c35f0d27ee1a..f84298a7100c5 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -33,8 +33,6 @@ extern unsigned long highstart_pfn, highend_pfn;
 #define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE)
 extern pte_t *pkmap_page_table;
 
-void kmap_init(void) __init;
-
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
@@ -53,6 +51,11 @@ void kmap_init(void) __init;
 
 #define flush_cache_kmaps()	flush_cache_all()
 
+/* FIXME: Use __flush_tlb_one(vaddr) instead of flush_cache_all() -- Anton */
+#define arch_kmap_local_post_map(vaddr, pteval)	flush_cache_all()
+#define arch_kmap_local_post_unmap(vaddr)	flush_cache_all()
+
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index b078205b70e0b..68db1f859b028 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -15,6 +15,3 @@ obj-$(CONFIG_SPARC32)   += leon_mm.o
 
 # Only used by sparc64
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
-
-# Only used by sparc32
-obj-$(CONFIG_HIGHMEM)   += highmem.o
diff --git a/arch/sparc/mm/highmem.c b/arch/sparc/mm/highmem.c
deleted file mode 100644
index 8f2a2afb048a2..0000000000000
--- a/arch/sparc/mm/highmem.c
+++ /dev/null
@@ -1,115 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  highmem.c: virtual kernel memory mappings for high memory
- *
- *  Provides kernel-static versions of atomic kmap functions originally
- *  found as inlines in include/asm-sparc/highmem.h.  These became
- *  needed as kmap_atomic() and kunmap_atomic() started getting
- *  called from within modules.
- *  -- Tomas Szepe <szepe@pinerecords.com>, September 2002
- *
- *  But kmap_atomic() and kunmap_atomic() cannot be inlined in
- *  modules because they are loaded with btfixup-ped functions.
- */
-
-/*
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need it.
- *
- * XXX This is an old text. Actually, it's good to use atomic kmaps,
- * provided you remember that they are atomic and not try to sleep
- * with a kmap taken, much like a spinlock. Non-atomic kmaps are
- * shared by CPUs, and so precious, and establishing them requires IPI.
- * Atomic kmaps are lightweight and we may have NCPUS more of them.
- */
-#include <linux/highmem.h>
-#include <linux/export.h>
-#include <linux/mm.h>
-
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-#include <asm/vaddrs.h>
-
-static pte_t *kmap_pte;
-
-void __init kmap_init(void)
-{
-	unsigned long address = __fix_to_virt(FIX_KMAP_BEGIN);
-
-        /* cache the first kmap pte */
-        kmap_pte = virt_to_kpte(address);
-}
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	long idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-
-/* XXX Fix - Anton */
-#if 0
-	__flush_cache_one(vaddr);
-#else
-	flush_cache_all();
-#endif
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-#endif
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-/* XXX Fix - Anton */
-#if 0
-	__flush_tlb_one(vaddr);
-#else
-	flush_tlb_all();
-#endif
-
-	return (void*) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-	type = kmap_atomic_idx();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	{
-		unsigned long idx;
-
-		idx = type + KM_TYPE_NR * smp_processor_id();
-		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN+idx));
-
-		/* XXX Fix - Anton */
-#if 0
-		__flush_cache_one(vaddr);
-#else
-		flush_cache_all();
-#endif
-
-		/*
-		 * force other mappings to Oops if they'll try to access
-		 * this pte without first remap it
-		 */
-		pte_clear(&init_mm, vaddr, kmap_pte-idx);
-		/* XXX Fix - Anton */
-#if 0
-		__flush_tlb_one(vaddr);
-#else
-		flush_tlb_all();
-#endif
-	}
-#endif
-
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 0070f8b9a753a..a03caa5f6628d 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -971,8 +971,6 @@ void __init srmmu_paging_init(void)
 
 	sparc_context_init(num_contexts);
 
-	kmap_init();
-
 	{
 		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e7f19452db74f..ed5780f610806 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -14,10 +14,11 @@ config X86_32
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
+	select GENERIC_VDSO_32
 	select HAVE_DEBUG_STACKOVERFLOW
+	select KMAP_LOCAL
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
-	select GENERIC_VDSO_32
 
 config X86_64
 	def_bool y
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 77217bd292bd5..9de29ee55cb10 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -151,7 +151,6 @@ extern void reserve_top_address(unsigned long reserve);
 
 extern int fixmaps_set;
 
-extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
diff --git a/arch/x86/include/asm/highmem.h b/arch/x86/include/asm/highmem.h
index 0f420b24e0fcb..bf6ed26788de1 100644
--- a/arch/x86/include/asm/highmem.h
+++ b/arch/x86/include/asm/highmem.h
@@ -58,11 +58,17 @@ extern unsigned long highstart_pfn, highend_pfn;
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
-void *kmap_atomic_pfn(unsigned long pfn);
-void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot);
-
 #define flush_cache_kmaps()	do { } while (0)
 
+#define	arch_kmap_local_post_map(vaddr, pteval)		\
+	arch_flush_lazy_mmu_mode()
+
+#define	arch_kmap_local_post_unmap(vaddr)		\
+	do {						\
+		flush_tlb_one_kernel((vaddr));		\
+		arch_flush_lazy_mmu_mode();		\
+	} while (0)
+
 extern void add_highpages_with_active_regions(int nid, unsigned long start_pfn,
 					unsigned long end_pfn);
 
diff --git a/arch/x86/include/asm/iomap.h b/arch/x86/include/asm/iomap.h
index bacf68c4d70e6..e2de092fc38cb 100644
--- a/arch/x86/include/asm/iomap.h
+++ b/arch/x86/include/asm/iomap.h
@@ -9,19 +9,14 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/highmem.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-void __iomem *
-iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot);
+void __iomem *__iomap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
 
-void
-iounmap_atomic(void __iomem *kvaddr);
+int iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot);
 
-int
-iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot);
-
-void
-iomap_free(resource_size_t base, unsigned long size);
+void iomap_free(resource_size_t base, unsigned long size);
 
 #endif /* _ASM_X86_IOMAP_H */
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 17189e47cee88..4f2f54e1281c3 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -38,7 +38,6 @@
 #include <linux/io.h>
 #include <linux/kdebug.h>
 #include <linux/syscalls.h>
-#include <linux/highmem.h>
 
 #include <asm/ldt.h>
 #include <asm/processor.h>
@@ -127,35 +126,6 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 }
 EXPORT_SYMBOL_GPL(start_thread);
 
-#ifdef CONFIG_PREEMPT_RT
-static void switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p)
-{
-	int i;
-
-	/*
-	 * Clear @prev's kmap_atomic mappings
-	 */
-	for (i = 0; i < prev_p->kmap_idx; i++) {
-		int idx = i + KM_TYPE_NR * smp_processor_id();
-		pte_t *ptep = kmap_pte - idx;
-
-		kpte_clear_flush(ptep, __fix_to_virt(FIX_KMAP_BEGIN + idx));
-	}
-	/*
-	 * Restore @next_p's kmap_atomic mappings
-	 */
-	for (i = 0; i < next_p->kmap_idx; i++) {
-		int idx = i + KM_TYPE_NR * smp_processor_id();
-
-		if (!pte_none(next_p->kmap_pte[i]))
-			set_pte(kmap_pte - idx, next_p->kmap_pte[i]);
-	}
-}
-#else
-static inline void
-switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p) { }
-#endif
-
 
 /*
  *	switch_to(x,y) should switch tasks from x to y.
@@ -217,8 +187,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	switch_to_extra(prev_p, next_p);
 
-	switch_kmaps(prev_p, next_p);
-
 	/*
 	 * Leave lazy mode, flushing any hypercalls made here.
 	 * This must be done before restoring TLS segments so
diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
index 95da91a7c7af5..2c54b76d8f849 100644
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -4,73 +4,6 @@
 #include <linux/swap.h> /* for totalram_pages */
 #include <linux/memblock.h>
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-	pte_t pte;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-	pte = mk_pte(page, prot);
-#ifdef CONFIG_PREEMPT_RT
-	current->kmap_pte[type] = pte;
-#endif
-	set_pte(kmap_pte-idx, pte);
-	arch_flush_lazy_mmu_mode();
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	return kmap_atomic_prot_pfn(pfn, kmap_prot);
-}
-EXPORT_SYMBOL_GPL(kmap_atomic_pfn);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr >= __fix_to_virt(FIX_KMAP_END) &&
-	    vaddr <= __fix_to_virt(FIX_KMAP_BEGIN)) {
-		int idx, type;
-
-		type = kmap_atomic_idx();
-		idx = type + KM_TYPE_NR * smp_processor_id();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-		WARN_ON_ONCE(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-#ifdef CONFIG_PREEMPT_RT
-		current->kmap_pte[type] = __pte(0);
-#endif
-		kpte_clear_flush(kmap_pte-idx, vaddr);
-		kmap_atomic_idx_pop();
-		arch_flush_lazy_mmu_mode();
-	}
-#ifdef CONFIG_DEBUG_HIGHMEM
-	else {
-		BUG_ON(vaddr < PAGE_OFFSET);
-		BUG_ON(vaddr >= (unsigned long)high_memory);
-	}
-#endif
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
 void __init set_highmem_pages_init(void)
 {
 	struct zone *zone;
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 7c055259de3a6..da31c2635ee43 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -394,19 +394,6 @@ kernel_physical_mapping_init(unsigned long start,
 	return last_map_addr;
 }
 
-pte_t *kmap_pte;
-
-static void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/*
-	 * Cache the first kmap pte:
-	 */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
-}
-
 #ifdef CONFIG_HIGHMEM
 static void __init permanent_kmaps_init(pgd_t *pgd_base)
 {
@@ -712,8 +699,6 @@ void __init paging_init(void)
 
 	__flush_tlb_all();
 
-	kmap_init();
-
 	/*
 	 * NOTE: at this point the bootmem allocator is fully available.
 	 */
diff --git a/arch/x86/mm/iomap_32.c b/arch/x86/mm/iomap_32.c
index 0ef360874c752..9aaa756ddf219 100644
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -44,34 +44,7 @@ void iomap_free(resource_size_t base, unsigned long size)
 }
 EXPORT_SYMBOL_GPL(iomap_free);
 
-void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
-{
-	pte_t pte = pfn_pte(pfn, prot);
-	unsigned long vaddr;
-	int idx, type;
-
-	migrate_disable();
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	WARN_ON(!pte_none(*(kmap_pte - idx)));
-
-#ifdef CONFIG_PREEMPT_RT
-	current->kmap_pte[type] = pte;
-#endif
-	set_pte(kmap_pte - idx, pte);
-	arch_flush_lazy_mmu_mode();
-
-	return (void *)vaddr;
-}
-
-/*
- * Map 'pfn' using protections 'prot'
- */
-void __iomem *
-iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
+void __iomem *__iomap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 {
 	/*
 	 * For non-PAT systems, translate non-WB request to UC- just in
@@ -87,39 +60,6 @@ iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
 	/* Filter out unsupported __PAGE_KERNEL* bits: */
 	pgprot_val(prot) &= __default_kernel_pte_mask;
 
-	return (void __force __iomem *) kmap_atomic_prot_pfn(pfn, prot);
+	return (void __force __iomem *)__kmap_local_pfn_prot(pfn, prot);
 }
-EXPORT_SYMBOL_GPL(iomap_atomic_prot_pfn);
-
-void
-iounmap_atomic(void __iomem *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr >= __fix_to_virt(FIX_KMAP_END) &&
-	    vaddr <= __fix_to_virt(FIX_KMAP_BEGIN)) {
-		int idx, type;
-
-		type = kmap_atomic_idx();
-		idx = type + KM_TYPE_NR * smp_processor_id();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-		WARN_ON_ONCE(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-#ifdef CONFIG_PREEMPT_RT
-		current->kmap_pte[type] = __pte(0);
-#endif
-		kpte_clear_flush(kmap_pte-idx, vaddr);
-		kmap_atomic_idx_pop();
-	}
-
-	pagefault_enable();
-	migrate_enable();
-}
-EXPORT_SYMBOL_GPL(iounmap_atomic);
+EXPORT_SYMBOL_GPL(__iomap_local_pfn_prot);
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index d0dfa50bd0bb4..dc22ef3cf4bed 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -666,6 +666,7 @@ endchoice
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU
+	select KMAP_LOCAL
 	help
 	  Linux can use the full amount of RAM in the system by
 	  default. However, the default MMUv2 setup only maps the
diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index eac503215f178..f8f24299acc19 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -68,6 +68,15 @@ static inline void flush_cache_kmaps(void)
 	flush_cache_all();
 }
 
+enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn);
+#define arch_kmap_local_map_idx		kmap_local_map_idx
+
+enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr);
+#define arch_kmap_local_unmap_idx	kmap_local_unmap_idx
+
+#define arch_kmap_local_post_unmap(vaddr)	\
+	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE)
+
 void kmap_init(void);
 
 #endif
diff --git a/arch/xtensa/mm/highmem.c b/arch/xtensa/mm/highmem.c
index 673196fe862ef..69017f99e9b96 100644
--- a/arch/xtensa/mm/highmem.c
+++ b/arch/xtensa/mm/highmem.c
@@ -12,8 +12,6 @@
 #include <linux/highmem.h>
 #include <asm/tlbflush.h>
 
-static pte_t *kmap_pte;
-
 #if DCACHE_WAY_SIZE > PAGE_SIZE
 unsigned int last_pkmap_nr_arr[DCACHE_N_COLORS];
 wait_queue_head_t pkmap_map_wait_arr[DCACHE_N_COLORS];
@@ -37,55 +35,21 @@ static inline enum fixed_addresses kmap_idx(int type, unsigned long color)
 		color;
 }
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
+enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn)
 {
-	enum fixed_addresses idx;
-	unsigned long vaddr;
-
-	idx = kmap_idx(kmap_atomic_idx_push(),
-		       DCACHE_ALIAS(page_to_phys(page)));
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte + idx)));
-#endif
-	set_pte(kmap_pte + idx, mk_pte(page, prot));
-
-	return (void *)vaddr;
+	return kmap_idx(type, DCACHE_ALIAS(pfn << PAGE_SHIFT);
 }
-EXPORT_SYMBOL(kmap_atomic_high_prot);
 
-void kunmap_atomic_high(void *kvaddr)
+enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr)
 {
-	if (kvaddr >= (void *)FIXADDR_START &&
-	    kvaddr < (void *)FIXADDR_TOP) {
-		int idx = kmap_idx(kmap_atomic_idx(),
-				   DCACHE_ALIAS((unsigned long)kvaddr));
-
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		pte_clear(&init_mm, kvaddr, kmap_pte + idx);
-		local_flush_tlb_kernel_range((unsigned long)kvaddr,
-					     (unsigned long)kvaddr + PAGE_SIZE);
-
-		kmap_atomic_idx_pop();
-	}
+	return kmap_idx(type, DCACHE_ALIAS(addr));
 }
-EXPORT_SYMBOL(kunmap_atomic_high);
 
 void __init kmap_init(void)
 {
-	unsigned long kmap_vstart;
-
 	/* Check if this memory layout is broken because PKMAP overlaps
 	 * page table.
 	 */
 	BUILD_BUG_ON(PKMAP_BASE < TLBTEMP_BASE_1 + TLBTEMP_SIZE);
-	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
 	kmap_waitqueues_init();
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d6ae5234dae97..467ba7f43c25c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -644,9 +644,12 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	} else {
 		if (rq->q->nr_hw_queues > 1)
 			return false;
+
+		preempt_disable();
 		cpu_list = this_cpu_ptr(&blk_cpu_done);
 		if (llist_add(&rq->ipi_list, cpu_list))
 			raise_softirq(BLOCK_SOFTIRQ);
+		preempt_enable();
 	}
 
 	return true;
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index aa41a6b3d4829..6ae7483c486af 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -8,7 +8,6 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
-#include <linux/sched.h>
 
 #include <asm/cacheflush.h>
 
@@ -32,9 +31,26 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
 
 #include <asm/kmap_types.h>
 
+/*
+ * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
+ */
+#ifdef CONFIG_KMAP_LOCAL
+void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
+void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
+void kunmap_local_indexed(void *vaddr);
+void kmap_local_fork(struct task_struct *tsk);
+void __kmap_local_sched_out(void);
+void __kmap_local_sched_in(void);
+static inline void kmap_assert_nomap(void)
+{
+	DEBUG_LOCKS_WARN_ON(current->kmap_ctrl.idx);
+}
+#else
+static inline void kmap_local_fork(struct task_struct *tsk) { }
+static inline void kmap_assert_nomap(void) { }
+#endif
+
 #ifdef CONFIG_HIGHMEM
-extern void *kmap_atomic_high_prot(struct page *page, pgprot_t prot);
-extern void kunmap_atomic_high(void *kvaddr);
 #include <asm/highmem.h>
 
 #ifndef ARCH_HAS_KMAP_FLUSH_TLB
@@ -70,27 +86,108 @@ static inline void kunmap(struct page *page)
 }
 
 /*
- * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
- * no global lock is needed and because the kmap code must perform a global TLB
- * invalidation when the kmap pool wraps.
+ * For highmem systems it is required to temporarily map pages
+ * which reside in the portion of memory which is not covered
+ * by the permanent kernel mapping.
  *
- * However when holding an atomic kmap it is not legal to sleep, so atomic
- * kmaps are appropriate for short, tight code paths only.
+ * This comes in three flavors:
  *
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need
- * it.
+ * 1) kmap/kunmap:
+ *
+ *    An interface to acquire longer term mappings with no restrictions
+ *    on preemption and migration. This comes with an overhead as the
+ *    mapping space is restricted and protected by a global lock. It
+ *    also requires global TLB invalidation when the kmap pool wraps.
+ *
+ *    kmap() might block when the mapping space is fully utilized until a
+ *    slot becomes available. Only callable from preemptible thread
+ *    context.
+ *
+ * 2) kmap_local.*()/kunmap_local.*()
+ *
+ *    An interface to acquire short term mappings. Can be invoked from any
+ *    context including interrupts. The mapping is per thread, CPU local
+ *    and not globaly visible. It can only be used in the context which
+ *    acquried the mapping. Nesting kmap_local.*() and kmap_atomic.*()
+ *    mappings is allowed to a certain extent (up to KMAP_TYPE_NR).
+ *
+ *    Nested kmap_local.*() and kunmap_local.*() invocations have to be
+ *    strictly ordered because the map implementation is stack based.
+ *
+ *    kmap_local.*() disables migration, but keeps preemption enabled. It's
+ *    valid to take pagefaults in a kmap_local region unless the context in
+ *    which the local kmap is acquired does not allow it for other reasons.
+ *
+ *    If a task holding local kmaps is preempted, the maps are removed on
+ *    context switch and restored when the task comes back on the CPU. As
+ *    the maps are strictly CPU local it is guaranteed that the task stays
+ *    on the CPU and the CPU cannot be unplugged until the local kmaps are
+ *    released.
+ *
+ * 3) kmap_atomic.*()/kunmap_atomic.*()
+ *
+ *    Based on the same mechanism as kmap local. Atomic kmap disables
+ *    preemption and pagefaults. Only use if absolutely required, use
+ *    the corresponding kmap_local variant if possible.
+ *
+ * Local and atomic kmaps are faster than kmap/kunmap, but impose
+ * restrictions. Only use them when required.
+ *
+ * For !HIGHMEM enabled systems the kmap flavours are not doing any mapping
+ * operation and kmap() won't sleep, but the kmap local and atomic variants
+ * still disable migration resp. pagefaults and preemption.
  */
 static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
-	migrate_disable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_disable();
+	else
+		preempt_disable();
 	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
-	return kmap_atomic_high_prot(page, prot);
+	return __kmap_local_page_prot(page, prot);
+}
+
+static inline void *kmap_atomic(struct page *page)
+{
+	return kmap_atomic_prot(page, kmap_prot);
+}
+
+static inline void *kmap_atomic_pfn(unsigned long pfn)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_disable();
+	else
+		preempt_disable();
+	pagefault_disable();
+	return __kmap_local_pfn_prot(pfn, kmap_prot);
+}
+
+static inline void __kunmap_atomic(void *addr)
+{
+	kunmap_local_indexed(addr);
+}
+
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	migrate_disable();
+	return __kmap_local_page_prot(page, prot);
+}
+
+static inline void *kmap_local_page(struct page *page)
+{
+	return kmap_local_page_prot(page, kmap_prot);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	migrate_disable();
+	return __kmap_local_pfn_prot(pfn, kmap_prot);
+}
+
+static inline void __kunmap_local(void *vaddr)
+{
+	kunmap_local_indexed(vaddr);
 }
-#define kmap_atomic(page)	kmap_atomic_prot(page, kmap_prot)
 
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
@@ -154,93 +251,77 @@ static inline void kunmap(struct page *page)
 
 static inline void *kmap_atomic(struct page *page)
 {
-	migrate_disable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_disable();
+	else
+		preempt_disable();
 	pagefault_disable();
 	return page_address(page);
 }
-#define kmap_atomic_prot(page, prot)	kmap_atomic(page)
 
-static inline void kunmap_atomic_high(void *addr)
+static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+{
+	return kmap_atomic(page);
+}
+
+static inline void *kmap_atomic_pfn(unsigned long pfn)
+{
+	return kmap_atomic(pfn_to_page(pfn));
+}
+
+static inline void __kunmap_local(void *addr)
 {
-	/*
-	 * Mostly nothing to do in the CONFIG_HIGHMEM=n case as kunmap_atomic()
-	 * handles re-enabling faults + preemption
-	 */
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
 #endif
 }
 
-#define kmap_atomic_pfn(pfn)	kmap_atomic(pfn_to_page(pfn))
+static inline void __kunmap_atomic(void *addr)
+{
+	__kunmap_local(addr);
+}
+
+static inline void *kmap_local_page(struct page *page)
+{
+	migrate_disable();
+	return page_address(page);
+}
+
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	return kmap_local_page(page);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	return kmap_local_page(pfn_to_page(pfn));
+}
 
 #define kmap_flush_unused()	do {} while(0)
 
 #endif /* CONFIG_HIGHMEM */
 
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
-
-#ifndef CONFIG_PREEMPT_RT
-DECLARE_PER_CPU(int, __kmap_atomic_idx);
-#endif
-
-static inline int kmap_atomic_idx_push(void)
-{
-#ifndef CONFIG_PREEMPT_RT
-	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
-
-# ifdef CONFIG_DEBUG_HIGHMEM
-	WARN_ON_ONCE(in_irq() && !irqs_disabled());
-	BUG_ON(idx >= KM_TYPE_NR);
-# endif
-	return idx;
-#else
-	current->kmap_idx++;
-	BUG_ON(current->kmap_idx > KM_TYPE_NR);
-	return current->kmap_idx - 1;
-#endif
-}
-
-static inline int kmap_atomic_idx(void)
-{
-#ifndef CONFIG_PREEMPT_RT
-	return __this_cpu_read(__kmap_atomic_idx) - 1;
-#else
-	return current->kmap_idx - 1;
-#endif
-}
-
-static inline void kmap_atomic_idx_pop(void)
-{
-#ifndef CONFIG_PREEMPT_RT
-# ifdef CONFIG_DEBUG_HIGHMEM
-	int idx = __this_cpu_dec_return(__kmap_atomic_idx);
-
-	BUG_ON(idx < 0);
-# else
-	__this_cpu_dec(__kmap_atomic_idx);
-# endif
-#else
-	current->kmap_idx--;
-# ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(current->kmap_idx < 0);
-# endif
-#endif
-}
-
-#endif
-
 /*
  * Prevent people trying to call kunmap_atomic() as if it were kunmap()
  * kunmap_atomic() should get the return value of kmap_atomic, not the page.
  */
-#define kunmap_atomic(addr)                                     \
-do {                                                            \
-	BUILD_BUG_ON(__same_type((addr), struct page *));       \
-	kunmap_atomic_high(addr);                                  \
-	pagefault_enable();                                     \
-	migrate_enable();					\
+#define kunmap_atomic(__addr)					\
+do {								\
+	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
+	__kunmap_atomic(__addr);				\
+	pagefault_enable();					\
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))			\
+		migrate_enable();				\
+	else							\
+		preempt_enable();				\
 } while (0)
 
+#define kunmap_local(__addr)					\
+do {								\
+	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
+	__kunmap_local(__addr);					\
+	migrate_enable();					\
+} while (0)
 
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
 #ifndef clear_user_highpage
diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index c75e4d3d8833f..2b69e2e793a41 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -69,13 +69,40 @@ io_mapping_map_atomic_wc(struct io_mapping *mapping,
 
 	BUG_ON(offset >= mapping->size);
 	phys_addr = mapping->base + offset;
-	return iomap_atomic_prot_pfn(PHYS_PFN(phys_addr), mapping->prot);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_disable();
+	else
+		preempt_disable();
+	pagefault_disable();
+	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
 }
 
 static inline void
 io_mapping_unmap_atomic(void __iomem *vaddr)
 {
-	iounmap_atomic(vaddr);
+	kunmap_local_indexed((void __force *)vaddr);
+	pagefault_enable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_enable();
+	else
+		preempt_enable();
+}
+
+static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	resource_size_t phys_addr;
+
+	BUG_ON(offset >= mapping->size);
+	phys_addr = mapping->base + offset;
+	migrate_disable();
+	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	kunmap_local_indexed((void __force *)vaddr);
+	migrate_enable();
 }
 
 static inline void __iomem *
@@ -97,7 +124,7 @@ io_mapping_unmap(void __iomem *vaddr)
 	iounmap(vaddr);
 }
 
-#else
+#else  /* HAVE_ATOMIC_IOMAP */
 
 #include <linux/uaccess.h>
 
@@ -149,7 +176,10 @@ static inline void __iomem *
 io_mapping_map_atomic_wc(struct io_mapping *mapping,
 			 unsigned long offset)
 {
-	preempt_disable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_disable();
+	else
+		preempt_disable();
 	pagefault_disable();
 	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
 }
@@ -159,10 +189,26 @@ io_mapping_unmap_atomic(void __iomem *vaddr)
 {
 	io_mapping_unmap(vaddr);
 	pagefault_enable();
-	preempt_enable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_enable();
+	else
+		preempt_enable();
 }
 
-#endif /* HAVE_ATOMIC_IOMAP */
+static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	migrate_disable();
+	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	io_mapping_unmap(vaddr);
+	migrate_enable();
+}
+
+#endif /* !HAVE_ATOMIC_IOMAP */
 
 static inline struct io_mapping *
 io_mapping_create_wc(resource_size_t base,
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index c86d60d53e99e..2cff7554395d1 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -204,6 +204,7 @@ extern int _cond_resched(void);
 extern void ___might_sleep(const char *file, int line, int preempt_offset);
 extern void __might_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
+extern void __cant_migrate(const char *file, int line);
 
 /**
  * might_sleep - annotation for functions that can sleep
@@ -231,6 +232,18 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 # define cant_sleep() \
 	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
 # define sched_annotate_sleep()	(current->task_state_change = 0)
+
+/**
+ * cant_migrate - annotation for functions that cannot migrate
+ *
+ * Will print a stack trace if executed in code which is migratable
+ */
+# define cant_migrate()							\
+	do {								\
+		if (IS_ENABLED(CONFIG_SMP))				\
+			__cant_migrate(__FILE__, __LINE__);		\
+	} while (0)
+
 /**
  * non_block_start - annotate the start of section where sleeping is prohibited
  *
@@ -256,6 +269,7 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 # define might_sleep() do { might_resched(); } while (0)
 # define might_sleep_no_state_check() do { might_resched(); } while (0)
 # define cant_sleep() do { } while (0)
+# define cant_migrate()		do { } while (0)
 # define sched_annotate_sleep() do { } while (0)
 # define non_block_start() do { } while (0)
 # define non_block_end() do { } while (0)
@@ -263,13 +277,6 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 
 #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
 
-#ifndef CONFIG_PREEMPT_RT
-# define cant_migrate()		cant_sleep()
-#else
-  /* Placeholder for now */
-# define cant_migrate()		do { } while (0)
-#endif
-
 /**
  * abs - return absolute value of an argument
  * @x: the value.  If it is unsigned type, it is converted to signed type first.
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 998d2c34cf0c2..271f911f2803d 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -110,6 +110,8 @@ static inline void local_lock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
+#ifdef CONFIG_PREEMPT_RT
+
 #define __local_lock(lock)					\
 	do {							\
 		migrate_disable();				\
@@ -122,8 +124,6 @@ static inline void local_lock_release(local_lock_t *l) { }
 		migrate_enable();				\
 	} while (0)
 
-#ifdef CONFIG_PREEMPT_RT
-
 #define __local_lock_irq(lock)					\
 	do {							\
 		migrate_disable();				\
@@ -151,6 +151,18 @@ static inline void local_lock_release(local_lock_t *l) { }
 
 #else
 
+#define __local_lock(lock)					\
+	do {							\
+		preempt_disable();				\
+		local_lock_acquire(this_cpu_ptr(lock));		\
+	} while (0)
+
+#define __local_unlock(lock)					\
+	do {							\
+		local_lock_release(this_cpu_ptr(lock));		\
+		preempt_enable();				\
+	} while (0)
+
 #define __local_lock_irq(lock)					\
 	do {							\
 		local_irq_disable();				\
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 8a47b9b1bade1..934b8e3cba872 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -386,7 +386,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #endif
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_SMP
 
 /*
  * Migrate-Disable and why it is undesired.
@@ -446,7 +446,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 extern void migrate_disable(void);
 extern void migrate_enable(void);
 
-#elif defined(CONFIG_PREEMPT_RT)
+#else
 
 static inline void migrate_disable(void)
 {
@@ -458,38 +458,6 @@ static inline void migrate_enable(void)
 	preempt_lazy_enable();
 }
 
-#else /* !CONFIG_PREEMPT_RT */
-
-/**
- * migrate_disable - Prevent migration of the current task
- *
- * Maps to preempt_disable() which also disables preemption. Use
- * migrate_disable() to annotate that the intent is to prevent migration,
- * but not necessarily preemption.
- *
- * Can be invoked nested like preempt_disable() and needs the corresponding
- * number of migrate_enable() invocations.
- */
-static __always_inline void migrate_disable(void)
-{
-	preempt_disable();
-}
-
-/**
- * migrate_enable - Allow migration of the current task
- *
- * Counterpart to migrate_disable().
- *
- * As migrate_disable() can be invoked nested, only the outermost invocation
- * reenables migration.
- *
- * Currently mapped to preempt_enable().
- */
-static __always_inline void migrate_enable(void)
-{
-	preempt_enable();
-}
-
-#endif /* CONFIG_SMP && CONFIG_PREEMPT_RT */
+#endif /* CONFIG_SMP */
 
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 20e482b158027..ef4b5a270e2f4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -632,6 +632,13 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+struct kmap_ctrl {
+#ifdef CONFIG_KMAP_LOCAL
+	int				idx;
+	pte_t				pteval[KM_TYPE_NR];
+#endif
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -720,7 +727,7 @@ struct task_struct {
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
 	void				*migration_pending;
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_SMP
 	unsigned short			migration_disabled;
 #endif
 	unsigned short			migration_flags;
@@ -1308,12 +1315,7 @@ struct task_struct {
 	unsigned int			sequential_io;
 	unsigned int			sequential_io_avg;
 #endif
-#ifdef CONFIG_PREEMPT_RT
-# if defined CONFIG_HIGHMEM || defined CONFIG_X86_32
-	int				kmap_idx;
-	pte_t				kmap_pte[KM_TYPE_NR];
-# endif
-#endif
+	struct kmap_ctrl		kmap_ctrl;
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	unsigned long			task_state_change;
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d6e3eae407b43..8810c09b29f43 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -2,6 +2,7 @@
 
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
+#include <linux/highmem.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 
@@ -202,6 +203,7 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 
 	/* Ensure that the address limit is intact and no locks are held */
 	addr_limit_user_check();
+	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 05a96cac81f04..833198db52f1c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -954,6 +954,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	account_kernel_stack(tsk, 1);
 
 	kcov_task_init(tsk);
+	kmap_local_fork(tsk);
 
 #ifdef CONFIG_FAULT_INJECTION
 	tsk->fail_nth = 0;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0fde39b8daab5..ca21d28a0f98f 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -249,13 +249,16 @@ static bool check_slow_task(struct task_struct *t, void *arg)
 
 /*
  * Scan the current list of tasks blocked within RCU read-side critical
- * sections, printing out the tid of each.
+ * sections, printing out the tid of each of the first few of them.
  */
-static int rcu_print_task_stall(struct rcu_node *rnp)
+static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
+	__releases(rnp->lock)
 {
+	int i = 0;
 	int ndetected = 0;
 	struct rcu_stall_chk_rdr rscr;
 	struct task_struct *t;
+	struct task_struct *ts[8];
 
 	if (!rcu_preempt_blocked_readers_cgp(rnp))
 		return 0;
@@ -264,6 +267,14 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
+		get_task_struct(t);
+		ts[i++] = t;
+		if (i >= ARRAY_SIZE(ts))
+			break;
+	}
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	for (i--; i; i--) {
+		t = ts[i];
 		if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
 			pr_cont(" P%d", t->pid);
 		else
@@ -273,6 +284,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 				".q"[rscr.rs.b.need_qs],
 				".e"[rscr.rs.b.exp_hint],
 				".l"[rscr.on_blkd_list]);
+		put_task_struct(t);
 		ndetected++;
 	}
 	pr_cont("\n");
@@ -293,8 +305,9 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
  * Because preemptible RCU does not exist, we never have to check for
  * tasks blocked within RCU read-side critical sections.
  */
-static int rcu_print_task_stall(struct rcu_node *rnp)
+static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 {
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	return 0;
 }
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
@@ -472,7 +485,6 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		ndetected += rcu_print_task_stall(rnp);
 		if (rnp->qsmask != 0) {
 			for_each_leaf_node_possible_cpu(rnp, cpu)
 				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
@@ -480,7 +492,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 					ndetected++;
 				}
 		}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		ndetected += rcu_print_task_stall(rnp, flags); // Releases rnp->lock.
 	}
 
 	for_each_possible_cpu(cpu)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 068ad8718c1ac..3fce6bbbeb5b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1765,8 +1765,6 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
-#ifdef CONFIG_PREEMPT_RT
-
 static void
 __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
 
@@ -1843,8 +1841,6 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return rq->nr_pinned;
 }
 
-#endif
-
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
@@ -2925,7 +2921,7 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 	}
 }
 
-#else
+#else /* CONFIG_SMP */
 
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
 					 const struct cpumask *new_mask,
@@ -2934,10 +2930,6 @@ static inline int __set_cpus_allowed_ptr(struct task_struct *p,
 	return set_cpus_allowed_ptr(p, new_mask);
 }
 
-#endif /* CONFIG_SMP */
-
-#if !defined(CONFIG_SMP) || !defined(CONFIG_PREEMPT_RT)
-
 static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
 
 static inline bool rq_has_pinned_tasks(struct rq *rq)
@@ -2945,7 +2937,7 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return false;
 }
 
-#endif
+#endif /* !CONFIG_SMP */
 
 static void
 ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
@@ -4178,6 +4170,22 @@ static inline void finish_lock_switch(struct rq *rq)
 # define finish_arch_post_lock_switch()	do { } while (0)
 #endif
 
+static inline void kmap_local_sched_out(void)
+{
+#ifdef CONFIG_KMAP_LOCAL
+	if (unlikely(current->kmap_ctrl.idx))
+		__kmap_local_sched_out();
+#endif
+}
+
+static inline void kmap_local_sched_in(void)
+{
+#ifdef CONFIG_KMAP_LOCAL
+	if (unlikely(current->kmap_ctrl.idx))
+		__kmap_local_sched_in();
+#endif
+}
+
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -4200,6 +4208,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
+	kmap_local_sched_out();
 	prepare_task(next);
 	prepare_arch_switch(next);
 }
@@ -4266,6 +4275,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
+	kmap_local_sched_in();
 
 	fire_sched_in_preempt_notifiers(current);
 	/*
@@ -8040,6 +8050,39 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
 EXPORT_SYMBOL_GPL(__cant_sleep);
+
+#ifdef CONFIG_SMP
+void __cant_migrate(const char *file, int line)
+{
+	static unsigned long prev_jiffy;
+
+	if (irqs_disabled())
+		return;
+
+	if (is_migration_disabled(current))
+		return;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return;
+
+	if (preempt_count() > 0)
+		return;
+
+	if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
+		return;
+	prev_jiffy = jiffies;
+
+	pr_err("BUG: assuming non migratable context at %s:%d\n", file, line);
+	pr_err("in_atomic(): %d, irqs_disabled(): %d, migration_disabled() %u pid: %d, name: %s\n",
+	       in_atomic(), irqs_disabled(), is_migration_disabled(current),
+	       current->pid, current->comm);
+
+	debug_show_held_locks(current);
+	dump_stack();
+	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
+}
+EXPORT_SYMBOL_GPL(__cant_migrate);
+#endif
 #endif
 
 #ifdef CONFIG_MAGIC_SYSRQ
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bbd7c74b8fc78..0028702ea9d93 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1054,7 +1054,7 @@ struct rq {
 	struct cpuidle_state	*idle_state;
 #endif
 
-#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
+#ifdef CONFIG_SMP
 	unsigned int		nr_pinned;
 #endif
 	unsigned int		push_busy;
@@ -1090,7 +1090,7 @@ static inline int cpu_of(struct rq *rq)
 
 static inline bool is_migration_disabled(struct task_struct *p)
 {
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_SMP
 	return p->migration_disabled;
 #else
 	return false;
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index faaa927ac2c8b..1c1dbd3003257 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -26,7 +26,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	if (current->nr_cpus_allowed == 1)
 		goto out;
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_SMP
 	if (current->migration_disabled)
 		goto out;
 #endif
diff --git a/localversion-rt b/localversion-rt
index 6f206be67cd28..c3054d08a1129 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt1
+-rt2
diff --git a/mm/Kconfig b/mm/Kconfig
index 422399a3ad8bc..6fac2ca99f6a9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -872,4 +872,7 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config KMAP_LOCAL
+	bool
+
 endmenu
diff --git a/mm/highmem.c b/mm/highmem.c
index a0a1df2f8ee31..c62992c10d473 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -30,13 +30,7 @@
 #include <linux/kgdb.h>
 #include <asm/tlbflush.h>
 #include <linux/vmalloc.h>
-
-#ifndef CONFIG_PREEMPT_RT
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
-DEFINE_PER_CPU(int, __kmap_atomic_idx);
-EXPORT_PER_CPU_SYMBOL(__kmap_atomic_idx);
-#endif
-#endif
+#include <asm/fixmap.h>
 
 /*
  * Virtual_count is not a pure "count".
@@ -368,9 +362,216 @@ void kunmap_high(struct page *page)
 	if (need_wakeup)
 		wake_up(pkmap_map_wait);
 }
-
 EXPORT_SYMBOL(kunmap_high);
-#endif	/* CONFIG_HIGHMEM */
+#endif /* CONFIG_HIGHMEM */
+
+#ifdef CONFIG_KMAP_LOCAL
+
+static inline int kmap_local_idx_push(void)
+{
+	int idx = current->kmap_ctrl.idx++;
+
+	WARN_ON_ONCE(in_irq() && !irqs_disabled());
+	BUG_ON(idx >= KM_TYPE_NR);
+	return idx;
+}
+
+static inline int kmap_local_idx(void)
+{
+	return current->kmap_ctrl.idx - 1;
+}
+
+static inline void kmap_local_idx_pop(void)
+{
+	current->kmap_ctrl.idx--;
+	BUG_ON(current->kmap_ctrl.idx < 0);
+}
+
+#ifndef arch_kmap_local_post_map
+# define arch_kmap_local_post_map(vaddr, pteval)	do { } while (0)
+#endif
+
+#ifndef arch_kmap_local_pre_unmap
+# define arch_kmap_local_pre_unmap(vaddr)		do { } while (0)
+#endif
+
+#ifndef arch_kmap_local_post_unmap
+# define arch_kmap_local_post_unmap(vaddr)		do { } while (0)
+#endif
+
+#ifndef arch_kmap_local_map_idx
+#define arch_kmap_local_map_idx(type, pfn)	kmap_local_calc_idx(type)
+#endif
+
+#ifndef arch_kmap_local_unmap_idx
+#define arch_kmap_local_unmap_idx(type, vaddr)	kmap_local_calc_idx(type)
+#endif
+
+#ifndef arch_kmap_local_high_get
+static inline void *arch_kmap_local_high_get(struct page *page)
+{
+	return NULL;
+}
+#endif
+
+/* Unmap a local mapping which was obtained by kmap_high_get() */
+static inline void kmap_high_unmap_local(unsigned long vaddr)
+{
+#ifdef ARCH_NEEDS_KMAP_HIGH_GET
+	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP))
+		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
+#endif
+}
+
+static inline int kmap_local_calc_idx(int type)
+{
+	return type + KM_TYPE_NR * smp_processor_id();
+}
+
+static pte_t *__kmap_pte;
+
+static pte_t *kmap_get_pte(void)
+{
+	if (!__kmap_pte)
+		__kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
+	return __kmap_pte;
+}
+
+void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
+{
+	pte_t pteval, *kmap_pte = kmap_get_pte();
+	unsigned long vaddr;
+	int idx;
+
+	preempt_disable();
+	idx = arch_kmap_local_map_idx(kmap_local_idx_push(), pfn);
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+	BUG_ON(!pte_none(*(kmap_pte - idx)));
+	pteval = pfn_pte(pfn, prot);
+	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
+	arch_kmap_local_post_map(vaddr, pteval);
+	current->kmap_ctrl.pteval[kmap_local_idx()] = pteval;
+	preempt_enable();
+
+	return (void *)vaddr;
+}
+EXPORT_SYMBOL_GPL(__kmap_local_pfn_prot);
+
+void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	void *kmap;
+
+	if (!PageHighMem(page))
+		return page_address(page);
+
+	/* Try kmap_high_get() if architecture has it enabled */
+	kmap = arch_kmap_local_high_get(page);
+	if (kmap)
+		return kmap;
+
+	return __kmap_local_pfn_prot(page_to_pfn(page), prot);
+}
+EXPORT_SYMBOL(__kmap_local_page_prot);
+
+void kunmap_local_indexed(void *vaddr)
+{
+	unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
+	pte_t *kmap_pte = kmap_get_pte();
+	int idx;
+
+	if (addr < __fix_to_virt(FIX_KMAP_END) ||
+	    addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
+		WARN_ON_ONCE(addr < PAGE_OFFSET);
+
+		/* Handle mappings which were obtained by kmap_high_get() */
+		kmap_high_unmap_local(addr);
+		return;
+	}
+
+	preempt_disable();
+	idx = arch_kmap_local_unmap_idx(kmap_local_idx(), addr);
+	WARN_ON_ONCE(addr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
+
+	arch_kmap_local_pre_unmap(addr);
+	pte_clear(&init_mm, addr, kmap_pte - idx);
+	arch_kmap_local_post_unmap(addr);
+	current->kmap_ctrl.pteval[kmap_local_idx()] = __pte(0);
+	kmap_local_idx_pop();
+	preempt_enable();
+}
+EXPORT_SYMBOL(kunmap_local_indexed);
+
+/*
+ * Invoked before switch_to(). This is safe even when during or after
+ * clearing the maps an interrupt which needs a kmap_local happens because
+ * the task::kmap_ctrl.idx is not modified by the unmapping code so a
+ * nested kmap_local will use the next unused index and restore the index
+ * on unmap. The already cleared kmaps of the outgoing task are irrelevant
+ * because the interrupt context does not know about them. The same applies
+ * when scheduling back in for an interrupt which happens before the
+ * restore is complete.
+ */
+void __kmap_local_sched_out(void)
+{
+	struct task_struct *tsk = current;
+	pte_t *kmap_pte = kmap_get_pte();
+	int i;
+
+	/* Clear kmaps */
+	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
+		pte_t pteval = tsk->kmap_ctrl.pteval[i];
+		unsigned long addr;
+		int idx;
+
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		/*
+		 * This is a horrible hack for XTENSA to calculate the
+		 * coloured PTE index. Uses the PFN encoded into the pteval
+		 * and the map index calculation because the actual mapped
+		 * virtual address is not stored in task::kmap_ctrl.
+		 * For any sane architecture this is optimized out.
+		 */
+		idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
+
+		addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+		arch_kmap_local_pre_unmap(addr);
+		pte_clear(&init_mm, addr, kmap_pte - idx);
+		arch_kmap_local_post_unmap(addr);
+	}
+}
+
+void __kmap_local_sched_in(void)
+{
+	struct task_struct *tsk = current;
+	pte_t *kmap_pte = kmap_get_pte();
+	int i;
+
+	/* Restore kmaps */
+	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
+		pte_t pteval = tsk->kmap_ctrl.pteval[i];
+		unsigned long addr;
+		int idx;
+
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		/* See comment in __kmap_local_sched_out() */
+		idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
+		addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+		set_pte_at(&init_mm, addr, kmap_pte - idx, pteval);
+		arch_kmap_local_post_map(addr, pteval);
+	}
+}
+
+void kmap_local_fork(struct task_struct *tsk)
+{
+	if (WARN_ON_ONCE(tsk->kmap_ctrl.idx))
+		memset(&tsk->kmap_ctrl, 0, sizeof(tsk->kmap_ctrl));
+}
+
+#endif
 
 #if defined(HASHED_PAGE_VIRTUAL)
 
