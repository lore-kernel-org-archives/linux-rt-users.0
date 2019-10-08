Return-Path: <SRS0=fauZ=YB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E39DC35280
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Oct 2019 16:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9C720815
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Oct 2019 16:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6JCjbFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfJHQFL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:05:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42075 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJHQFL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Oct 2019 12:05:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so18146972lje.9;
        Tue, 08 Oct 2019 09:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0UVqNIV0POnW5dby0dbdx1U9vQuG/qxbGoGcY7weL30=;
        b=l6JCjbFEMicjT+WZHFJ9SZSsNbcdDznuB5cWhtuUqJpZ9/ptyYNLLvjYkr6d/3UwlH
         rYyubjcuQZdJIXDqSnBveJXvgDi991jdXGnBfrE68sIEn+pVBY2AGXKZCB8KnhRY2wPz
         vxsuPTxXdT0rudK/lytKWlp5EdJTrSu8WhhmejhwYXcF/jLZ6pSB6OYbkocxFQCVV0WT
         slQpjweKTnSZsV3GRfjEo9ScHTkT4RbVfjh+SM/3233h7NhldsjZwu9JJqyizDQ/ca/1
         eg4R31Q+FSxtski9I2klDvpD3dW5ekRwNHGydskVofkKuC3umEMyQZB1nfI+sbxnVVIy
         aH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UVqNIV0POnW5dby0dbdx1U9vQuG/qxbGoGcY7weL30=;
        b=Uxe1C8g12YSnheuizoQzpjD5FCCsd4lCK2WNBIh0AllgrObjSIwE4w8mtcaDm2Yfj1
         K98AMd5FYIDtQkU4ruXawohgkA3gRV96i0KkkIR/9Y135W2JqPUOjONTenN7LOWhrg5z
         uIDipRpeHAvNxI+xXSzmhLeoTRXlvspAXu4WfKpqMt0bXyCNVmQ9Kja6qipenaEnpWlD
         XLQo90UIJ/q8NCBtp3PHD7U2lEsKiH7zXEL1AeAgmL5XkGvxVvUP+kgYLnYxBiJYdYmk
         Cp7fN/E10CqsrM5ShHZByyG1uijM8wPEgIIZHFxGwtvNJ+UKVaA0nHacE4cBUbtMca03
         sYuQ==
X-Gm-Message-State: APjAAAXL+F8CqjZWPDm9e8mmE6nJ+QeCVEhD1pQ0fYom072TsF/RYvGl
        IgjVwzoIcRdGaUhYNyZX3iA=
X-Google-Smtp-Source: APXvYqzQ+Jv3XFkYlnT6ZtELKk4KkJGJgKgVz2z5Xp+/7eAQ8tYVpnb/MGsstkt4G1Ez0hKgmJJ+4A==
X-Received: by 2002:a2e:7a16:: with SMTP id v22mr22450142ljc.61.1570550708288;
        Tue, 08 Oct 2019 09:05:08 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id m15sm4084586ljh.50.2019.10.08.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 09:05:07 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 8 Oct 2019 18:04:59 +0200
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191008160459.GA5487@pc636>
References: <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
 <20191007083037.zu3n5gindvo7damg@beryllium.lan>
 <20191007105631.iau6zhxqjeuzajnt@linutronix.de>
 <20191007162330.GA26503@pc636>
 <20191007163443.6owts5jp2frum7cy@beryllium.lan>
 <20191007165611.GA26964@pc636>
 <20191007173644.hiiukrl2xryziro3@linutronix.de>
 <20191007214420.GA3212@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007214420.GA3212@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Oct 07, 2019 at 11:44:20PM +0200, Uladzislau Rezki wrote:
> On Mon, Oct 07, 2019 at 07:36:44PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-10-07 18:56:11 [+0200], Uladzislau Rezki wrote:
> > > Actually there is a high lock contention on vmap_area_lock, because it
> > > is still global. You can have a look at last slide:
> > > 
> > > https://linuxplumbersconf.org/event/4/contributions/547/attachments/287/479/Reworking_of_KVA_allocator_in_Linux_kernel.pdf
> > > 
> > > so this change will make it a bit higher. From the other hand i agree
> > > that for rt it should be fixed, probably it could be done like:
> > > 
> > > ifdef PREEMPT_RT
> > >     migrate_disable()
> > > #else
> > >     preempt_disable()
> > > ...
> > > 
> > > but i am not sure it is good either.
> > 
> > What is to be expected on average? Is the lock acquired and then
> > released again because the slot is empty and memory needs to be
> > allocated or can it be assumed that this hardly happens? 
> > 
> The lock is not released(we are not allowed), instead we just try
> to allocate with GFP_NOWAIT flag. It can happen if preallocation
> has been failed with GFP_KERNEL flag earlier:
> 
> <snip>
> ...
>  } else if (type == NE_FIT_TYPE) {
>   /*
>    * Split no edge of fit VA.
>    *
>    *     |       |
>    *   L V  NVA  V R
>    * |---|-------|---|
>    */
>   lva = __this_cpu_xchg(ne_fit_preload_node, NULL);
>   if (unlikely(!lva)) {
>       ...
>       lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
>       ...
>   }
> ...
> <snip>
> 
> How often we need an extra object for split purpose, the answer
> is it depends on. For example fork() path falls to that pattern.
> 
> I think we can assume that migration can hardly ever happen and
> that should be considered as rare case. Thus we can do a prealoading
> without worrying much if a it occurs:
> 
> <snip>
> urezki@pc636:~/data/ssd/coding/linux-stable$ git diff
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e92ff5f7dd8b..bc782edcd1fd 100644 
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1089,20 +1089,16 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>          * Even if it fails we do not really care about that. Just proceed
>          * as it is. "overflow" path will refill the cache we allocate from.
>          */
> -       preempt_disable();
> -       if (!__this_cpu_read(ne_fit_preload_node)) {
> -               preempt_enable();
> +       if (!this_cpu_read(ne_fit_preload_node)) {
>                 pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> -               preempt_disable();
> 
> -               if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
> +               if (this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
>                         if (pva)
>                                 kmem_cache_free(vmap_area_cachep, pva);
>                 }
>         }
>  
>         spin_lock(&vmap_area_lock);
> -       preempt_enable();
> 
>         /*
>          * If an allocation fails, the "vend" address is
> urezki@pc636:~/data/ssd/coding/linux-stable$
> <snip>
> 
> so, we do not guarantee, instead we minimize number of allocations
> with GFP_NOWAIT flag. For example on my 4xCPUs i am not able to
> even trigger the case when CPU is not preloaded.
> 
> I can test it tomorrow on my 12xCPUs to see its behavior there.
> 
Tested it on different systems. For example on my 8xCPUs system that
runs PREEMPT kernel i see only few GFP_NOWAIT allocations, i.e. it
happens when we land to another CPU that was not preloaded.

I run the special test case that follows the preload pattern and path.
So 20 "unbind" threads run it and each does 1000000 allocations. As a
result only 3.5 times among 1000000, during splitting, CPU was not
preloaded thus, GFP_NOWAIT was used to obtain an extra object.

It is obvious that slightly modified approach still minimizes allocations
in atomic context, so it can happen but the number is negligible and can
be ignored, i think.

--
Vlad Rezki
