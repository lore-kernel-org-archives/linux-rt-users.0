From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched: fix the wrong macro name of CONFIG_DEBUG_PREEMPT
Date: Tue, 09 Apr 2013 10:37:25 -0400
Message-ID: <1365518245.25498.57.camel@gandalf.local.home>
References: <5162AE51.8030804@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt@vger.kernel.org
To: Qiang Huang <h.huangqiang@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:31408 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935016Ab3DIOh2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Apr 2013 10:37:28 -0400
In-Reply-To: <5162AE51.8030804@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas, 

Can you pick up this patch for 3.8-rt? I'll add it to stable after you
have done so.

Thanks,

-- Steve

On Mon, 2013-04-08 at 19:47 +0800, Qiang Huang wrote:
> Might be a typo, would cause some debug code never be run.
> 
> Signed-off-by: Qiang Huang <h.huangqiang@huawei.com>
> ---
>  kernel/sched/core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 30126e2..7b50412 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3405,7 +3405,7 @@ static noinline void __schedule_bug(struct task_struct *prev)
>  	print_modules();
>  	if (irqs_disabled())
>  		print_irqtrace_events(prev);
> -#ifdef DEBUG_PREEMPT
> +#ifdef CONFIG_DEBUG_PREEMPT
>  	if (in_atomic_preempt_off()) {
>  		pr_err("Preemption disabled at:");
>  		print_ip_sym(current->preempt_disable_ip);
> @@ -7802,7 +7802,7 @@ void __might_sleep(const char *file, int line, int preempt_offset)
>  	debug_show_held_locks(current);
>  	if (irqs_disabled())
>  		print_irqtrace_events(current);
> -#ifdef DEBUG_PREEMPT
> +#ifdef CONFIG_DEBUG_PREEMPT
>  	if (!preempt_count_equals(preempt_offset)) {
>  		pr_err("Preemption disabled at:");
>  		print_ip_sym(current->preempt_disable_ip);


