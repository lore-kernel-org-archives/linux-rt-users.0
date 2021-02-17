Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1DFC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D66564DF3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBQDvm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBQDvk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:51:40 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E330C06174A
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:51:00 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z32so8646912qtd.8
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=lvTJbDjNYR4UTnkPJG/N2JV7Ie0IOkOKyi1JgE+51m4=;
        b=rQRS12vwT1AHT3NT1EMHSpVqMDwj+yTNkH3EDsvrg4TpEhu4k11hsCdjHpaLY3I86F
         mkrjkgZ7lNKTzsBm2TNPBTjsbeuAe5K6cVmHba8L7o5sz0dupLf1avzUzD+i9f0xRKGy
         CghfkqFbDq6Rr7f8ZGuHP2z9XLS0LRiKYh1jwMaUnFhXMk34wZ5Jr7vkHj6lwwgJhLZN
         LxgHJs80+m9fTJWvZIPB+w8nioh4vbwnszjelYO3PKdAhFLH3ozRAgwZcsHw3of736XV
         1eDtMRNhmEBJLhYNcj0ucLcmRnMOLDw8cQswoiq2QEOuWangEcR/y4sF5AiLmMp5fA1a
         iJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=lvTJbDjNYR4UTnkPJG/N2JV7Ie0IOkOKyi1JgE+51m4=;
        b=BVR2lTVJNBdthw3vCpsEeCNhjnRKsUE1rpOYvT39hCGCLYB6aTL4+YJEBzgtahegoh
         0+8CUUPS859B9hichKJJL2o72nYsi2cZRXNvRe6GUmFmMtqCcKjkGcJEGfgM/cWqBlr6
         fqH0CdoW684sQUOCUAyWOU0p66NlA4lh+VMzAFQ7hplFUOarcaCHW42rlZrxjiMMPjHA
         0LogwT/BS1wIrP1BwyU1zYgS4mn8lnuTqovYtQsuwsXOuRxZF73Yf7lr/Id+AdHEQGyF
         G8Mmdu+wsRQPsvrOIYktamodaCWZ15onCCed8HNc3vjB5TbqIYLvrIn9a/hbXM7yS7sB
         /hnw==
X-Gm-Message-State: AOAM532yoBu5e9qOUt2P3F9EJfjwTDEUj0X5UM9CIfnyPtpUV2EW9gAt
        I5+wsFuGDPH5dDHwfnrzRlDHTzSwLjg+LA==
X-Google-Smtp-Source: ABdhPJwtQxOYGseeASqnayLHV5NKk+2dxsNK09Za+lx7aIbicM7U+3axhS8BO95mVlyEwcjGIVAObw==
X-Received: by 2002:ac8:5ac4:: with SMTP id d4mr21771711qtd.38.1613533859522;
        Tue, 16 Feb 2021 19:50:59 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id d2sm445959qtn.7.2021.02.16.19.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:50:59 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:50:58 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v5 05/13] signaltest: Add JSON output feature
In-Reply-To: <20210210175118.19709-6-dwagner@suse.de>
Message-ID: <c8b99d53-a277-6ee1-7d33-c8667ea385b4@redhat.com>
References: <20210210175118.19709-1-dwagner@suse.de> <20210210175118.19709-6-dwagner@suse.de>
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
>  src/signaltest/signaltest.c | 109 +++++++++++++++++++++++++++++-------
>  1 file changed, 88 insertions(+), 21 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index dd5633d5fc51..09039b299367 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -22,6 +22,7 @@
>  #include <unistd.h>
>  #include <errno.h>
>  #include <sched.h>
> +#include <inttypes.h>
>  
>  #include <linux/unistd.h>
>  
> @@ -205,6 +206,14 @@ static int verbose;
>  static int quiet;
>  static int lockall;
>  static struct bitmask *affinity_mask = NULL;
> +static char outfile[MAX_PATH];
> +
> +enum option_values {
> +	OPT_AFFINITY=1, OPT_BREAKTRACE,
> +	OPT_DURATION, OPT_HELP, OPT_LOOPS,
> +	OPT_MLOCKALL, OPT_OUTPUT, OPT_PRIORITY,
> +	OPT_QUIET, OPT_SMP, OPT_THREADS, OPT_VERBOSE
> +};
>  
>  /* Process commandline options */
>  static void process_options(int argc, char *argv[])
> @@ -216,17 +225,18 @@ static void process_options(int argc, char *argv[])
>  		int option_index = 0;
>  		/** Options for getopt */
>  		static struct option long_options[] = {
> -			{"affinity",		optional_argument,	NULL, 'a'},
> -			{"breaktrace",		required_argument,	NULL, 'b'},
> -			{"duration",		required_argument,	NULL, 'D'},
> -			{"help",		no_argument,		NULL, 'h'},
> -			{"loops",		required_argument,	NULL, 'l'},
> -			{"mlockall",		no_argument,		NULL, 'm'},
> -			{"priority",		required_argument,	NULL, 'p'},
> -			{"quiet",		no_argument,		NULL, 'q'},
> -			{"smp",			no_argument,		NULL, 'S'},
> -			{"threads",		required_argument,	NULL, 't'},
> -			{"verbose",		no_argument,		NULL, 'v'},
> +			{"affinity",	optional_argument,	NULL, OPT_AFFINITY},
> +			{"breaktrace",	required_argument,	NULL, OPT_BREAKTRACE},
> +			{"duration",	required_argument,	NULL, OPT_DURATION},
> +			{"help",	no_argument,		NULL, OPT_HELP},
> +			{"loops",	required_argument,	NULL, OPT_LOOPS},
> +			{"mlockall",	no_argument,		NULL, OPT_MLOCKALL},
> +			{"output",	required_argument,	NULL, OPT_OUTPUT},
> +			{"priority",	required_argument,	NULL, OPT_PRIORITY},
> +			{"quiet",	no_argument,		NULL, OPT_QUIET},
> +			{"smp",		no_argument,		NULL, OPT_SMP},
> +			{"threads",	required_argument,	NULL, OPT_THREADS},
> +			{"verbose",	no_argument,		NULL, OPT_VERBOSE},
>  			{NULL, 0, NULL, 0}
>  		};
>  		int c = getopt_long(argc, argv, "a::b:D:hl:mp:qSt:v",
> @@ -234,6 +244,7 @@ static void process_options(int argc, char *argv[])
>  		if (c == -1)
>  			break;
>  		switch (c) {
> +		case OPT_AFFINITY:
>  		case 'a':
>  			if (optarg) {
>  				parse_cpumask(optarg, &affinity_mask);
> @@ -248,17 +259,49 @@ static void process_options(int argc, char *argv[])
>  				printf("Using %u cpus.\n",
>  					numa_bitmask_weight(affinity_mask));
>  			break;
> -		case 'b': tracelimit = atoi(optarg); break;
> -		case 'D': duration = parse_time_string(optarg); break;
> +		case OPT_BREAKTRACE:
> +		case 'b':
> +			tracelimit = atoi(optarg);
> +			break;
> +		case OPT_DURATION:
> +		case 'D':
> +			duration = parse_time_string(optarg);
> +			break;
> +		case OPT_HELP:
>  		case '?':
> -		case 'h': display_help(0); break;
> -		case 'l': max_cycles = atoi(optarg); break;
> -		case 'm': lockall = 1; break;
> -		case 'p': priority = atoi(optarg); break;
> -		case 'q': quiet = 1; break;
> -		case 'S': smp = 1; break;
> -		case 't': num_threads = atoi(optarg); break;
> -		case 'v': verbose = 1; break;
> +		case 'h':
> +			display_help(0);
> +			break;
> +		case OPT_LOOPS:
> +		case 'l':
> +			max_cycles = atoi(optarg);
> +			break;
> +		case OPT_MLOCKALL:
> +		case 'm':
> +			lockall = 1;
> +			break;
> +		case OPT_OUTPUT:
> +			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
> +		case OPT_PRIORITY:
> +		case 'p':
> +			priority = atoi(optarg);
> +			break;
> +		case OPT_QUIET:
> +		case 'q':
> +			quiet = 1;
> +			break;
> +		case OPT_SMP:
> +		case 'S':
> +			smp = 1;
> +			break;
> +		case OPT_THREADS:
> +		case 't':
> +			num_threads = atoi(optarg);
> +			break;
> +		case OPT_VERBOSE:
> +		case 'v': verbose = 1;
> +			break;
>  		}
>  	}
>  
> @@ -312,6 +355,27 @@ static void print_stat(struct thread_param *par, int index, int verbose)
>  	}
>  }
>  
> +static void write_stats(FILE *f, void *data)
> +{
> +	struct thread_param *par = data;
> +	struct thread_stat *s;
> +	unsigned int i;
> +
> +	fprintf(f, "  \"thread\": {\n");
> +	for (i = 0; i < num_threads; i++) {
> +		fprintf(f, "    \"%u\": {\n", i);
> +		s = &par->stats[i];
> +		fprintf(f, "      \"cycles\": %" PRIu64 ",\n", s->cycles);
> +		fprintf(f, "      \"min\": %" PRIu64 ",\n", s->min);
> +		fprintf(f, "      \"max\": %" PRIu64 ",\n", s->max);
> +		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
> +		fprintf(f, "      \"cpu\": %d\n", par->cpu);
> +		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
> +
> +	}
> +	fprintf(f, "  }\n");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	sigset_t sigset;
> @@ -454,6 +518,9 @@ int main(int argc, char **argv)
>  		if (stat[i].values)
>  			free(stat[i].values);
>  	}
> +	if (strlen(outfile) != 0)
> +		rt_write_json(outfile, argc, argv, write_stats, par);
> +
>  	free(stat);
>   outpar:
>  	free(par);
> -- 
> 2.30.0
> 
> 

This has a number of conflicts due to me
not applying all of the changes to smp / numa
