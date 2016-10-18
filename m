From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 6/6] mm: add preempt points into __purge_vmap_area_lazy
Date: Tue, 18 Oct 2016 16:56:48 -0400
Message-ID: <20161018205648.GB7021@home.goodmis.org>
References: <1476773771-11470-1-git-send-email-hch@lst.de>
 <1476773771-11470-7-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@linux-foundation.org, joelaf@google.com, jszhang@marvell.com,
	chris@chris-wilson.co.uk, joaodias@google.com, linux-mm@kvack.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1476773771-11470-7-git-send-email-hch@lst.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Oct 18, 2016 at 08:56:11AM +0200, Christoph Hellwig wrote:
> From: Joel Fernandes <joelaf@google.com>
> 
> Use cond_resched_lock to avoid holding the vmap_area_lock for a
> potentially long time.
> 
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> [hch: split from a larger patch by Joel, wrote the crappy changelog]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6c7eb8d..98b19ea 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -628,7 +628,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  	struct llist_node *valist;
>  	struct vmap_area *va;
>  	struct vmap_area *n_va;
> -	int nr = 0;
> +	bool do_free = false;
>  
>  	lockdep_assert_held(&vmap_purge_lock);
>  
> @@ -638,18 +638,22 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  			start = va->va_start;
>  		if (va->va_end > end)
>  			end = va->va_end;
> -		nr += (va->va_end - va->va_start) >> PAGE_SHIFT;
> +		do_free = true;
>  	}
>  
> -	if (!nr)
> +	if (!do_free)
>  		return false;
>  
> -	atomic_sub(nr, &vmap_lazy_nr);
>  	flush_tlb_kernel_range(start, end);
>  
>  	spin_lock(&vmap_area_lock);
> -	llist_for_each_entry_safe(va, n_va, valist, purge_list)
> +	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
> +		int nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
> +
>  		__free_vmap_area(va);
> +		atomic_sub(nr, &vmap_lazy_nr);
> +		cond_resched_lock(&vmap_area_lock);

Is releasing the lock within a llist_for_each_entry_safe() actually safe? Is
vmap_area_lock the one to protect the valist?

That is llist_for_each_entry_safe(va, n_va, valist, purg_list) does:

	for (va = llist_entry(valist, typeof(*va), purge_list);
	     &va->purge_list != NULL &&
	     n_va = llist_entry(va->purge_list.next, typeof(*n_va),
				purge_list, true);
	     pos = n)

Thus n_va is pointing to the next element to process when we release the
lock. Is it possible for another task to get into this same path and process
the item that n_va is pointing to? Then when the preempted task comes back,
grabs the vmap_area_lock, and then continues the loop with what n_va has,
could that cause problems? That is, the next iteration after releasing the
lock does va = n_va. What happens if n_va no longer exits?

I don't know this code that well, and perhaps vmap_area_lock is not protecting
the list and this is all fine.

-- Steve


> +	}
>  	spin_unlock(&vmap_area_lock);
>  	return true;
>  }
> -- 
> 2.1.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
