Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD80EC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 22:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E05860F23
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 22:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhGWV7V (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:59:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46200 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhGWV7U (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jul 2021 17:59:20 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 956E220003;
        Fri, 23 Jul 2021 22:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627079992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbWYyES6yS++/mUvpq0fraCgAR+v/Vi0waf2hTVIYvE=;
        b=gm4Qunmbzdnr9wPkLmyedqU1KtOn4+1yS2bGlDPXRzPVS/lUQjPPfKT3lptFQxEkC1aD1P
        +UiqP46Ki9fsxQjOUCBcKc/Ig1/2kuyiF16c8q73hU0xgEVkCZBKaGYxjHaDLYgM140OXH
        Owo6QPc7gV5vCzhJrEAE3jJhSkrilCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627079992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbWYyES6yS++/mUvpq0fraCgAR+v/Vi0waf2hTVIYvE=;
        b=kntTgiACfht19gsWcNjjszTL3IcuWcYSUi2FWfZYENqmKBqHAA1FNc1lH9DtLWYh7GZWn6
        xdexpDdbl3s9s9CA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6A69713697;
        Fri, 23 Jul 2021 22:39:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id MjSEGDhF+2CHBQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 23 Jul 2021 22:39:52 +0000
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5be1a703-9a0a-4115-1d69-634e5e8ecefd@suse.cz>
Date:   Sat, 24 Jul 2021 00:39:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <84a7bd02cf109c6a5a8c7cc2bfc2898cb98270aa.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 7/21/21 11:33 AM, Mike Galbraith wrote:
> On Wed, 2021-07-21 at 10:44 +0200, Vlastimil Babka wrote:
>>
>> So this doesn't look like our put_cpu_partial() preempted a
>> __slab_alloc() on the same cpu, right?
> 
> No, likely it was the one preempted by someone long gone, but we'll
> never know without setting a trap.
> 
>> BTW did my ugly patch work?
> 
> Nope.  I guess you missed my reporting it to have been a -ENOBOOT, and

Indeed, I misunderstood it as you talking about your patch.

> that cutting it in half, ie snagging only __slab_free() does boot, and
> seems to cure all of the RT fireworks.

OK, so depending on drain=1 makes this apply only to put_cpu_partial()
called from __slab_free and not get_partial_node(). One notable
difference is that in __slab_free we don't have n->list_lock locked and
in get_partial_node() we do. I guess in case your list_lock is made raw
again by another patch, that explains a local_lock can't nest under it.
If not, then I would expect this to work (I don't think they ever nest
in the opposite order, also lockdep should tell us instead of
-ENOBOOT?), but might be missing something...

I'd rather not nest those locks in any case. I just need to convince
myself that the scenario the half-fix fixes is indeed the only one
that's needed and we're not leaving there other races that are just
harder to trigger...

> (chainsaw noises...)
> 
> ---
>  mm/slub.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2551,6 +2551,8 @@ static void put_cpu_partial(struct kmem_
>  	int pobjects;
> 
>  	slub_get_cpu_ptr(s->cpu_slab);
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && drain)
> +		local_lock(&s->cpu_slab->lock);
>  	do {
>  		pages = 0;
>  		pobjects = 0;
> @@ -2564,7 +2566,13 @@ static void put_cpu_partial(struct kmem_
>  				 * partial array is full. Move the existing
>  				 * set to the per node partial list.
>  				 */
> -				unfreeze_partials(s);
> +				this_cpu_write(s->cpu_slab->partial, NULL);
> +				if (IS_ENABLED(CONFIG_PREEMPT_RT) && drain)
> +					local_unlock(&s->cpu_slab->lock);
> +				__unfreeze_partials(s, oldpage);
> +				if (IS_ENABLED(CONFIG_PREEMPT_RT) && drain)
> +					local_lock(&s->cpu_slab->lock);
> +
>  				oldpage = NULL;
>  				pobjects = 0;
>  				pages = 0;
> @@ -2581,6 +2589,8 @@ static void put_cpu_partial(struct kmem_
> 
>  	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
>  								!= oldpage);
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && drain)
> +		local_unlock(&s->cpu_slab->lock);
>  	slub_put_cpu_ptr(s->cpu_slab);
>  #endif	/* CONFIG_SLUB_CPU_PARTIAL */
>  }
> 
> 

