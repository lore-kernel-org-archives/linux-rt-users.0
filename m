From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/7] RT: Add support for updating push-rt priority under
 PI boost
Date: Mon, 15 Oct 2007 13:47:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710151347161.26495@gandalf.stny.rr.com>
References: <20071013001052.7444.8363.stgit@novell1.haskins.net>
 <20071013001554.7444.3543.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932943AbXJORs2@vger.kernel.org>
In-Reply-To: <20071013001554.7444.3543.stgit@novell1.haskins.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Fri, 12 Oct 2007, Gregory Haskins wrote:

Again no description.

-- Steve

> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> ---
>
>  kernel/sched.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/sched.c b/kernel/sched.c
> index 50c88e8..62f9f0b 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -4663,6 +4663,7 @@ void rt_mutex_setprio(struct task_struct *p, int prio)
>  		 * this runqueue and our priority is higher than the current's
>  		 */
>  		if (task_running(rq, p)) {
> +			set_rq_prio(rq, p->prio);
>  			if (p->prio > oldprio)
>  				resched_task(rq->curr);
>  		} else {
> @@ -4722,6 +4723,9 @@ void set_user_nice(struct task_struct *p, long nice)
>  		 */
>  		if (delta < 0 || (delta > 0 && task_running(rq, p)))
>  			resched_task(rq->curr);
> +
> +		if (delta && task_running(rq, p))
> +			set_rq_prio(rq, p->prio);
>  	}
>  out_unlock:
>  	task_rq_unlock(rq, &flags);
>
>
>
