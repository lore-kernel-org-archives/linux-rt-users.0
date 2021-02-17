Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE83C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014BA64DF3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhBQDwO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBQDwM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:52:12 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF880C061756
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:51:31 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t62so11626247qke.7
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=tgjlppM0xLYpIkXnoE5qSOjnhaXUdiXsMCStthpQF3I=;
        b=Ja1CSxdiFGXcvJk1rxcjOgnLMkixV0WU6zVyVQQL1/BHcpKSA7t3TBPJzbkNzFTth6
         YBA3M6HYgI7nd1A55/GpsehB8WBklGZMMzMZ9b/lwrDFqo0nCHXhS036Z7slz/NrtYP0
         I7uFK6cU11m7gas0WDIfnXGE/3YRyqhNeRJIHyYuuk5vvRtIGtjJ2KdJWrtzut7mrSYa
         xLKPf5szoTRo+FwjWOlW01USwljIfK9CWSPx1kVjfxdFosEnCGCDwYJyMZSrBn8f4b7B
         8hfXQioet+IJRT0/mMB0LWGuNBKWvA0G7rx41PScwoznQVXUostJHMF9ieDQ4oEXuAI+
         zb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=tgjlppM0xLYpIkXnoE5qSOjnhaXUdiXsMCStthpQF3I=;
        b=i5TQ2m0+vGz926ylAq7C+wyHs7y62TNcdgLGJPdb5lno6jyy0fhGu69Tg7gaagkFLX
         o8qeHr0Wfk99BcDK3hh8PVvcml9OgDRsvp4Q7WlQefYHH1cP9hsl0fuJfaeeUGfqYGuL
         61QAC3pmmAW6VgNMnHUfijlsySzpl7v46OAKYU9RSxOfjLbwCz+ZBHjqMEgCl2MvlQAd
         SSdS7ZtyLzl59jkJrHBzieKacEm7SnkyDoyzArRRQb9UE4jM6c7rm0lPL6S76bTHImco
         dQm2yio/5Bx29ADJ2/4l9pcvKSBcjv3gkRjv5GdVyxqRv5U/dwDtu3Sah4M3EpUG+b53
         +TKQ==
X-Gm-Message-State: AOAM531QnkcKX93XoaFN0Vgiz/ygTkqKwz7K8XXBHwJXJ1G5p9WQImba
        PhZoocc24RXeKtE3EX7G/48=
X-Google-Smtp-Source: ABdhPJz/JRHvmO3nK9qW73ldoUrQ1Yk+Kg6Ocxop7Rm+iuYh1Lw+a8JQoeKXadsSsdhYRWxMALOI8w==
X-Received: by 2002:a37:b181:: with SMTP id a123mr23279293qkf.179.1613533891063;
        Tue, 16 Feb 2021 19:51:31 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id k8sm784042qkk.81.2021.02.16.19.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:51:30 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:51:30 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v5 08/13] ptsematest: Add JSON output feature
In-Reply-To: <20210210175118.19709-9-dwagner@suse.de>
Message-ID: <441b9815-21e5-6ec1-2f67-45fbd5981e2b@redhat.com>
References: <20210210175118.19709-1-dwagner@suse.de> <20210210175118.19709-9-dwagner@suse.de>
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
>  src/ptsematest/ptsematest.c | 120 ++++++++++++++++++++++++++++++------
>  1 file changed, 101 insertions(+), 19 deletions(-)
> 
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index 7d4ca97773d6..2755bfde5210 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -20,6 +20,7 @@
>  #include <linux/unistd.h>
>  #include <utmpx.h>
>  #include <pthread.h>
> +#include <inttypes.h>
>  
>  #include "rt-utils.h"
>  #include "rt-get_cpu.h"
> @@ -155,6 +156,7 @@ static void display_help(int error)
>  	       "                           days.\n"
>  	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> +	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p PRIO  --prio=PRIO       priority\n"
>  	       "-q       --quiet           print a summary only on exit\n"
>  	       "-S       --smp             SMP testing: options -a -t and same priority\n"
> @@ -180,6 +182,13 @@ static int distance = 500;
>  static int smp;
>  static int sameprio;
>  static int quiet;
> +static char outfile[MAX_PATH];
> +
> +enum option_value {
> +	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_DISTANCE, OPT_DURATION,
> +	OPT_HELP, OPT_INTERVAL, OPT_LOOPS, OPT_OUTPUT, OPT_PRIORITY,
> +	OPT_QUIET, OPT_SMP, OPT_THREADS
> +};
>  
>  static void process_options(int argc, char *argv[])
>  {
> @@ -190,17 +199,18 @@ static void process_options(int argc, char *argv[])
>  		int option_index = 0;
>  		/** Options for getopt */
>  		static struct option long_options[] = {
> -			{"affinity",	optional_argument,	NULL, 'a'},
> -			{"breaktrace",	required_argument,	NULL, 'b'},
> -			{"distance",	required_argument,	NULL, 'd'},
> -			{"duration",	required_argument,	NULL, 'D'},
> -			{"help",	no_argument,		NULL, 'h'},
> -			{"interval",	required_argument,	NULL, 'i'},
> -			{"loops",	required_argument,	NULL, 'l'},
> -			{"priority",	required_argument,	NULL, 'p'},
> -			{"quiet",	no_argument	,	NULL, 'q'},
> -			{"smp",		no_argument,		NULL, 'S'},
> -			{"threads",	optional_argument,	NULL, 't'},
> +			{"affinity",	optional_argument,	NULL, OPT_AFFINITY},
> +			{"breaktrace",	required_argument,	NULL, OPT_BREAKTRACE},
> +			{"distance",	required_argument,	NULL, OPT_DISTANCE},
> +			{"duration",	required_argument,	NULL, OPT_DURATION},
> +			{"help",	no_argument,		NULL, OPT_HELP},
> +			{"interval",	required_argument,	NULL, OPT_INTERVAL},
> +			{"loops",	required_argument,	NULL, OPT_LOOPS},
> +			{"output",	required_argument,      NULL, OPT_OUTPUT },
> +			{"priority",	required_argument,	NULL, OPT_PRIORITY},
> +			{"quiet",	no_argument	,	NULL, OPT_QUIET},
> +			{"smp",		no_argument,		NULL, OPT_SMP},
> +			{"threads",	optional_argument,	NULL, OPT_THREADS},
>  			{NULL, 0, NULL, 0}
>  		};
>  		int c = getopt_long (argc, argv, "a::b:d:i:l:D:p:qSt::h",
> @@ -208,6 +218,7 @@ static void process_options(int argc, char *argv[])
>  		if (c == -1)
>  			break;
>  		switch (c) {
> +		case OPT_AFFINITY:
>  		case 'a':
>  			if (smp) {
>  				warn("-a ignored due to --smp\n");
> @@ -223,20 +234,49 @@ static void process_options(int argc, char *argv[])
>  				setaffinity = AFFINITY_USEALL;
>  			}
>  			break;
> -		case 'b': tracelimit = atoi(optarg); break;
> -		case 'd': distance = atoi(optarg); break;
> -		case 'D': duration = parse_time_string(optarg); break;
> -		case 'i': interval = atoi(optarg); break;
> +		case OPT_BREAKTRACE:
> +		case 'b':
> +			tracelimit = atoi(optarg);
> +			break;
> +		case OPT_DISTANCE:
> +		case 'd':
> +			distance = atoi(optarg);
> +			break;
> +		case OPT_DURATION:
> +		case 'D':
> +			duration = parse_time_string(optarg);
> +			break;
> +		case OPT_INTERVAL:
> +		case 'i':
> +			interval = atoi(optarg);
> +			break;
> +		case OPT_HELP:
>  		case '?':
> -		case 'h': display_help(0); break;
> -		case 'l': max_cycles = atoi(optarg); break;
> -		case 'p': priority = atoi(optarg); break;
> -		case 'q': quiet = 1; break;
> +		case 'h':
> +			display_help(0);
> +			break;
> +		case OPT_LOOPS:
> +		case 'l':
> +			max_cycles = atoi(optarg);
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
>  		case 'S':
>  			smp = 1;
>  			num_threads = max_cpus;
>  			setaffinity = AFFINITY_USEALL;
>  			break;
> +		case OPT_THREADS:
>  		case 't':
>  			if (smp) {
>  				warn("-t ignored due to --smp\n");
> @@ -316,6 +356,40 @@ static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
>  	}
>  }
>  
> +struct params_stats {
> +	struct params *receiver;
> +	struct params *sender;
> +};
> +
> +static void write_stats(FILE *f, void *data)
> +{
> +	struct params_stats *ps = data;
> +	struct params *s, *r;
> +	unsigned int i;
> +
> +	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
> +	fprintf(f, "  \"thread\": {\n");
> +	for (i = 0; i < num_threads; i++) {
> +		s = &ps->sender[i];
> +		r = &ps->receiver[i];
> +		fprintf(f, "    \"%u\": {\n", i);
> +		fprintf(f, "      \"sender\": {\n");
> +		fprintf(f, "        \"cpu\": %d,\n", s->cpu);
> +		fprintf(f, "        \"priority\": %d,\n", s->priority);
> +		fprintf(f, "        \"samples\": %d,\n", s->samples);
> +		fprintf(f, "        \"interval\": %ld\n", r->delay.tv_nsec/1000);
> +		fprintf(f, "      },\n");
> +		fprintf(f, "      \"receiver\": {\n");
> +		fprintf(f, "        \"cpu\": %d,\n", r->cpu);
> +		fprintf(f, "        \"priority\": %d,\n", r->priority);
> +		fprintf(f, "        \"min\": %d,\n", r->mindiff);
> +		fprintf(f, "        \"avg\": %.2f,\n", r->sumdiff/r->samples);
> +		fprintf(f, "        \"max\": %d\n", r->maxdiff);
> +		fprintf(f, "      }\n");
> +		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
> +	}
> +	fprintf(f, "  }\n");
> +}
>  
>  int main(int argc, char *argv[])
>  {
> @@ -439,6 +513,14 @@ int main(int argc, char *argv[])
>  		pthread_mutex_destroy(&syncmutex[i]);
>  	}
>  
> +	if (strlen(outfile) != 0) {
> +		struct params_stats ps = {
> +			.receiver = receiver,
> +			.sender = sender,
> +		};
> +		rt_write_json(outfile, argc, argv, write_stats, &ps);
> +	}
> +
>  nomem:
>  
>  	return 0;
> -- 
> 2.30.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
