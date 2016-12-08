From: John Keeping <john@metanate.com>
Subject: Re: Lockdep splat from destroy_workqueue() with RT_PREEMPT_FULL
Date: Thu, 8 Dec 2016 16:25:44 +0000
Message-ID: <20161208162544.1909caf2.john@metanate.com>
References: <20161208122028.18e7b9e1.john@metanate.com>
        <20161208133306.254xkj2d4a2c24yr@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161208133306.254xkj2d4a2c24yr@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian,

On Thu, 8 Dec 2016 14:33:06 +0100, Sebastian Andrzej Siewior wrote:
> On 2016-12-08 12:20:28 [+0000], John Keeping wrote:
> > I am seeing the following splat when stopping btattach on v4.4.30-rt41
> > with PREEMPT_RT_FULL with lockdep and slub_debug.
> > 
> > The bad unlock balance seems to just be an effect of the lock having
> > been overwritten with POISON_FREE, the real issue is that
> > put_pwq_unlocked() is not resuming and unlocking the pool before the RCU
> > work scheduled indirectly by put_pwq() has completed.  
> 
> can you reproduce this? If so, is this patch helping?

Yes, I am able to reproduce it reasonably reliably, or at least I *was*
able to: since applying the patch below I haven't seen it fail at all,
so consider the patch:

Tested-by: John Keeping <john@metanate.com>


> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1135,9 +1135,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
>  		 * As both pwqs and pools are RCU protected, the
>  		 * following lock operations are safe.
>  		 */
> +		rcu_read_lock();
>  		local_spin_lock_irq(pendingb_lock, &pwq->pool->lock);
>  		put_pwq(pwq);
>  		local_spin_unlock_irq(pendingb_lock, &pwq->pool->lock);
> +		rcu_read_unlock();
>  	}
>  }


John
