Return-Path: <SRS0=QNvF=T5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27498C28CC1
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 May 2019 14:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5E323B05
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 May 2019 14:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfE2Oxa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 May 2019 10:53:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54885 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfE2Ox3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 May 2019 10:53:29 -0400
Received: from p200300d06f28ff00b92b307fdbdaf2b9.dip0.t-ipconnect.de ([2003:d0:6f28:ff00:b92b:307f:dbda:f2b9] helo=somnus.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1hVzxG-00063R-Hd; Wed, 29 May 2019 16:53:26 +0200
Date:   Wed, 29 May 2019 16:53:26 +0200 (CEST)
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 2/3] timers: do not raise softirq unconditionally
 (spinlockless version)
In-Reply-To: <20190415201429.427759476@amt.cnet>
Message-ID: <alpine.DEB.2.21.1905291653120.1395@somnus>
References: <20190415201213.600254019@amt.cnet> <20190415201429.427759476@amt.cnet>
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

> Check base->pending_map locklessly and skip raising timer softirq 
> if empty.
> 
> What allows the lockless (and potentially racy against mod_timer) 
> check is that mod_timer will raise another timer softirq after
> modifying base->pending_map.

The raise of the timer softirq after adding the timer is done
unconditionally - so there are timer softirqs raised which are not required
at all, as mentioned before.

This check is for !CONFIG_PREEMPT_RT_FULL only implemented. The commit
message totally igonres that you are implementing something
CONFIG_PREEMPT_RT_FULL dependent as well.

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

So with this patch and the change you made in the patch before, timers on
RT are expired only when there is pending irq work or after modifying a
timer on a non housekeeping cpu?

With your patches I could create the following problematic situation on RT
(if I understood everything properly): I add a timer which should expire in
50 jiffies to the wheel of a non housekeeping cpu. So it ends up 50 buckets
away form now in the first wheel. This timer is the only timer in the wheel
and the next timer softirq raise is required in 50 jiffies. After adding
the timer, the timer interrupt is raised, and no timer has to be expired,
because there is no timer pending. If there is no irq work required during
the next 51 jiffies and also no timer changed, the timer I added, will not
expire in time. The timer_base will come out of idle but will not forward
the base clk. This makes it even worse: When then adding a timer, the timer
base is forwarded - but without checking for the next pending timer, so the
first added timer will be delayed even more.

So your implementation lacks forwarding the timer_base->clk when timer_base
comes out of idle with respect to the next pending timer.


> +#endif
> +	base = this_cpu_ptr(&timer_bases[BASE_STD]);
> +	if (!housekeeping_cpu(base->cpu, HK_FLAG_TIMER)) {
> +		if (!bitmap_empty(base->pending_map, WHEEL_SIZE))
> +			goto raise;
> +		base++;
> +		if (!bitmap_empty(base->pending_map, WHEEL_SIZE))
> +			goto raise;
> +
> +		return;
> +	}
> +
> +raise:
>  	raise_softirq(TIMER_SOFTIRQ);
>  }
>  
>

Thanks,

	Anna-Maria

