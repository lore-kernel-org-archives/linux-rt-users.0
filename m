From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 01/32] tracing: Add hist_field_name() accessor
Date: Fri, 14 Jul 2017 11:19:38 +0900
Message-ID: <20170714021938.GC6959@sejong>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
 <a0f2699176fffe26bce68cc78811b573fe83636e.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a0f2699176fffe26bce68cc78811b573fe83636e.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Mon, Jun 26, 2017 at 05:49:02PM -0500, Tom Zanussi wrote:
> In preparation for hist_fields that won't be strictly based on
> trace_event_fields, add a new hist_field_name() accessor to allow that
> flexibility and update associated users.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 68 +++++++++++++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 1c21d0e..91ffc39 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -146,6 +146,23 @@ struct hist_trigger_data {
>  	struct tracing_map		*map;
>  };
>  
> +static const char *hist_field_name(struct hist_field *field,
> +				   unsigned int level)
> +{
> +	const char *field_name = "";
> +
> +	if (level > 1)
> +		return field_name;
> +
> +	if (field->field)
> +		field_name = field->field->name;
> +
> +	if (field_name == NULL)
> +		field_name = "";
> +
> +	return field_name;
> +}
> +
>  static hist_field_fn_t select_value_fn(int field_size, int field_is_signed)
>  {
>  	hist_field_fn_t fn = NULL;
> @@ -653,7 +670,6 @@ static int is_descending(const char *str)
>  static int create_sort_keys(struct hist_trigger_data *hist_data)
>  {
>  	char *fields_str = hist_data->attrs->sort_key_str;
> -	struct ftrace_event_field *field = NULL;
>  	struct tracing_map_sort_key *sort_key;
>  	int descending, ret = 0;
>  	unsigned int i, j;
> @@ -670,7 +686,9 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
>  	}
>  
>  	for (i = 0; i < TRACING_MAP_SORT_KEYS_MAX; i++) {
> +		struct hist_field *hist_field;
>  		char *field_str, *field_name;
> +		const char *test_name;
>  
>  		sort_key = &hist_data->sort_keys[i];
>  
> @@ -703,8 +721,11 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
>  		}
>  
>  		for (j = 1; j < hist_data->n_fields; j++) {
> -			field = hist_data->fields[j]->field;
> -			if (field && (strcmp(field_name, field->name) == 0)) {
> +			hist_field = hist_data->fields[j];
> +			test_name = hist_field_name(hist_field, 0);
> +			if (test_name == NULL)
> +				continue;

The hist_field_name() don't return NULL.

Thanks,
Namhyung
