From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Decrease number of calls of push_rt_task() in
 push_rt_tasks()
Date: Thu, 31 Jan 2013 11:08:10 -0500
Message-ID: <1359648490.17639.107.camel@gandalf.local.home>
References: <2016751359330408@web20f.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2016751359330408@web20f.yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2013-01-28 at 03:46 +0400, Kirill Tkhai wrote:
> The patch aims to decrease the number of calls of push_rt_task()
> in push_rt_tasks().
> 
> It's not necessary to push more than 'num_online_cpus() - 1' tasks.
> If just pushed task doesn't leave its new CPU during our local call
> of push_rt_tasks() than we won't push another task to the CPU.
> If it leave or change priority than it will pull new task by itself.

I'm curious. Have you hit situations where this was an issue? Or was
this just discovered by code review?

-- Steve

> 
> Signed-off-by: Kirill V Tkhai <tkhai@yandex.ru>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ingo Molnar <mingo@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: linux-rt-users <linux-rt-users@vger.kernel.org>
> ---
>  kernel/sched/rt.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4e8f0f4..edf046d 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1703,8 +1703,10 @@ out:
>  
>  static void push_rt_tasks(struct rq *rq)
>  {
> +	int num_cpus = num_online_cpus() - 1;
> +
>  	/* push_rt_task will return true if it moved an RT */
> -	while (push_rt_task(rq))
> +	while (push_rt_task(rq) && --num_cpus > 0)
>  		;
>  }
>  
