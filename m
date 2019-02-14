From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH v2 4/5] tracing: Use tracing error_log with kprobe
 events (incomplete)
Date: Thu, 14 Feb 2019 12:13:59 +0900
Message-ID: <20190214121359.fff5e00e036fec5bfe39351e@kernel.org>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
        <db931dea3818fb79a710f7b83cb53b06cf565de1.1550074795.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <db931dea3818fb79a710f7b83cb53b06cf565de1.1550074795.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Wed, 13 Feb 2019 12:17:55 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Here are a few examples of replacing kprobe_events error handling with
> tracing_log_err() from the new tracing error_log mechanism.  Only a
> few example errors are converted, and even these are incomplete, since
> I didn't know where to get the current command and used a dummy string
> for those.  Also, these are completely untested, just provided for
> RFC purposes.

OK, can I take this over? I would like to try to use this framework.

> 
> With this change, users will find some kprobe_events errors in
> tracing/error_log instead of dmesg.

Yes, that is much better, especially for ftracetest.


Thank you,


> 
> TODO: If acceptable, convert all the rest of the kprobe errors and
> figure out how to get the actual cmd logged along with the error.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_probe.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 9962cb5da8ac..3d7b195c943b 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -13,6 +13,22 @@
>  
>  #include "trace_probe.h"
>  
> +#define ERRORS								\
> +	C(NONE,			"No error"),				\
> +	C(INVALID_STRING_SPEC,	"string only accepts memory or address."), \
> +	C(ARG_TOO_LONG,		"Argument is too long."),		\
> +	C(INVALID_ARG_NAME,	"Invalid argument name"),
> +
> +#undef C
> +#define C(a, b)		KPROBE_ERR_##a
> +
> +enum { ERRORS };
> +
> +#undef C
> +#define C(a, b)		b
> +
> +static const char *err_text[] = { ERRORS };
> +
>  const char *reserved_field_names[] = {
>  	"common_type",
>  	"common_flags",
> @@ -384,7 +400,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>  	int ret, len;
>  
>  	if (strlen(arg) > MAX_ARGSTR_LEN) {
> -		pr_info("Argument is too long.: %s\n",  arg);
> +		tracing_log_err("kprobe_events", "replace this with command", err_text, KPROBE_ERR_ARG_TOO_LONG, err_pos("command", arg));
>  		return -ENOSPC;
>  	}
>  	parg->comm = kstrdup(arg, GFP_KERNEL);
> @@ -443,7 +459,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>  	if (!strcmp(parg->type->name, "string")) {
>  		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_IMM &&
>  		    code->op != FETCH_OP_COMM) {
> -			pr_info("string only accepts memory or address.\n");
> +			tracing_log_err("kprobe_events", "replace this with command", err_text, KPROBE_ERR_INVALID_STRING_SPEC, 0);
> +
>  			ret = -EINVAL;
>  			goto fail;
>  		}
> @@ -558,8 +575,7 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, char *arg,
>  		return -ENOMEM;
>  
>  	if (!is_good_name(parg->name)) {
> -		pr_info("Invalid argument[%d] name: %s\n",
> -			i, parg->name);
> +		tracing_log_err("kprobe_events", "replace this with command", err_text, KPROBE_ERR_INVALID_ARG_NAME, err_pos("cmd", parg->name));
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
