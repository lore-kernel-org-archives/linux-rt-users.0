From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH v3.14-rt] netpoll: guard the access to dev->npinfo with
	rcu_read_lock/unlock_bh() for CONFIG_PREEMPT_RT_FULL=y
Date: Wed, 3 Dec 2014 13:50:20 +0100
Message-ID: <20141203125020.GA5775@opentech.at>
References: <1417608357-26552-1-git-send-email-kexin.hao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Kevin Hao <haokexin@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:46934 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbaLCM5U (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Dec 2014 07:57:20 -0500
Content-Disposition: inline
In-Reply-To: <1417608357-26552-1-git-send-email-kexin.hao@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 03 Dec 2014, Kevin Hao wrote:

> For vanilla kernel we don't need to invoke rcu_read_lock/unlock_bh
> explicitly to mark an RCU-bh critical section in the softirq context
> because bh is already disabled in this case. But for a rt kernel,
> the commit ("rcu: Merge RCU-bh into RCU-preempt") implements the
> RCU-bh in term of RCU-preempt. So we have to use
> rcu_read_lock/unlock_bh() to mark an RCU-bh critical section even in
> +
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	rcu_read_lock_bh();
> +#endif
> +
> +	npinfo = rcu_dereference_bh(skb->dev->npinfo);
> +	ret = npinfo && (!list_empty(&npinfo->rx_np) || npinfo->rx_flags);
> +
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	rcu_read_unlock_bh();
> +#endif

Is that not actually a bug indepedent of RT ? 
without the rcu_read_lock/unlock who says that the 
rcu_dereference is still valid at this point ? 
I though that if bh are already disabled you still
need the read_lock. disabled bh would allow to "downgrad" 
the rcu_read_lock_bh to rcu_read_lock but you still need it.

thx!
hofrat
