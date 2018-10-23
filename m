From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v6 07/15] tracing: Move hist trigger key printing into a
 separate function
Date: Tue, 23 Oct 2018 23:37:22 +0900
Message-ID: <20181023233722.95a6685f2395c0ba979698a4@kernel.org>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
        <7b9b456df5b0738f73aa6a688db82c345d0358e1.1539288364.git.tom.zanussi@linux.intel.com>
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
In-Reply-To: <7b9b456df5b0738f73aa6a688db82c345d0358e1.1539288364.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Thu, 11 Oct 2018 16:02:04 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Future patches will want to print a histogram key outside a histogram
> - add and use hist_trigger_print_key() for that purpose.

Hmm, I think this change should be done with such user code, because without
the user code I can not decide it is good or not.

Thank you,

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 3712200dc670..5ec462cb7672 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4849,10 +4849,10 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
>  	}
>  }
>  
> -static void
> -hist_trigger_entry_print(struct seq_file *m,
> -			 struct hist_trigger_data *hist_data, void *key,
> -			 struct tracing_map_elt *elt)
> +static void hist_trigger_print_key(struct seq_file *m,
> +				   struct hist_trigger_data *hist_data,
> +				   void *key,
> +				   struct tracing_map_elt *elt)
>  {
>  	struct hist_field *key_field;
>  	char str[KSYM_SYMBOL_LEN];
> @@ -4928,6 +4928,17 @@ hist_trigger_entry_print(struct seq_file *m,
>  		seq_puts(m, " ");
>  
>  	seq_puts(m, "}");
> +}
> +
> +static void hist_trigger_entry_print(struct seq_file *m,
> +				     struct hist_trigger_data *hist_data,
> +				     void *key,
> +				     struct tracing_map_elt *elt)
> +{
> +	const char *field_name;
> +	unsigned int i;
> +
> +	hist_trigger_print_key(m, hist_data, key, elt);
>  
>  	seq_printf(m, " hitcount: %10llu",
>  		   tracing_map_read_sum(elt, HITCOUNT_IDX));
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
