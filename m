Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ACDC4338F
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 23:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673BD61104
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 23:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhHEXWX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 19:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhHEXWW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 19:22:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09D3060EB9;
        Thu,  5 Aug 2021 23:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628205727;
        bh=i33xhaeVpXGV2BhPzbhlBwQZn8O01SRCEx1xg2D/ogc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PTOpokADg1joo1BVq/LCyTP9Dfnys2JPYFddBTo/oM2s9Oq8QuhsyXA1enMA2eGac
         0x4GIL0nALbQznW9/AXuBTYRAWOBBTmZ1dxdvKyj5e0dgMs+brROUIjE84aqWvlSR8
         Dddsnpxxa3os65Jvg4JFsDxb4S8YyKSRDuS2cUWc=
Date:   Thu, 5 Aug 2021 16:22:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
Message-Id: <20210805162206.664dfc8c090f2be5ea313d57@linux-foundation.org>
In-Reply-To: <20210805160019.1137-2-mgorman@techsingularity.net>
References: <20210805160019.1137-1-mgorman@techsingularity.net>
        <20210805160019.1137-2-mgorman@techsingularity.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu,  5 Aug 2021 17:00:19 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> Disable preemption on -RT for the vmstat code. On vanila the code runs
> in IRQ-off regions while on -RT it may not when stats are updated under
> a local_lock. "preempt_disable" ensures that the same resources is not
> updated in parallel due to preemption.
> 
> This patch differs from the preempt-rt version where __count_vm_event and
> __count_vm_events are also protected. The counters are explicitly "allowed
> to be to be racy" so there is no need to protect them from preemption. Only
> the accurate page stats that are updated by a read-modify-write need
> protection. This patch also differs in that a preempt_[en|dis]able_rt
> helper is not used. As vmstat is the only user of the helper, it was
> suggested that it be open-coded in vmstat.c instead of risking the helper
> being used in unnecessary contexts.
> 
> ...
>
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -319,6 +319,16 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
>  	long x;
>  	long t;
>  
> +	/*
> +	 * Accurate vmstat updates require a RMW. On !PREEMPT_RT kernels,
> +	 * atomicity is provided by IRQs being disabled -- either explicitly
> +	 * or via local_lock_irq. On PREEMPT_RT, local_lock_irq only disables
> +	 * CPU migrations and preemption potentially corrupts a counter so
> +	 * disable preemption.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_disable();

This is so obvious I expect it has been discussed, but...  why not

static inline void preempt_disable_if_rt(void)
{
	if (IS_ENABLED(CONFIG_PREEMPT_RT))
		preempt_disable();
}

?


