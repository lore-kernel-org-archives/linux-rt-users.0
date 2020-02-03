Return-Path: <SRS0=b5ha=3X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CBFC35247
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Feb 2020 18:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E51821582
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Feb 2020 18:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgBCSRs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:17:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60331 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbgBCSRs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Feb 2020 13:17:48 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iygI6-000622-9i; Mon, 03 Feb 2020 19:17:46 +0100
Date:   Mon, 3 Feb 2020 19:17:46 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT] mm/memcontrol: Move misplaced
 local_unlock_irqrestore()
Message-ID: <20200203181746.htlca2aynoqidm3o@linutronix.de>
References: <20200126211945.28116-1-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200126211945.28116-1-matt@codeblueprint.co.uk>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-01-26 21:19:45 [+0000], Matt Fleming wrote:
> There's no need to leave interrupts disabled when calling css_put_many().

For RT the interrupts are never actually disabled and for !RT they are
disabled with or without the change.
The comment about the disable function mentions just the counters and
css_put_many()'s callback just invokes a worker so it is probably save
to move the function as suggested.

May I ask how on earth you managed to open that file on a Sunday
evening?

> Cc: Daniel Wagner <wagi@monom.org>
> Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b6f208c5a6b..1120b9d8dd86 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7062,10 +7062,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	mem_cgroup_charge_statistics(memcg, page, PageTransHuge(page),
>  				     -nr_entries);
>  	memcg_check_events(memcg, page);
> +	local_unlock_irqrestore(event_lock, flags);
>  
>  	if (!mem_cgroup_is_root(memcg))
>  		css_put_many(&memcg->css, nr_entries);
> -	local_unlock_irqrestore(event_lock, flags);
>  }
>  
>  /**

Sebastian
