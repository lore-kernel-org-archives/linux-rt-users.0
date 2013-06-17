From: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH][RFC] kernel/cpu: do not change the cpus_allowed of the
 current task when unplugging cpus
Date: Mon, 17 Jun 2013 18:48:32 +0800
Message-ID: <20130617104832.GA20410@localhost.localdomain>
References: <1368699439-13034-1-git-send-email-chenhui.zhao@freescale.com>
 <20130607090543.GD10280@linutronix.de>
 <20130609095942.GA8548@localhost.localdomain>
 <20130614152917.GA8597@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tglx@linutronix.de>, <leoli@freescale.com>,
	<scottwood@freescale.com>, <Priyanka.Jain@freescale.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:27065
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932264Ab3FQKsj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Jun 2013 06:48:39 -0400
Content-Disposition: inline
In-Reply-To: <20130614152917.GA8597@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 14, 2013 at 05:29:17PM +0200, Sebastian Andrzej Siewior wrote:
> * Zhao Chenhui | 2013-06-09 17:59:42 [+0800]:
> 
> >No. _cpu_down() on mainline do not change the cpus_allowed.
> My bad.
> 
> >The problem is that the task which turned off cpu2 (for instance)
> >can not run on cpu2 again after cpu2 is turned on, because cpu2 has been
> >removed from the cpus_allowed of the task.
> >
> >The task can put himself back on cpu2 throuhg the system call,
> >but I think applications should not do this work and do not care which cpu
> >it is running on in most time.
> 
> The mask needs to be changed because you may not be on the CPU while it
> is going down. What do you think about:
> 

I don't think it is necessary to change the mask. migration_call() invoked by
the cpu notify "CPU_DYING" will remove all running tasks from the dying cpu.
Even if the current task is running on the dying cpu, it will be transfered
to another online cpu. 

I guess that changing the mask benefits the latency of the system.
Please correct me.

-Chenhui

> Subject: [PATCH] kernel/hotplug: restore original cpu mask oncpu/down
> 
> If a task which is allowed to run only on CPU X puts CPU Y down then it
> will be allowed on all CPUs but the on CPU Y after it comes back from
> kernel. This patch ensures that we don't lose the initial setting unless
> the CPU the task is running is going down.
> 
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/cpu.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 3acf17d..f5ad8e1 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -545,6 +545,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
>  		.hcpu = hcpu,
>  	};
>  	cpumask_var_t cpumask;
> +	cpumask_var_t cpumask_org;
>  
>  	if (num_online_cpus() == 1)
>  		return -EBUSY;
> @@ -555,6 +556,12 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
>  	/* Move the downtaker off the unplug cpu */
>  	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
>  		return -ENOMEM;
> +	if (!alloc_cpumask_var(&cpumask_org, GFP_KERNEL))  {
> +		free_cpumask_var(cpumask);
> +		return -ENOMEM;
> +	}
> +
> +	cpumask_copy(cpumask_org, tsk_cpus_allowed(current));
>  	cpumask_andnot(cpumask, cpu_online_mask, cpumask_of(cpu));
>  	set_cpus_allowed_ptr(current, cpumask);
>  	free_cpumask_var(cpumask);
> @@ -563,7 +570,8 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
>  	if (mycpu == cpu) {
>  		printk(KERN_ERR "Yuck! Still on unplug CPU\n!");
>  		migrate_enable();
> -		return -EBUSY;
> +		err = -EBUSY;
> +		goto restore_cpus;
>  	}
>  
>  	cpu_hotplug_begin();
> @@ -622,6 +630,9 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
>  	cpu_hotplug_done();
>  	if (!err)
>  		cpu_notify_nofail(CPU_POST_DEAD | mod, hcpu);
> +restore_cpus:
> +	set_cpus_allowed_ptr(current, cpumask_org);
> +	free_cpumask_var(cpumask_org);
>  	return err;
>  }
>  

