From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [RFC][PATCH RT 1/6] rt,rcu: Have rcu_read_lock_sched() use
 locks for PREEMPT_RT
Date: Thu, 27 Jun 2013 05:52:14 +0200
Message-ID: <1372305134.5871.5.camel@marge.simpson.net>
References: <20130626192806.107564905@goodmis.org>
	 <20130626193049.724948276@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clark.williams@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58575 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab3F0DxA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Jun 2013 23:53:00 -0400
In-Reply-To: <20130626193049.724948276@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2013-06-26 at 15:28 -0400, Steven Rostedt wrote:

> @@ -2491,6 +2491,31 @@ static inline int rcu_blocking_is_gp(voi
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +DEFINE_LOCAL_IRQ_LOCK(rcu_sched_lock);
> +/*
> + * Real-time allows for synchronize sched to sleep but not migrate.
> + * This is done via the local locks. When calling synchronize_sched(),
> + * all the local locks need to be taken and released. This will ensure
> + * that all users of rcu_read_lock_sched() will be out of their critical
> + * sections at the completion of this function. synchronize_sched() will
> + * still perform the normal RCU sched operations to synchronize with
> + * locations that use disabling preemption or interrupts.
> + */
> +static void rcu_synchronize_sched_rt(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		spin_lock(&per_cpu(rcu_sched_lock, cpu).lock);
> +		spin_unlock(&per_cpu(rcu_sched_lock, cpu).lock);
> +	}
> +}

Does that have to be possible vs online?

-Mike

