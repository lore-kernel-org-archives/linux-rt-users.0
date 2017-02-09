From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 08/21] tracing: Make traceprobe parsing code
 reusable
Date: Thu, 9 Feb 2017 15:40:44 -0500
Message-ID: <20170209154044.0926a013@gandalf.local.home>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
        <b0fb1a112132ba195029ec5d83a9e8c29bb79029.1486569306.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbdBIUn0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Feb 2017 15:43:26 -0500
In-Reply-To: <b0fb1a112132ba195029ec5d83a9e8c29bb79029.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed,  8 Feb 2017 11:25:04 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> traceprobe_probes_write() and traceprobe_command() actually contain
> nothing that ties them to kprobes - the code is generically useful for
> similar types of parsing elsewhere, so separate it out and move it to
> trace.c/trace.h.
> 
> Other than moving it, the only change is in naming:
> traceprobe_probes_write() becomes trace_parse_run_command() and
> traceprobe_command() becomes trace_run_command().
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace.c        | 75 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace.h        |  7 +++++
>  kernel/trace/trace_kprobe.c | 18 +++++------
>  kernel/trace/trace_probe.c  | 75 ---------------------------------------------
>  kernel/trace/trace_probe.h  |  7 -----
>  kernel/trace/trace_uprobe.c |  2 +-
>  6 files changed, 92 insertions(+), 92 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 5868656..78dff2f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7912,6 +7912,81 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
>  }
>  EXPORT_SYMBOL_GPL(ftrace_dump);
>  
> +int trace_run_command(const char *buf, int (*createfn)(int, char **))
> +{
> +	char **argv;
> +	int argc, ret;
> +
> +	argc = 0;
> +	ret = 0;
> +	argv = argv_split(GFP_KERNEL, buf, &argc);
> +	if (!argv)
> +		return -ENOMEM;
> +
> +	if (argc)
> +		ret = createfn(argc, argv);
> +
> +	argv_free(argv);
> +
> +	return ret;
> +}
> +
> +#define WRITE_BUFSIZE  4096
> +
> +ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
> +				size_t count, loff_t *ppos,
> +				int (*createfn)(int, char **))
> +{
> +	char *kbuf, *tmp;
> +	int ret = 0;
> +	size_t done = 0;
> +	size_t size;
> +
> +	kbuf = kmalloc(WRITE_BUFSIZE, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	while (done < count) {
> +		size = count - done;
> +
> +		if (size >= WRITE_BUFSIZE)
> +			size = WRITE_BUFSIZE - 1;
> +
> +		if (copy_from_user(kbuf, buffer + done, size)) {

OK, I'm looking at this code now, and I really dislike how we do a
copy_from_user() at every iteration even when not necessary.

I'm going to fix this in the trace_probe.c file, so giving you a heads
up, that my change will conflict with this patch.

-- Steve

> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		kbuf[size] = '\0';
> +		tmp = strchr(kbuf, '\n');
> +
> +		if (tmp) {
> +			*tmp = '\0';
> +			size = tmp - kbuf + 1;
> +		} else if (done + size < count) {
> +			pr_warn("Line length is too long: Should be less than %d\n",
> +				WRITE_BUFSIZE);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		done += size;
> +		/* Remove comments */
> +		tmp = strchr(kbuf, '#');
> +
> +		if (tmp)
> +			*tmp = '\0';
> +
> +		ret = trace_run_command(kbuf, createfn);
> +		if (ret)
> +			goto out;
> +	}
> +	ret = done;
> +
> +out:
> +	kfree(kbuf);
> +
> +	return ret;
> +}
> +
>  __init static int tracer_alloc_buffers(void)
>  {
>  	int ring_buf_size;
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index ac55fa1..f2af21b 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1647,6 +1647,13 @@ extern int trace_event_enable_disable(struct trace_event_file *file,
>  int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set);
>  int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
>  
> +#define MAX_EVENT_NAME_LEN	64
> +
> +extern int trace_run_command(const char *buf, int (*createfn)(int, char**));
> +extern ssize_t trace_parse_run_command(struct file *file,
> +		const char __user *buffer, size_t count, loff_t *ppos,
> +		int (*createfn)(int, char**));
> +
>  /*
>   * Normal trace_printk() and friends allocates special buffers
>   * to do the manipulation, as well as saves the print formats
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index a133ecd..8f3b4d9 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -876,8 +876,8 @@ static int probes_open(struct inode *inode, struct file *file)
>  static ssize_t probes_write(struct file *file, const char __user *buffer,
>  			    size_t count, loff_t *ppos)
>  {
> -	return traceprobe_probes_write(file, buffer, count, ppos,
> -			create_trace_kprobe);
> +	return trace_parse_run_command(file, buffer, count, ppos,
> +				       create_trace_kprobe);
>  }
>  
>  static const struct file_operations kprobe_events_ops = {
> @@ -1402,9 +1402,9 @@ static __init int kprobe_trace_self_tests_init(void)
>  
>  	pr_info("Testing kprobe tracing: ");
>  
> -	ret = traceprobe_command("p:testprobe kprobe_trace_selftest_target "
> -				  "$stack $stack0 +0($stack)",
> -				  create_trace_kprobe);
> +	ret = trace_run_command("p:testprobe kprobe_trace_selftest_target "
> +				"$stack $stack0 +0($stack)",
> +				create_trace_kprobe);
>  	if (WARN_ON_ONCE(ret)) {
>  		pr_warn("error on probing function entry.\n");
>  		warn++;
> @@ -1424,8 +1424,8 @@ static __init int kprobe_trace_self_tests_init(void)
>  		}
>  	}
>  
> -	ret = traceprobe_command("r:testprobe2 kprobe_trace_selftest_target "
> -				  "$retval", create_trace_kprobe);
> +	ret = trace_run_command("r:testprobe2 kprobe_trace_selftest_target "
> +				"$retval", create_trace_kprobe);
>  	if (WARN_ON_ONCE(ret)) {
>  		pr_warn("error on probing function return.\n");
>  		warn++;
> @@ -1495,13 +1495,13 @@ static __init int kprobe_trace_self_tests_init(void)
>  			disable_trace_kprobe(tk, file);
>  	}
>  
> -	ret = traceprobe_command("-:testprobe", create_trace_kprobe);
> +	ret = trace_run_command("-:testprobe", create_trace_kprobe);
>  	if (WARN_ON_ONCE(ret)) {
>  		pr_warn("error on deleting a probe.\n");
>  		warn++;
>  	}
>  
> -	ret = traceprobe_command("-:testprobe2", create_trace_kprobe);
> +	ret = trace_run_command("-:testprobe2", create_trace_kprobe);
>  	if (WARN_ON_ONCE(ret)) {
>  		pr_warn("error on deleting a probe.\n");
>  		warn++;
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 8c0553d..b7de026 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -622,81 +622,6 @@ void traceprobe_free_probe_arg(struct probe_arg *arg)
>  	kfree(arg->comm);
>  }
>  
> -int traceprobe_command(const char *buf, int (*createfn)(int, char **))
> -{
> -	char **argv;
> -	int argc, ret;
> -
> -	argc = 0;
> -	ret = 0;
> -	argv = argv_split(GFP_KERNEL, buf, &argc);
> -	if (!argv)
> -		return -ENOMEM;
> -
> -	if (argc)
> -		ret = createfn(argc, argv);
> -
> -	argv_free(argv);
> -
> -	return ret;
> -}
> -
> -#define WRITE_BUFSIZE  4096
> -
> -ssize_t traceprobe_probes_write(struct file *file, const char __user *buffer,
> -				size_t count, loff_t *ppos,
> -				int (*createfn)(int, char **))
> -{
> -	char *kbuf, *tmp;
> -	int ret = 0;
> -	size_t done = 0;
> -	size_t size;
> -
> -	kbuf = kmalloc(WRITE_BUFSIZE, GFP_KERNEL);
> -	if (!kbuf)
> -		return -ENOMEM;
> -
> -	while (done < count) {
> -		size = count - done;
> -
> -		if (size >= WRITE_BUFSIZE)
> -			size = WRITE_BUFSIZE - 1;
> -
> -		if (copy_from_user(kbuf, buffer + done, size)) {
> -			ret = -EFAULT;
> -			goto out;
> -		}
> -		kbuf[size] = '\0';
> -		tmp = strchr(kbuf, '\n');
> -
> -		if (tmp) {
> -			*tmp = '\0';
> -			size = tmp - kbuf + 1;
> -		} else if (done + size < count) {
> -			pr_warn("Line length is too long: Should be less than %d\n",
> -				WRITE_BUFSIZE);
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		done += size;
> -		/* Remove comments */
> -		tmp = strchr(kbuf, '#');
> -
> -		if (tmp)
> -			*tmp = '\0';
> -
> -		ret = traceprobe_command(kbuf, createfn);
> -		if (ret)
> -			goto out;
> -	}
> -	ret = done;
> -
> -out:
> -	kfree(kbuf);
> -
> -	return ret;
> -}
> -
>  static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
>  			   bool is_return)
>  {
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 0c0ae54..37ab38c 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -42,7 +42,6 @@
>  
>  #define MAX_TRACE_ARGS		128
>  #define MAX_ARGSTR_LEN		63
> -#define MAX_EVENT_NAME_LEN	64
>  #define MAX_STRING_SIZE		PATH_MAX
>  
>  /* Reserved field names */
> @@ -356,12 +355,6 @@ extern int traceprobe_conflict_field_name(const char *name,
>  
>  extern int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset);
>  
> -extern ssize_t traceprobe_probes_write(struct file *file,
> -		const char __user *buffer, size_t count, loff_t *ppos,
> -		int (*createfn)(int, char**));
> -
> -extern int traceprobe_command(const char *buf, int (*createfn)(int, char**));
> -
>  /* Sum up total data length for dynamic arraies (strings) */
>  static nokprobe_inline int
>  __get_data_size(struct trace_probe *tp, struct pt_regs *regs)
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 4f2ba2b..10e3ec8 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -649,7 +649,7 @@ static int probes_open(struct inode *inode, struct file *file)
>  static ssize_t probes_write(struct file *file, const char __user *buffer,
>  			    size_t count, loff_t *ppos)
>  {
> -	return traceprobe_probes_write(file, buffer, count, ppos, create_trace_uprobe);
> +	return trace_parse_run_command(file, buffer, count, ppos, create_trace_uprobe);
>  }
>  
>  static const struct file_operations uprobe_events_ops = {

