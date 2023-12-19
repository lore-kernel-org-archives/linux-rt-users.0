Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E4D2DF84
	for <linux-rt-users@vger.kernel.org>; Tue, 19 Dec 2023 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSKSJTk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703007578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y9ud1kmhIgbNL+EA/79W4FzheMxqcTEvklRbwfe1C6s=;
	b=SSKSJTk/X46uHUsBqX43tCrudadTyJvdikpCvId5nvO315/bDZtlp8D6q7n+so/14n/75H
	LOxLp/O3v+OUQaaaLeJ7HFxEv94izMpvRrKvBtCovITOYdLF9NsMfCdi4nd6OXF2aH/FUF
	0tlJbtm18eFczszVpeC1lFTcCRq5e3Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-7rZgEYAZP9qTjkyLThAG5A-1; Tue, 19 Dec 2023 12:39:36 -0500
X-MC-Unique: 7rZgEYAZP9qTjkyLThAG5A-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67f27673b1dso45121706d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Dec 2023 09:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007576; x=1703612376;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9ud1kmhIgbNL+EA/79W4FzheMxqcTEvklRbwfe1C6s=;
        b=KEYRf57+JwwoY3sfdNUX1fqPFfTLDQmz60P5TK3MhbX0+6yhaE2v9CzXCC+pOBRjOJ
         /kWkRkJQddbw8XtYiPvl0bCl1Io40ps9H+FaEr6IHos63OM0ssl6bhaLB/1LlS9q0chE
         rLcdV1Hcs7V2kNuPJkQMemwDZw908d2Yihm9nH8iyUw5lBML2ss4zwwyo2G55zE6MnM0
         cd9i7jP2Qq0JrtaHy6f5YGVNP1LKW0IKKywu3tBUO5dUA/MWrveV2SGMHJsxQKeIuV1f
         N4ma/nmFFAXTSCUC6AbB6BWqfYu0mtHMbxNO0CAwdklWDKkclogRmYRdi00R8UFUse4w
         24sg==
X-Gm-Message-State: AOJu0Yz1g6ND+VuwlujDsO/UKDRANWbvAofS5L0ACneZgtKHRJXSGe3T
	FDN9e7+qlTW7Pn9FgvuANKUxdBYs3hAB0jp5zoi/m5bYJ4ZxzNLMeddLVaPieiwNsdRTJq+K3oA
	oswsItzKPhCki9C+aDGjFYgt918k=
X-Received: by 2002:a05:6214:1bcc:b0:67f:5abe:8393 with SMTP id m12-20020a0562141bcc00b0067f5abe8393mr2206465qvc.4.1703007576442;
        Tue, 19 Dec 2023 09:39:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHhvAIhDb+k3eqdAdfKdulBKb5+b8qqh/0EwF3JQTR0hphJwImF+T+/nMzwIh6g28R3OXyTg==
X-Received: by 2002:a05:6214:1bcc:b0:67f:5abe:8393 with SMTP id m12-20020a0562141bcc00b0067f5abe8393mr2206452qvc.4.1703007576051;
        Tue, 19 Dec 2023 09:39:36 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id v10-20020a0cf90a000000b0067f64c06bcesm413247qvn.102.2023.12.19.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:39:35 -0800 (PST)
Date: Tue, 19 Dec 2023 12:39:26 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/2] rt-tests: cyclicdeadline: Add histogram support
In-Reply-To: <20231219033750.334327-3-crwood@redhat.com>
Message-ID: <652c9d32-74a0-9d9d-d794-4382b945385f@redhat.com>
References: <20231219033750.334327-1-crwood@redhat.com> <20231219033750.334327-3-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 18 Dec 2023, Crystal Wood wrote:

> Add support for the --histogram and --histfile options as in cyclictest.
> The short -h option is not supported, as cyclicdeadline already uses that
> for help.  -H/--histofall is not supported but could be easily added.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
> v2: Fix a checkpatch warning
> 
>  src/sched_deadline/cyclicdeadline.c | 114 +++++++++++++++++++++++++---
>  1 file changed, 104 insertions(+), 10 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 097e2e5d4580..e449be57870e 100644
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
> @@ -1058,8 +1118,14 @@ static void loop(struct sched_data *sched_data, int nr_threads)
>  	if (!quiet) {
>  		printf("\033[%dB", nr_threads + 2);
>  	} else {
> -		for (i = 0; i < nr_threads; ++i)
> -			print_stat(stdout, &sched_data[i], i, 0, 0);
> +		if (histogram) {
> +			FILE *out = histfile ? histfile : stdout;
> +
> +			print_hist(out, sched_data, nr_threads);
> +		} else {
> +			for (i = 0; i < nr_threads; ++i)
> +				print_stat(stdout, &sched_data[i], i, 0, 0);
> +		}
>  	}
>  }
>  
> @@ -1075,10 +1141,14 @@ static void write_stats(FILE *f, void *data)
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
> @@ -1088,6 +1158,7 @@ enum options_values {
>  	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
>  	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET,
>  	OPT_BREAKTRACE, OPT_TRACEMARK, OPT_INFO, OPT_DEBUG,
> +	OPT_HISTOGRAM, OPT_HISTFILE
>  };
>  
>  int main(int argc, char **argv)
> @@ -1130,6 +1201,8 @@ int main(int argc, char **argv)
>  			{ "tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
>  			{ "verbose",	no_argument,	NULL,	OPT_INFO},
>  			{ "debug",	no_argument, 	NULL, 	OPT_DEBUG},
> +			{ "histogram",	required_argument, NULL, OPT_HISTOGRAM },
> +			{ "histfile",	required_argument, NULL, OPT_HISTFILE },
>  			{ NULL,		0,			NULL,	0   },
>  		};
>  		c = getopt_long(argc, argv, "a::c:D:hi:s:t:b:q", options, NULL);
> @@ -1188,6 +1261,17 @@ int main(int argc, char **argv)
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
> @@ -1233,6 +1317,10 @@ int main(int argc, char **argv)
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
> @@ -1262,6 +1350,9 @@ int main(int argc, char **argv)
>  		sd->runtime_us = runtime;
>  		sd->deadline_us = interval;
>  
> +		if (histogram)
> +			sd->stat.hist = &hset.histos[i];
> +
>  		info(info_enable, "interval: %lld:%lld\n", sd->runtime_us, sd->deadline_us);
>  
>  		/* Make sure that we can make our deadlines */
> @@ -1356,6 +1447,9 @@ int main(int argc, char **argv)
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
Signed-off-by: John Kacur <jkacur@redhat.com>

