Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0FpQ5d0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A753135
	for <linux-rt-users@vger.kernel.org>; Thu, 14 Dec 2023 08:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702570268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGgWqJMkuNgi4UI+fd5XAVxCbLStMTWuHLyxun8npyE=;
	b=a0FpQ5d02H+cXrZHe8Z35bB+Px2MRNeVn35+D0S0a9Ef9uoCgXvrJRlQ2+uRxnp1d4EaKo
	DHpQxrzkPx15RBEdlk8S0u/dgTn37h4vCLLt4GC5eQ7aaQoxMcfXaOjhrzlTIrnxRegPo+
	R+CLAbRHcnB1pYAUNtDTgNBtn8bKLQU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-SOlClJ60OSSDA4oMSmx1ug-1; Thu, 14 Dec 2023 11:11:06 -0500
X-MC-Unique: SOlClJ60OSSDA4oMSmx1ug-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77f6cd3da10so647379385a.1
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Dec 2023 08:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570266; x=1703175066;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGgWqJMkuNgi4UI+fd5XAVxCbLStMTWuHLyxun8npyE=;
        b=feB2s86ieBb42D2N+jG4tXjRUzEgTOYdbExFWpxNvVXjhh5qL/bQLMijLcjOeCycon
         V/HrwDlPaWyAxHtVd32R/C85Pqn935vwkCsJHjPytcb4c7Qpusnb+VAln+d54GFPykgz
         rV3t/KyaKOr1Oc2Dx25xgtJnLcwQuO/GEuaJrPw/p0wRIfdMllDsIfU/cNztl8Ehvmd6
         u0xS0S2oJDXPqKWMOG5YwY6B9eYHVVthgsp0DVejsBOhSpDQMdwRc392BroQATJTiIuf
         EswcNNS9+St94vNMMMJYLba/jP+ncoUf/TOuy3hxy1W0LqMcDkONfPBJ4++yKrEKzEEo
         3/jw==
X-Gm-Message-State: AOJu0YzTIxUz4es7o2hr3JuHcPtSwKNfmrHyBBJCmBjYGTsV0ytQIAKs
	GlAV9yss68tAzrszuqIiGLC6JPbsLT7/8P3U2P58+7AV7ceC2VVa+Dn8siRqWFpePmRtvQgLmRp
	kL74/CMw1ylF4qdIMqWKs5lcbS9OQrv7h48M=
X-Received: by 2002:ae9:f103:0:b0:77f:9591:37f0 with SMTP id k3-20020ae9f103000000b0077f959137f0mr2990545qkg.13.1702570265914;
        Thu, 14 Dec 2023 08:11:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCMFsnTZx+ungxhKhGTVGUWQqWu7Xj6wemA/rDsQLFx8b92SCsfNXpXdfnbhzTP6Nkc6ra+A==
X-Received: by 2002:ae9:f103:0:b0:77f:9591:37f0 with SMTP id k3-20020ae9f103000000b0077f959137f0mr2990534qkg.13.1702570265590;
        Thu, 14 Dec 2023 08:11:05 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id qt6-20020a05620a8a0600b0077d8622ee6csm5394541qkn.81.2023.12.14.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:11:05 -0800 (PST)
Date: Thu, 14 Dec 2023 11:10:55 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/4] rt-tests: cyclicdeadline: Add histogram support
In-Reply-To: <20231206205508.17148-5-crwood@redhat.com>
Message-ID: <f53a25ce-fbb0-6db5-7b25-d2b6f37de59e@redhat.com>
References: <20231206205508.17148-1-crwood@redhat.com> <20231206205508.17148-5-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 6 Dec 2023, Crystal Wood wrote:

> Add support for the --histogram and --histfile options as in cyclictest.
> The short -h option is not supported, as cyclicdeadline already uses that
> for help.  -H/--histofall is not supported but could be easily added.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
> Given the recent request for oslat, do we want to be able to do ns-granularity
> histograms?  Or just stick with what cyclictest supports, as that's what rteval
> wants?

rteval will want what we teach it to want. If the hardware supports 
meaningful numbers with ns-granularity, it might make sense to include it.
start with just doing what cyclictest currently supports, but I wouldn't 
rule out adding this in the future.

> 
> Is histofall support needed?  rteval doesn't use it.

Not sure, we probably want one or the other, I suppose the idea was to not 
have the extra information if you're parsing it with another program like 
rteval but to include it otherwise. I ran it just ctrl-cing it and 
couldn't see a difference.

John

> ---
>  src/sched_deadline/cyclicdeadline.c | 113 +++++++++++++++++++++++++---
>  1 file changed, 103 insertions(+), 10 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 097e2e5d4580..f45ec3d6394b 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -33,6 +33,7 @@
>  #include "rt-utils.h"
>  #include "rt-sched.h"
>  #include "rt-error.h"
> +#include "histogram.h"
>  
>  #define _STR(x) #x
>  #define STR(x) _STR(x)
> @@ -40,6 +41,8 @@
>  #define MAXPATH 1024
>  #endif
>  
> +#define HIST_MAX	1000000
> +
>  #define CPUSET_ALL	"my_cpuset_all"
>  #define CPUSET_LOCAL	"my_cpuset"
>  
> @@ -56,16 +59,13 @@ struct thread_stat {
>  	long act;
>  	double avg;
>  	long *values;
> -	long *hist_array;
> -	long *outliers;
> +	struct histogram *hist;
>  	pthread_t thread;
>  	int threadstarted;
>  	int tid;
>  	long reduce;
>  	long redmax;
>  	long cycleofmax;
> -	long hist_overflow;
> -	long num_outliers;
>  };
>  
>  struct sched_data {
> @@ -84,6 +84,8 @@ static int info_enable;
>  static int debug_enable;
>  static int tracelimit;
>  static int trace_marker;
> +static int histogram;
> +static FILE *histfile;
>  static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
>  static pid_t break_thread_id;
>  static uint64_t break_thread_value;
> @@ -97,6 +99,8 @@ static int mark_fd;
>  static int quiet;
>  static char jsonfile[MAX_PATH];
>  
> +static struct histoset hset;
> +
>  static int find_mount(const char *mount, char *debugfs)
>  {
>  	char type[100];
> @@ -691,6 +695,10 @@ static void usage(int error)
>  	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
>  	       "                           days\n"
>  	       "-h       --help            Show this help menu.\n"
> +	       "         --histogram=US    dump a latency histogram to stdout after the run\n"
> +	       "                           US is the max latency time to be tracked in microseconds\n"
> +	       "			   This option runs all threads at the same priority.\n"
> +	       "	 --histfile=<path> dump the latency histogram to <path> instead of stdout\n"
>  	       "-i INTV  --interval        The shortest deadline for the tasks in us\n"
>  	       "                           (default 1000us).\n"
>  	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
> @@ -718,6 +726,55 @@ static u64 get_time_us(void)
>  	return time;
>  }
>  
> +static void print_hist(FILE *fp, struct sched_data *sd, int nthreads)
> +{
> +	int i;
> +	unsigned long maxmax, alloverflows;
> +
> +	fprintf(fp, "# Histogram\n");
> +	for (i = 0; i < histogram; i++) {
> +		unsigned long flags = 0;
> +
> +		fprintf(fp, "%06d ", i);
> +
> +		hset_print_bucket(&hset, fp, i, flags);
> +		fprintf(fp, "\n");
> +	}
> +	fprintf(fp, "# Min Latencies:");
> +	for (i = 0; i < nthreads; i++)
> +		fprintf(fp, " %05lu", sd[i].stat.min);
> +	fprintf(fp, "\n");
> +	fprintf(fp, "# Avg Latencies:");
> +	for (i = 0; i < nthreads; i++)
> +		fprintf(fp, " %05lu", sd[i].stat.cycles ?
> +		       (long)(sd[i].stat.avg/sd[i].stat.cycles) : 0);
> +	fprintf(fp, "\n");
> +	fprintf(fp, "# Max Latencies:");
> +	maxmax = 0;
> +	for (i = 0; i < nthreads; i++) {
> +		fprintf(fp, " %05lu", sd[i].stat.max);
> +		if (sd[i].stat.max > maxmax)
> +			maxmax = sd[i].stat.max;
> +	}
> +	fprintf(fp, "\n");
> +	fprintf(fp, "# Histogram Overflows:");
> +	alloverflows = 0;
> +	for (i = 0; i < nthreads; i++) {
> +		fprintf(fp, " %05lu", sd[i].stat.hist->oflow_count);
> +		alloverflows += sd[i].stat.hist->oflow_count;
> +	}
> +	fprintf(fp, "\n");
> +
> +	fprintf(fp, "# Histogram Overflow at cycle number:\n");
> +	for (i = 0; i < nthreads; i++) {
> +		fprintf(fp, "# Thread %d: ", i);
> +		hist_print_oflows(sd[i].stat.hist, fp);
> +		fprintf(fp, "\n");
> +	}
> +
> +	fprintf(fp, "\n");
> +}
> +
>  static void print_stat(FILE *fp, struct sched_data *sd, int index, int verbose, int quiet)
>  {
>  	struct thread_stat *stat = &sd->stat;
> @@ -784,6 +841,9 @@ static u64 do_runtime(struct sched_data *sd, u64 period)
>  	stat->act = diff;
>  	stat->avg += (double) diff;
>  
> +	if (histogram)
> +		hist_sample(stat->hist, diff);
> +
>  	stat->cycles++;
>  
>  	return next_period;
> @@ -1058,8 +1118,13 @@ static void loop(struct sched_data *sched_data, int nr_threads)
>  	if (!quiet) {
>  		printf("\033[%dB", nr_threads + 2);
>  	} else {
> -		for (i = 0; i < nr_threads; ++i)
> -			print_stat(stdout, &sched_data[i], i, 0, 0);
> +		if (histogram) {
> +			FILE *out = histfile ? histfile : stdout;
> +			print_hist(out, sched_data, nr_threads);
> +		} else {
> +			for (i = 0; i < nr_threads; ++i)
> +				print_stat(stdout, &sched_data[i], i, 0, 0);
> +		}
>  	}
>  }
>  
> @@ -1075,10 +1140,14 @@ static void write_stats(FILE *f, void *data)
>  	for (i = 0; i < nr_threads; i++) {
>  		s = &sd[i].stat;
>  		fprintf(f, "    \"%u\": {\n", i);
> -		fprintf(f, "	 \"cycles\": %ld,\n", s->cycles);
> -		fprintf(f, "	 \"min\": %ld,\n", s->min);
> -		fprintf(f, "	 \"max\": %ld,\n", s->max);
> -		fprintf(f, "	 \"avg\": %.2f\n", s->avg/s->cycles);
> +
> +		fprintf(f, "      \"histogram\": {");
> +		hist_print_json(s->hist, f);
> +		fprintf(f, "      },\n");
> +		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
> +		fprintf(f, "      \"min\": %ld,\n", s->min);
> +		fprintf(f, "      \"max\": %ld,\n", s->max);
> +		fprintf(f, "      \"avg\": %.2f\n", s->avg/s->cycles);
>  		fprintf(f, "    }%s\n", i == nr_threads - 1 ? "" : ",");
>  	}
>  	fprintf(f, "  }\n");
> @@ -1088,6 +1157,7 @@ enum options_values {
>  	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
>  	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET,
>  	OPT_BREAKTRACE, OPT_TRACEMARK, OPT_INFO, OPT_DEBUG,
> +	OPT_HISTOGRAM, OPT_HISTFILE
>  };
>  
>  int main(int argc, char **argv)
> @@ -1130,6 +1200,8 @@ int main(int argc, char **argv)
>  			{ "tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
>  			{ "verbose",	no_argument,	NULL,	OPT_INFO},
>  			{ "debug",	no_argument, 	NULL, 	OPT_DEBUG},
> +			{ "histogram",	required_argument, NULL, OPT_HISTOGRAM },
> +			{ "histfile",	required_argument, NULL, OPT_HISTFILE },
>  			{ NULL,		0,			NULL,	0   },
>  		};
>  		c = getopt_long(argc, argv, "a::c:D:hi:s:t:b:q", options, NULL);
> @@ -1188,6 +1260,17 @@ int main(int argc, char **argv)
>  		case OPT_DEBUG:
>  			debug_enable = 1;
>  			break;
> +		case OPT_HISTOGRAM:
> +			histogram = atoi(optarg);
> +			if (histogram <= 0 || histogram > HIST_MAX)
> +				usage(1);
> +			break;
> +		case OPT_HISTFILE:
> +			histfile = fopen(optarg, "w");
> +			if (!histfile)
> +				fatal("Couldn\'t open histfile %s: %s\n",
> +				      optarg, strerror(errno));
> +			break;
>  		default:
>  			usage(1);
>  		}
> @@ -1233,6 +1316,10 @@ int main(int argc, char **argv)
>  	if (!thread || !sched_data)
>  		fatal("allocating threads");
>  
> +	if (histogram && hset_init(&hset, nr_threads, 1, histogram, histogram))
> +		fatal("failed to allocate histogram of size %d for %d threads\n",
> +		      histogram, nr_threads);
> +
>  	if (nr_threads > nr_cpus) {
>  		/*
>  		 * More threads than CPUs, then have the total be
> @@ -1262,6 +1349,9 @@ int main(int argc, char **argv)
>  		sd->runtime_us = runtime;
>  		sd->deadline_us = interval;
>  
> +		if (histogram)
> +			sd->stat.hist = &hset.histos[i];
> +
>  		info(info_enable, "interval: %lld:%lld\n", sd->runtime_us, sd->deadline_us);
>  
>  		/* Make sure that we can make our deadlines */
> @@ -1356,6 +1446,9 @@ int main(int argc, char **argv)
>  		free(setcpu_buf);
>  	free(thread);
>  	free(sched_data);
> +	if (histfile)
> +		fclose(histfile);
> +	hset_destroy(&hset);
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 
> 
> 

