From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/4] futex: convert hash_bucket locks to raw_spinlock_t
Date: Mon, 12 Jul 2010 07:45:20 -0400
Message-ID: <1278935120.1537.187.camel@gandalf.stny.rr.com>
References: <1278714780-788-1-git-send-email-dvhltc@us.ibm.com>
	 <1278714780-788-5-git-send-email-dvhltc@us.ibm.com>
	 <1278790882.7352.101.camel@marge.simson.net>
	 <1278855208.15197.6.camel@marge.simson.net>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Darren Hart <dvhltc@us.ibm.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Mike Galbraith <mgalbraith@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:58061 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab0GLLpX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Jul 2010 07:45:23 -0400
In-Reply-To: <1278855208.15197.6.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2010-07-11 at 15:33 +0200, Mike Galbraith wrote:
> On Sat, 2010-07-10 at 21:41 +0200, Mike Galbraith wrote:

> diff --git a/kernel/futex.c b/kernel/futex.c
> index a6cec32..ef489f3 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2255,7 +2255,14 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, int fshared,
>  	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
>  	futex_wait_queue_me(hb, &q, to);
>  
> -	spin_lock(&hb->lock);
> +	/*
> +	 * Non-blocking synchronization point with futex_requeue().
> +	 *
> +	 * We dare not block here because this will alter PI state, possibly
> +	 * before our waker finishes modifying same in wakeup_next_waiter().
> +	 */
> +	while(!spin_trylock(&hb->lock))
> +		cpu_relax();

I agree that this would work. But I wonder if this should have an:

#ifdef PREEMPT_RT
[...]
#else
	spin_lock(&hb->lock);
#endif

around it. Or encapsulate this lock in a macro that does the same thing
(just to keep the actual code cleaner)

-- Steve

>  	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
>  	spin_unlock(&hb->lock);
>  	if (ret)
> 
> 


