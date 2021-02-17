Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E7C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE14864DF3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhBQDwt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhBQDwr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:52:47 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67A8C061574
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:52:07 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 81so11653050qkf.4
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=wb1H7P8dbUvy0Kk+fPncv+Z/5kxVloYbJB2QFj5+K7Y=;
        b=O08/WB7xpNdB0FMEOHRYSWIUsM3siKVhI38xmGVtLKo6tk+qSWaNYsmL26VykR2/lg
         PQLJ4+m6HsJ9aBWQrTm7DLf0ylkeTPyiMSIKRFN5WTg8zZSQVdcUVCPe02mv/t7KOQ/8
         nUPt4+52jDx01wRQhhicOK/jTUzGpn7EXswb8yFwqS2K1GFNjs8XduDdEidCtirJwUmD
         HYq9yqti5G3w20rdd9BIf2upf9lPU8zEfIrYZRnMdRvRz30NkEsRcCjLN58N6xAxdu5Q
         B0koR6d2Fus/5lFpJHzs1IJ2Rh1RrRkya240wGWJxna+fdAErQtnblqKWiU/a3RRFeHi
         rZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=wb1H7P8dbUvy0Kk+fPncv+Z/5kxVloYbJB2QFj5+K7Y=;
        b=NrdNxFcNWecRKPRAm/qZ4YeVctGSbG4KvzvS9eraPI2Ti3biyrM5w+CXcsvU8M9Z7T
         ETvrUujIHRUkL8ZDbLYUoJ9QcfIdMnKE/m8airL47oQPoD5FQlptk5vxLE1e15VCoF3T
         Bkjw5+ViAPHjybx8SHrgk0vW1htom6f5NZPwyZhbb6ImYwLPP0s9kyd7glTB04ItkZtg
         7B4dgxkJIkhmUKEn/Ak8yPOOVL/TLx9+DxCwb2fE/715IIgXNkuhSH8hf9Hb2MPpHRfW
         hjYOPSTERueq5ZR5Z6QT6dTjWusoXsHhfC5yBI2ljwZwTxRa9r8v3myxXP65Ln6LDIIr
         ksCw==
X-Gm-Message-State: AOAM5312E3GPUnUrlx3FM283PKYNANKCvwWBjfg0FUWL8PsT7zxU3rt4
        hFucFEdhOZOvc4t8iei0Wbgde57Mzh27aA==
X-Google-Smtp-Source: ABdhPJyo2r5WynhwdUqh4xKkuv4bGl0ShdEKDTW7CjH+j/ZPXIBD/yE2Yz4b60xT9STJ9wb0yUkWXg==
X-Received: by 2002:a05:620a:2041:: with SMTP id d1mr22617348qka.326.1613533927016;
        Tue, 16 Feb 2021 19:52:07 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id 14sm413942qtx.84.2021.02.16.19.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:52:06 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:52:06 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v5 12/13] rt-migrate-test: Add JSON output
 feature
In-Reply-To: <20210210175118.19709-13-dwagner@suse.de>
Message-ID: <662fe996-5e1b-74ae-da14-41ce6d8e050@redhat.com>
References: <20210210175118.19709-1-dwagner@suse.de> <20210210175118.19709-13-dwagner@suse.de>
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
>  src/rt-migrate-test/rt-migrate-test.c | 120 ++++++++++++++++++++++----
>  1 file changed, 101 insertions(+), 19 deletions(-)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 9bf716c9178c..56b7b66ccdf4 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -19,11 +19,14 @@
>  #include <fcntl.h>
>  #include <signal.h>
>  #include <sys/time.h>
> -#include <linux/unistd.h>
>  #include <sys/syscall.h>
>  #include <errno.h>
>  #include <sched.h>
>  #include <pthread.h>
> +#include <inttypes.h>
> +
> +#include <linux/unistd.h>
> +
>  #include "rt-utils.h"
>  
>  int nr_tasks;
> @@ -99,6 +102,7 @@ static int done;
>  static int loop;
>  static int duration;
>  static int quiet;
> +static char outfile[MAX_PATH];
>  
>  static pthread_barrier_t start_barrier;
>  static pthread_barrier_t end_barrier;
> @@ -160,6 +164,7 @@ static void usage(int error)
>  	       "-h       --help            Print this help message\n"
>  	       "-l LOOPS --loops=LOOPS     Number of iterations to run (50)\n"
>  	       "-m TIME  --maxerr=TIME     Max allowed error (microsecs)\n"
> +	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p PRIO  --prio=PRIO       base priority to start RT tasks with (2)\n"
>  	       "-q       --quiet           print a summary only on exit\n"
>  	       "-r TIME  --run-time=TIME   Run time (ms) to busy loop the threads (20)\n"
> @@ -169,22 +174,29 @@ static void usage(int error)
>  	exit(error);
>  }
>  
> +enum option_value {
> +	OPT_CHECK=1, OPT_DURATION, OPT_EQUAL, OPT_HELP, OPT_LOOPS,
> +	OPT_MAXERR, OPT_OUTPUT, OPT_PRIO, OPT_QUIET, OPT_RUN_TIME,
> +	OPT_SLEEP_TIME
> +};
> +
>  static void parse_options(int argc, char *argv[])
>  {
>  	for (;;) {
>  		int option_index = 0;
>  		/** Options for getopt */
>  		static struct option long_options[] = {
> -			{"check",	no_argument,		NULL, 'c'},
> -			{"duration",	required_argument,	NULL, 'D'},
> -			{"equal",	no_argument,		NULL, 'e'},
> -			{"help",	no_argument,		NULL, 'h'},
> -			{"loops",	required_argument,	NULL, 'l'},
> -			{"maxerr",	required_argument,	NULL, 'm'},
> -			{"prio",	required_argument,	NULL, 'p'},
> -			{"quiet",	no_argument,		NULL, 'q'},
> -			{"run-time",	required_argument,	NULL, 'r'},
> -			{"sleep-time",	required_argument,	NULL, 's'},
> +			{"check",	no_argument,		NULL, OPT_CHECK},
> +			{"duration",	required_argument,	NULL, OPT_DURATION},
> +			{"equal",	no_argument,		NULL, OPT_EQUAL},
> +			{"help",	no_argument,		NULL, OPT_HELP},
> +			{"loops",	required_argument,	NULL, OPT_LOOPS},
> +			{"maxerr",	required_argument,	NULL, OPT_MAXERR},
> +			{"output",	required_argument,      NULL, OPT_OUTPUT },
> +			{"prio",	required_argument,	NULL, OPT_PRIO},
> +			{"quiet",	no_argument,		NULL, OPT_QUIET},
> +			{"run-time",	required_argument,	NULL, OPT_RUN_TIME},
> +			{"sleep-time",	required_argument,	NULL, OPT_SLEEP_TIME},
>  			{NULL, 0, NULL, 0}
>  		};
>  		int c = getopt_long(argc, argv, "cD:ehl:m:p:qr:s:",
> @@ -192,21 +204,50 @@ static void parse_options(int argc, char *argv[])
>  		if (c == -1)
>  			break;
>  		switch (c) {
> -		case 'c': check = 1; break;
> -		case 'D': duration = parse_time_string(optarg); break;
> -		case 'e': equal = 1; break;
> +		case OPT_CHECK:
> +		case 'c':
> +			check = 1;
> +			break;
> +		case OPT_DURATION:
> +		case 'D':
> +			duration = parse_time_string(optarg);
> +			break;
> +		case OPT_EQUAL:
> +		case 'e':
> +			equal = 1;
> +			break;
> +		case OPT_HELP:
>  		case '?':
>  		case 'h':
>  			usage(0);
>  			break;
> -		case 'l': nr_runs = atoi(optarg); break;
> -		case 'm': max_err = usec2nano(atoi(optarg)); break;
> -		case 'p': prio_start = atoi(optarg); break;
> -		case 'q': quiet = 1; break;
> +		case OPT_LOOPS:
> +		case 'l':
> +			nr_runs = atoi(optarg);
> +			break;
> +		case OPT_MAXERR:
> +		case 'm':
> +			max_err = usec2nano(atoi(optarg));
> +			break;
> +		case OPT_OUTPUT:
> +			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
> +		case OPT_PRIO:
> +		case 'p':
> +			prio_start = atoi(optarg);
> +			break;
> +		case OPT_QUIET:
> +		case 'q':
> +			quiet = 1;
> +			break;
> +		case OPT_RUN_TIME:
>  		case 'r':
>  			run_interval = atoi(optarg);
>  			break;
> -		case 's': interval = atoi(optarg); break;
> +		case OPT_SLEEP_TIME:
> +		case 's':
> +			interval = atoi(optarg);
> +			break;
>  		default:
>  			usage(1);
>  		}
> @@ -313,6 +354,44 @@ static void print_results(void)
>  	}
>  }
>  
> +static void write_stats(FILE *f, void *data)
> +{
> +	int i;
> +	int t;
> +	unsigned long long tasks_max[nr_tasks];
> +	unsigned long long tasks_min[nr_tasks];
> +	unsigned long long tasks_avg[nr_tasks];
> +
> +	memset(tasks_max, 0, sizeof(tasks_max[0])*nr_tasks);
> +	memset(tasks_min, 0xff, sizeof(tasks_min[0])*nr_tasks);
> +	memset(tasks_avg, 0, sizeof(tasks_avg[0])*nr_tasks);
> +
> +	for (i=0; i < nr_runs; i++) {
> +		for (t=0; t < nr_tasks; t++) {
> +			unsigned long long itv = intervals[i][t];
> +
> +			if (tasks_max[t] < itv)
> +				tasks_max[t] = itv;
> +			if (tasks_min[t] > itv)
> +				tasks_min[t] = itv;
> +			tasks_avg[t] += itv;
> +		}
> +	}
> +
> +	fprintf(f, "  \"num_threads\": %d,\n", nr_tasks);
> +	fprintf(f, "  \"thread\": {\n");
> +	for (i = 0; i < nr_tasks; i++) {
> +		fprintf(f, "    \"%u\": {\n", i);
> +		fprintf(f, "      \"prio\": %d,\n", calc_prio(i));
> +		fprintf(f, "      \"min\": %lld,\n", nano2usec(tasks_min[i]));
> +		fprintf(f, "      \"avg\": %lld,\n", nano2usec(tasks_avg[i]) / nr_runs);
> +		fprintf(f, "      \"max\": %lld,\n", nano2usec(tasks_max[i]));
> +		fprintf(f, "      \"total\": %lld\n", nano2usec(tasks_avg[i]));
> +		fprintf(f, "    }%s\n", i == nr_tasks - 1 ? "" : ",");
> +	}
> +	fprintf(f, "  }\n");
> +}
> +
>  static unsigned long busy_loop(unsigned long long start_time)
>  {
>  	unsigned long long time;
> @@ -582,6 +661,9 @@ int main (int argc, char **argv)
>  
>  	print_results();
>  
> +	if (strlen(outfile) != 0)
> +		rt_write_json(outfile, argc, argv, write_stats, NULL);
> +
>  	if (stop) {
>  		/*
>  		 * We use this test in bash while loops
> -- 
> 2.30.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
