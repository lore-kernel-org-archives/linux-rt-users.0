From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH] [RT] avoid preemption in memory controller code
Date: Fri, 12 Dec 2008 10:17:31 +0900
Message-ID: <20081212101731.6034a554.kamezawa.hiroyu@jp.fujitsu.com>
References: <preempt_enable_rt();>
	<1229022045-31670-1-git-send-email-tim@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de
To: Tim Blechmann <tim@klingt.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:39625 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093AbYLLBS2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Dec 2008 20:18:28 -0500
In-Reply-To: <1229022045-31670-1-git-send-email-tim@klingt.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 11 Dec 2008 20:00:45 +0100
Tim Blechmann <tim@klingt.org> wrote:

> the lru_lock of struct mem_group_per_zone is used to avoid preemption
> during the mem_cgroup_charge_statistics function. this does not work
> correctly, when CONFIG_PREEMPT_RT is enabled.
> therefore, the preemption is disabled using the preempt_disable_rt macro
> in these cases.
> 
> Signed-off-by: Tim Blechmann <tim@klingt.org>

Sorry, memcg's code this function in mmotm kernel is now, following.
Please give me advice if some more thinking is necessary for RT.

==
static void mem_cgroup_charge_statistics(struct mem_cgroup *mem,
                                         struct page_cgroup *pc,
                                         bool charge)
{
        int val = (charge)? 1 : -1;
        struct mem_cgroup_stat *stat = &mem->stat;
        struct mem_cgroup_stat_cpu *cpustat;
        int cpu = get_cpu();

        cpustat = &stat->cpustat[cpu];
        if (PageCgroupCache(pc))
                __mem_cgroup_stat_add_safe(cpustat, MEM_CGROUP_STAT_CACHE, val);
        else
                __mem_cgroup_stat_add_safe(cpustat, MEM_CGROUP_STAT_RSS, val);

        if (charge)
                __mem_cgroup_stat_add_safe(cpustat,
                                MEM_CGROUP_STAT_PGPGIN_COUNT, 1);
        else
                __mem_cgroup_stat_add_safe(cpustat,
                                MEM_CGROUP_STAT_PGPGOUT_COUNT, 1);
        put_cpu();
}
==

Regards,
-Kame
> ---
>  mm/memcontrol.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 562b94f..70493c4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -158,7 +158,7 @@ pcg_default_flags[NR_CHARGE_TYPE] = {
>  };
>  
>  /*
> - * Always modified under lru lock. Then, not necessary to preempt_disable()
> + * Always modified under lru lock. Disable preemption with preempt_disable_rt()
>   */
>  static void mem_cgroup_charge_statistics(struct mem_cgroup *mem,
>  					 struct page_cgroup *pc,
> @@ -170,6 +170,7 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *mem,
>  
>  	VM_BUG_ON(!irqs_disabled());
>  
> +	preempt_disable_rt();
>  	cpustat = &stat->cpustat[smp_processor_id()];
>  	if (PageCgroupCache(pc))
>  		__mem_cgroup_stat_add_safe(cpustat, MEM_CGROUP_STAT_CACHE, val);
> @@ -182,6 +183,7 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *mem,
>  	else
>  		__mem_cgroup_stat_add_safe(cpustat,
>  				MEM_CGROUP_STAT_PGPGOUT_COUNT, 1);
> +	preempt_enable_rt();
>  }
>  
>  static struct mem_cgroup_per_zone *
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

