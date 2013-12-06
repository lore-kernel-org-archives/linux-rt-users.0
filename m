From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] make migrate disable/enable conditioned on
 softirq_nestcnt transition
Date: Thu, 5 Dec 2013 19:45:30 -0500
Message-ID: <20131205194530.1c086844@gandalf.local.home>
References: <20131205234222.GE15603@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>,
	LKML <linux-kernel@vger.kernel.org>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131205234222.GE15603@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

BTW, Please Cc LKML when sending patches. It is the kernel you are
modifying, not userspace.

On Fri, 6 Dec 2013 00:42:22 +0100
Nicholas Mc Guire <der.herr@hofr.at> wrote:

> 
>  This patch removes the recursive calls to migrate_disable/enable in 
>  local_bh_disable/enable
> 
>  the softirq-local-lock.patch introduces local_bh_disable/enable wich 
>  decrements/increments the current->softirq_nestcnt and disable/enables
>  migration as well. as softirq_nestcnt (include/linux/sched.h conditioned
>  on CONFIG_PREEMPT_RT_BASE) already is tracking the nesting level of the
>  recursive calls to local_bh_disable/enable (all in kernel/softirq.c) - no 
>  need to do it twice.
> 
>  migrate_disable/enable thus can be conditionsed on softirq_nestcnt making
>  a transition from 0-1 to disable migration and 1-0 to re-enable it.
> 
>  patch on top of 3.12.1-rt4
> 
>  No change of functional behavior, this does noticably reduce the observed 
>  nesting level of migrate_disable/enable 
> 
> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> ---
>  kernel/softirq.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 9a7268f..16ebbd9 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -569,8 +569,8 @@ static void do_current_softirqs(int need_rcu_bh_qs)
>  
>  void local_bh_disable(void)
>  {
> -	migrate_disable();
> -	current->softirq_nestcnt++;
> +	if (++current->softirq_nestcnt == 1)
> +		migrate_disable();
>  }
>  EXPORT_SYMBOL(local_bh_disable);
>  
> @@ -584,8 +584,8 @@ void local_bh_enable(void)
>  		do_current_softirqs(1);
>  	local_irq_enable();
>  
> -	current->softirq_nestcnt--;
> -	migrate_enable();
> +	if (--current->softirq_nestcnt == 0)
> +		migrate_enable();

I wonder if we should add a:

	BUG_ON(current->softirq_nestcnt < 0);

As for the patch, I haven't found anything wrong with it.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

>  }
>  EXPORT_SYMBOL(local_bh_enable);
>  
> @@ -597,8 +597,10 @@ EXPORT_SYMBOL(local_bh_enable_ip);
>  
>  void _local_bh_enable(void)
>  {
> -	current->softirq_nestcnt--;
> -	migrate_enable();
> +	if (WARN_ON(current->softirq_nestcnt == 0))
> +		return;
> +	if (--current->softirq_nestcnt == 0)
> +		migrate_enable();
>  }
>  EXPORT_SYMBOL(_local_bh_enable);
>  
