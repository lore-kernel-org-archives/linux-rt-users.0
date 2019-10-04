Return-Path: <SRS0=K3q3=X5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD44C47404
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Oct 2019 15:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C052133F
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Oct 2019 15:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbfJDPhe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:37:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37227 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389586AbfJDPhe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Oct 2019 11:37:34 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iGPe4-0006ZK-Na; Fri, 04 Oct 2019 17:37:28 +0200
Date:   Fri, 4 Oct 2019 17:37:28 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
References: <20191003090906.1261-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191003090906.1261-1-dwagner@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If you post something that is related to PREEMPT_RT please keep tglx and
me in Cc.

On 2019-10-03 11:09:06 [+0200], Daniel Wagner wrote:
> Replace preempt_enable() and preempt_disable() with the vmap_area_lock
> spin_lock instead. Calling spin_lock() with preempt disabled is
> illegal for -rt. Furthermore, enabling preemption inside the
> spin_lock() doesn't really make sense.

This spin_lock will cause all CPUs to block on it while the
preempt_disable() does not have this limitation.
I added a migrate_disable() in my -next tree. Looking at it again, I
have reasonable doubt that this preempt_disable() is needed.

> Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for
> split purpose")
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  mm/vmalloc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 08c134aa7ff3..0d1175673583 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1091,11 +1091,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	 * Even if it fails we do not really care about that. Just proceed
>  	 * as it is. "overflow" path will refill the cache we allocate from.
>  	 */
> -	preempt_disable();
> +	spin_lock(&vmap_area_lock);
>  	if (!__this_cpu_read(ne_fit_preload_node)) {
> -		preempt_enable();
> +		spin_unlock(&vmap_area_lock);
>  		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> -		preempt_disable();
> +		spin_lock(&vmap_area_lock);
>  
>  		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
>  			if (pva)
> @@ -1103,9 +1103,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		}
>  	}
>  
> -	spin_lock(&vmap_area_lock);
> -	preempt_enable();
> -
>  	/*
>  	 * If an allocation fails, the "vend" address is
>  	 * returned. Therefore trigger the overflow path.
> -- 

Sebastian
