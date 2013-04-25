From: Li Zefan <lizefan@huawei.com>
Subject: Re: cgroup_fj tests will stick the nort kernel
Date: Thu, 25 Apr 2013 16:44:30 +0800
Message-ID: <5178ECEE.4070907@huawei.com>
References: <5170F28F.3060002@huawei.com> <51750563.8050301@huawei.com> <1366646447.9609.131.camel@gandalf.local.home> <5176217E.8030008@huawei.com> <5178C922.3060506@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	zhangwei <jovi.zhangwei@huawei.com>
To: Qiang Huang <h.huangqiang@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:51749 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab3DYIpQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 04:45:16 -0400
In-Reply-To: <5178C922.3060506@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> And the patch below, I added your signed-off-by if it looks good to you.

Don't...

> Here is the patch seems solve the problem, it looks all good in my box, my
> only concern is how will this affect our RT code.
> 
> 
>>From 8e4fa4e9a7b510bdaf90b8140ce1e847375abccf Mon Sep 17 00:00:00 2001
> From: Qiang Huang <h.huangqiang@huawei.com>
> Date: Thu, 25 Apr 2013 10:22:01 +0800
> Subject: [PATCH] sched: don't clear PF_THREAD_BOUND in select_fallback_rq
> 
> This is revert of "sched-clear-pf-thread-bound-on-fallback-rq.patch"
> (commit 0d939066acdcb in v3.4-rt),.
> 
> Select_fallback_rq() can be easilly called during system boot, because
> select_task_rq_fair() just return task_cpu(p) for bounded kernel threads,
> which is 0 during system boot and not in tsk_cpus_allowed, so
> select_fallback_rq() is called and PF_THREAD_BOUND is cleared. In my
> box, 1/3 bounded kernel threads will clear that flag after boot.
> 
> And it will cause problems, for example:
> # for pid in `ps -e -o pid`; do taskset -p -c 0-15 $pid; done
> this command will cause system hung.
> 
> What's more, I don't see why we need to clear this flag any more,
> because "cpu/rt: Rework cpu down for PREEMPT_RT" already remove the
> optimization for PF_THREAD_BOUND on migrate_disable/enable.
> 
> Signed-off-by: Qiang Huang <h.huangqiang@huawei.com>
> Signed-off-by: Li Zefan <lizefan@huawei.com>

You shoudn't have added my SOB... I didn't write this patch and I didn't
even sugguest this fix or check if this is a correct fix.

Please read Documentation/SubmittingPatches to learn how SOB should
be used.

> ---
>  kernel/sched/core.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 751ec60..8db6e3b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1327,12 +1327,6 @@ out:
>  		}
>  	}
> 
> -	/*
> -	 * Clear PF_THREAD_BOUND, otherwise we wreckage
> -	 * migrate_disable/enable. See optimization for
> -	 * PF_THREAD_BOUND tasks there.
> -	 */
> -	p->flags &= ~PF_THREAD_BOUND;
>  	return dest_cpu;
>  }
> 

