Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0161C636CA
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A7461166
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhGRIBf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 18 Jul 2021 04:01:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54098 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhGRIBd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 18 Jul 2021 04:01:33 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B07C222253;
        Sun, 18 Jul 2021 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626595114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lFXsUKClt9utCJbeMYGbYEMZneK/Y9bderWwll5CPcs=;
        b=wKPZLk5/rmIzr6WECg4igKhcKud+egQh55TY46yLjRlD5LrtR0cJWqEQ25sWveaSQpF3rq
        l0Cd+807vUnSfnqPtmToLd/CTUpKWw9gwepNsau536tfhUWCJNBTZMk6gc5r8rpEFKoRCZ
        QgG+9Z66BcLsmwczjlQ0TX6xJX+d18w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626595114;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lFXsUKClt9utCJbeMYGbYEMZneK/Y9bderWwll5CPcs=;
        b=0F0+yxWY5mWsKimkLVmjUA+WF7upqj1oyCRhpEPl92SbXvCLu05XQZhx8uGoGxfNDcsdJd
        k5HpLgX0/N8sokBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7C07B13AD2;
        Sun, 18 Jul 2021 07:58:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Hjd1HCrf82DBDwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Sun, 18 Jul 2021 07:58:34 +0000
Subject: Re: [patch] v2 mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
To:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
 <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
 <878s2fnv79.ffs@nanos.tec.linutronix.de>
 <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
 <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
 <476d147ab6eec386a1e8b8e11cb09708377f8c3e.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <725fe90b-4918-321e-ca88-6166bec0c131@suse.cz>
Date:   Sun, 18 Jul 2021 09:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <476d147ab6eec386a1e8b8e11cb09708377f8c3e.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 7/17/21 4:58 PM, Mike Galbraith wrote:
> On Thu, 2021-07-15 at 18:34 +0200, Mike Galbraith wrote:
>> Greetings crickets,
>>
>> Methinks he problem is the hole these patches opened only for RT.
>>
>> static void put_cpu_partial(struct kmem_cache *s, struct page *page,
>> int drain)
>> {
>> #ifdef CONFIG_SLUB_CPU_PARTIAL
>> 	struct page *oldpage;
>> 	int pages;
>> 	int pobjects;
>>
>> 	slub_get_cpu_ptr(s->cpu_slab);
>>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Bah, I'm tired of waiting to see what if anything mm folks do about
> this little bugger, so I'm gonna step on it my damn self and be done
> with it.  Fly or die little patchlet.

Sorry, Mike. Got some badly timed sickness. Will check ASAP.

> mm/slub: restore/expand unfreeze_partials() local exclusion scope
> 
> 2180da7ea70a ("mm, slub: use migrate_disable() on PREEMPT_RT") replaced
> preempt_disable() in put_cpu_partial() with migrate_disable(), which when
> combined with ___slab_alloc() having become preemptibile, leads to
> kmem_cache_free()/kfree() blowing through ___slab_alloc() unimpeded,
> and vice versa, resulting in PREMPT_RT exclusive explosions in both
> paths while stress testing with both SLUB_CPU_PARTIAL/MEMCG enabled,
> ___slab_alloc() during allocation (duh), and __unfreeze_partials()
> during free, both while accessing an unmapped page->freelist.
> 
> Serialize put_cpu_partial()/unfreeze_partials() on cpu_slab->lock to
> ensure that alloc/free paths cannot pluck cpu_slab->partial out from
> underneath each other unconstrained.
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> Fixes: 2180da7ea70a ("mm, slub: use migrate_disable() on PREEMPT_RT")
> ---
>  mm/slub.c |   23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2418,6 +2418,17 @@ static void __unfreeze_partials(struct k
>  	if (n)
>  		spin_unlock_irqrestore(&n->list_lock, flags);
> 
> +	/*
> +	 * If we got here via __slab_free() -> put_cpu_partial(),
> +	 * memcg_free_page_obj_cgroups() ->kfree() may send us
> +	 * back to __slab_free() -> put_cpu_partial() for an
> +	 * unfortunate second encounter with cpu_slab->lock.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && memcg_kmem_enabled()) {
> +		lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock.lock));
> +		local_unlock(&s->cpu_slab->lock);
> +	}
> +
>  	while (discard_page) {
>  		page = discard_page;
>  		discard_page = discard_page->next;
> @@ -2426,6 +2437,9 @@ static void __unfreeze_partials(struct k
>  		discard_slab(s, page);
>  		stat(s, FREE_SLAB);
>  	}
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && memcg_kmem_enabled())
> +		local_lock(&s->cpu_slab->lock);
>  }
> 
>  /*
> @@ -2497,7 +2511,9 @@ static void put_cpu_partial(struct kmem_
>  				 * partial array is full. Move the existing
>  				 * set to the per node partial list.
>  				 */
> +				local_lock(&s->cpu_slab->lock);
>  				unfreeze_partials(s);
> +				local_unlock(&s->cpu_slab->lock);
>  				oldpage = NULL;
>  				pobjects = 0;
>  				pages = 0;
> @@ -2579,7 +2595,9 @@ static void flush_cpu_slab(struct work_s
>  	if (c->page)
>  		flush_slab(s, c, true);
> 
> +	local_lock(&s->cpu_slab->lock);
>  	unfreeze_partials(s);
> +	local_unlock(&s->cpu_slab->lock);
>  }
> 
>  static bool has_cpu_slab(int cpu, struct kmem_cache *s)
> @@ -2632,8 +2650,11 @@ static int slub_cpu_dead(unsigned int cp
>  	struct kmem_cache *s;
> 
>  	mutex_lock(&slab_mutex);
> -	list_for_each_entry(s, &slab_caches, list)
> +	list_for_each_entry(s, &slab_caches, list) {
> +		local_lock(&s->cpu_slab->lock);
>  		__flush_cpu_slab(s, cpu);
> +		local_unlock(&s->cpu_slab->lock);
> +	}
>  	mutex_unlock(&slab_mutex);
>  	return 0;
>  }
> 

