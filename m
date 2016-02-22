From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/4] tools lib traceevent: Implements '%' operation
Date: Mon, 22 Feb 2016 15:23:03 -0500
Message-ID: <20160222152303.02f79376@gandalf.local.home>
References: <cover.1456157869.git.bristot@redhat.com>
	<5c96a395c56cea6d3d13d949051bdece86cc26e0.1456157869.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:49717 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752095AbcBVUXK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Feb 2016 15:23:10 -0500
In-Reply-To: <5c96a395c56cea6d3d13d949051bdece86cc26e0.1456157869.git.bristot@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 22 Feb 2016 14:08:22 -0300
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> The operation '%' is not implemented on event-parse.c, causing
> an error on the parse of events with '%' operation on its
> printk format. For example,
> 
> # perf record -e sched:sched_deadline_yield ~/y
>   Warning: [sched:sched_deadline_yield] unknown op '%'
> ....
> # perf script
>   Warning: [sched:sched_deadline_yield] unknown op '%'
> 	y  1641 [006]  3364.109319: sched:sched_deadline_yield: \
> 			[FAILED TO PARSE] now=3364109314595 	\
> 			deadline=3364139295135 runtime=19975597
> 
> This patch implements the '%' operation. With this patch, we see the
> correct output:
> 
> # perf record -e sched:sched_deadline_yield ~/y
>   No Warning
> 
> # perf script
> 	y  4005 [001]  4623.650978: sched:sched_deadline_yield: \
> 		now=4623.650974050				\
> 		deadline=4623.680957364 remaining_runtime=19979611
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Arnaldo,

This patch is not dependent on the rest of the series and looks like a
good general fix.

Can you pull this one into your tree, and please add my:

Reviewed-by: Steven Rostedt <rsotedt@goodmis.org>

Thanks!

-- Steve

> ---
>  tools/lib/traceevent/event-parse.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index c3bd294..575e751 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -1951,6 +1951,7 @@ process_op(struct event_format *event, struct print_arg *arg, char **tok)
>  		   strcmp(token, "*") == 0 ||
>  		   strcmp(token, "^") == 0 ||
>  		   strcmp(token, "/") == 0 ||
> +		   strcmp(token, "%") == 0 ||
>  		   strcmp(token, "<") == 0 ||
>  		   strcmp(token, ">") == 0 ||
>  		   strcmp(token, "<=") == 0 ||
> @@ -3689,6 +3690,9 @@ eval_num_arg(void *data, int size, struct event_format *event, struct print_arg
>  		case '/':
>  			val = left / right;
>  			break;
> +		case '%':
> +			val = left % right;
> +			break;
>  		case '*':
>  			val = left * right;
>  			break;

