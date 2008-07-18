From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
Date: Fri, 18 Jul 2008 15:41:33 +0530
Message-ID: <20080718101133.GO20277@linux.vnet.ibm.com>
References: <20080709160543.GG7101@linux.vnet.ibm.com> <1216085521.7740.37.camel@pasglop> <20080717125645.GN20277@linux.vnet.ibm.com> <1216325671.7740.359.camel@pasglop>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux.kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nivedita Singhvi <niv@us.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	paulmck@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP01.au.ibm.com ([202.81.18.162]:37794 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbYGRKOU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Jul 2008 06:14:20 -0400
Content-Disposition: inline
In-Reply-To: <1216325671.7740.359.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2008-07-18 06:14:31]:

> 
> > All these operations are done assuming that tlb_gather_mmu disables
> > preemption and tlb_finish_mmu enables preemption again.
> > This is not true for -rt.
> > For x86, none of the code paths between tlb_gather_mmu and
> > tlb_finish_mmu access any per_cpu variables.
> > But this is not true for powerpc64 as we can see.
> > 
> > One way could be to make tlb_gather_mmu disable preemption as it does
> > in mainline but only for powerpc.
> > Although i am not sure, if this is the right step ahead.
> > 
> > I am attaching a patch below for the same.
> > I have left out the tce bits, as they are fine.
> > 
> > Note: I haven't extensively tested the patch
> 
> A better option is to make sure that a context switch does the right
> thing, flushing the pending batch. I think that's already the case,
> which means that your original patch may work, but that needs to
> be double-checked and commented properly.
> 
With the original patch, the pending batch does get flushed 
in a non-preemptable region. 
I am resending the original with just adding the necesary comments.

-Thanks,
        Chirag



Signed-Off-By: Chirag <chirag@linux.vnet.ibm.com>

Index: linux-2.6.25.8-rt7/arch/powerpc/mm/tlb_64.c
===================================================================
--- linux-2.6.25.8-rt7.orig/arch/powerpc/mm/tlb_64.c	2008-07-18 10:08:00.000000000 +0530
+++ linux-2.6.25.8-rt7/arch/powerpc/mm/tlb_64.c	2008-07-18 10:09:54.000000000 +0530
@@ -38,7 +38,6 @@
  * include/asm-powerpc/tlb.h file -- tgall
  */
 DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
-DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
 unsigned long pte_freelist_forced_free;
 
 struct pte_freelist_batch
@@ -48,7 +47,7 @@
 	pgtable_free_t	tables[0];
 };
 
-DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
+DEFINE_PER_CPU_LOCKED(struct pte_freelist_batch *, pte_freelist_cur);
 unsigned long pte_freelist_forced_free;
 
 #define PTE_FREELIST_SIZE \
@@ -92,24 +91,21 @@
 
 void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf)
 {
-	/*
-	 * This is safe since tlb_gather_mmu has disabled preemption.
-	 * tlb->cpu is set by tlb_gather_mmu as well.
-	 */
+	int cpu;
         cpumask_t local_cpumask = cpumask_of_cpu(tlb->cpu);
-	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
+	struct pte_freelist_batch **batchp = &get_cpu_var_locked(pte_freelist_cur, &cpu);
 
 	if (atomic_read(&tlb->mm->mm_users) < 2 ||
 	    cpus_equal(tlb->mm->cpu_vm_mask, local_cpumask)) {
 		pgtable_free(pgf);
-		return;
+		goto cleanup;
 	}
 
 	if (*batchp == NULL) {
 		*batchp = (struct pte_freelist_batch *)__get_free_page(GFP_ATOMIC);
 		if (*batchp == NULL) {
 			pgtable_free_now(pgf);
-			return;
+			goto cleanup;
 		}
 		(*batchp)->index = 0;
 	}
@@ -118,6 +114,9 @@
 		pte_free_submit(*batchp);
 		*batchp = NULL;
 	}
+
+ cleanup:
+	put_cpu_var_locked(pte_freelist_cur, cpu);
 }
 
 /*
@@ -253,13 +252,15 @@
 
 void pte_free_finish(void)
 {
-	/* This is safe since tlb_gather_mmu has disabled preemption */
-	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
+	int cpu;
+	struct pte_freelist_batch **batchp = &get_cpu_var_locked(pte_freelist_cur, &cpu);
 
-	if (*batchp == NULL)
-		return;
-	pte_free_submit(*batchp);
-	*batchp = NULL;
+	if (*batchp) {
+		pte_free_submit(*batchp);
+		*batchp = NULL;
+	}
+
+	put_cpu_var_locked(pte_freelist_cur, cpu);
 }
 
 /**
Index: linux-2.6.25.8-rt7/include/asm-powerpc/tlb.h
===================================================================
--- linux-2.6.25.8-rt7.orig/include/asm-powerpc/tlb.h	2008-07-18 10:08:00.000000000 +0530
+++ linux-2.6.25.8-rt7/include/asm-powerpc/tlb.h	2008-07-18 10:31:02.000000000 +0530
@@ -40,18 +40,20 @@
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	struct ppc64_tlb_batch *tlbbatch = &__get_cpu_var(ppc64_tlb_batch);
+	/* Disable preemption to ensure the pending TLB batch is flushed
+	 * before a potential context switch
+	 */
+	struct ppc64_tlb_batch *tlbbatch = &get_cpu_var(ppc64_tlb_batch);
 
 	/* If there's a TLB batch pending, then we must flush it because the
 	 * pages are going to be freed and we really don't want to have a CPU
 	 * access a freed page because it has a stale TLB
 	 */
 	if (tlbbatch->index) {
-		preempt_disable();
 		__flush_tlb_pending(tlbbatch);
-		preempt_enable();
 	}
 
+	put_cpu_var(ppc64_tlb_batch);
 	pte_free_finish();
 }
 
Index: linux-2.6.25.8-rt7/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-2.6.25.8-rt7.orig/arch/powerpc/platforms/pseries/iommu.c	2008-07-17 14:47:30.000000000 +0530
+++ linux-2.6.25.8-rt7/arch/powerpc/platforms/pseries/iommu.c	2008-07-18 10:09:54.000000000 +0530
@@ -124,7 +124,7 @@
 	}
 }
 
-static DEFINE_PER_CPU(u64 *, tce_page) = NULL;
+static DEFINE_PER_CPU_LOCKED(u64 *, tce_page) = NULL;
 
 static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
@@ -135,12 +135,13 @@
 	u64 *tcep;
 	u64 rpn;
 	long l, limit;
+	int cpu;
 
 	if (npages == 1)
 		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
 					   direction);
 
-	tcep = __get_cpu_var(tce_page);
+	tcep = get_cpu_var_locked(tce_page, &cpu);
 
 	/* This is safe to do since interrupts are off when we're called
 	 * from iommu_alloc{,_sg}()
@@ -148,10 +149,13 @@
 	if (!tcep) {
 		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
-		if (!tcep)
+		if (!tcep) {
+			put_cpu_var_locked(tce_page, cpu);
 			return tce_build_pSeriesLP(tbl, tcenum, npages,
 						   uaddr, direction);
-		__get_cpu_var(tce_page) = tcep;
+		}
+
+		per_cpu_var_locked(tce_page, cpu) = tcep;
 	}
 
 	rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
@@ -188,6 +192,8 @@
 		printk("\ttce[0] val = 0x%lx\n", tcep[0]);
 		show_stack(current, (unsigned long *)__get_SP());
 	}
+
+	put_cpu_var_locked(tce_page, cpu);
 }
 
 static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
