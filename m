From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Lockdep splat from destroy_workqueue() with RT_PREEMPT_FULL
Date: Thu, 8 Dec 2016 14:33:06 +0100
Message-ID: <20161208133306.254xkj2d4a2c24yr@linutronix.de>
References: <20161208122028.18e7b9e1.john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
To: John Keeping <john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161208122028.18e7b9e1.john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-12-08 12:20:28 [+0000], John Keeping wrote:
> Hi,
Hi John,

> I am seeing the following splat when stopping btattach on v4.4.30-rt41
> with PREEMPT_RT_FULL with lockdep and slub_debug.
> 
> The bad unlock balance seems to just be an effect of the lock having
> been overwritten with POISON_FREE, the real issue is that
> put_pwq_unlocked() is not resuming and unlocking the pool before the RCU
> work scheduled indirectly by put_pwq() has completed.

can you reproduce this? If so, is this patch helping?

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1135,9 +1135,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 		 * As both pwqs and pools are RCU protected, the
 		 * following lock operations are safe.
 		 */
+		rcu_read_lock();
 		local_spin_lock_irq(pendingb_lock, &pwq->pool->lock);
 		put_pwq(pwq);
 		local_spin_unlock_irq(pendingb_lock, &pwq->pool->lock);
+		rcu_read_unlock();
 	}
 }
 

Sebastian
