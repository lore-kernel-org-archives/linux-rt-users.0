Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F946C71156
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 13:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280E22085B
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 13:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="WzuoZvpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgK3NyG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 08:54:06 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:51164 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgK3NyF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 08:54:05 -0500
Received: from localhost (home.natalenko.name [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 4EC7A8B59BC;
        Mon, 30 Nov 2020 14:53:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1606744403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RFHLyr5yJAiwqzy/tg+7SSSk7uhDHJnuCus8X6tDJDk=;
        b=WzuoZvpu9O2FW5dvtqmJS12nQrxdcjNn4H3cQywMebYlWoYOBOcV92J4LxbZcNc29X1++1
        dAeIR4aNOo5FQ4NAoUnm9Rbi/SX4YyJty1OfHRhVYWA1v13h38IgUpEo832g87UUj0u3s2
        EGPn4+fc0z98TQuFWymKt0hgCJaX17M=
Date:   Mon, 30 Nov 2020 14:53:22 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: scheduling while atomic in z3fold
Message-ID: <20201130135322.zi7moa57ajbdvfpy@spock.localdomain>
References: <20201128140523.ovmqon5fjetvpby4@spock.localdomain>
 <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
 <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
 <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
 <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
 <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
 <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
 <20201129112922.db53kmtpu76xxukj@spock.localdomain>
 <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Nov 30, 2020 at 02:20:14PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-11-29 12:41:14 [+0100], Mike Galbraith wrote:
> > On Sun, 2020-11-29 at 12:29 +0100, Oleksandr Natalenko wrote:
> > >
> > > Ummm so do compressors explode under non-rt kernel in your tests as
> > > well, or it is just -rt that triggers this?
> > 
> > I only tested a non-rt kernel with z3fold, which worked just fine.
> 
> I tried this and it did not not explode yet. Mike, can you please
> confirm?
> 
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 18feaa0bc5377..0bf70f624a4bd 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -642,14 +642,17 @@ static inline void add_to_unbuddied(struct z3fold_pool *pool,
>  {
>  	if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0 ||
>  			zhdr->middle_chunks == 0) {
> -		struct list_head *unbuddied = get_cpu_ptr(pool->unbuddied);
> -
> +		struct list_head *unbuddied;
>  		int freechunks = num_free_chunks(zhdr);
> +
> +		migrate_disable();
> +		unbuddied = this_cpu_ptr(pool->unbuddied);
> +
>  		spin_lock(&pool->lock);
>  		list_add(&zhdr->buddy, &unbuddied[freechunks]);
>  		spin_unlock(&pool->lock);
>  		zhdr->cpu = smp_processor_id();
> -		put_cpu_ptr(pool->unbuddied);
> +		migrate_enable();
>  	}
>  }
>  
> @@ -887,7 +890,8 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
>  
>  lookup:
>  	/* First, try to find an unbuddied z3fold page. */
> -	unbuddied = get_cpu_ptr(pool->unbuddied);
> +	migrate_disable();
> +	unbuddied = this_cpu_ptr(pool->unbuddied);
>  	for_each_unbuddied_list(i, chunks) {
>  		struct list_head *l = &unbuddied[i];
>  
> @@ -905,7 +909,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
>  		    !z3fold_page_trylock(zhdr)) {
>  			spin_unlock(&pool->lock);
>  			zhdr = NULL;
> -			put_cpu_ptr(pool->unbuddied);
> +			migrate_enable();
>  			if (can_sleep)
>  				cond_resched();
>  			goto lookup;
> @@ -919,7 +923,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
>  		    test_bit(PAGE_CLAIMED, &page->private)) {
>  			z3fold_page_unlock(zhdr);
>  			zhdr = NULL;
> -			put_cpu_ptr(pool->unbuddied);
> +			migrate_enable();
>  			if (can_sleep)
>  				cond_resched();
>  			goto lookup;
> @@ -934,7 +938,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
>  		kref_get(&zhdr->refcount);
>  		break;
>  	}
> -	put_cpu_ptr(pool->unbuddied);
> +	migrate_enable();
>  
>  	if (!zhdr) {
>  		int cpu;
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 78a20f7b00f2c..b24f761b9241c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -394,7 +394,9 @@ struct zswap_comp {
>  	u8 *dstmem;
>  };
>  
> -static DEFINE_PER_CPU(struct zswap_comp, zswap_comp);
> +static DEFINE_PER_CPU(struct zswap_comp, zswap_comp) = {
> +	.lock = INIT_LOCAL_LOCK(lock),

Is it a residue?

> +};
>  
>  static int zswap_dstmem_prepare(unsigned int cpu)
>  {
> 
> > 	-Mike
> 
> Sebastian

-- 
  Oleksandr Natalenko (post-factum)
