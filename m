From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 07/40] tracing: Apply absolute timestamps to instance
 max buffer
Date: Wed, 6 Sep 2017 20:49:46 -0400
Message-ID: <20170906204946.61c4e680@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <ebdb168d0be042dcdf51f81e696b17fabe3609c1.1504642143.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbdIGAtu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Sep 2017 20:49:50 -0400
In-Reply-To: <ebdb168d0be042dcdf51f81e696b17fabe3609c1.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue,  5 Sep 2017 16:57:19 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> From: Baohong Liu <baohong.liu@intel.com>
> 
> Currently absolute timestamps are applied to both regular and max
> buffers only for global trace. For instance trace, absolute
> timestamps are applied only to regular buffer. But, regular and max
> buffers can be swapped, for example, following a snapshot. So, for
> instance trace, bad timestamps can be seen following a snapshot.
> Let's apply absolute timestamps to instance max buffer as well.
> 
> Similarly, buffer clock change is applied to instance max buffer
> as well.
> 
> Signed-off-by: Baohong Liu <baohong.liu@intel.com>
> ---
>  kernel/trace/trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 66d465e..719e4c1 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6223,7 +6223,7 @@ static int tracing_set_clock(struct trace_array *tr, const char *clockstr)
>  	tracing_reset_online_cpus(&tr->trace_buffer);
>  
>  #ifdef CONFIG_TRACER_MAX_TRACE
> -	if (tr->flags & TRACE_ARRAY_FL_GLOBAL && tr->max_buffer.buffer)
> +	if (tr->max_buffer.buffer)
>  		ring_buffer_set_clock(tr->max_buffer.buffer, trace_clocks[i].func);
>  	tracing_reset_online_cpus(&tr->max_buffer);
>  #endif




> @@ -6307,7 +6307,7 @@ int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs)
>  	tracing_reset_online_cpus(&tr->trace_buffer);
>  
>  #ifdef CONFIG_TRACER_MAX_TRACE
> -	if (tr->flags & TRACE_ARRAY_FL_GLOBAL && tr->max_buffer.buffer)
> +	if (tr->max_buffer.buffer)
>  		ring_buffer_set_time_stamp_abs(tr->max_buffer.buffer, abs);
>  	tracing_reset_online_cpus(&tr->max_buffer);
>  #endif

Please fold this part into the previous patch. I'm adding the first
part to my tree now and will start testing it tonight, and push it to
Linus by the weekend.

-- Steve

