From: Qiang Huang <h.huangqiang@huawei.com>
Subject: Re: [RFC PATCH] tasklet: correct the comments about tasklet schedule
Date: Wed, 30 Apr 2014 15:48:32 +0800
Message-ID: <5360AAD0.5030708@huawei.com>
References: <536075C1.2080704@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	zhangwei <jovi.zhangwei@huawei.com>,
	"Li Zefan" <lizefan@huawei.com>, <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>, <mingo@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:28443 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbaD3HuF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Apr 2014 03:50:05 -0400
In-Reply-To: <536075C1.2080704@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Forgot to mention, this patch and analyze are based on 3.4 rt.

On 2014/4/30 12:02, Qiang Huang wrote:
> Hi all,
> 
> Ingo's patch:
> 00853150572df2	tasklet: Prevent tasklets from going into infinite spin in RT
> changed behavior about tasklet in NO-RT scenario, but I found some suspicious
> from code and comments.
> 
> Like the below patch says, if a tasklet is already running on another CPU,
> then it would have RUN flag and have no SCHED flag, so when we call
> tasklet_schedule, then in __tasklet_common_schedule(), tasklet_trylock()
> will return false, and the tasklet won't be added to tasklet_vec list,
> so there is no reschedule, right?
> 
> Another, the comments said schedule called from tasklet itself would cause
> lockup, like it mentioned above, in tasklet function, the tasklet has RUN
> flag, and have no SCHED flag, so when it call tasklet_schedule, it will
> only meet tasklet_trylock return false, then nothing happened. I think this
> should not be any lockup.
> 
> After all, if my understanding is correct, it changed the behavior when
> tasklet scheduled itself, this would affect some kernel modules using
> tasklet, is this what we want in RT? If so, should we use RT_FULL config
> to isolate this affect?
> 
> --------------------
> 
> Correct the comments as the code really do.
> 
> Signed-off-by: Qiang Huang <h.huangqiang@huawei.com>
> ---
>  include/linux/interrupt.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index fb05761..e9d73e6 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -514,9 +514,8 @@ extern void __send_remote_softirq(struct call_single_data *cp, int cpu,
>       to be executed on some cpu at least once after this.
>     * If the tasklet is already scheduled, but its execution is still not
>       started, it will be executed only once.
> -   * If this tasklet is already running on another CPU, it is rescheduled
> -     for later.
> -   * Schedule must not be called from the tasklet itself (a lockup occurs)
> +   * If this tasklet is already running on another CPU (or schedule is called
> +     from tasklet itself), it wound not be rescheduled.
>     * Tasklet is strictly serialized wrt itself, but not
>       wrt another tasklets. If client needs some intertask synchronization,
>       he makes it with spinlocks.
> --
> 1.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


