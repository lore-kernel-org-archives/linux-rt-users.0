From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 3/5] sched: make double-lock-balance fair
Date: Tue, 26 Aug 2008 16:14:49 +1000
Message-ID: <200808261614.49662.nickpiggin@yahoo.com.au>
References: <20080825200852.23217.13842.stgit@dev.haskins.net> <20080825201534.23217.14936.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, srostedt@redhat.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	npiggin@suse.de, gregory.haskins@gmail.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756962AbYHZGPN@vger.kernel.org>
In-Reply-To: <20080825201534.23217.14936.stgit@dev.haskins.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 26 August 2008 06:15, Gregory Haskins wrote:
> double_lock balance() currently favors logically lower cpus since they
> often do not have to release their own lock to acquire a second lock.
> The result is that logically higher cpus can get starved when there is
> a lot of pressure on the RQs.  This can result in higher latencies on
> higher cpu-ids.
>
> This patch makes the algorithm more fair by forcing all paths to have
> to release both locks before acquiring them again.  Since callsites to
> double_lock_balance already consider it a potential preemption/reschedule
> point, they have the proper logic to recheck for atomicity violations.
>
> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> ---
>
>  kernel/sched.c |   17 +++++------------
>  1 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched.c b/kernel/sched.c
> index 6e0bde6..b7326cd 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -2790,23 +2790,16 @@ static int double_lock_balance(struct rq *this_rq,
> struct rq *busiest) __acquires(busiest->lock)
>  	__acquires(this_rq->lock)
>  {
> -	int ret = 0;
> -
>  	if (unlikely(!irqs_disabled())) {
>  		/* printk() doesn't work good under rq->lock */
>  		spin_unlock(&this_rq->lock);
>  		BUG_ON(1);
>  	}
> -	if (unlikely(!spin_trylock(&busiest->lock))) {
> -		if (busiest < this_rq) {
> -			spin_unlock(&this_rq->lock);
> -			spin_lock(&busiest->lock);
> -			spin_lock_nested(&this_rq->lock, SINGLE_DEPTH_NESTING);
> -			ret = 1;
> -		} else
> -			spin_lock_nested(&busiest->lock, SINGLE_DEPTH_NESTING);
> -	}
> -	return ret;
> +
> +	spin_unlock(&this_rq->lock);
> +	double_rq_lock(this_rq, busiest);

Rather than adding the extra atomic operation, can't you just put this
into the unlikely spin_trylock failure path rather than the unfair logic
there?

FWIW, this is always going to be a *tiny* bit unfair, because of double
rq lock taking the lower lock first. I guess to fix that you need to just
have a single lock to take before taking 2 rq locks. But that's not
really appropriate for mainline (and maybe not -rt either).
