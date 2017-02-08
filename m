From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 01/21] tracing: Add hist_field_name() accessor
Date: Wed, 8 Feb 2017 15:09:10 -0500
Message-ID: <20170208150910.7f8da33f@gandalf.local.home>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
        <23ed24355842ebe9d0c7c11dd19d51f4beda695b.1486569306.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <23ed24355842ebe9d0c7c11dd19d51f4beda695b.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed,  8 Feb 2017 11:24:57 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> In preparation for hist_fields that won't be strictly based on
> trace_event_fields, add a new hist_field_name() accessor to allow that
> flexibility and update associated users.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 59 +++++++++++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index f3a960e..37347d7 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -145,6 +145,16 @@ struct hist_trigger_data {
>  	struct tracing_map		*map;
>  };
>  
> +static const char *hist_field_name(struct hist_field *field)
> +{
> +	const char *field_name = NULL;
> +
> +	if (field->field)
> +		field_name = field->field->name;
> +
> +	return field_name;
> +}

It would be much simpler to do:

{
	if (field->field)
		return field->field->name;

	return NULL;
}

or even:

	return field->field ? field->field->name : NULL;



> +
>  static hist_field_fn_t select_value_fn(int field_size, int field_is_signed)
>  {
>  	hist_field_fn_t fn = NULL;
> @@ -652,7 +662,6 @@ static int is_descending(const char *str)
>  static int create_sort_keys(struct hist_trigger_data *hist_data)
>  {
>  	char *fields_str = hist_data->attrs->sort_key_str;
> -	struct ftrace_event_field *field = NULL;
>  	struct tracing_map_sort_key *sort_key;
>  	int descending, ret = 0;
>  	unsigned int i, j;
> @@ -669,7 +678,9 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
>  	}
>  
>  	for (i = 0; i < TRACING_MAP_SORT_KEYS_MAX; i++) {
> +		struct hist_field *hist_field;
>  		char *field_str, *field_name;
> +		const char *test_name;
>  
>  		sort_key = &hist_data->sort_keys[i];
>  
> @@ -702,8 +713,9 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
>  		}
>  
>  		for (j = 1; j < hist_data->n_fields; j++) {
> -			field = hist_data->fields[j]->field;
> -			if (field && (strcmp(field_name, field->name) == 0)) {
> +			hist_field = hist_data->fields[j];
> +			test_name = hist_field_name(hist_field);
> +			if (strcmp(field_name, test_name) == 0) {

If hist_field_name() returns NULL, the strcmp() will crash.

>  				sort_key->field_idx = j;
>  				descending = is_descending(field_str);
>  				if (descending < 0) {
> @@ -951,6 +963,7 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
>  	struct hist_field *key_field;
>  	char str[KSYM_SYMBOL_LEN];
>  	bool multiline = false;
> +	const char *field_name;
>  	unsigned int i;
>  	u64 uval;
>  

-- Steve
