From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
Date: Thu, 17 Jul 2008 18:26:45 +0530
Message-ID: <20080717125645.GN20277@linux.vnet.ibm.com>
References: <20080709160543.GG7101@linux.vnet.ibm.com> <1216085521.7740.37.camel@pasglop>
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
Received: from e28smtp05.in.ibm.com ([59.145.155.5]:42658 "EHLO
	e28esmtp05.in.ibm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754052AbYGQM5J (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Jul 2008 08:57:09 -0400
Content-Disposition: inline
In-Reply-To: <1216085521.7740.37.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Benjamin,
   Thanks for the review
* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2008-07-15 11:32:01]:

> On Wed, 2008-07-09 at 21:35 +0530, Chirag Jog wrote:
> > Hi,
> > This patch fixes various paths in the -rt kernel on powerpc64 where per_cpu
> > variables are accessed in a preempt unsafe way.
> > When a power box with -rt kernel is booted, multiple BUG messages are
> > generated "BUG: init:1 task might have lost a preemption check!".
> > After booting a kernel with these patches applied, these messages
> > don't appear.
> > 
> > Also I ran the realtime tests from ltp to ensure the stability.
> 
> That sounds bad tho...
> 
> IE. You are changing the code to lock/unlock on all those TLB batching
> operations, but seem to miss the core reason why it was done that way:
> ie, the code assumes that it will not change CPU -between- those calls,
> since the whole stuff should be already have been within a per-cpu
> locked section at the caller level.
> 
All these operations are done assuming that tlb_gather_mmu disables
preemption and tlb_finish_mmu enables preemption again.
This is not true for -rt.
For x86, none of the code paths between tlb_gather_mmu and
tlb_finish_mmu access any per_cpu variables.
But this is not true for powerpc64 as we can see.

One way could be to make tlb_gather_mmu disable preemption as it does
in mainline but only for powerpc.
Although i am not sure, if this is the right step ahead.

I am attaching a patch below for the same.
I have left out the tce bits, as they are fine.

Note: I haven't extensively tested the patch
                    
- Thanks, 
    Chirag


Index: linux-2.6.25.8-rt7/arch/powerpc/mm/tlb_64.c
===================================================================
--- linux-2.6.25.8-rt7.orig/arch/powerpc/mm/tlb_64.c	2008-07-17 16:51:31.000000000 +0530
+++ linux-2.6.25.8-rt7/arch/powerpc/mm/tlb_64.c	2008-07-17 16:51:33.000000000 +0530
@@ -37,7 +37,7 @@
 /* This is declared as we are using the more or less generic
  * include/asm-powerpc/tlb.h file -- tgall
  */
-DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
 unsigned long pte_freelist_forced_free;
 
@@ -96,7 +96,7 @@
 	 * This is safe since tlb_gather_mmu has disabled preemption.
 	 * tlb->cpu is set by tlb_gather_mmu as well.
 	 */
-        cpumask_t local_cpumask = cpumask_of_cpu(tlb->cpu);
+        cpumask_t local_cpumask = cpumask_of_cpu(smp_processor_id());
 	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
 
 	if (atomic_read(&tlb->mm->mm_users) < 2 ||
Index: linux-2.6.25.8-rt7/arch/powerpc/mm/init_32.c
===================================================================
--- linux-2.6.25.8-rt7.orig/arch/powerpc/mm/init_32.c	2008-07-17 16:51:31.000000000 +0530
+++ linux-2.6.25.8-rt7/arch/powerpc/mm/init_32.c	2008-07-17 16:51:33.000000000 +0530
@@ -54,7 +54,7 @@
 #endif
 #define MAX_LOW_MEM	CONFIG_LOWMEM_SIZE
 
-DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 unsigned long total_memory;
 unsigned long total_lowmem;
Index: linux-2.6.25.8-rt7/include/asm-powerpc/tlb.h
===================================================================
--- linux-2.6.25.8-rt7.orig/include/asm-powerpc/tlb.h	2008-07-17 16:51:31.000000000 +0530
+++ linux-2.6.25.8-rt7/include/asm-powerpc/tlb.h	2008-07-17 16:51:33.000000000 +0530
@@ -46,11 +46,8 @@
 	 * pages are going to be freed and we really don't want to have a CPU
 	 * access a freed page because it has a stale TLB
 	 */
-	if (tlbbatch->index) {
-		preempt_disable();
+	if (tlbbatch->index)
 		__flush_tlb_pending(tlbbatch);
-		preempt_enable();
-	}
 
 	pte_free_finish();
 }
Index: linux-2.6.25.8-rt7/include/asm-generic/tlb.h
===================================================================
--- linux-2.6.25.8-rt7.orig/include/asm-generic/tlb.h	2008-07-17 16:51:31.000000000 +0530
+++ linux-2.6.25.8-rt7/include/asm-generic/tlb.h	2008-07-17 17:33:02.000000000 +0530
@@ -41,23 +41,32 @@
 	unsigned int		nr;	/* set to ~0U means fast mode */
 	unsigned int		need_flush;/* Really unmapped some ptes? */
 	unsigned int		fullmm; /* non-zero means full mm flush */
+#if !defined(__powerpc64__)
 	int			cpu;
+#endif
 	struct page *		pages[FREE_PTE_NR];
 };
 
 /* Users of the generic TLB shootdown code must declare this storage space. */
-DECLARE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
-
+#if !defined(__powerpc64__)
+	DECLARE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
+#else
+	DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
+#endif
 /* tlb_gather_mmu
  *	Return a pointer to an initialized struct mmu_gather.
  */
 static inline struct mmu_gather *
 tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
 {
-	int cpu;
-	struct mmu_gather *tlb = &get_cpu_var_locked(mmu_gathers, &cpu);
 
-	tlb->cpu = cpu;
+#if !defined(__powerpc64__)
+		int cpu;
+		struct mmu_gather *tlb = &get_cpu_var_locked(mmu_gathers, &cpu);
+		tlb->cpu = cpu;
+#else
+		struct mmu_gather *tlb = &get_cpu_var(mmu_gathers);
+#endif
 	tlb->mm = mm;
 
 	/* Use fast mode if only one CPU is online */
@@ -93,7 +102,11 @@
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
 
-	put_cpu_var_locked(mmu_gathers, tlb->cpu);
+#if !defined(__powerpc64__)
+		put_cpu_var_locked(mmu_gathers, tlb->cpu);
+#else
+		put_cpu_var(mmu_gathers);
+#endif
 }
 
 /* tlb_remove_page


