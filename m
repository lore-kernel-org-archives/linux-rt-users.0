From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 35/40] tracing: Reverse the order
 event_mutex/trace_types_lock are taken
Date: Fri, 8 Sep 2017 15:31:35 -0400
Message-ID: <20170908153135.14725f01@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <4b52f9b1c49599780af1a193736df609b2785a63.1504642143.git.tom.zanussi@linux.intel.com>
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
Received: from mail.kernel.org ([198.145.29.99]:48434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756581AbdIHTbj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Sep 2017 15:31:39 -0400
In-Reply-To: <4b52f9b1c49599780af1a193736df609b2785a63.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue,  5 Sep 2017 16:57:47 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Change the order event_mutex and trace_types_lock are taken, to avoid
> circular dependencies and lockdep spew.
> 
> Changing the order shouldn't matter to any current code, but does to
> anything that takes the event_mutex first and then trace_types_lock.
> This is the case when calling tracing_set_clock from inside an event
> command, which already holds the event_mutex.

This is a very scary patch. I'll apply it and run a bunch of tests with
lockdep enabled. Let's see what blows up (or not).

-- Steve

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index c93540c..889802c 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1406,8 +1406,8 @@ static int subsystem_open(struct inode *inode, struct file *filp)
>  		return -ENODEV;
>  
>  	/* Make sure the system still exists */
> -	mutex_lock(&trace_types_lock);
>  	mutex_lock(&event_mutex);
> +	mutex_lock(&trace_types_lock);
>  	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
>  		list_for_each_entry(dir, &tr->systems, list) {
>  			if (dir == inode->i_private) {
> @@ -1421,8 +1421,8 @@ static int subsystem_open(struct inode *inode, struct file *filp)
>  		}
>  	}
>   exit_loop:
> -	mutex_unlock(&event_mutex);
>  	mutex_unlock(&trace_types_lock);
> +	mutex_unlock(&event_mutex);
>  
>  	if (!system)
>  		return -ENODEV;
> @@ -2294,15 +2294,15 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
>  int trace_add_event_call(struct trace_event_call *call)
>  {
>  	int ret;
> -	mutex_lock(&trace_types_lock);
>  	mutex_lock(&event_mutex);
> +	mutex_lock(&trace_types_lock);
>  
>  	ret = __register_event(call, NULL);
>  	if (ret >= 0)
>  		__add_event_to_tracers(call);
>  
> -	mutex_unlock(&event_mutex);
>  	mutex_unlock(&trace_types_lock);
> +	mutex_unlock(&event_mutex);
>  	return ret;
>  }
>  
> @@ -2356,13 +2356,13 @@ int trace_remove_event_call(struct trace_event_call *call)
>  {
>  	int ret;
>  
> -	mutex_lock(&trace_types_lock);
>  	mutex_lock(&event_mutex);
> +	mutex_lock(&trace_types_lock);
>  	down_write(&trace_event_sem);
>  	ret = probe_remove_event_call(call);
>  	up_write(&trace_event_sem);
> -	mutex_unlock(&event_mutex);
>  	mutex_unlock(&trace_types_lock);
> +	mutex_unlock(&event_mutex);
>  
>  	return ret;
>  }
> @@ -2424,8 +2424,8 @@ static int trace_module_notify(struct notifier_block *self,
>  {
>  	struct module *mod = data;
>  
> -	mutex_lock(&trace_types_lock);
>  	mutex_lock(&event_mutex);
> +	mutex_lock(&trace_types_lock);
>  	switch (val) {
>  	case MODULE_STATE_COMING:
>  		trace_module_add_events(mod);
> @@ -2434,8 +2434,8 @@ static int trace_module_notify(struct notifier_block *self,
>  		trace_module_remove_events(mod);
>  		break;
>  	}
> -	mutex_unlock(&event_mutex);
>  	mutex_unlock(&trace_types_lock);
> +	mutex_unlock(&event_mutex);
>  
>  	return 0;
>  }

