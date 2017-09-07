From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 25/40] tracing: Add support for dynamic tracepoints
Date: Thu, 7 Sep 2017 18:02:26 -0400
Message-ID: <20170907180226.1497e96c@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <9f89af4588c84850a58edcf72d2591ba78906c30.1504642143.git.tom.zanussi@linux.intel.com>
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
Received: from mail.kernel.org ([198.145.29.99]:60878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbdIGWCa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Sep 2017 18:02:30 -0400
In-Reply-To: <9f89af4588c84850a58edcf72d2591ba78906c30.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue,  5 Sep 2017 16:57:37 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> The tracepoint infrastructure assumes statically-defined tracepoints
> and uses static_keys for tracepoint enablement.  In order to define
> tracepoints on the fly, we need to have a dynamic counterpart.

Do we?

I believe the static keys should work just fine if you don't have any
defined static keys jumps, and they should work as a simple counter.

Could we do that instead of adding another variable to a structure that
is defined over a thousand times? Save us 4k of memory.

-- Steve

> 
> Add a 'dynamic' flag to struct tracepoint along with accompanying
> logic for this purpose.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  include/linux/tracepoint-defs.h |  1 +
>  kernel/tracepoint.c             | 18 +++++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index a031920..bc22d54 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -32,6 +32,7 @@ struct tracepoint {
>  	int (*regfunc)(void);
>  	void (*unregfunc)(void);
>  	struct tracepoint_func __rcu *funcs;
> +	bool dynamic;
>  };
>  
>  #endif
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 685c50a..1c5957f 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -197,7 +197,9 @@ static int tracepoint_add_func(struct tracepoint *tp,
>  	struct tracepoint_func *old, *tp_funcs;
>  	int ret;
>  
> -	if (tp->regfunc && !static_key_enabled(&tp->key)) {
> +	if (tp->regfunc &&
> +	    ((tp->dynamic && !(atomic_read(&tp->key.enabled) > 0)) ||
> +	     !static_key_enabled(&tp->key))) {
>  		ret = tp->regfunc();
>  		if (ret < 0)
>  			return ret;
> @@ -219,7 +221,9 @@ static int tracepoint_add_func(struct tracepoint *tp,
>  	 * is used.
>  	 */
>  	rcu_assign_pointer(tp->funcs, tp_funcs);
> -	if (!static_key_enabled(&tp->key))
> +	if (tp->dynamic && !(atomic_read(&tp->key.enabled) > 0))
> +		atomic_inc(&tp->key.enabled);
> +	else if (!tp->dynamic && !static_key_enabled(&tp->key))
>  		static_key_slow_inc(&tp->key);
>  	release_probes(old);
>  	return 0;
> @@ -246,10 +250,14 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>  
>  	if (!tp_funcs) {
>  		/* Removed last function */
> -		if (tp->unregfunc && static_key_enabled(&tp->key))
> +		if (tp->unregfunc &&
> +		    ((tp->dynamic && (atomic_read(&tp->key.enabled) > 0)) ||
> +		     static_key_enabled(&tp->key)))
>  			tp->unregfunc();
>  
> -		if (static_key_enabled(&tp->key))
> +		if (tp->dynamic && (atomic_read(&tp->key.enabled) > 0))
> +			atomic_dec(&tp->key.enabled);
> +		else if (!tp->dynamic && static_key_enabled(&tp->key))
>  			static_key_slow_dec(&tp->key);
>  	}
>  	rcu_assign_pointer(tp->funcs, tp_funcs);
> @@ -258,7 +266,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>  }
>  
>  /**
> - * tracepoint_probe_register -  Connect a probe to a tracepoint
> + * tracepoint_probe_register_prio -  Connect a probe to a tracepoint
>   * @tp: tracepoint
>   * @probe: probe handler
>   * @data: tracepoint data

