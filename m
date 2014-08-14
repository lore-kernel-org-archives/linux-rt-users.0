From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 6/6] cyclictest: Add long option --laptop to preserve
 battery power
Date: Thu, 14 Aug 2014 18:38:06 +0200 (CEST)
Message-ID: <alpine.LFD.2.10.1408141837200.25171@riemann>
References: <1408033090-24866-1-git-send-email-jkacur@redhat.com> <1408033090-24866-7-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:58249 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbaHNQi2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Aug 2014 12:38:28 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so1329955wes.25
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Aug 2014 09:38:26 -0700 (PDT)
In-Reply-To: <1408033090-24866-7-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 14 Aug 2014, John Kacur wrote:

> Some people running cyclictest on laptops don't want to automatically
> take advantage of the trick that prevents the power management to
> transistion to high cstates, since it eats up their battery power.
> 
> Allow them to suppress this feature with --laptop
> 
> This will result in power latency results of course.

The above should read: "This will result in poorer latency results of 
course."
> 
> Feature-requested-by:  Joakim Hernberg <jhernberg@alchemy.lu>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index b45041e01f3a..a3e7b1d6c377 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -186,6 +186,7 @@ static int use_fifo = 0;
>  static pthread_t fifo_threadid;
>  static int aligned = 0;
>  static int offset = 0;
> +static int laptop = 0;
>  
>  static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
>  static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER;
> @@ -235,6 +236,11 @@ static void set_latency_target(void)
>  	struct stat s;
>  	int err;
>  
> +	if (laptop) {
> +		warn("not setting cpu_dma_latency to save battery power\n");
> +		return;
> +	}
> +
>  	errno = 0;
>  	err = stat("/dev/cpu_dma_latency", &s);
>  	if (err == -1) {
> @@ -1020,6 +1026,9 @@ static void display_help(int error)
>  	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
>  	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> +	       "	 --laptop	   Save battery when running cyclictest\n"
> +	       "			   This will give you poorer realtime results\n"
> +	       "			   but will not drain your battery so quickly\n"
>  	       "-m       --mlockall        lock current and future memory allocations\n"
>  	       "-M       --refresh_on_max  delay updating the screen until a new max latency is hit\n"
>  	       "-n       --nanosleep       use clock_nanosleep\n"
> @@ -1183,7 +1192,7 @@ enum option_values {
>  	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION, OPT_SYSTEM,
>  	OPT_SMP, OPT_THREADS, OPT_TRACER, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
>  	OPT_WAKEUP, OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
> -	OPT_ALIGNED,
> +	OPT_ALIGNED, OPT_LAPTOP,
>  };
>  
>  /* Process commandline options */
> @@ -1216,6 +1225,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  			{"histofall",        required_argument, NULL, OPT_HISTOFALL },
>  			{"interval",         required_argument, NULL, OPT_INTERVAL },
>  			{"irqsoff",          no_argument,       NULL, OPT_IRQSOFF },
> +			{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
>  			{"loops",            required_argument, NULL, OPT_LOOPS },
>  			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
>  			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
> @@ -1445,6 +1455,8 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  			handlepolicy(optarg); break;
>  		case OPT_DBGCYCLIC:
>  			ct_debug = 1; break;
> +		case OPT_LAPTOP:
> +			laptop = 1; break;
>  		}
>  	}
>  
> -- 
> 1.8.1.4
> 
> 
