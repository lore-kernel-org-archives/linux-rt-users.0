From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH]sched/stop_task: Do not account zero delta_exec in
 put_prev_task_stop
Date: Thu, 14 Feb 2013 14:25:32 -0500
Message-ID: <1360869932.23152.51.camel@gandalf.local.home>
References: <180751360618804@web6d.yandex.ru>
	 <878v6spwmk.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Kirill Tkhai <tkhai@yandex.ru>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <878v6spwmk.fsf@sejong.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2013-02-13 at 15:15 +0900, Namhyung Kim wrote:
> ---
> >  kernel/sched/stop_task.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> > index da5eb5b..78d0458 100644
> > --- a/kernel/sched/stop_task.c
> > +++ b/kernel/sched/stop_task.c
> > @@ -58,8 +58,8 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
> >  	u64 delta_exec;
> >  
> >  	delta_exec = rq->clock_task - curr->se.exec_start;
> > -	if (unlikely((s64)delta_exec < 0))
> > -		delta_exec = 0;
> > +	if (unlikely((s64)delta_exec <= 0))
> > +		return;
> 
> It seems it needs to update curr->se.exec_start then.
> 

Ah, if it's less than zero, it does.

A better patch would be:

	if (unlikely((s64)delta_exec <= 0)) {
		curr->se.exec_start = rq->clock_task;
		return;
	}

Thanks!

-- Steve
