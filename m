From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3] cyclictest: add --tracemark option
Date: Thu, 24 Mar 2016 15:17:19 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603241516290.8641@riemann>
References: <20160322132708.20a79023@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34888 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756823AbcCXORb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Mar 2016 10:17:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id s187so3197294wme.2
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2016 07:17:30 -0700 (PDT)
In-Reply-To: <20160322132708.20a79023@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 22 Mar 2016, Luiz Capitulino wrote:

> cyclictest will only write to /sys/kernel/debug/tracing/trace_maker
> if it's also setup to do tracing. This conflicts with
> running cyclictest under trace-cmd.
> 
> The --tracemark option tells cyclictest to write to the
> trace_marker file even when it's not doing tracing.
> 
> It can be used like this:
> 
>  # trace-cmd record [...] cyclictest [...] -bX --tracemark --notrace
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> ---
> 
> John, I hope this is what you asked me to do.
> 
> o v3
> 
>  - Rebased on top of latest devel/v0.97 (HEAD a638701)
>  - Add missing help text
> 
>  src/cyclictest/cyclictest.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index b9571f5..4844dfa 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -202,6 +202,7 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts);
>  static int shutdown;
>  static int tracelimit = 0;
>  static int notrace = 0;
> +static int trace_marker = 0;
>  static int ftrace = 0;
>  static int kernelversion;
>  static int verbose = 0;
> @@ -561,6 +562,18 @@ static void debugfs_prepare(void)
>  		fileprefix = procfileprefix;
>  }
>  
> +static void enable_trace_mark(void)
> +{
> +	if (!trace_marker)
> +		return;
> +
> +	if (!tracelimit)
> +		fatal("--tracemark requires -b\n");
> +
> +	debugfs_prepare();
> +	open_tracemark_fd();
> +}
> +
>  static void setup_tracer(void)
>  {
>  	if (!tracelimit || notrace)
> @@ -1312,6 +1325,7 @@ static void display_help(int error)
>  	       "-t [NUM] --threads=NUM     number of threads:\n"
>  	       "                           without NUM, threads = max_cpus\n"
>  	       "                           without -t default = 1\n"
> +	       "         --tracemark       write a trace mark when -b latency is exceeded\n"
>  	       "-T TRACE --tracer=TRACER   set tracing function\n"
>  	       "    configured tracers: %s\n"
>  	       "-u       --unbuffered      force unbuffered output for live processing\n"
> @@ -1453,7 +1467,7 @@ enum option_values {
>  	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRACER, OPT_TRIGGER,
>  	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP,
>  	OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
> -	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
> +	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI, OPT_TRACEMARK,
>  };
>  
>  /* Process commandline options */
> @@ -1508,6 +1522,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  			{"spike",	     required_argument, NULL, OPT_TRIGGER },
>  			{"spike-nodes",	     required_argument, NULL, OPT_TRIGGER_NODES },
>  			{"threads",          optional_argument, NULL, OPT_THREADS },
> +			{"tracemark",        no_argument,       NULL, OPT_TRACEMARK },
>  			{"tracer",           required_argument, NULL, OPT_TRACER },
>  			{"unbuffered",       no_argument,       NULL, OPT_UNBUFFERED },
>  			{"numa",             no_argument,       NULL, OPT_NUMA },
> @@ -1749,6 +1764,8 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  			fatal("--smi is not available on your arch\n");
>  #endif
>  			break;
> +		case OPT_TRACEMARK:
> +			trace_marker = 1; break;
>  		}
>  	}
>  
> @@ -2184,6 +2201,8 @@ int main(int argc, char **argv)
>  
>  	setup_tracer();
>  
> +	enable_trace_mark();
> +
>  	if (check_timer())
>  		warn("High resolution timers not available\n");
>  
> -- 
> 2.1.0
> 
> --


Signed-off-by: John Kacur <jkacur@redhat.com>
