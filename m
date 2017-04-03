From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch RT 1/4] rtmutex: Make lock_killable work
Date: Mon, 3 Apr 2017 11:21:26 -0400
Message-ID: <20170403112126.75504264@gandalf.local.home>
References: <20170401105058.958246042@linutronix.de>
        <20170401112758.051867031@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        RT-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Wargreen <wargreen@lebib.org>,
        rt-stable@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170401112758.051867031@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 01 Apr 2017 12:50:59 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Locking an rt mutex killable does not work because signal handling is
> restricted to TASK_INTERRUPTIBLE.
> 
> Use signal_pending_state() unconditionaly.

Does this mean rt mutex killable is not INTERRUPTIBLE? because the
change log seems to just assume that.

In other words, mortals reading this have no idea what you are talking
about ;-)

-- Steve

> 
> Cc: rt-stable@vger.kernel.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/locking/rtmutex.c |   19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1633,18 +1633,13 @@ static int __sched
>  		if (try_to_take_rt_mutex(lock, current, waiter))
>  			break;
>  
> -		/*
> -		 * TASK_INTERRUPTIBLE checks for signals and
> -		 * timeout. Ignored otherwise.
> -		 */
> -		if (unlikely(state == TASK_INTERRUPTIBLE)) {
> -			/* Signal pending? */
> -			if (signal_pending(current))
> -				ret = -EINTR;
> -			if (timeout && !timeout->task)
> -				ret = -ETIMEDOUT;
> -			if (ret)
> -				break;
> +		if (timeout && !timeout->task) {
> +			ret = -ETIMEDOUT;
> +			break;
> +		}
> +		if (signal_pending_state(state, current)) {
> +			ret = -EINTR;
> +			break;
>  		}
>  
>  		if (ww_ctx && ww_ctx->acquired > 0) {
> 
