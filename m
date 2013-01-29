From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH]sched/rt: Do not try to push tasks if pinned task
 switches to RT
Date: Tue, 29 Jan 2013 08:26:00 -0500
Message-ID: <1359465960.17639.25.camel@gandalf.local.home>
References: <3019251359404630@web18f.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3019251359404630@web18f.yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2013-01-29 at 00:23 +0400, Kirill Tkhai wrote:
> Just switched pinned task is not able to be pushed. If the rq had had
> several RT tasks before they have already been considered as candidates
> to be pushed (or pulled).

Thanks, but I have one minor nit.

> 
> Signed-off-by: Kirill V Tkhai <tkhai@yandex.ru>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ingo Molnar <mingo@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: linux-rt-users <linux-rt-users@vger.kernel.org>
> ---
>  kernel/sched/rt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4e8f0f4..5f7d92b 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1925,9 +1925,9 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
>  	 */
>  	if (p->on_rq && rq->curr != p) {
>  #ifdef CONFIG_SMP
> -		if (rq->rt.overloaded && push_rt_task(rq) &&
> +		if (rq->rt.overloaded && p->nr_cpus_allowed > 1 &&

I would swap the order here. That is, check p->nr_cpus_allowed before
rq->rt.overloaded. The order doesn't really matter, and even though
rq->rt.overloaded is probably more likely to be 0, it is used by other
CPUs. And as a micro-optimization, I rather read something that is used
by only one CPU than to read something that may be modified by many
CPUs.

-- Steve


>  		    /* Don't resched if we changed runqueues */
> -		    rq != task_rq(p))
> +		    push_rt_task(rq) && rq != task_rq(p))
>  			check_resched = 0;
>  #endif /* CONFIG_SMP */
>  		if (check_resched && p->prio < rq->curr->prio)
