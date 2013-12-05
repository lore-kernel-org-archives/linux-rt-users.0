From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/1] rcutree/rcu_bh_qs: disable irq while calling rcu_preempt_qs()
Date: Thu, 5 Dec 2013 10:26:08 -0500
Message-ID: <52A09B10.1010004@windriver.com>
References: <1386237162-10141-1-git-send-email-tiejun.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Tiejun Chen <tiejun.chen@windriver.com>, <bigeasy@linutronix.de>,
	<tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:61687 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455Ab3LEPZ4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 10:25:56 -0500
In-Reply-To: <1386237162-10141-1-git-send-email-tiejun.chen@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 13-12-05 04:52 AM, Tiejun Chen wrote:
> Any callers should make sure irq is disabled before calling rcu_preempt_qs().

Can we stick to the standard rule of three here for commit logs please?

1) Describe what the end user symptoms look like (crash, bug, splat)

2) Describe the underlying problem, i.e. why it happens.

3) Describe why the fix proposed is the _right_ fix, in cases
where it isn't obvious what the impact of the change will be etc.

Maybe it seems obvious to you what the 1,2,3 are -- but it won't
be obvious to everyone, and I hate having to guess.

Thanks,
Paul.
--

> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  kernel/rcutree.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/rcutree.c b/kernel/rcutree.c
> index 7ec834d..6f6d133 100644
> --- a/kernel/rcutree.c
> +++ b/kernel/rcutree.c
> @@ -186,7 +186,12 @@ static void rcu_preempt_qs(int cpu);
>  
>  void rcu_bh_qs(int cpu)
>  {
> +	unsigned long flags;
> +
> +	/* Callers to this function, rcu_preempt_qs(), must disable irqs. */
> +	local_irq_save(flags);
>  	rcu_preempt_qs(cpu);
> +	local_irq_restore(flags);
>  }
>  #else
>  void rcu_bh_qs(int cpu)
> 
