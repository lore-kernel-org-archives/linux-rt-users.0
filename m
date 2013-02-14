From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH]sched/stop_task: Do not account zero delta_exec in
 put_prev_task_stop
Date: Thu, 14 Feb 2013 14:23:07 -0500
Message-ID: <1360869787.23152.49.camel@gandalf.local.home>
References: <180751360618804@web6d.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <180751360618804@web6d.yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2013-02-12 at 01:40 +0400, Kirill Tkhai wrote:
> Simple return
> 

I'll ack the patch, but I nack the change log. Please write something up
that's a little more descriptive.

Thanks,

-- Steve

> Signed-off-by: Kirill V Tkhai <tkhai@yandex.ru>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ingo Molnar <mingo@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: linux-rt-users <linux-rt-users@vger.kernel.org>
> ---
>  kernel/sched/stop_task.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index da5eb5b..78d0458 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -58,8 +58,8 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
>  	u64 delta_exec;
>  
>  	delta_exec = rq->clock_task - curr->se.exec_start;
> -	if (unlikely((s64)delta_exec < 0))
> -		delta_exec = 0;
> +	if (unlikely((s64)delta_exec <= 0))
> +		return;
>  
>  	schedstat_set(curr->se.statistics.exec_max,
>  			max(curr->se.statistics.exec_max, delta_exec));
