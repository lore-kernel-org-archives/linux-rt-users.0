From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch -rt] Fix infinite loop with 2.6.31.4-rt14
Date: Fri, 23 Oct 2009 09:21:22 -0700
Message-ID: <4AE1D802.6050906@us.ibm.com>
References: <20091023134700.GA5578@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: dino@in.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:35996 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbZJWQVh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Oct 2009 12:21:37 -0400
In-Reply-To: <20091023134700.GA5578@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Dino,

Dinakar Guniguntala wrote:
> 
> Not sure if this the best way to go here, but the patch below seems to resolve
> the problem for me
> 
> If this is fine, I'll send a separate patch for mainline. Currently mainline
> seems to be missing the earlier patch referenced above as well

So... something else sets ret to -EAGAIN which should be returned to 
userspace, rather than used to retry.


>  /**
> - * handle_early_requeue_pi_wakeup() - Detect early wakeup on the initial futex
> - * @hb:		the hash_bucket futex_q was original enqueued on
> - * @q:		the futex_q woken while waiting to be requeued
> - * @key2:	the futex_key of the requeue target futex
> - * @timeout:	the timeout associated with the wait (NULL if none)
> - *
> - * Detect if the task was woken on the initial futex as opposed to the requeue
> - * target futex.  If so, determine if it was a timeout or a signal that caused
> - * the wakeup and return the appropriate error code to the caller.  Must be
> - * called with the hb lock held.
> - *
> - * Returns
> - *  0 - no early wakeup detected
> - * <0 - -ETIMEDOUT or -ERESTARTNOINTR
> - */
> -static inline
> -int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
> -				   struct futex_q *q, union futex_key *key2,
> -				   struct hrtimer_sleeper *timeout)
> -{

Cramming this entire function into futex_wait_requeue_pi() doesn't 
appear relevant to the problem. Please don't make 
futex_wait_requeue_pi() any longer than it already is. My fault that, 
but let's not make it worse!

>  	spin_unlock(&hb->lock);
> +	if (ret == -EAGAIN) {
> +		/* Retry on spurious wakeup */
> +		put_futex_key(fshared, &q.key);
> +		put_futex_key(fshared, &key2);
> +		goto retry;
> +	}

The above is the core of the change yes?

>  	if (ret)
>  		goto out_put_keys;
> 
> @@ -2264,9 +2247,6 @@ out_put_keys:
>  out_key2:
>  	put_futex_key(fshared, &key2);
> 
> -	/* Spurious wakeup ? */
> -	if (ret == -EAGAIN)
> -		goto retry;

I did a little digging trying to see what else might be returning EAGAIN 
after the handle_early..() call.  I only see fixup_pi_state_owner() and 
rt_mutex_finish_proxy_lock().  Neither of those has an obvious return of 
EAGAIN.  I'll keep looking.

If this turns out to be the proper fix, please reduce it down to simply 
check for EAGAIN after handle_early..() and return from there, with a 
comment, and avoid moving the logic into this overly large function.

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
