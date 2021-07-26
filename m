Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD35C4338F
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 21:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A3B60F5A
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 21:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhGZUrC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 16:47:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41376 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhGZUrB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jul 2021 16:47:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8663320080;
        Mon, 26 Jul 2021 21:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627334848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8908+hHqfz+eFp1UWByqbQTVwA8dHMFdaT5CPRtqOs=;
        b=MoXI6pH+iXoU++ZSqZ4jJSGrQptr+Xbt4xC7RpMUIK3lNe0+dwCH7YNEV2x98rGrnTvc78
        Tv5I6i9xEqt84HtUC8JS/8HhFjE6sO9qio6V3o3BGb7Ygs0lhKRiEWzhHXPh0+QiqfllOJ
        dTSn18um4SgXMLq8Pprw6wlVyPk+Ors=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627334848;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8908+hHqfz+eFp1UWByqbQTVwA8dHMFdaT5CPRtqOs=;
        b=yqURUOlG4q9yIjTEm8x73XaIniBqn7Tm8uza8DqO9p57meylzpbSHz9v4vAhaT9xwoKKfN
        6LmRpf4ajdbCueDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5907713B57;
        Mon, 26 Jul 2021 21:27:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 40AiFMAo/2CnQAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 26 Jul 2021 21:27:28 +0000
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
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
 <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
 <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
 <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
 <69da2ecd-a797-e264-fbfa-13108dc7a573@suse.cz>
 <84a7bd02cf109c6a5a8c7cc2bfc2898cb98270aa.camel@gmx.de>
 <5be1a703-9a0a-4115-1d69-634e5e8ecefd@suse.cz>
 <bd121f5db01404774dbecc70bd7155f8431d8046.camel@gmx.de>
 <76dedfc3-0497-1776-d006-486b9bfd88da@suse.cz>
 <72a045663bf8f091ae11dd328d5e085541d54fcd.camel@gmx.de>
 <18ca0ce9-3407-61e1-31d6-5c48e80eb5bb@suse.cz>
 <73f032c2-70f1-77b6-9fd2-9aca52fd5b4d@suse.cz>
 <b41fa4f2-8368-f33a-10c2-68554b16eb1e@suse.cz>
 <e3470ab357b48bccfbd1f5133b982178a7d2befb.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <26c181c9-ec48-09e2-2d73-6fc769a19c76@suse.cz>
Date:   Mon, 26 Jul 2021 23:26:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e3470ab357b48bccfbd1f5133b982178a7d2befb.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 7/26/21 7:00 PM, Mike Galbraith wrote:
> On Sun, 2021-07-25 at 21:34 +0200, Vlastimil Babka wrote:
>> On 7/25/21 9:12 PM, Vlastimil Babka wrote:
>>> +       /*
>>> +        * On !RT we just want to disable preemption, on RT we need
>>> the lock
>>> +        * for real. This happens to match local_lock() semantics.
>>> +        */
>>> +       local_lock(&s->cpu_slab->lock);
>>
>> OK I realized (and tglx confirmed) that this will blow up on !RT +
>> lockdep if interrupted by ___slab_alloc() that will do
>> local_lock_irqsave(). So back to #ifdefs it is. But should work as-is
>> for RT testing.
> 
> Speaking of that local_lock_irqsave(), and some unloved ifdefs..
> 
> Why not do something like the below?  When I look at new_slab:, I see
> cpu_slab->partial assignment protected by IRQs being disabled, which
> implies to me it should probably be so protected everywhere.  There
> used to be another slub_set_percpu_partial() call in
> unfreeze_partials(), which was indeed called with IRQs disabled, quite
> sane looking to an mm outsider looking in. The odd man out ->partial
> assignment was the preempt disabled put_cpu_partial() cmpxchg loop,
> which contained an IRQ disabled region to accommodate the
> aforementioned unfreeze_partials().
> 
> Is there real world benefit to the cmpxchg loops whacked below (ala
> monkey see monkey do) over everyone just taking the straight shot you
> laid down for RT?  It's easier on the eye (mine anyway), and neither
> PREEMPT or PREEMPT_RT seem inclined to complain... tick... tock...

Yep, sounds like a good approach, thanks. Percpu partial is not *the*
SLUB fast path, so it should be sufficient without the lockless cmpxchg
tricks. Will incorporate in updated series.

> 
> ---
>  mm/slub.c |   79 ++++++++++++++++++++++++++++++++------------------------------
>  1 file changed, 41 insertions(+), 38 deletions(-)
> 
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2437,13 +2437,12 @@ static void __unfreeze_partials(struct k
>  static void unfreeze_partials(struct kmem_cache *s)
>  {
>  	struct page *partial_page;
> +	unsigned long flags;
> 
> -	do {
> -		partial_page = this_cpu_read(s->cpu_slab->partial);
> -
> -	} while (partial_page &&
> -		 this_cpu_cmpxchg(s->cpu_slab->partial, partial_page, NULL)
> -				  != partial_page);
> +	local_lock_irqsave(&s->cpu_slab->lock, flags);
> +	partial_page = this_cpu_read(s->cpu_slab->partial);
> +	this_cpu_write(s->cpu_slab->partial, NULL);
> +	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> 
>  	if (partial_page)
>  		__unfreeze_partials(s, partial_page);
> @@ -2480,41 +2479,45 @@ static void put_cpu_partial(struct kmem_
>  {
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  	struct page *oldpage;
> -	int pages;
> -	int pobjects;
> -
> -	slub_get_cpu_ptr(s->cpu_slab);
> -	do {
> -		pages = 0;
> -		pobjects = 0;
> -		oldpage = this_cpu_read(s->cpu_slab->partial);
> -
> -		if (oldpage) {
> -			pobjects = oldpage->pobjects;
> -			pages = oldpage->pages;
> -			if (drain && pobjects > slub_cpu_partial(s)) {
> -				/*
> -				 * partial array is full. Move the existing
> -				 * set to the per node partial list.
> -				 */
> -				unfreeze_partials(s);
> -				oldpage = NULL;
> -				pobjects = 0;
> -				pages = 0;
> -				stat(s, CPU_PARTIAL_DRAIN);
> -			}
> +	struct page *page_to_unfreeze = NULL;
> +	unsigned long flags;
> +	int pages = 0, pobjects = 0;
> +
> +	local_lock_irqsave(&s->cpu_slab->lock, flags);
> +
> +	if (oldpage = this_cpu_read(s->cpu_slab->partial)) {
> +		pobjects = oldpage->pobjects;
> +		pages = oldpage->pages;
> +		if (drain && pobjects > slub_cpu_partial(s)) {
> +			/*
> +			 * partial array is full. Move the existing
> +			 * set to the per node partial list.
> +			 *
> +			 * Postpone unfreezing until we drop the local
> +			 * lock to avoid an RT unlock/relock requirement
> +			 * due to MEMCG __slab_free() recursion.
> +			 */
> +			page_to_unfreeze = oldpage;
> +
> +			oldpage = NULL;
> +			pobjects = 0;
> +			pages = 0;
> +			stat(s, CPU_PARTIAL_DRAIN);
>  		}
> +	}
> +
> +	pages++;
> +	pobjects += page->objects - page->inuse;
> +
> +	page->pages = pages;
> +	page->pobjects = pobjects;
> +	page->next = oldpage;
> 
> -		pages++;
> -		pobjects += page->objects - page->inuse;
> +	this_cpu_write(s->cpu_slab->partial, page);
> +	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> 
> -		page->pages = pages;
> -		page->pobjects = pobjects;
> -		page->next = oldpage;
> -
> -	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
> -								!= oldpage);
> -	slub_put_cpu_ptr(s->cpu_slab);
> +	if (page_to_unfreeze)
> +		__unfreeze_partials(s, page_to_unfreeze);
>  #endif	/* CONFIG_SLUB_CPU_PARTIAL */
>  }
> 
> 
> 

