Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472C8C433E3
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 05:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B05820715
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 05:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="esifnW1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMF6h (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgHMF6h (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Aug 2020 01:58:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC14CC061757;
        Wed, 12 Aug 2020 22:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A2tIL3lRKqt3QhjARTkmfIICANxslC8SgzyYivoY1jI=; b=esifnW1ssdRYcS8qFCosQ3I/yv
        b/byejn2cSb+i3bwvW+nJbT8jThfqBrPUol4ISi7/M8kQ9FqIAH9blMrJZFsCYbPrg9DSYojg8EV+
        xSfG+zzUy7qo2QHi91KM3vmNAs/EAHLychpHou7Tl38bA5ym+Hwf9VHmpTVnNS+LXWT8SMm+FYLOJ
        vhWStCFq1L6Auyv+P4mAp9j+7w44JNc82kI1yZcqCVuvmz690fma3Dnmr2omi+PaG1ISpjis60MdN
        GPJps4VefW5qGIqKDCrSTiQ8rBmTi4ZV/PfbWP3clFuB+RnlDdAbbymiIEYoASiMb7UeT6uuS6U6w
        BMVN/uoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k66Fr-000368-Uc; Thu, 13 Aug 2020 05:58:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C7BB980C8B; Thu, 13 Aug 2020 07:58:22 +0200 (CEST)
Date:   Thu, 13 Aug 2020 07:58:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiafei Pan <Jiafei.Pan@nxp.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        romain.perier@gmail.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com
Subject: Re: [PATCH] softirq: add irq off checking for __raise_softirq_irqoff
Message-ID: <20200813055822.GC3982@worktop.programming.kicks-ass.net>
References: <20200806040729.39186-1-Jiafei.Pan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806040729.39186-1-Jiafei.Pan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 06, 2020 at 12:07:29PM +0800, Jiafei Pan wrote:
> __raise_softirq_irqoff will update per-CPU mask of pending softirqs,
> it need to be called in irq disabled context in order to keep it atomic
> operation, otherwise it will be interrupted by hardware interrupt,
> and per-CPU softirqs pending mask will be corrupted, the result is
> there will be unexpected issue, for example hrtimer soft irq will
> be losed and soft hrtimer will never be expire and handled.
> 
> Adding irqs disabled checking here to provide warning in irqs enabled
> context.
> 
> Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
> ---
>  kernel/softirq.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index bf88d7f62433..11f61e54a3ae 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -481,6 +481,11 @@ void raise_softirq(unsigned int nr)
>  
>  void __raise_softirq_irqoff(unsigned int nr)
>  {
> +	/* This function can only be called in irq disabled context,
> +	 * otherwise or_softirq_pending will be interrupted by hardware
> +	 * interrupt, so that there will be unexpected issue.
> +	 */

Comment style is wrong, also I'm not sure the comment is really
helpfull.

> +	WARN_ON_ONCE(!irqs_disabled());

	lockdep_assert_irqs_disabled();

>  	trace_softirq_raise(nr);
>  	or_softirq_pending(1UL << nr);
>  }
