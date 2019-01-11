From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v11 03/15] tracing: Split up onmatch action data
Date: Fri, 11 Jan 2019 13:32:46 +0900
Message-ID: <20190111043246.GB625@sejong>
References: <cover.1547062835.git.tom.zanussi@linux.intel.com>
 <37949f9c6e89144e6ed553e75617ff6528b9b7eb.1547062835.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <37949f9c6e89144e6ed553e75617ff6528b9b7eb.1547062835.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Wed, Jan 09, 2019 at 01:49:10PM -0600, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Currently, the onmatch action data binds the onmatch action to data
> related to synthetic event generation.  Since we want to allow the
> onmatch handler to potentially invoke a different action, and because
> we expect other handlers to generate synthetic events, we need to
> separate the data related to these two functions.
> 
> Also rename the onmatch data to something more descriptive, and create
> and use common action data destroy function.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
[SNIP]
>  
> -static void onmax_destroy(struct action_data *data)
> +static void action_data_destroy(struct action_data *data)
>  {
>  	unsigned int i;
>  
> -	destroy_hist_field(data->onmax.max_var, 0);
> -	destroy_hist_field(data->onmax.var, 0);
> +	lockdep_assert_held(&event_mutex);
>  
> -	kfree(data->onmax.var_str);
>  	kfree(data->action_name);
>  
>  	for (i = 0; i < data->n_params; i++)
>  		kfree(data->params[i]);
>  
> +	if (data->synth_event)
> +		data->synth_event->ref--;
> +

I was wondering about the missing synth_event_mutex used to guard the
refcount.  Then I noticed that I totally missed Masami's dynamic event
work which removed it.  Nice job..

Thanks,
Namhyung


>  	kfree(data);
>  }
>  
> +static void onmax_destroy(struct action_data *data)
> +{
> +	destroy_hist_field(data->onmax.max_var, 0);
> +	destroy_hist_field(data->onmax.var, 0);
> +
> +	kfree(data->onmax.var_str);
> +
> +	action_data_destroy(data);
> +}
