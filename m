From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH]sched/rt: Do not account zero delta_exec in
 update_curr_rt()
Date: Wed, 30 Jan 2013 08:35:16 -0500
Message-ID: <1359552916.17639.93.camel@gandalf.local.home>
References: <931541359550236@web1g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <931541359550236@web1g.yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2013-01-30 at 16:50 +0400, Kirill Tkhai wrote:
> There are several places of consecutive calls of dequeue_task_rt()
> and put_prev_task_rt() in the scheduler. For example, function
> rt_mutex_setprio() does it.
> 
> The both calls lead to update_curr_rt(), the second of it receives
> zeroed delta_exec. The only effective action in this case is call of
> sched_rt_avg_update(), which can change rq->age_stamp and rq->rt_avg.
> But it is possible in case of ""floating"" rq->clock. This fact is
> not reasonable to be accounted. Another actions do nothing.
> 
> Signed-off-by: Kirill V Tkhai <tkhai@yandex.ru>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> CC: Ingo Molnar <mingo@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: linux-rt-users <linux-rt-users@vger.kernel.org>
> ---
>  kernel/sched/rt.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4e8f0f4..c6d7993 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -925,8 +925,8 @@ static void update_curr_rt(struct rq *rq)
>  		return;
>  
>  	delta_exec = rq->clock_task - curr->se.exec_start;
> -	if (unlikely((s64)delta_exec < 0))
> -		delta_exec = 0;
> +	if (unlikely((s64)delta_exec <= 0))
> +		return;
>  
>  	schedstat_set(curr->se.statistics.exec_max,
>  		      max(curr->se.statistics.exec_max, delta_exec));
