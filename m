From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Page faults with 3.6.11-rt30 but not with 3.6.11-rt25
Date: Fri, 22 Mar 2013 10:46:40 -0400
Message-ID: <1363963600.6345.102.camel@gandalf.local.home>
References: <F9467A784CC48947B1D879F07370839E0EBD79BD@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:15449 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330Ab3CVOqm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Mar 2013 10:46:42 -0400
In-Reply-To: <F9467A784CC48947B1D879F07370839E0EBD79BD@fe20099s.ecn.etasgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-03-22 at 09:46 +0000, Koehrer Mathias (ETAS/ESS2) wrote:
> Hi all,
> 
> I have a x86 (32bit, Intel Core 2 Quad, 4GB RAM) system running fairly stable using 3.6.11-rt25.
> Now I switched to the latest RT_PREEMPT patch of the 3.6 series (3.6.11-rt30).
> However, since that I get frequently kernel messages like the one below.
> The system is not working stable anymore.
> 
> ------------[ cut here ]------------
> WARNING: at arch/x86/mm/highmem_32.c:47 kmap_atomic_prot+0x76/0xe0()
> Hardware name: HP xw4600 Workstation
> Modules linked in: kvm
> Pid: 1640, comm: blkid Not tainted 3.6.11-rt30 #2
> Call Trace:
>  [<c1026cd5>] warn_slowpath_common+0x68/0x7d
>  [<c1023e9c>] ? kmap_atomic_prot+0x76/0xe0
>  [<c1026cfe>] warn_slowpath_null+0x14/0x18
>  [<c1023e9c>] kmap_atomic_prot+0x76/0xe0
>  [<c1023f19>] kmap_atomic+0x13/0x15
>  [<c10909a8>] get_page_from_freelist+0x3f9/0x49a
>  [<c1091324>] __alloc_pages_nodemask+0x11f/0x5b5
>  [<c108bda7>] ? unlock_page+0x1d/0x20
>  [<c10b14be>] ? kmem_cache_alloc+0xda/0x18b
>  [<c10a9fca>] ? anon_vma_prepare+0x54/0xf9
>  [<c10aa034>] ? anon_vma_prepare+0xbe/0xf9
>  [<c10a3dfb>] handle_pte_fault+0x135/0x58b
>  [<c1091a34>] ? free_pages+0x22/0x24
>  [<c10a2c0b>] ? tlb_finish_mmu+0x25/0x36
>  [<c10a4f7a>] handle_mm_fault+0x91/0xb2
>  [<c1020a9f>] do_page_fault+0x32c/0x369
>  [<c10a79f6>] ? do_brk+0x1d4/0x207
>  [<c105b9f0>] ? rt_up_write+0xd/0xf
>  [<c10a7b62>] ? sys_brk+0xf9/0x102
>  [<c1020773>] ? vmalloc_sync_all+0xf7/0xf7
>  [<c13a5bfa>] error_code+0x5a/0x60
>  [<c1020773>] ? vmalloc_sync_all+0xf7/0xf7
> ---[ end trace 0000000000000002 ]---
> 
> With the 3.6.11-rt25 I never saw this errors.
> I have attached the full "dmesg" output and the kernel configuration.
> I have a pure vanilla kernel + the RT_PREEMPT patch. No other patches in the kernel.
> 
> Any feedback or proposals how to get around that issue are highly welcome.

Doing a diff between the two kernels, it looks like there was a bit of
work on highmem (the stuff that lets you use more than 1 Gig of memory
on a 32 bit system). I haven't looked too deep at the bug, but if you
apply the following patch, do you get a stable system again?

(this is a revert of "highmem: Store ptes right away in the task
struct")

-- Steve


diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 33e5d14..120c790 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -198,34 +198,6 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 }
 EXPORT_SYMBOL_GPL(start_thread);
 
-#ifdef CONFIG_PREEMPT_RT_FULL
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
-		set_pte(kmap_pte - idx, next_p->kmap_pte[i]);
-	}
-}
-#else
-static inline void
-switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p) { }
-#endif
-
 
 /*
  *	switch_to(x,y) should switch tasks from x to y.
@@ -305,7 +277,40 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 		     task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT))
 		__switch_to_xtra(prev_p, next_p, tss);
 
-	switch_kmaps(prev_p, next_p);
+#ifdef CONFIG_PREEMPT_RT_FULL
+	/*
+	 * Save @prev's kmap_atomic stack
+	 */
+	prev_p->kmap_idx = __this_cpu_read(__kmap_atomic_idx);
+	if (unlikely(prev_p->kmap_idx)) {
+		int i;
+
+		for (i = 0; i < prev_p->kmap_idx; i++) {
+			int idx = i + KM_TYPE_NR * smp_processor_id();
+
+			pte_t *ptep = kmap_pte - idx;
+			prev_p->kmap_pte[i] = *ptep;
+			kpte_clear_flush(ptep, __fix_to_virt(FIX_KMAP_BEGIN + idx));
+		}
+
+		__this_cpu_write(__kmap_atomic_idx, 0);
+	}
+
+	/*
+	 * Restore @next_p's kmap_atomic stack
+	 */
+	if (unlikely(next_p->kmap_idx)) {
+		int i;
+
+		__this_cpu_write(__kmap_atomic_idx, next_p->kmap_idx);
+
+		for (i = 0; i < next_p->kmap_idx; i++) {
+			int idx = i + KM_TYPE_NR * smp_processor_id();
+
+			set_pte(kmap_pte - idx, next_p->kmap_pte[i]);
+		}
+	}
+#endif
 
 	/*
 	 * Leave lazy mode, flushing any hypercalls made here.
diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
index 0935789..ab8683a 100644
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -31,7 +31,6 @@ EXPORT_SYMBOL(kunmap);
  */
 void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
-	pte_t pte = mk_pte(page, prot);
 	unsigned long vaddr;
 	int idx, type;
 
@@ -45,10 +44,7 @@ void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 	WARN_ON(!pte_none(*(kmap_pte-idx)));
-#ifdef CONFIG_PREEMPT_RT_FULL
-	current->kmap_pte[type] = pte;
-#endif
-	set_pte(kmap_pte-idx, pte);
+	set_pte(kmap_pte-idx, mk_pte(page, prot));
 	arch_flush_lazy_mmu_mode();
 
 	return (void *)vaddr;
diff --git a/arch/x86/mm/iomap_32.c b/arch/x86/mm/iomap_32.c
index 4e1d4d5..7b179b4 100644
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -56,7 +56,6 @@ EXPORT_SYMBOL_GPL(iomap_free);
 
 void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
 {
-	pte_t pte = pfn_pte(pfn, prot);
 	unsigned long vaddr;
 	int idx, type;
 
@@ -65,10 +64,7 @@ void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
 	type = kmap_atomic_idx_push();
 	idx = type + KM_TYPE_NR * smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_PREEMPT_RT_FULL
-	current->kmap_pte[type] = pte;
-#endif
-	set_pte(kmap_pte - idx, pte);
+	set_pte(kmap_pte - idx, pfn_pte(pfn, prot));
 	arch_flush_lazy_mmu_mode();
 
 	return (void *)vaddr;
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index acdd321..5d6119c 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -86,49 +86,32 @@ static inline void __kunmap_atomic(void *addr)
 
 #if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
 
-#ifndef CONFIG_PREEMPT_RT_FULL
 DECLARE_PER_CPU(int, __kmap_atomic_idx);
-#endif
 
 static inline int kmap_atomic_idx_push(void)
 {
-#ifndef CONFIG_PREEMPT_RT_FULL
 	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
 
-# ifdef CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 	WARN_ON_ONCE(in_irq() && !irqs_disabled());
 	BUG_ON(idx > KM_TYPE_NR);
-# endif
-	return idx;
-#else
-	return current->kmap_idx++;
 #endif
+	return idx;
 }
 
 static inline int kmap_atomic_idx(void)
 {
-#ifndef CONFIG_PREEMPT_RT_FULL
 	return __this_cpu_read(__kmap_atomic_idx) - 1;
-#else
-	return current->kmap_idx - 1;
-#endif
 }
 
 static inline void kmap_atomic_idx_pop(void)
 {
-#ifndef CONFIG_PREEMPT_RT_FULL
-# ifdef CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 	int idx = __this_cpu_dec_return(__kmap_atomic_idx);
 
 	BUG_ON(idx < 0);
-# else
-	__this_cpu_dec(__kmap_atomic_idx);
-# endif
 #else
-	current->kmap_idx--;
-# ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(current->kmap_idx < 0);
-# endif
+	__this_cpu_dec(__kmap_atomic_idx);
 #endif
 }
 
diff --git a/mm/highmem.c b/mm/highmem.c
index 29e88a8..2da13a5 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -29,11 +29,10 @@
 #include <linux/kgdb.h>
 #include <asm/tlbflush.h>
 
-#ifndef CONFIG_PREEMPT_RT_FULL
+
 #if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
 DEFINE_PER_CPU(int, __kmap_atomic_idx);
 #endif
-#endif
 
 /*
  * Virtual_count is not a pure "count".
@@ -48,9 +47,8 @@ DEFINE_PER_CPU(int, __kmap_atomic_idx);
 unsigned long totalhigh_pages __read_mostly;
 EXPORT_SYMBOL(totalhigh_pages);
 
-#ifndef CONFIG_PREEMPT_RT_FULL
+
 EXPORT_PER_CPU_SYMBOL(__kmap_atomic_idx);
-#endif
 
 unsigned int nr_free_highpages (void)
 {



