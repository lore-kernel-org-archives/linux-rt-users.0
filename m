From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v15 05/15] tracing: Add conditional snapshot
Date: Thu, 14 Feb 2019 17:25:11 -0600
Message-ID: <1550186711.2498.10.camel@kernel.org>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
         <1bea07828d5fd6864a585f83b1eed47ce097eb45.1550100284.git.tom.zanussi@linux.intel.com>
         <20190214181150.0453ecdf@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214181150.0453ecdf@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Thu, 2019-02-14 at 18:11 -0500, Steven Rostedt wrote:
> On Wed, 13 Feb 2019 17:42:45 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > +
> > +/**
> > + * tracing_snapshot_cond_enable - enable conditional snapshot for
> > an instance
> > + * @tr:		The tracing instance
> > + * @cond_data:	User data to associate with the snapshot
> > + * @update:	Implementation of the cond_snapshot update
> > function
> > + *
> > + * Check whether the conditional snapshot for the given instance
> > has
> > + * already been enabled, or if the current tracer is already using
> > a
> > + * snapshot; if so, return -EBUSY, else create a cond_snapshot and
> > + * save the cond_data and update function inside.
> > + *
> > + * Returns 0 if successful, error otherwise.
> > + */
> > +int tracing_snapshot_cond_enable(struct trace_array *tr, void
> > *cond_data,
> > +				 cond_update_fn_t update)
> > +{
> > +	struct cond_snapshot *cond_snapshot;
> > +	int ret = 0;
> > +
> > +	cond_snapshot = kzalloc(sizeof(*cond_snapshot),
> > GFP_KERNEL);
> > +	if (!cond_snapshot)
> > +		return -ENOMEM;
> > +
> > +	cond_snapshot->cond_data = cond_data;
> > +	cond_snapshot->update = update;
> > +
> > +	mutex_lock(&trace_types_lock);
> > +
> > +	ret = tracing_alloc_snapshot_instance(tr);
> > +	if (ret)
> > +		goto fail_unlock;
> > +
> > +	if (tr->current_trace->use_max_tr) {
> > +		ret = -EBUSY;
> > +		goto fail_unlock;
> > +	}
> > +
> > +	if (tr->cond_snapshot) {
> > +		ret = -EBUSY;
> > +		goto fail_unlock;
> > +	}
> > +
> > +	arch_spin_lock(&tr->max_lock);
> > +	tr->cond_snapshot = cond_snapshot;
> > +	arch_spin_unlock(&tr->max_lock);
> > +
> > +	mutex_unlock(&trace_types_lock);
> > +
> > +	return ret;
> > +
> > + fail_unlock:
> > +        mutex_unlock(&trace_types_lock);
> > +        kfree(cond_snapshot);
> > +        return ret;
> 
> Some whitespace damage here. No need to resend, I fixed it.
> 

OK, thanks.

> 
> > +}
> > +EXPORT_SYMBOL_GPL(tracing_snapshot_cond_enable);
> > +
> 
> I also added this change on top of your series.
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 0460cc0f28fd..2cf3c747a357 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1116,6 +1116,14 @@ int tracing_snapshot_cond_enable(struct
> trace_array *tr, void *cond_data,
>  		goto fail_unlock;
>  	}
>  
> +	/*
> +	 * The cond_snapshot can only change to NULL without the
> +	 * trace_types_lock. We don't care if we race with it going
> +	 * to NULL, but we want to make sure that it's not set to
> +	 * something other than NULL when we get here, which we can
> +	 * do safely with only holding the trace_types_lock and not
> +	 * having to take the max_lock.
> +	 */
>  	if (tr->cond_snapshot) {
>  		ret = -EBUSY;
>  		goto fail_unlock;
> 

Looks good, thanks for adding that back.

Tom

> I'll start testing your series now.
> 
> Thanks!
> 
> -- Steve
> 
