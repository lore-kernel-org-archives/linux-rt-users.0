From: Corey Minyard <cminyard@caviumnetworks.com>
Subject: Re: [PATCH] slab+rt: Don't free locks twice in cpuup_canceled
Date: Wed, 25 Sep 2013 11:37:06 -0500
Message-ID: <52431132.9070209@caviumnetworks.com>
References: <1379700149-16400-1-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bn1lp0156.outbound.protection.outlook.com ([207.46.163.156]:5631
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750855Ab3IYQwr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Sep 2013 12:52:47 -0400
In-Reply-To: <1379700149-16400-1-git-send-email-minyard@acm.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I forgot to mention that this was on 3.10.10-rt7.

-corey

On 09/20/2013 01:02 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> Signed-off-by: Corey Minyard <cminyard@cavium.com>
> ---
>  mm/slab.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index 494274e..0a3d6d3 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1270,7 +1270,6 @@ static void __cpuinit cpuup_canceled(long cpu)
>  			free_block(cachep, nc->entry, nc->avail, node);
>  
>  		if (!cpumask_empty(mask)) {
> -			local_spin_unlock_irq(slab_lock, &n->list_lock);
>  			unlock_l3_and_free_delayed(&n->list_lock);
>  			goto free_array_cache;
>  		}
> @@ -1285,7 +1284,6 @@ static void __cpuinit cpuup_canceled(long cpu)
>  		alien = n->alien;
>  		n->alien = NULL;
>  
> -		local_spin_unlock_irq(slab_lock, &n->list_lock);
>  		unlock_l3_and_free_delayed(&n->list_lock);
>  
>  		kfree(shared);

