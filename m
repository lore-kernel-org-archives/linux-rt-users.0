From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 01/32] tracing: Add hist_field_name() accessor
Date: Thu, 13 Jul 2017 09:41:37 -0500
Message-ID: <1499956897.3995.32.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <a0f2699176fffe26bce68cc78811b573fe83636e.1498510759.git.tom.zanussi@linux.intel.com>
         <AM3PR02MB1308DE5C55A9ED048022E7DC1AC0@AM3PR02MB130.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "vedang.patel@intel.com" <vedang.patel@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Piotr Gregor <pgregor@quadrant-systems.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM3PR02MB1308DE5C55A9ED048022E7DC1AC0@AM3PR02MB130.eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Piotr,

On Thu, 2017-07-13 at 06:49 +0000, Piotr Gregor wrote:
> Hi Tom,
> 
> Which repo and branch do you push these changes into?
> 

  https://github.com/tzanussi/linux-trace-inter-event.git tzanussi/inter-event-v01

Tom

> cheers,
> Piotr
> 
> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Tom Zanussi
> Sent: 26 June 2017 23:49
> To: rostedt@goodmis.org
> Cc: tglx@linutronix.de; mhiramat@kernel.org; namhyung@kernel.org; vedang.patel@intel.com; linux-kernel@vger.kernel.org; linux-rt-users@vger.kernel.org; Tom Zanussi <tom.zanussi@linux.intel.com>
> Subject: [PATCH 01/32] tracing: Add hist_field_name() accessor
> 
> In preparation for hist_fields that won't be strictly based on trace_event_fields, add a new hist_field_name() accessor to allow that flexibility and update associated users.
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
>  static hist_field_fn_t select_value_fn(int field_size, int field_is_signed)  {
>  	hist_field_fn_t fn = NULL;
> @@ -653,7 +670,6 @@ static int is_descending(const char *str)  static int create_sort_keys(struct hist_trigger_data *hist_data)  {
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
> +			if (strcmp(field_name, test_name) == 0) {
>  				sort_key->field_idx = j;
>  				descending = is_descending(field_str);
>  				if (descending < 0) {
> @@ -952,6 +973,7 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
>  	struct hist_field *key_field;
>  	char str[KSYM_SYMBOL_LEN];
>  	bool multiline = false;
> +	const char *field_name;
>  	unsigned int i;
>  	u64 uval;
>  
> @@ -963,26 +985,27 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
>  		if (i > hist_data->n_vals)
>  			seq_puts(m, ", ");
>  
> +		field_name = hist_field_name(key_field, 0);
> +
>  		if (key_field->flags & HIST_FIELD_FL_HEX) {
>  			uval = *(u64 *)(key + key_field->offset);
> -			seq_printf(m, "%s: %llx",
> -				   key_field->field->name, uval);
> +			seq_printf(m, "%s: %llx", field_name, uval);
>  		} else if (key_field->flags & HIST_FIELD_FL_SYM) {
>  			uval = *(u64 *)(key + key_field->offset);
>  			sprint_symbol_no_offset(str, uval);
> -			seq_printf(m, "%s: [%llx] %-45s",
> -				   key_field->field->name, uval, str);
> +			seq_printf(m, "%s: [%llx] %-45s", field_name,
> +				   uval, str);
>  		} else if (key_field->flags & HIST_FIELD_FL_SYM_OFFSET) {
>  			uval = *(u64 *)(key + key_field->offset);
>  			sprint_symbol(str, uval);
> -			seq_printf(m, "%s: [%llx] %-55s",
> -				   key_field->field->name, uval, str);
> +			seq_printf(m, "%s: [%llx] %-55s", field_name,
> +				   uval, str);
>  		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
>  			char *comm = elt->private_data;
>  
>  			uval = *(u64 *)(key + key_field->offset);
> -			seq_printf(m, "%s: %-16s[%10llu]",
> -				   key_field->field->name, comm, uval);
> +			seq_printf(m, "%s: %-16s[%10llu]", field_name,
> +				   comm, uval);
>  		} else if (key_field->flags & HIST_FIELD_FL_SYSCALL) {
>  			const char *syscall_name;
>  
> @@ -991,8 +1014,8 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
>  			if (!syscall_name)
>  				syscall_name = "unknown_syscall";
>  
> -			seq_printf(m, "%s: %-30s[%3llu]",
> -				   key_field->field->name, syscall_name, uval);
> +			seq_printf(m, "%s: %-30s[%3llu]", field_name,
> +				   syscall_name, uval);
>  		} else if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
>  			seq_puts(m, "stacktrace:\n");
>  			hist_trigger_stacktrace_print(m,
> @@ -1000,15 +1023,14 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
>  						      HIST_STACKTRACE_DEPTH);
>  			multiline = true;
>  		} else if (key_field->flags & HIST_FIELD_FL_LOG2) {
> -			seq_printf(m, "%s: ~ 2^%-2llu", key_field->field->name,
> +			seq_printf(m, "%s: ~ 2^%-2llu", field_name,
>  				   *(u64 *)(key + key_field->offset));
>  		} else if (key_field->flags & HIST_FIELD_FL_STRING) {
> -			seq_printf(m, "%s: %-50s", key_field->field->name,
> +			seq_printf(m, "%s: %-50s", field_name,
>  				   (char *)(key + key_field->offset));
>  		} else {
>  			uval = *(u64 *)(key + key_field->offset);
> -			seq_printf(m, "%s: %10llu", key_field->field->name,
> -				   uval);
> +			seq_printf(m, "%s: %10llu", field_name, uval);
>  		}
>  	}
>  
> @@ -1021,13 +1043,13 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
>  		   tracing_map_read_sum(elt, HITCOUNT_IDX));
>  
>  	for (i = 1; i < hist_data->n_vals; i++) {
> +		field_name = hist_field_name(hist_data->fields[i], 0);
> +
>  		if (hist_data->fields[i]->flags & HIST_FIELD_FL_HEX) {
> -			seq_printf(m, "  %s: %10llx",
> -				   hist_data->fields[i]->field->name,
> +			seq_printf(m, "  %s: %10llx", field_name,
>  				   tracing_map_read_sum(elt, i));
>  		} else {
> -			seq_printf(m, "  %s: %10llu",
> -				   hist_data->fields[i]->field->name,
> +			seq_printf(m, "  %s: %10llu", field_name,
>  				   tracing_map_read_sum(elt, i));
>  		}
>  	}
> @@ -1142,7 +1164,9 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
>  
>  static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)  {
> -	seq_printf(m, "%s", hist_field->field->name);
> +	const char *field_name = hist_field_name(hist_field, 0);
> +
> +	seq_printf(m, "%s", field_name);
>  	if (hist_field->flags) {
>  		const char *flags_str = get_hist_field_flags(hist_field);
>  
> --
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
