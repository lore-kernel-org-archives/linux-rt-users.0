Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41DFC433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9264664D9F
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhBQDvw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBQDvu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:51:50 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4529C0613D6
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:51:10 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h16so8629395qth.11
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=HMqd63wNeBy65lDsbU5wCvTEfZtYlYGmI9Qufi15rYU=;
        b=ME/iOZjkybthQssg+xtphgSnanzCpdSHiPFqX5r6cOHfJ7q0X2+3Y1FMm1eeaaGcmM
         dWFxTbaMX92+PZ8gVAAQuoGvTozo4XYXUYls20L5zfrKfMdU/T19Zvavc8oWJeedau/D
         +cgd+lFQ9LqBzTbEgB9UkkwPBq3M+YoOEuS8pmwvIv1T/QoTAadk4f9u+FD08/X542Cd
         tf4VxJsAcdxk9072LZV3oPF7nu2kSxbKf1OFvDVlxKy0u/BwYNgTqY8GTWHL9vjxjf7s
         6/pqwOxFli/9bOt8JMlSbDqpXb1m2CKN0n/To6MvO8Lx98AwF4YQaykb8NEY2yuGzmcF
         syXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=HMqd63wNeBy65lDsbU5wCvTEfZtYlYGmI9Qufi15rYU=;
        b=HUgLxy0t7FXfChCjcrTjNoEc/GTk2cbKlCDowuR8A4uo5bp57bfahE8VfeC8xHvj8Z
         0iLSkZFLFyUY4wcvq4O/+0KWeE23IkdcQIRv7sxr4TZp0EzuF8rWAoCgMHnj8/Rs7Noo
         TSpx4+D4AFEvt58GZzRvvxX1PGbvggVvc8stkHjlxfrXytAgSSf963AhMNMnDLzdvqXF
         bkXV3KbvB0muiFWKxgArY779RXwwzr+ryUTkN6JV0StKjdfz4YcTijKS3pdV779EvT06
         K7us2uCb9cTaVrPpXbnBTjTBuebjvkvHlIu64735hQwDo3uMGr0w/4ezyiEyy9ywnBlf
         4gtQ==
X-Gm-Message-State: AOAM530wakL8KN7teN2/C+YmB3dbepKEcgY2qPu+/EcQWwT2MzOH0cDa
        B0eeEUpLEf2zl0dgnQHXWGU=
X-Google-Smtp-Source: ABdhPJzAydpuPITzh5b6KCawTwwRwGnNRGrksRtTuui4QCxJ/hoduV9T7LkmyBb04KYbpcGaVjGnmg==
X-Received: by 2002:ac8:7512:: with SMTP id u18mr21251199qtq.290.1613533869852;
        Tue, 16 Feb 2021 19:51:09 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id u27sm810266qku.82.2021.02.16.19.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:51:09 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:51:08 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v5 06/13] cyclicdeadline: Add JSON output
 feature
In-Reply-To: <20210210175118.19709-7-dwagner@suse.de>
Message-ID: <5d53d1f-1db9-90d9-2eea-6b4ebd164d@redhat.com>
References: <20210210175118.19709-1-dwagner@suse.de> <20210210175118.19709-7-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 10 Feb 2021, Daniel Wagner wrote:

> Write the test results as JSON output to a file. This allows to
> simplifies any parsing later on.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 72 ++++++++++++++++++++++-------
>  1 file changed, 56 insertions(+), 16 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 71cde5781499..ed3c960d9916 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -18,6 +18,7 @@
>  #include <errno.h>
>  #include <signal.h>
>  #include <getopt.h>
> +#include <inttypes.h>
>  
>  #include <sys/syscall.h>
>  #include <sys/types.h>
> @@ -85,13 +86,11 @@ static pthread_barrier_t barrier;
>  
>  static int cpu_count;
>  static int all_cpus;
> -
>  static int nr_threads;
>  static int use_nsecs;
> -
>  static int mark_fd;
> -
>  static int quiet;
> +static char outfile[MAX_PATH];
>  
>  static int find_mount(const char *mount, char *debugfs)
>  {
> @@ -603,16 +602,17 @@ static void usage(int error)
>  	       "                           tasks on. An empty CPUSET runs on all CPUs a deadline\n"
>  	       "                           task.\n"
>  	       "                           on CPU 4, and thread #5 on CPU 5.\n"
> -	       "-D TIME     --duration     Specify a length for the test run.\n"
> +	       "-D TIME  --duration        Specify a length for the test run.\n"
>  	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
>  	       "                           days\n"
> -	       "-h          --help         Show this help menu.\n"
> -	       "-i INTV     --interval     The shortest deadline for the tasks in us\n"
> +	       "-h       --help            Show this help menu.\n"
> +	       "-i INTV  --interval        The shortest deadline for the tasks in us\n"
>  	       "                           (default 1000us).\n"
> -	       "-s STEP     --step         The amount to increase the deadline for each task in us\n"
> +	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
> +	       "-s STEP  --step            The amount to increase the deadline for each task in us\n"
>  	       "                           (default 500us).\n"
> -	       "-t NUM      --threads      The number of threads to run as deadline (default 1).\n"
> -	       "-q          --quiet        print a summary only on exit\n"
> +	       "-t NUM   --threads         The number of threads to run as deadline (default 1).\n"
> +	       "-q       --quiet           print a summary only on exit\n"
>  	       );
>  	exit(error);
>  }
> @@ -966,6 +966,32 @@ static void loop(struct sched_data *sched_data, int nr_threads)
>  	}
>  }
>  
> +static void write_stats(FILE *f, void *data)
> +{
> +	struct sched_data *sd = data;
> +	struct thread_stat *s;
> +	unsigned int i;
> +
> +	fprintf(f, "  \"num_threads\": %d,\n", nr_threads);
> +	fprintf(f, "  \"resolution_in_ns\": %u,\n", use_nsecs);
> +	fprintf(f, "  \"thread\": {\n");
> +	for (i = 0; i < nr_threads; i++) {
> +		s = &sd[i].stat;
> +		fprintf(f, "    \"%u\": {\n", i);
> +		fprintf(f, "	 \"cycles\": %" PRIu64 ",\n", s->cycles);
> +		fprintf(f, "	 \"min\": %" PRIu64 ",\n", s->min);
> +		fprintf(f, "	 \"max\": %" PRIu64 ",\n", s->max);
> +		fprintf(f, "	 \"avg\": %.2f\n", s->avg/s->cycles);
> +		fprintf(f, "    }%s\n", i == nr_threads - 1 ? "" : ",");
> +	}
> +	fprintf(f, "  }\n");
> +}
> +
> +enum options_valud {
> +	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
> +	OPT_OUTPUT, OPT_STEP, OPT_THREADS, OPT_QUIET
> +};
> +
>  int main(int argc, char **argv)
>  {
>  	struct sched_data *sched_data;
> @@ -992,19 +1018,21 @@ int main(int argc, char **argv)
>  
>  	for (;;) {
>  		static struct option options[] = {
> -			{ "affinity",	optional_argument,	NULL,	'a' },
> -			{ "duration",	required_argument,	NULL,	'D' },
> -			{ "help",	no_argument,		NULL,	'h' },
> -			{ "interval",	required_argument,	NULL,	'i' },
> -			{ "step",	required_argument,	NULL,	's' },
> -			{ "threads",	required_argument,	NULL,	't' },
> -			{ "quiet",	no_argument,		NULL,	'q' },
> +			{ "affinity",	optional_argument,	NULL,	OPT_AFFINITY },
> +			{ "duration",	required_argument,	NULL,	OPT_DURATION },
> +			{ "help",	no_argument,		NULL,	OPT_HELP },
> +			{ "interval",	required_argument,	NULL,	OPT_INTERVAL },
> +			{ "output",	required_argument,	NULL,	OPT_OUTPUT },
> +			{ "step",	required_argument,	NULL,	OPT_STEP },
> +			{ "threads",	required_argument,	NULL,	OPT_THREADS },
> +			{ "quiet",	no_argument,		NULL,	OPT_QUIET },
>  			{ NULL,		0,			NULL,	0   },
>  		};
>  		c = getopt_long(argc, argv, "a::c:D:hi:s:t:q", options, NULL);
>  		if (c == -1)
>  			break;
>  		switch (c) {
> +		case OPT_AFFINITY:
>  		case 'a':
>  		case 'c':
>  			if (!nr_threads)
> @@ -1016,21 +1044,30 @@ int main(int argc, char **argv)
>  			else
>  				all_cpus = 1;
>  			break;
> +		case OPT_INTERVAL:
>  		case 'i':
>  			interval = atoi(optarg);
>  			break;
> +		case OPT_OUTPUT:
> +			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
> +		case OPT_STEP:
>  		case 's':
>  			step = atoi(optarg);
>  			break;
> +		case OPT_THREADS:
>  		case 't':
>  			nr_threads = atoi(optarg);
>  			break;
> +		case OPT_DURATION:
>  		case 'D':
>  			duration = parse_time_string(optarg);
>  			break;
> +		case OPT_QUIET:
>  		case 'q':
>  			quiet = 1;
>  			break;
> +		case OPT_HELP:
>  		case 'h':
>  			usage(0);
>  			break;
> @@ -1190,6 +1227,9 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> +	if (strlen(outfile) != 0)
> +		rt_write_json(outfile, argc, argv, write_stats, sched_data);
> +
>  	if (setcpu_buf)
>  		free(setcpu_buf);
>  	free(thread);
> -- 
> 2.30.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
