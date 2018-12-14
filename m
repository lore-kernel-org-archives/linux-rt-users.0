From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v8 20/22] tracing: Use hist trigger's var_ref array to
 destroy var_refs
Date: Sat, 15 Dec 2018 01:31:19 +0900
Message-ID: <20181215013119.dc796fd4d2d21535adb4cf6c@kernel.org>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
        <4d6103ab7b4fdef81a82e2977b4005a26212a726.1544483273.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4d6103ab7b4fdef81a82e2977b4005a26212a726.1544483273.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 10 Dec 2018 18:01:34 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Since every var ref for a trigger has an entry in the var_ref[] array,
> use that to destroy the var_refs, instead of piecemeal via the field
> expressions.
> 
> This allows us to avoid having to keep and treat differently separate
> lists for the action-related references, which future patches will
> remove.

I'm not so sure, but this seems a bugfix... if so, please move this at
the top of this series.

Thank you,

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index d07bb2d75e18..da4800c3f745 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2312,6 +2312,15 @@ static int contains_operator(char *str)
>  	return field_op;
>  }
>  
> +static void __destroy_hist_field(struct hist_field *hist_field)
> +{
> +	kfree(hist_field->var.name);
> +	kfree(hist_field->name);
> +	kfree(hist_field->type);
> +
> +	kfree(hist_field);
> +}
> +
>  static void destroy_hist_field(struct hist_field *hist_field,
>  			       unsigned int level)
>  {
> @@ -2323,14 +2332,13 @@ static void destroy_hist_field(struct hist_field *hist_field,
>  	if (!hist_field)
>  		return;
>  
> +	if (hist_field->flags & HIST_FIELD_FL_VAR_REF)
> +		return; /* var refs will be destroyed separately */
> +
>  	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
>  		destroy_hist_field(hist_field->operands[i], level + 1);
>  
> -	kfree(hist_field->var.name);
> -	kfree(hist_field->name);
> -	kfree(hist_field->type);
> -
> -	kfree(hist_field);
> +	__destroy_hist_field(hist_field);
>  }
>  
>  static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
> @@ -2457,6 +2465,12 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
>  			hist_data->fields[i] = NULL;
>  		}
>  	}
> +
> +	for (i = 0; i < hist_data->n_var_refs; i++) {
> +		WARN_ON(!(hist_data->var_refs[i]->flags & HIST_FIELD_FL_VAR_REF));
> +		__destroy_hist_field(hist_data->var_refs[i]);
> +		hist_data->var_refs[i] = NULL;
> +	}
>  }
>  
>  static int init_var_ref(struct hist_field *ref_field,
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
