From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of
 memory allocated in cpu hotplug prepare state
Date: Tue, 18 Dec 2018 12:14:31 +0100
Message-ID: <20181218111431.7vr7rhvr5t7xb5i2@linutronix.de>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        jolsa@kernel.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: zhe.he@windriver.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-12-18 18:30:33 [+0800], zhe.he@windriver.com wrote:
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3398,13 +3398,16 @@ ssize_t intel_event_sysfs_show(char *page, u64 config)
>  	return x86_event_sysfs_show(page, config, event);
>  }
>  
> -struct intel_shared_regs *allocate_shared_regs(int cpu)
> +void allocate_shared_regs(struct intel_shared_regs **pregs, int cpu)
>  {
> -	struct intel_shared_regs *regs;
> +	struct intel_shared_regs *regs = *pregs;
>  	int i;
>  
> -	regs = kzalloc_node(sizeof(struct intel_shared_regs),
> -			    GFP_KERNEL, cpu_to_node(cpu));
> +	if (regs)
> +		memset(regs, 0, sizeof(struct intel_shared_regs));
> +	else
> +		regs = *pregs = kzalloc_node(sizeof(struct intel_shared_regs),
> +					     GFP_KERNEL, cpu_to_node(cpu));
>  	if (regs) {
>  		/*
>  		 * initialize the locks to keep lockdep happy

void allocate_shared_regs(int cpu)
{
	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
        struct intel_shared_regs *regs = puc->shared_regs;
        int i;

	if (!regs)
		regs = kmalloc_node(sizeof(struct intel_shared_regs),
                            GFP_KERNEL, cpu_to_node(cpu));
        if (!regs)
		return;
	memset(regs, 0, sizeof(struct intel_shared_regs));
        for (i = 0; i < EXTRA_REG_MAX; i++)
        	raw_spin_lock_init(&regs->regs[i].lock);

        return regs;
}


> @@ -3414,20 +3417,21 @@ struct intel_shared_regs *allocate_shared_regs(int cpu)
>  
>  		regs->core_id = -1;
>  	}
> -	return regs;
>  }
>  
> -static struct intel_excl_cntrs *allocate_excl_cntrs(int cpu)
> +static void allocate_excl_cntrs(struct intel_excl_cntrs **pc, int cpu)
>  {
> -	struct intel_excl_cntrs *c;
> +	struct intel_excl_cntrs *c = *pc;
>  
> -	c = kzalloc_node(sizeof(struct intel_excl_cntrs),
> -			 GFP_KERNEL, cpu_to_node(cpu));
> +	if (c)
> +		memset(c, 0, sizeof(struct intel_excl_cntrs));
> +	else
> +		c = *pc = kzalloc_node(sizeof(struct intel_excl_cntrs),
> +				       GFP_KERNEL, cpu_to_node(cpu));
>  	if (c) {
>  		raw_spin_lock_init(&c->lock);
>  		c->core_id = -1;
>  	}
> -	return c;
>  }

static void allocate_excl_cntrs(int cpu)
{
	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
	struct intel_excl_cntrs *c = cpuc->excl_cntrs;
	
	if (!c)
		c = kmalloc_node(sizeof(struct intel_excl_cntrs),
			 GFP_KERNEL, cpu_to_node(cpu));
	if (!c)
		return;
	memset(c, 0, sizeof(struct intel_excl_cntrs));
	raw_spin_lock_init(&c->lock);
	c->core_id = -1;
	cpuc->excl_cntrs = c;
}


>  static void intel_pmu_cpu_dying(int cpu)
>  {
> -	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
> -	struct intel_shared_regs *pc;
> -
> -	pc = cpuc->shared_regs;
> -	if (pc) {
> -		if (pc->core_id == -1 || --pc->refcnt == 0)

I think ->refcnt member can go, too. It is only incremented now for no
reason now.

> -			kfree(pc);
> -		cpuc->shared_regs = NULL;
> -	}
> -
> -	free_excl_cntrs(cpu);
> -
>  	fini_debug_store_on_cpu(cpu);
>  
>  	if (x86_pmu.counter_freezing)

Sebastian
