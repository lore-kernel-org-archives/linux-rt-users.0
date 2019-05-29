Return-Path: <SRS0=QNvF=T5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3000AC28CC0
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 May 2019 14:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131AD23B08
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 May 2019 14:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfE2OxJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 May 2019 10:53:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54879 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfE2OxJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 May 2019 10:53:09 -0400
Received: from p200300d06f28ff00b92b307fdbdaf2b9.dip0.t-ipconnect.de ([2003:d0:6f28:ff00:b92b:307f:dbda:f2b9] helo=somnus.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1hVzwv-00061P-Pz; Wed, 29 May 2019 16:53:05 +0200
Date:   Wed, 29 May 2019 16:53:05 +0200 (CEST)
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 1/3] timers: raise timer softirq on
 __mod_timer/add_timer_on
In-Reply-To: <20190415201429.342103190@amt.cnet>
Message-ID: <alpine.DEB.2.21.1905291652480.1395@somnus>
References: <20190415201213.600254019@amt.cnet> <20190415201429.342103190@amt.cnet>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 15 Apr 2019, Marcelo Tosatti wrote:

[...]

> The patch "timers: do not raise softirq unconditionally" from Thomas
> attempts to address that by checking, in the sched tick, whether its
> necessary to raise the timer softirq. Unfortunately, it attempts to grab
> the tvec base spinlock which generates the issue described in the patch
> "Revert "timers: do not raise softirq unconditionally"".

Both patches are not available in the version your patch set is based
on. Better pointers would be helpful.

> tvec_base->lock protects addition of timers to the wheel versus
> timer interrupt execution.

The timer_base->lock (formally known as tvec_base->lock), synchronizes all
accesses to timer_base and not only addition of timers versus timer
interrupt execution. Deletion of timers, getting the next timer interrupt,
forwarding the base clock and migration of timers are protected as well by
timer_base->lock.

> This patch does not grab the tvec base spinlock from irq context,
> but rather performs a lockless access to base->pending_map.

I cannot see where this patch performs a lockless access to
timer_base->pending_map.

> It handles the the race between timer addition and timer interrupt
> execution by unconditionally (in case of isolated CPUs) raising the
> timer softirq after making sure the updated bitmap is visible 
> on remote CPUs.

So after modifying a timer on a non housekeeping timer base, the timer
softirq is raised - even if there is no pending timer in the next
bucket. Only with this patch, this shouldn't be a problem - but it is an
additional raise of timer softirq and an overhead when adding a timer,
because the normal timer softirq is raised from sched tick anyway.

> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
>  kernel/time/timer.c |   38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> Index: linux-rt-devel/kernel/time/timer.c
> ===================================================================
> --- linux-rt-devel.orig/kernel/time/timer.c	2019-04-15 13:56:06.974210992 -0300
> +++ linux-rt-devel/kernel/time/timer.c	2019-04-15 14:21:02.788704354 -0300
> @@ -1056,6 +1063,17 @@
>  		internal_add_timer(base, timer);
>  	}
>  
> +	if (!housekeeping_cpu(base->cpu, HK_FLAG_TIMER) &&
> +	    !(timer->flags & TIMER_DEFERRABLE)) {
> +		call_single_data_t *c;
> +
> +		c = per_cpu_ptr(&raise_timer_csd, base->cpu);
> +
> +		/* Make sure bitmap updates are visible on remote CPUs */
> +		smp_wmb();
> +		smp_call_function_single_async(base->cpu, c);
> +	}
> +
>  out_unlock:
>  	raw_spin_unlock_irqrestore(&base->lock, flags);
>

Could you please explain me, why you decided to use the above
implementation for raising the timer softirq after modifying a timer?

Thanks,

	Anna-Maria

