Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A5AC433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F60664DF3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhBQDwA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBQDv5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:51:57 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CC7C06174A
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:51:42 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id a1so5694951qvd.13
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=EmK5S6xNyn3XjiycPyXrVcbDyUKJbXBMvbPWglyJ9XY=;
        b=XiTXivJGE3dZswkTN1q6BgRa8t0pdJR+1RDWxHumy06JwAilVjZBKWJ8tccQ7+/3Ti
         MKrqyUnR+Xk3oQxOh+r2o0kLgqtMeVgd9gu7FgyDsiJ5Z3owwbx+1nYIk+zu2U38xh+L
         7Oz2nWexqHU+gSU+2Vjeg8EjtUErwDWM6ekDG3luEa1KKqG0rJ5DHxmGJjJTWMh4OFsC
         8F3NcYUFA2n6BBjxCQ6AtDr/pARjRUrpTuvArt7MXCs6Kb05OmmdTSQl9i7cfq3xa/DX
         zxnE6A6RnrIPMHSR7SPJIXSFl861XLjUtXp9kNICzOJ25eb/H5U4fy9nDaYSvY/IFawG
         wwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=EmK5S6xNyn3XjiycPyXrVcbDyUKJbXBMvbPWglyJ9XY=;
        b=qc0WeCK7xyinKaMZCCadOrEqTlV4m/jRJpvai1Sl4yORmD81OGWdv7+aUMbuiXZaJV
         QvDTz7C/Dt/kDo/+HK1DKHF3xHwrgrOS7Nxy/aX5l0Nmtyk9nMO8/lH7aEEAsqEsviSi
         7QaozvvX3dv6DVP8pavPJuy/pyVcLgFHKdVttYJwgJkDB/u8WQZzR70dkwMHGxfVWTsC
         nr0K/fuImPHxgrKeRWLl8UMyQRb77VCbTLtxxxoVZUwhtwImNY8aFala0QfcI0dLD8zl
         eO/hHPCBLMhGlvSPUhXk8RQXRox3Dm5KQOHvDHcktRI8QHa4/k5k58ReRsy2o50PyjiC
         6jUg==
X-Gm-Message-State: AOAM532qej0i1JtvsYkWMAzunennww1Gl71F/Z+8aR7v/XdDpqBGAWwS
        v4U7LgZkdzuev54hUsGowFPaSH31N8Fkcg==
X-Google-Smtp-Source: ABdhPJyefLvLXIe7OyMrTDulPyKsxAE52e0lN8V2QAOSUwlPXWF6zYkTXlwZOrX/Y4fZXfTS9gKRvg==
X-Received: by 2002:ad4:5846:: with SMTP id de6mr885153qvb.57.1613533901372;
        Tue, 16 Feb 2021 19:51:41 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id m5sm810397qkf.55.2021.02.16.19.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:51:41 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:51:40 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v5 09/13] sigwaittest: Add JSON output feature
In-Reply-To: <20210210175118.19709-10-dwagner@suse.de>
Message-ID: <c68f3a68-696-f5ad-218d-c34372314a2@redhat.com>
References: <20210210175118.19709-1-dwagner@suse.de> <20210210175118.19709-10-dwagner@suse.de>
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
>  src/signaltest/signaltest.c   |   1 +
>  src/sigwaittest/sigwaittest.c | 117 ++++++++++++++++++++++++++++------
>  2 files changed, 100 insertions(+), 18 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 09039b299367..b1a71efdf42f 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -361,6 +361,7 @@ static void write_stats(FILE *f, void *data)
>  	struct thread_stat *s;
>  	unsigned int i;
>  
> +	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
>  	fprintf(f, "  \"thread\": {\n");
>  	for (i = 0; i < num_threads; i++) {
>  		fprintf(f, "    \"%u\": {\n", i);
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index f10c24914d4a..0cdf30a6a769 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -39,6 +39,7 @@
>  #include <linux/unistd.h>
>  #include <utmpx.h>
>  #include <pthread.h>
> +#include <inttypes.h>
>  
>  #include "rt-utils.h"
>  #include "rt-get_cpu.h"
> @@ -220,6 +221,7 @@ static void display_help(int error)
>  	       "-f [OPT] --fork[=OPT]      fork new processes instead of creating threads\n"
>  	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> +	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p PRIO  --prio=PRIO       priority\n"
>  	       "-q       --quiet           print a summary only on exit\n"
>  	       "-t       --threads         one thread per available processor\n"
> @@ -240,6 +242,13 @@ static int duration;
>  static int interval = 1000;
>  static int distance = 500;
>  static int quiet;
> +static char outfile[MAX_PATH];
> +
> +enum option_value {
> +	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_DISTANCE, OPT_DURATION,
> +	OPT_FORK, OPT_HELP, OPT_INTERVAL, OPT_LOOPS, OPT_OUTPUT,
> +	OPT_PRIORITY, OPT_QUIET, OPT_THREADS
> +};
>  
>  static void process_options(int argc, char *argv[])
>  {
> @@ -251,17 +260,18 @@ static void process_options(int argc, char *argv[])
>  		int option_index = 0;
>  		/** Options for getopt */
>  		static struct option long_options[] = {
> -			{"affinity",		optional_argument,	NULL, 'a'},
> -			{"breaktrace",		required_argument,	NULL, 'b'},
> -			{"distance",		required_argument,	NULL, 'd'},
> -			{"duration",		required_argument,	NULL, 'D'},
> -			{"fork",		optional_argument,	NULL, 'f'},
> -			{"help",		no_argument,		NULL, 'h'},
> -			{"interval",		required_argument,	NULL, 'i'},
> -			{"loops",		required_argument,	NULL, 'l'},
> -			{"priority",		required_argument,	NULL, 'p'},
> -			{"quiet",		no_argument,		NULL, 'q'},
> -			{"threads",		optional_argument,	NULL, 't'},
> +			{"affinity",	optional_argument,	NULL, OPT_AFFINITY},
> +			{"breaktrace",	required_argument,	NULL, OPT_BREAKTRACE},
> +			{"distance",	required_argument,	NULL, OPT_DISTANCE},
> +			{"duration",	required_argument,	NULL, OPT_DURATION},
> +			{"fork",	optional_argument,	NULL, OPT_FORK},
> +			{"help",	no_argument,		NULL, OPT_HELP},
> +			{"interval",	required_argument,	NULL, OPT_INTERVAL},
> +			{"loops",	required_argument,	NULL, OPT_LOOPS},
> +			{"output",	required_argument,      NULL, OPT_OUTPUT },
> +			{"priority",	required_argument,	NULL, OPT_PRIORITY},
> +			{"quiet",	no_argument,		NULL, OPT_QUIET},
> +			{"threads",	optional_argument,	NULL, OPT_THREADS},
>  			{NULL, 0, NULL, 0}
>  		};
>  		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:qt::",
> @@ -269,6 +279,7 @@ static void process_options(int argc, char *argv[])
>  		if (c == -1)
>  			break;
>  		switch (c) {
> +		case OPT_AFFINITY:
>  		case 'a':
>  			if (optarg != NULL) {
>  				affinity = atoi(optarg);
> @@ -280,9 +291,19 @@ static void process_options(int argc, char *argv[])
>  				setaffinity = AFFINITY_USEALL;
>  			}
>  			break;
> -		case 'b': thistracelimit = atoi(optarg); break;
> -		case 'd': distance = atoi(optarg); break;
> -		case 'D': duration = parse_time_string(optarg); break;
> +		case OPT_BREAKTRACE:
> +		case 'b':
> +			thistracelimit = atoi(optarg);
> +			break;
> +		case OPT_DISTANCE:
> +		case 'd':
> +			distance = atoi(optarg);
> +			break;
> +		case OPT_DURATION:
> +		case 'D':
> +			duration = parse_time_string(optarg);
> +			break;
> +		case OPT_FORK:
>  		case 'f':
>  			if (optarg != NULL) {
>  				wasforked = 1;
> @@ -294,14 +315,31 @@ static void process_options(int argc, char *argv[])
>  			} else
>  				mustfork = 1;
>  			break;
> +		case OPT_HELP:
>  		case '?':
>  		case 'h':
>  			display_help(0);
>  			break;
> -		case 'i': interval = atoi(optarg); break;
> -		case 'l': max_cycles = atoi(optarg); break;
> -		case 'p': priority = atoi(optarg); break;
> -		case 'q': quiet = 1; break;
> +		case OPT_INTERVAL:
> +		case 'i':
> +			interval = atoi(optarg);
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
> +		case OPT_THREADS:
>  		case 't':
>  			if (optarg != NULL)
>  				num_threads = atoi(optarg);
> @@ -388,6 +426,41 @@ static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
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
> +
>  int main(int argc, char *argv[])
>  {
>  	int i, totalsize = 0;
> @@ -627,6 +700,14 @@ int main(int argc, char *argv[])
>  		}
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
>  	if (mustfork) {
>  		munmap(param, totalsize);
> -- 
> 2.30.0
> 
> 

Doesn't apply
