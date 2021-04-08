Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B137CC433B4
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Apr 2021 16:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830EC61131
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Apr 2021 16:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhDHQrZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhDHQrY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Apr 2021 12:47:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2106C061762;
        Thu,  8 Apr 2021 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rPSDzrfrowrO77gFeqY3scGy/8/d4rLkbSq9WX5pPKE=; b=g4gIFCTjZ2YwfqCdI4fvKFNi04
        xcM97NxBfimA6tHY047VWTQeGou2dQbOmYz5UE7LdSCgbsrif9fg2jgzjDOUMGK4D6k06/qljK64R
        HBxd4r9t64Z8cdxQDJFGGrdCMKqgv4WIEnyAumwcOCm34Ssg04ALRNRh0e6PIh67WBBHOvF7pvbHL
        dw+uBcGs0NJHmEXgfH4rWd3gVM1cjjDA7LAxIXXl3VbeD/rk0gTJhZLSmrkidr++PXidw86MNmiFE
        N/wWhrlYUq0Ck3Re2OFbzJQOcU1/s+5WA5UtN9rSecP/8hDQ0Y8ftpPOth+lPqy9b950qT4WyWfSc
        a/GHJ4Nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXnx-008g4t-2v; Thu, 08 Apr 2021 16:46:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ECE373001BF;
        Thu,  8 Apr 2021 18:46:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4ACD52C1E1B6B; Thu,  8 Apr 2021 12:52:07 +0200 (CEST)
Date:   Thu, 8 Apr 2021 12:52:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 02/11] mm/page_alloc: Convert per-cpu list protection to
 local_lock
Message-ID: <YG7gV7yAEEjOcQZY@hirez.programming.kicks-ass.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407202423.16022-3-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Apr 07, 2021 at 09:24:14PM +0100, Mel Gorman wrote:
> There is a lack of clarity of what exactly local_irq_save/local_irq_restore
> protects in page_alloc.c . It conflates the protection of per-cpu page
> allocation structures with per-cpu vmstat deltas.
> 
> This patch protects the PCP structure using local_lock which for most
> configurations is identical to IRQ enabling/disabling.  The scope of the
> lock is still wider than it should be but this is decreased laster.

> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index a4393ac27336..106da8fbc72a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h

> @@ -337,6 +338,7 @@ enum zone_watermarks {
>  #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
>  #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
>  
> +/* Fields and list protected by pagesets local_lock in page_alloc.c */
>  struct per_cpu_pages {
>  	int count;		/* number of pages in the list */
>  	int high;		/* high watermark, emptying needed */

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a68bacddcae0..e9e60d1a85d4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -112,6 +112,13 @@ typedef int __bitwise fpi_t;
>  static DEFINE_MUTEX(pcp_batch_high_lock);
>  #define MIN_PERCPU_PAGELIST_FRACTION	(8)
>  
> +struct pagesets {
> +	local_lock_t lock;
> +};
> +static DEFINE_PER_CPU(struct pagesets, pagesets) = {
> +	.lock = INIT_LOCAL_LOCK(lock),
> +};

So why isn't the local_lock_t in struct per_cpu_pages ? That seems to be
the actual object that is protected by it and is already per-cpu.

Is that because you want to avoid the duplication across zones? Is that
worth the effort?
