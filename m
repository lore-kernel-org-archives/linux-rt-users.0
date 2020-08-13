Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801A9C433E3
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C6A20781
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 14:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHMO4s (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:56:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMO4r (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Aug 2020 10:56:47 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C2420781;
        Thu, 13 Aug 2020 14:56:46 +0000 (UTC)
Date:   Thu, 13 Aug 2020 10:56:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiafei Pan <jiafei.pan@nxp.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "romain.perier@gmail.com" <romain.perier@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] softirq: add irq off checking for
 __raise_softirq_irqoff
Message-ID: <20200813105644.1eb6f2cd@oasis.local.home>
In-Reply-To: <AM0PR04MB4772B1B6D3391BAEAD4411808A430@AM0PR04MB4772.eurprd04.prod.outlook.com>
References: <20200806040729.39186-1-Jiafei.Pan@nxp.com>
        <AM0PR04MB4772B1B6D3391BAEAD4411808A430@AM0PR04MB4772.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 13 Aug 2020 03:03:46 +0000
Jiafei Pan <jiafei.pan@nxp.com> wrote:

> Any comments? Thanks.
> 
> @Steven Rostedt, I thinks irq off checking is necessary especially

This is probably more for Thomas Gleixner.

> for Preempt-RT kernel, because some context may be changed from irq
> off to irq on when enable Preempt RT, I once met a issue that hrtimer
> soft irq is lost when enabled Preempt RT, finally I found
> napi_schedule_irqoff is called in hardware interrupt handler, there
> maybe no issue for non RT kernel, but for Preempt RT, interrupt is
> threaded, so irq is on in interrupt handler, the result is
> __raise_softirq_irqoff is called in irq on context, so that per-CPU
> softirq masking is corrupted because of the process of updating of
> soft irq masking is interrupted and not a atomic operation , and then
> caused hrtimer soft irq is lost. So I think adding irq status
> checking in __raise_softirq_irqoff can report such issue directly and
> help us to find the root cause of such issue.
> 
> I know that there may be performance impaction to add extra checking
> here, if it is the case, how about to include it in some debug
> configuration items? Such as CONFIG_DEBUG_PREEMPT or other debug
> items?
> 


> Best Regards,
> Jiafei.
> 
> -----Original Message-----
> From: Jiafei Pan <Jiafei.Pan@nxp.com> 
> Sent: Thursday, August 6, 2020 12:07 PM
> To: peterz@infradead.org; mingo@kernel.org; tglx@linutronix.de; rostedt@goodmis.org; romain.perier@gmail.com; will@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-rt-users@vger.kernel.org; Jiafei Pan <jiafei.pan@nxp.com>; Leo Li <leoyang.li@nxp.com>; Vladimir Oltean <vladimir.oltean@nxp.com>; Jiafei Pan <jiafei.pan@nxp.com>
> Subject: [PATCH] softirq: add irq off checking for __raise_softirq_irqoff
> 
> __raise_softirq_irqoff will update per-CPU mask of pending softirqs, it need to be called in irq disabled context in order to keep it atomic operation, otherwise it will be interrupted by hardware interrupt, and per-CPU softirqs pending mask will be corrupted, the result is there will be unexpected issue, for example hrtimer soft irq will be losed and soft hrtimer will never be expire and handled.

Please wrap your change logs.

> 
> Adding irqs disabled checking here to provide warning in irqs enabled context.
> 
> Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
> ---
>  kernel/softirq.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c index bf88d7f62433..11f61e54a3ae 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -481,6 +481,11 @@ void raise_softirq(unsigned int nr)
>  
>  void __raise_softirq_irqoff(unsigned int nr)  {
> +	/* This function can only be called in irq disabled context,
> +	 * otherwise or_softirq_pending will be interrupted by hardware
> +	 * interrupt, so that there will be unexpected issue.
> +	 */
> +	WARN_ON_ONCE(!irqs_disabled());

Perhaps: lockdep_assert_irqs_disabled() is more appropriate, and
doesn't add extra overhead on production systems.

-- Steve


>  	trace_softirq_raise(nr);
>  	or_softirq_pending(1UL << nr);
>  }
> --
> 2.17.1

