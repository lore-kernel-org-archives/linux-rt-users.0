From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [PATCH v3 2/2] timers: Don't search for expired timers while
 TIMER_SOFTIRQ is scheduled
Date: Fri, 5 Jan 2018 13:37:45 -0600
Message-ID: <28f05e39-6bc6-99c5-e1bc-91be3e79ea78@ni.com>
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20170803210657.19179-1-haris.okanovic@ni.com>
 <20170803210657.19179-2-haris.okanovic@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: harisokn@gmail.com, julia.cartwright@ni.com, gratian.crisan@ni.com,
        anna-maria@linutronix.de
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170803210657.19179-2-haris.okanovic@ni.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

It looks like an old version of this patch is included in v4.9*-rt* 
kernels -- E.g. commit 032f93ca in v4.9.68-rt60. There's nothing 
functionally wrong with the included version to the best of my 
knowledge. However, I posted a newer V3 [1][2] based on Thomas' feedback 
that's substantially cleaner and likely more efficient (haven't measured 
yet). I think we should include the latter version instead, if only for 
the cosmetic benefits. Thoughts?

[1] https://patchwork.kernel.org/patch/9879825/  [PATCH v3,1/2]
[2] https://patchwork.kernel.org/patch/9879827/  [PATCH v3,2/2]

-- Haris


On 08/03/2017 04:06 PM, Haris Okanovic wrote:
> This change avoid needlessly searching for more timers in
> run_local_timers() (hard interrupt context) when they can't fire.
> For example, when ktimersoftd/run_timer_softirq() is scheduled but
> preempted due to cpu contention. When it runs, run_timer_softirq() will
> discover newly expired timers up to current jiffies in addition to
> firing previously expired timers.
> 
> However, this change also adds an edge case where non-hrtimer firing
> is sometimes delayed by an additional tick. This is acceptable since we
> don't make latency guarantees for non-hrtimers and would prefer to
> minimize hard interrupt time instead.
> 
> Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>
> ---
> [PATCH v3]
>   - Split block_softirq into separate commit
> 
> https://github.com/harisokanovic/linux/tree/dev/hokanovi/timer-peek-v5
> ---
>   kernel/time/timer.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 078027d8a866..f0ef9675abdf 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -208,6 +208,7 @@ struct timer_base {
>   	bool			migration_enabled;
>   	bool			nohz_active;
>   	bool			is_idle;
> +	bool			block_softirq;
>   	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
>   	struct hlist_head	vectors[WHEEL_SIZE];
>   	struct hlist_head	expired_lists[LVL_DEPTH];
> @@ -1376,9 +1377,11 @@ static int __collect_expired_timers(struct timer_base *base)
>   
>   	/*
>   	 * expire_timers() must be called at least once before we can
> -	 * collect more timers.
> +	 * collect more timers. We should never hit this case unless
> +	 * TIMER_SOFTIRQ got raised without expired timers.
>   	 */
> -	if (base->expired_levels)
> +	if (WARN_ONCE(base->expired_levels,
> +			"Must expire collected timers before collecting more"))
>   		return base->expired_levels;
>   
>   	clk = base->clk;
> @@ -1702,6 +1705,9 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
>   	__run_timers(base);
>   	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active)
>   		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
> +
> +	/* Allow new TIMER_SOFTIRQs to get scheduled by run_local_timers() */
> +	base->block_softirq = false;
>   }
>   
>   /*
> @@ -1712,6 +1718,14 @@ void run_local_timers(void)
>   	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
>   
>   	hrtimer_run_queues();
> +
> +	/*
> +	 * Skip if TIMER_SOFTIRQ is already running on this CPU, since it
> +	 * will find and expire all timers up to current jiffies.
> +	 */
> +	if (base->block_softirq)
> +		return;
> +
>   	/* Raise the softirq only if required. */
>   	if (time_before(jiffies, base->clk) || !tick_find_expired(base)) {
>   		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON) || !base->nohz_active)
> @@ -1720,7 +1734,10 @@ void run_local_timers(void)
>   		base++;
>   		if (time_before(jiffies, base->clk) || !tick_find_expired(base))
>   			return;
> +		base--;
>   	}
> +
> +	base->block_softirq = true;
>   	raise_softirq(TIMER_SOFTIRQ);
>   }
>   
> 
