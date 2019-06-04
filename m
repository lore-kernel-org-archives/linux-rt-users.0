Return-Path: <SRS0=a75S=UD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B336AC282CE
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Jun 2019 06:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906C623BC0
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Jun 2019 06:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFDG3l (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:29:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfFDG3l (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Jun 2019 02:29:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A49583F42;
        Tue,  4 Jun 2019 06:29:41 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DDE9648A9;
        Tue,  4 Jun 2019 06:29:34 +0000 (UTC)
Date:   Tue, 4 Jun 2019 14:29:31 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 2/3] timers: do not raise softirq unconditionally
 (spinlockless version)
Message-ID: <20190604062931.GC15459@xz-x1>
References: <20190415201213.600254019@amt.cnet>
 <20190415201429.427759476@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415201429.427759476@amt.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 04 Jun 2019 06:29:41 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Apr 15, 2019 at 05:12:15PM -0300, Marcelo Tosatti wrote:
> Check base->pending_map locklessly and skip raising timer softirq 
> if empty.
> 
> What allows the lockless (and potentially racy against mod_timer) 
> check is that mod_timer will raise another timer softirq after
> modifying base->pending_map.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
>  kernel/time/timer.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> Index: linux-rt-devel/kernel/time/timer.c
> ===================================================================
> --- linux-rt-devel.orig/kernel/time/timer.c	2019-04-15 14:21:02.788704354 -0300
> +++ linux-rt-devel/kernel/time/timer.c	2019-04-15 14:22:56.755047354 -0300
> @@ -1776,6 +1776,24 @@
>  		if (time_before(jiffies, base->clk))
>  			return;
>  	}
> +
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +/* On RT, irq work runs from softirq */
> +	if (irq_work_needs_cpu())
> +		goto raise;
> +#endif
> +	base = this_cpu_ptr(&timer_bases[BASE_STD]);
> +	if (!housekeeping_cpu(base->cpu, HK_FLAG_TIMER)) {
> +		if (!bitmap_empty(base->pending_map, WHEEL_SIZE))
> +			goto raise;
> +		base++;

Shall we check against CONFIG_NO_HZ_COMMON?  Otherwise the base could
point to something else rather tha the deferred base (NR_BASES==1 if
without nohz-common).

I see that run_local_timers() has similar pattern, actually I'm
thinking whether we can put things like "base++" to be inside some
"if"s of CONFIG_NO_HZ_COMMON to be clear.

Thanks,

-- 
Peter Xu
