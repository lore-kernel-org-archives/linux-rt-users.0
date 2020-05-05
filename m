Return-Path: <SRS0=pvg0=6T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC45C47256
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 May 2020 04:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A409F206B8
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 May 2020 04:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgEEEA7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 5 May 2020 00:00:59 -0400
Received: from mail5.windriver.com ([192.103.53.11]:41574 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgEEEA6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 May 2020 00:00:58 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 0453xfSg015149
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 4 May 2020 20:59:53 -0700
Received: from [128.224.162.157] (128.224.162.157) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Mon, 4 May 2020
 20:59:30 -0700
Subject: Re: [PATCH RT] mm: Don't warn about atomic memory allocations during
 suspend
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     linux-rt <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>
References: <20200413041817.27514-1-liwei.song@windriver.com>
 <20200416170943.hjoytlggvfzzdqjt@linutronix.de>
 <8cd11f67-dbf8-cce9-548f-ccc544f9486c@windriver.com>
 <20200421145147.lejozjuvjjd4nmyf@linutronix.de>
 <0662fa80-3dbd-3b47-3677-f22716f5661f@windriver.com>
 <20200504145325.3rjc3iskg2coejje@linutronix.de>
From:   Liwei Song <liwei.song@windriver.com>
Message-ID: <a24d2165-a2d2-b63e-36a0-7dc9d6a0cf06@windriver.com>
Date:   Tue, 5 May 2020 11:59:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <20200504145325.3rjc3iskg2coejje@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 5/4/20 22:53, Sebastian Andrzej Siewior wrote:
> From: Liwei Song <liwei.song@windriver.com>
> 
> The ACPI code allocates larger amount of memory during resume. This
> triggers a warning because the allocation happens with disabled
> interrupts.
> At this stage only one CPU is active so there should be no lock
> contention. If SLUB needs to call into the buddy allocator for more
> memory then it should not enable interrupts.
> 
> Limit the check to system state with more CPUs and scheduling and only
> enable interrupts in SLUB at this stage.
> 
> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> [bigeasy: commit description, allocate_slab() hunk]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> Are you okay with this Liwei?

Yes, I'm fine with this, thanks for your help.

Liwei.


> 
>  mm/slub.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 15c194ff16e6e..6ea1057edf1ab 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1655,7 +1655,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>  		enableirqs = true;
>  
>  #ifdef CONFIG_PREEMPT_RT
> -	if (system_state > SYSTEM_BOOTING)
> +	if (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND)
>  		enableirqs = true;
>  #endif
>  	if (enableirqs)
> @@ -2771,7 +2771,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>  	unsigned long tid;
>  
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
> -		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
> +		WARN_ON_ONCE(!preemptible() &&
> +			     (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND));
>  
>  	s = slab_pre_alloc_hook(s, gfpflags);
>  	if (!s)
> @@ -3236,7 +3237,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	int i;
>  
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
> -		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
> +		WARN_ON_ONCE(!preemptible() &&
> +			     (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND));
>  
>  	/* memcg and kmem_cache debug support */
>  	s = slab_pre_alloc_hook(s, flags);
> 
