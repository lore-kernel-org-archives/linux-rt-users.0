From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 02/32] tracing: Reimplement log2
Date: Fri, 14 Jul 2017 11:33:21 +0900
Message-ID: <20170714023321.GD6959@sejong>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
 <032f7234ba8aef8428ed717f624e805e1d0e5524.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <032f7234ba8aef8428ed717f624e805e1d0e5524.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jun 26, 2017 at 05:49:03PM -0500, Tom Zanussi wrote:
> log2 as currently implemented applies only to u64 trace_event_field
> derived fields, and assumes that anything it's applied to is a u64
> field.
> 
> To prepare for synthetic fields like latencies, log2 should be
> applicable to those as well, so take the opportunity now to fix the
> current problems as well as expand to more general uses.
> 
> log2 should be thought of as a chaining function rather than a field
> type.  To enable this as well as possible future function
> implementations, add a hist_field operand array into the hist_field
> definition for this purpose, and make use of it to implement the log2
> 'function'.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 91ffc39..7b55956 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -28,12 +28,16 @@
>  
>  typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event);
>  
> +#define HIST_FIELD_OPERANDS_MAX	2
> +
>  struct hist_field {
>  	struct ftrace_event_field	*field;
>  	unsigned long			flags;
>  	hist_field_fn_t			fn;
>  	unsigned int			size;
>  	unsigned int			offset;
> +	unsigned int                    is_signed;
> +	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
>  };
>  
>  static u64 hist_field_none(struct hist_field *field, void *event)
> @@ -71,7 +75,9 @@ static u64 hist_field_pstring(struct hist_field *hist_field, void *event)
>  
>  static u64 hist_field_log2(struct hist_field *hist_field, void *event)
>  {
> -	u64 val = *(u64 *)(event + hist_field->field->offset);
> +	struct hist_field *operand = hist_field->operands[0];
> +
> +	u64 val = operand->fn(operand, event);
>  
>  	return (u64) ilog2(roundup_pow_of_two(val));
>  }
> @@ -156,6 +162,8 @@ static const char *hist_field_name(struct hist_field *field,
>  
>  	if (field->field)
>  		field_name = field->field->name;
> +	else if (field->flags & HIST_FIELD_FL_LOG2)
> +		field_name = hist_field_name(field->operands[0], ++level);
>  
>  	if (field_name == NULL)
>  		field_name = "";
> @@ -357,8 +365,20 @@ static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
>  	.elt_init	= hist_trigger_elt_comm_init,
>  };
>  
> -static void destroy_hist_field(struct hist_field *hist_field)
> +static void destroy_hist_field(struct hist_field *hist_field,
> +			       unsigned int level)
>  {
> +	unsigned int i;
> +
> +	if (level > 2)
> +		return;
> +
> +	if (!hist_field)
> +		return;
> +
> +	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
> +		destroy_hist_field(hist_field->operands[i], ++level);

Wouldn't it be 'level + 1' ?

Thanks,
Namhyung


> +
>  	kfree(hist_field);
>  }
