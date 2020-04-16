Return-Path: <SRS0=egP0=6A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9821AC352BE
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Apr 2020 17:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8382E2078E
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Apr 2020 17:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgDPRJr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730647AbgDPRJr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Apr 2020 13:09:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9DFC061A0C
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Apr 2020 10:09:46 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jP81I-0002m2-1q; Thu, 16 Apr 2020 19:09:44 +0200
Date:   Thu, 16 Apr 2020 19:09:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Liwei Song <liwei.song@windriver.com>
Cc:     linux-rt <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH RT] mm: do not warn for suspend when allocate memory on RT
Message-ID: <20200416170943.hjoytlggvfzzdqjt@linutronix.de>
References: <20200413041817.27514-1-liwei.song@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413041817.27514-1-liwei.song@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-13 12:18:17 [+0800], Liwei Song wrote:
> Interrupts are off during resume from RAM, this will triger a warning
> when allocate memory in non-preemptible context on RT since commit
> b5d5bc970f209 ("mm: Warn on memory allocation in non-preemptible
> context on RT"), exclude suspend from this warning check.

Is this the ACPI backtrace or do you have something else?

I'm currently not 100% sure if we can skip the warning.

> Fixes: b5d5bc970f209 ("mm: Warn on memory allocation in non-preemptible context on RT")
> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> ---
>  mm/slub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1929645daa53..ebff24ae50ea 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2771,7 +2771,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>  	unsigned long tid;
>  
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
> -		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
> +		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING &&
> +				system_state != SYSTEM_SUSPEND);
>  
>  	s = slab_pre_alloc_hook(s, gfpflags);
>  	if (!s)
> @@ -3236,7 +3237,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	int i;
>  
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
> -		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
> +		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING &&
> +				system_state != SYSTEM_SUSPEND);
>  
>  	/* memcg and kmem_cache debug support */
>  	s = slab_pre_alloc_hook(s, flags);

Sebastian
