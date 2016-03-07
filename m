From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 14/13] tracing: Fix probe_wakeup_latency_hist_start()
 prototype
Date: Mon, 7 Mar 2016 14:42:16 -0500
Message-ID: <20160307144216.45e1b862@gandalf.local.home>
References: <20160302154847.937325532@goodmis.org>
	<1457064246.3501.2.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:33631 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932223AbcCGTmW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 14:42:22 -0500
In-Reply-To: <1457064246.3501.2.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 04 Mar 2016 05:04:06 +0100
Mike Galbraith <umgwanakikbuti@gmail.com> wrote:

> Drop 'success' arg from probe_wakeup_latency_hist_start().
> 
> Fixes: cf1dd658 sched: Introduce the trace_sched_waking tracepoint
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>

Thanks, I applied this to 3.18-rt, 3.14-rt, 3.12-rt, 3.10-rt, 3.4-rt,
and 3.2-rt.

-- Steve

> ---
>  kernel/trace/latency_hist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/latency_hist.c b/kernel/trace/latency_hist.c
> index 66a69eb5329c..b6c1d14b71c4 100644
> --- a/kernel/trace/latency_hist.c
> +++ b/kernel/trace/latency_hist.c
> @@ -115,7 +115,7 @@ static DEFINE_PER_CPU(struct hist_data, wakeup_latency_hist_sharedprio);
>  static char *wakeup_latency_hist_dir = "wakeup";
>  static char *wakeup_latency_hist_dir_sharedprio = "sharedprio";
>  static notrace void probe_wakeup_latency_hist_start(void *v,
> -	struct task_struct *p, int success);
> +	struct task_struct *p);
>  static notrace void probe_wakeup_latency_hist_stop(void *v,
>  	struct task_struct *prev, struct task_struct *next);
>  static notrace void probe_sched_migrate_task(void *,
> @@ -869,7 +869,7 @@ static notrace void probe_sched_migrate_task(void *v, struct task_struct *task,
>  }
>  
>  static notrace void probe_wakeup_latency_hist_start(void *v,
> -	struct task_struct *p, int success)
> +	struct task_struct *p)
>  {
>  	unsigned long flags;
>  	struct task_struct *curr = current;

