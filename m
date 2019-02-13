From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v14 06/15] tracing: Add hist trigger snapshot() action
Date: Wed, 13 Feb 2019 14:25:51 -0500
Message-ID: <20190213142551.0b89604e@gandalf.local.home>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
        <c191f511b3d29e1d4a7f36e49d7702a97950e113.1549403369.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c191f511b3d29e1d4a7f36e49d7702a97950e113.1549403369.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue,  5 Feb 2019 16:41:52 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> +static struct track_data *track_data_alloc(unsigned int key_len,
> +					   struct action_data *action_data,
> +					   struct hist_trigger_data *hist_data)
> +{
> +	struct track_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	unsigned int size = TASK_COMM_LEN;

Why have the variable "size"?

> +	struct hist_elt_data *elt_data;
> +
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	data->key = kzalloc(key_len, GFP_KERNEL);
> +	if (!data->key) {
> +		track_data_free(data);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	data->key_len = key_len;
> +	data->action_data = action_data;
> +	data->hist_data = hist_data;
> +
> +	elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
> +	if (!elt_data) {
> +		track_data_free(data);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	data->elt.private_data = elt_data;
> +
> +	elt_data->comm = kzalloc(size, GFP_KERNEL);

Why not just do:

	elt_data->comm = kzalloc(TASK_COMM_LEN, GFP_KERNEL);

?

> +	if (!elt_data->comm) {
> +		track_data_free(data);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return data;
> +}
> +
>  static char last_hist_cmd[MAX_FILTER_STR_VAL];
>  static char hist_err_str[MAX_FILTER_STR_VAL];
>  
> @@ -1726,12 +1805,6 @@ static struct hist_field *find_event_var(struct hist_trigger_data *hist_data,
>  	return hist_field;
>  }
>  
> -struct hist_elt_data {
> -	char *comm;
> -	u64 *var_ref_vals;
> -	char *field_var_str[SYNTH_FIELDS_MAX];
> -};
> -
>  static u64 hist_field_var_ref(struct hist_field *hist_field,
>  			      struct tracing_map_elt *elt,
>  			      struct ring_buffer_event *rbe,
> @@ -3452,6 +3525,112 @@ static bool check_track_val(struct tracing_map_elt *elt,
>  	return data->track_data.check_val(track_val, var_val);
>  }
>  
> +#ifdef CONFIG_TRACER_SNAPSHOT
> +static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
> +{
> +	/* called with tr->max_lock held */
> +	struct track_data *track_data = tr->cond_snapshot->cond_data;
> +	struct hist_elt_data *elt_data, *track_elt_data;
> +	struct snapshot_context *context = cond_data;
> +	u64 track_val;
> +
> +	if (!track_data)
> +		return false;
> +
> +	track_val = get_track_val(track_data->hist_data, context->elt,
> +				  track_data->action_data);
> +
> +	track_data->track_val = track_val;
> +	memcpy(track_data->key, context->key, track_data->key_len);
> +
> +	elt_data = context->elt->private_data;
> +	track_elt_data = track_data->elt.private_data;
> +	if (elt_data->comm)
> +		memcpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);

I noticed this because we hardcode the size in memcpy. Should hard code
it above, otherwise it looks like elt_data->comm may be something other
than TASK_COMM_LEN.

-- Steve

> +
> +	track_data->updated = true;
> +
> +	return true;
> +}
> +
