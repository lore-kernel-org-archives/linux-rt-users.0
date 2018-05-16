From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 05/14] tracing: Do not show filter file for ftrace
 internal events
Date: Wed, 16 May 2018 18:10:25 +0900
Message-ID: <20180516091025.GB30309@danjae.aot.lge.com>
References: <20180514205845.017925650@goodmis.org>
 <20180514205958.061558690@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180514205958.061558690@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, May 14, 2018 at 04:58:50PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The filter file in the ftrace internal events, like in
> /sys/kernel/tracing/events/ftrace/function/filter is not attached to any
> functionality. Do not create them as they are meaningless.
> 
> In the future, if an ftrace internal event gets filter functionality, then
> it will need to create it directly.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 5b647904a65b..14ff4ff3caab 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2007,16 +2007,18 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
>  			return -1;
>  		}
>  	}
> -	trace_create_file("filter", 0644, file->dir, file,
> -			  &ftrace_event_filter_fops);
>  
>  	/*
>  	 * Only event directories that can be enabled should have
> -	 * triggers.
> +	 * triggers or filters.
>  	 */
> -	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
> +	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
> +		trace_create_file("filter", 0644, file->dir, file,
> +				  &ftrace_event_filter_fops);
> +
>  		trace_create_file("trigger", 0644, file->dir, file,
>  				  &event_trigger_fops);
> +	}
>  
>  #ifdef CONFIG_HIST_TRIGGERS
>  	trace_create_file("hist", 0444, file->dir, file,

What about moving the "hist" file as well since it's meaningless
without the trigger.

Thanks,
Namhyung
