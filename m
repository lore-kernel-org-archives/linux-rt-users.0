Return-Path: <SRS0=wEKt=D3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A2EC43457
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Oct 2020 12:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4F322240
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Oct 2020 12:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406324AbgJTMig convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Oct 2020 08:38:36 -0400
Received: from mailout06.rmx.de ([94.199.90.92]:58086 "EHLO mailout06.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406223AbgJTMig (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Oct 2020 08:38:36 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout06.rmx.de (Postfix) with ESMTPS id 4CFtTN6PJ5z9yxw;
        Tue, 20 Oct 2020 14:38:32 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4CFtT21pd1z2xGP;
        Tue, 20 Oct 2020 14:38:14 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.87) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 20 Oct
 2020 14:38:06 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <tglx@linutronix.de>, <linux-rt-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: sched: system doesn't boot since  "sched: Add new migrate_disable() implementation"
Date:   Tue, 20 Oct 2020 14:38:06 +0200
Message-ID: <3306981.cWQ2TMxoAe@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20201020113009.GR2628@hirez.programming.kicks-ass.net>
References: <1654655.1jrfHnk7pZ@n95hx1g2> <20201019150935.koqbk57dmahhomdc@linutronix.de> <20201020113009.GR2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [192.168.54.87]
X-RMX-ID: 20201020-143818-4CFtT21pd1z2xGP-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tuesday, 20 October 2020, 13:30:09 CEST, Peter Zijlstra wrote:
> On Mon, Oct 19, 2020 at 05:09:35PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-10-19 12:21:06 [+0200], Christian Eggers wrote:
> > > I have problems with the latest 5.9-rt releases on i.MX6ULL (!
CONFIG_SMP):
> > …
> > 
> > > Any hints?
> > 
> > Thank you for the report. The reason is the migrate_disable()
> > implementation for !SMP.
> 
> This should fix things I suppose. I'll fold it in.
> 
> ---
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -378,7 +378,12 @@ static inline void preempt_notifier_init
>  extern void migrate_disable(void);
>  extern void migrate_enable(void);
> 
> -#else /* !(CONFIG_SMP && CONFIG_PREEMPT_RT) */
> +#elif defined(CONFIG_PREEMPT_RT)
> +
> +static inline void migrate_disable(void) { }
> +static inline void migrate_enable(void { }
closing bracket missing

> +
> +#else /* !CONFIG_PREEMPT_RT */
> 
>  /**
>   * migrate_disable - Prevent migration of the current task

I didn't understand much of you discussion with Sebastian,
but my system is able to boot now.

# uname -r
5.9.0-rt16+

Best regards
Christian



