From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] munmap: kbuild menu for munmap interface
Date: Mon, 25 Apr 2011 11:31:13 -0400
Message-ID: <1303745473.18763.9.camel@gandalf.stny.rr.com>
References: <1303728272-11408-1-git-send-email-leemgs1@gmail.com>
	 <1303728272-11408-4-git-send-email-leemgs1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
	Darren Hart <dvhart@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Geunsik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:36967 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756278Ab1DYPbQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Apr 2011 11:31:16 -0400
In-Reply-To: <1303728272-11408-4-git-send-email-leemgs1@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-04-25 at 19:44 +0900, Geunsik Lim wrote:
> From: Geunsik Lim <geunsik.lim@samsung.com>
> 
> Support kbuild menu to select memory unmap operation size
> at build time.

The subject and this line are not quite the same. The subject looks like
it only modifies the kbuild options, not mm/memory.c as well. Please
fix.

> 
> Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
> Acked-by: Hyunjin Choi <hj89.choi@samsung.com>
> ---
>  init/Kconfig |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/memory.c  |   21 +++++++++++-----
>  2 files changed, 84 insertions(+), 7 deletions(-)
> 

> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -57,6 +57,7 @@
>  #include <linux/swapops.h>
>  #include <linux/elf.h>
>  #include <linux/gfp.h>
> +#include <linux/munmap_unit_size.h>
>  
>  #include <asm/io.h>
>  #include <asm/pgalloc.h>
> @@ -1079,6 +1080,10 @@ static unsigned long unmap_page_range(struct mmu_gather *tlb,
>  			(*zap_work)--;
>  			continue;
>  		}
> +#if 0
> +printk("DEBUG:munmap step2,(%s:%d), unmap range = current(%lu) + \
> +zap_work(%lu bytes) \n", current->comm, current->pid, addr, *zap_work);
> +#endif

No #if 0 debug printing in mainline.

>  		next = zap_pud_range(tlb, vma, pgd, addr, next,
>  						zap_work, details);
>  	} while (pgd++, addr = next, (addr != end && *zap_work > 0));
> @@ -1088,12 +1093,10 @@ static unsigned long unmap_page_range(struct mmu_gather *tlb,
>  	return addr;
>  }
>  
> -#ifdef CONFIG_PREEMPT
> -# define ZAP_BLOCK_SIZE	(8 * PAGE_SIZE)
> -#else
> -/* No preempt: go for improved straight-line efficiency */
> -# define ZAP_BLOCK_SIZE	(1024 * PAGE_SIZE)
> -#endif
> +/* No preempt: go for improved straight-line efficiency
> + * on PREEMPT(preemption mode) this is not a critical latency-path.
> + */
> +# define ZAP_BLOCK_SIZE        (munmap_unit_size * PAGE_SIZE)
>  
>  /**
>   * unmap_vmas - unmap a range of memory covered by a list of vma's
> @@ -1133,7 +1136,11 @@ unsigned long unmap_vmas(struct mmu_gather **tlbp,
>  	spinlock_t *i_mmap_lock = details? details->i_mmap_lock: NULL;
>  	int fullmm = (*tlbp)->fullmm;
>  	struct mm_struct *mm = vma->vm_mm;
> -
> +#if 0
> +printk("DEBUG:munmap step1,(%s:%d), unit=zap_work(%ld)/ZAP_BLOCK(%ld), \
> +vma:[%8lu]=%lu-%lu \n", current->comm, current->pid, zap_work, ZAP_BLOCK_SIZE, \
> +vma->vm_end - vma->vm_start, vma->vm_end, vma->vm_start);
> +#endif

Get rid of this too.

Either have pr_debug(...) or nothing at all.

-- Steve

>  	mmu_notifier_invalidate_range_start(mm, start_addr, end_addr);
>  	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next) {
>  		unsigned long end;


