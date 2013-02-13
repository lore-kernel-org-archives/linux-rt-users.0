From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH]sched/stop_task: Do not account zero delta_exec in put_prev_task_stop
Date: Wed, 13 Feb 2013 15:15:47 +0900
Message-ID: <878v6spwmk.fsf@sejong.aot.lge.com>
References: <180751360618804@web6d.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <180751360618804@web6d.yandex.ru> (Kirill Tkhai's message of
	"Tue, 12 Feb 2013 01:40:04 +0400")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Kirill,

On Tue, 12 Feb 2013 01:40:04 +0400, Kirill Tkhai wrote:
> Simple return
>
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

It seems it needs to update curr->se.exec_start then.

Thanks,
Namhyung

>  
>  	schedstat_set(curr->se.statistics.exec_max,
>  			max(curr->se.statistics.exec_max, delta_exec));
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
