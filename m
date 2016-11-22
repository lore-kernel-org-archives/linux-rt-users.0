From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 07/10] mm: warn about vfree from atomic context
Date: Tue, 22 Nov 2016 19:35:34 +0300
Message-ID: <996e56cb-137f-cd3e-eb69-e9ef03ad75c4@virtuozzo.com>
References: <1479474236-4139-1-git-send-email-hch@lst.de>
 <1479474236-4139-8-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <joelaf@google.com>, <jszhang@marvell.com>, <chris@chris-wilson.co.uk>,
	<joaodias@google.com>, <linux-mm@kvack.org>,
	<linux-rt-users@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, <akpm@linux-foundation.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1479474236-4139-8-git-send-email-hch@lst.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On 11/18/2016 04:03 PM, Christoph Hellwig wrote:
> We can't handle vfree itself from atomic context, but callers
> can explicitly use vfree_atomic instead, which defers the actual
> vfree to a workqueue.  Unfortunately in_atomic does not work
> on non-preemptible kernels, so we can't just do the right thing
> by default.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 80f3fae..e2030b4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1530,6 +1530,7 @@ void vfree_atomic(const void *addr)
>  void vfree(const void *addr)
>  {
>  	BUG_ON(in_nmi());
> +	WARN_ON_ONCE(in_atomic());

This one is wrong. We still can call vfree() from interrupt context.
So WARN_ON_ONCE(in_atomic() && !in_interrupt()) would be correct,
but also redundant. DEBUG_ATOMIC_SLEEP=y should catch illegal vfree() calls.
Let's just drop this patch, ok?



>  	kmemleak_free(addr);
>  
> 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
