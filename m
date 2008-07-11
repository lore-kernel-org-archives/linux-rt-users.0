From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
 variables
Date: Fri, 11 Jul 2008 10:19:02 +0200
Message-ID: <20080711101902.74b0abf6@bull.net>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux.kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Dinakar Guniguntala <dino@in.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	paulmck@linux.vnet.ibm.com, Nivedita Singhvi <niv@us.ibm.com>,
	Josh Triplett <josht@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>
To: Chirag Jog <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:43851 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbYGKISd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Jul 2008 04:18:33 -0400
In-Reply-To: <20080709160543.GG7101@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


  Hi Chirag,

On Wed, 9 Jul 2008 21:35:43 +0530 Chirag Jog <chirag@linux.vnet.ibm.com> wrote:

> 
> Hi,
> This patch fixes various paths in the -rt kernel on powerpc64 where per_cpu
> variables are accessed in a preempt unsafe way.
> When a power box with -rt kernel is booted, multiple BUG messages are
> generated "BUG: init:1 task might have lost a preemption check!".
> After booting a kernel with these patches applied, these messages
> don't appear.

  That does indeed greatly reduce BUGs display. Good. Thanks.

  Tested-by: Sebastien Dugue <sebastien.dugue@bull.net>

  Sebastien.

> 
> Also I ran the realtime tests from ltp to ensure the stability.
> 
> 
> Signed-Off-By: Chirag <chirag@linux.vnet.ibm.com>
> arch/powerpc/mm/tlb_64.c               |   31 ++++++++++++++++---------------
> arch/powerpc/platforms/pseries/iommu.c |   14 ++++++++++----
> include/asm-powerpc/tlb.h              |    5 ++---
> 3 files changed, 28 insertions(+), 22 deletions(-)
> 
>  
> Index: linux-2.6.25.8-rt7/arch/powerpc/mm/tlb_64.c
> ===================================================================
> --- linux-2.6.25.8-rt7.orig/arch/powerpc/mm/tlb_64.c	2008-07-09 21:29:21.000000000 +0530
> +++ linux-2.6.25.8-rt7/arch/powerpc/mm/tlb_64.c	2008-07-09 21:30:37.000000000 +0530
> @@ -38,7 +38,6 @@
>   * include/asm-powerpc/tlb.h file -- tgall
>   */
>  DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
> -DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
>  unsigned long pte_freelist_forced_free;
>  
>  struct pte_freelist_batch
> @@ -48,7 +47,7 @@
>  	pgtable_free_t	tables[0];
>  };
>  
> -DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
> +DEFINE_PER_CPU_LOCKED(struct pte_freelist_batch *, pte_freelist_cur);
>  unsigned long pte_freelist_forced_free;
>  
>  #define PTE_FREELIST_SIZE \
> @@ -92,24 +91,21 @@
>  
>  void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf)
>  {
> -	/*
> -	 * This is safe since tlb_gather_mmu has disabled preemption.
> -	 * tlb->cpu is set by tlb_gather_mmu as well.
> -	 */
> +	int cpu;
>          cpumask_t local_cpumask = cpumask_of_cpu(tlb->cpu);
> -	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
> +	struct pte_freelist_batch **batchp = &get_cpu_var_locked(pte_freelist_cur, &cpu);
>  
>  	if (atomic_read(&tlb->mm->mm_users) < 2 ||
>  	    cpus_equal(tlb->mm->cpu_vm_mask, local_cpumask)) {
>  		pgtable_free(pgf);
> -		return;
> +		goto cleanup;
>  	}
>  
>  	if (*batchp == NULL) {
>  		*batchp = (struct pte_freelist_batch *)__get_free_page(GFP_ATOMIC);
>  		if (*batchp == NULL) {
>  			pgtable_free_now(pgf);
> -			return;
> +			goto cleanup;
>  		}
>  		(*batchp)->index = 0;
>  	}
> @@ -118,6 +114,9 @@
>  		pte_free_submit(*batchp);
>  		*batchp = NULL;
>  	}
> +
> + cleanup:
> +	put_cpu_var_locked(pte_freelist_cur, cpu);
>  }
>  
>  /*
> @@ -253,13 +252,15 @@
>  
>  void pte_free_finish(void)
>  {
> -	/* This is safe since tlb_gather_mmu has disabled preemption */
> -	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
> +	int cpu;
> +	struct pte_freelist_batch **batchp = &get_cpu_var_locked(pte_freelist_cur, &cpu);
>  
> -	if (*batchp == NULL)
> -		return;
> -	pte_free_submit(*batchp);
> -	*batchp = NULL;
> +	if (*batchp) {
> +		pte_free_submit(*batchp);
> +		*batchp = NULL;
> +	}
> +
> +	put_cpu_var_locked(pte_freelist_cur, cpu);
>  }
>  
>  /**
> Index: linux-2.6.25.8-rt7/include/asm-powerpc/tlb.h
> ===================================================================
> --- linux-2.6.25.8-rt7.orig/include/asm-powerpc/tlb.h	2008-07-09 21:29:21.000000000 +0530
> +++ linux-2.6.25.8-rt7/include/asm-powerpc/tlb.h	2008-07-09 21:29:41.000000000 +0530
> @@ -40,18 +40,17 @@
>  
>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
> -	struct ppc64_tlb_batch *tlbbatch = &__get_cpu_var(ppc64_tlb_batch);
> +	struct ppc64_tlb_batch *tlbbatch = &get_cpu_var(ppc64_tlb_batch);
>  
>  	/* If there's a TLB batch pending, then we must flush it because the
>  	 * pages are going to be freed and we really don't want to have a CPU
>  	 * access a freed page because it has a stale TLB
>  	 */
>  	if (tlbbatch->index) {
> -		preempt_disable();
>  		__flush_tlb_pending(tlbbatch);
> -		preempt_enable();
>  	}
>  
> +	put_cpu_var(ppc64_tlb_batch);
>  	pte_free_finish();
>  }
>  
> Index: linux-2.6.25.8-rt7/arch/powerpc/platforms/pseries/iommu.c
> ===================================================================
> --- linux-2.6.25.8-rt7.orig/arch/powerpc/platforms/pseries/iommu.c	2008-07-09 21:29:21.000000000 +0530
> +++ linux-2.6.25.8-rt7/arch/powerpc/platforms/pseries/iommu.c	2008-07-09 21:29:41.000000000 +0530
> @@ -124,7 +124,7 @@
>  	}
>  }
>  
> -static DEFINE_PER_CPU(u64 *, tce_page) = NULL;
> +static DEFINE_PER_CPU_LOCKED(u64 *, tce_page) = NULL;
>  
>  static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  				     long npages, unsigned long uaddr,
> @@ -135,12 +135,13 @@
>  	u64 *tcep;
>  	u64 rpn;
>  	long l, limit;
> +	int cpu;
>  
>  	if (npages == 1)
>  		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
>  					   direction);
>  
> -	tcep = __get_cpu_var(tce_page);
> +	tcep = get_cpu_var_locked(tce_page, &cpu);
>  
>  	/* This is safe to do since interrupts are off when we're called
>  	 * from iommu_alloc{,_sg}()
> @@ -148,10 +149,13 @@
>  	if (!tcep) {
>  		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
>  		/* If allocation fails, fall back to the loop implementation */
> -		if (!tcep)
> +		if (!tcep) {
> +			put_cpu_var_locked(tce_page, cpu);
>  			return tce_build_pSeriesLP(tbl, tcenum, npages,
>  						   uaddr, direction);
> -		__get_cpu_var(tce_page) = tcep;
> +		}
> +
> +		per_cpu_var_locked(tce_page, cpu) = tcep;
>  	}
>  
>  	rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
> @@ -188,6 +192,8 @@
>  		printk("\ttce[0] val = 0x%lx\n", tcep[0]);
>  		show_stack(current, (unsigned long *)__get_SP());
>  	}
> +
> +	put_cpu_var_locked(tce_page, cpu);
>  }
>  
>  static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
