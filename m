From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 4/7] mm: defer vmalloc from atomic context
Date: Mon, 24 Oct 2016 18:44:37 +0300
Message-ID: <25c117ae-6d06-9846-6a88-ae6221ad6bfe@virtuozzo.com>
References: <1477149440-12478-1-git-send-email-hch@lst.de>
 <1477149440-12478-5-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <joelaf@google.com>, <jszhang@marvell.com>, <chris@chris-wilson.co.uk>,
	<joaodias@google.com>, <linux-mm@kvack.org>,
	<linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, <akpm@linux-foundation.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1477149440-12478-5-git-send-email-hch@lst.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org



On 10/22/2016 06:17 PM, Christoph Hellwig wrote:
> We want to be able to use a sleeping lock for freeing vmap to keep
> latency down.  For this we need to use the deferred vfree mechanisms
> no only from interrupt, but from any atomic context.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a4e2cec..bcc1a64 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1509,7 +1509,7 @@ void vfree(const void *addr)
>  
>  	if (!addr)
>  		return;
> -	if (unlikely(in_interrupt())) {
> +	if (unlikely(in_atomic())) {

in_atomic() cannot always detect atomic context, thus it shouldn't be used here.
You can add something like vfree_in_atomic() and use it in atomic call sites.

>  		struct vfree_deferred *p = this_cpu_ptr(&vfree_deferred);
>  		if (llist_add((struct llist_node *)addr, &p->list))
>  			schedule_work(&p->wq);
> 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
