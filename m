From: Julia Cartwright <julia@ni.com>
Subject: Re: [RFC] timers: Don't wake ktimersoftd on every tick
Date: Thu, 8 Dec 2016 10:48:10 -0600
Message-ID: <20161208164810.GG1335@jcartwri.amer.corp.natinst.com>
References: <20161205200702.17248-1-haris.okanovic@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-rt-users@vger.kernel.org>, <bigeasy@linutronix.de>,
        <tglx@linutronix.de>, <gratian.crisan@ni.com>
To: Haris Okanovic <haris.okanovic@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:49853 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752246AbcLHQsU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Dec 2016 11:48:20 -0500
Content-Disposition: inline
In-Reply-To: <20161205200702.17248-1-haris.okanovic@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Dec 05, 2016 at 02:07:02PM -0600, Haris Okanovic wrote:
> We recently upgraded from 4.1 to 4.6 and noticed a minor latency
> regression caused by an additional thread wakeup (ktimersoftd) in
> interrupt context on every tick. The wakeups are from
> run_local_timers() raising TIMER_SOFTIRQ. Both TIMER and SCHED softirq
> coalesced into one ksoftirqd wakeup prior to Sebastian's change to split
> timers into their own thread (c002d3c0).
> 
> There's already logic in run_local_timers() to avoid some unnecessary
> wakeups of ksoftirqd, but it doesn't seems to catch them all. In
> particular, I've seen many unnecessary wakeups when jiffies increments
> prior to run_local_timers().
> 
> This patch attempts to improve things by servicing timers in interrupt
> context until one or more are ready to fire:
[..]
>  kernel/time/timer.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index ba53447..c6241ac 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1374,6 +1374,49 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
>  	}
>  }
>  
> +/* Called in interrupt context to quickly check if one or
> + * more timers are expired in base
> + */
> +static bool has_expired_timers(struct timer_base *base)
> +{
> +	bool res = false;
> +	unsigned long clk, end_clk, idx;
> +	int i;
> +
> +	raw_spin_lock(&base->lock);
> +
> +	end_clk = jiffies;
> +	if (unlikely(time_after(end_clk, base->clk + HZ))) {
> +		/* Don't spend too much time in interrupt context. If we didn't
> +		 * service timers in the last second, defer to ktimersoftd.
> +		 */
> +		res = true;
> +		goto end;
> +	}
> +
> +	for ( ; base->clk <= end_clk; base->clk++) {
> +		clk = base->clk;
> +		for (i = 0; i < LVL_DEPTH; i++) {
> +			idx = (clk & LVL_MASK) + i * LVL_SIZE;
> +
> +			if (test_bit(idx, base->pending_map)) {
> +				res = true;
> +				goto end;
> +			}
> +
> +			/* Is it time to look at the next level? */
> +			if (clk & LVL_CLK_MASK)
> +				break;
> +			/* Shift clock for the next level granularity */
> +			clk >>= LVL_CLK_SHIFT;
> +		}
> +	}
> +
> +	end:
> +	raw_spin_unlock(&base->lock);
> +	return res;
> +}
> +

I'm wondering if instead of iterating through and bailing when we see a
expired timer, we should also just go ahead and splice the expired
timers onto a per-CPU "expired" list, bump base->clk, and then schedule the
softirq, which would then only iterate this list and call expiry.

That's marginally more logic in hardirq context than what you are doing
here, but not a lot (and more importantly, it's bounded), and it
prevents us from having to walk the wheel twice (once in hardirq
context, once in softirq) as you have written here.

   Julia
