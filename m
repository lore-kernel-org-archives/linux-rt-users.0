Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085DAC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB53064DFD
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBSQCY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhBSQCP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:02:15 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8487EC061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:01:33 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id m144so5906044qke.10
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=xYywFbLUx6BJINPOKQZHWNhZ27lJ/xmdi3tVtXbQdHk=;
        b=co/mc0kNS6Nojgpp+0Yax604q6IFIZf+x6rU3h81u/nXM5Dioz8bQNzXZ2eraObsdK
         JxVde31INj/luLwFzu/VWsJJFzDg97OPj9efrnLVKKrTRhATTg13aP+eJednxHgnsNSU
         2zJiqcB+7Vk5ALjEri7E2LVu8kqQKAYumssyMzYvTqSjQbDdfEZJ5DZ6cru09sO4PmkY
         XFNcAn5+WN/bYzbEO1SSsCQz02z8SvwpHzw/n2WIwAXGTb79z3Uwck/RorY3wDcBQWqk
         IpnRVwOkS3k19kH27mOQUtd0RirDMyfYRXoBAJNdiH3yYRyftfdBjAtF2v0SUwYZV20P
         h29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=xYywFbLUx6BJINPOKQZHWNhZ27lJ/xmdi3tVtXbQdHk=;
        b=Se+ytFHLnfcJOVQz2x1J/Cti9PpR6AoSYqt0pQ69LuPuZe+cicEeBeHQ8AstrlN3Vm
         3vZiqrqz7cAKxVYspFsb1i0exFi9SC/YMXhyM0RDYd1scmZgB2OR8E8uQjnSCdchBJLC
         fjjSpEuxnwwlf0d8kJ6E5nyF/w/5MkG1+vyBb16zopaCAl1V3UaYoYBZxPUdSrpq+pEK
         3gDZ1mYXJWuTO+FAxl3Hx3l/KMl+LEwKm0yM0fawLMSU1dGqxB5dg4j8CoG6LiA6yr1L
         K6IJFFk2lhOp45r6fNKC1fCbWxXNuparhjSAf0/xJEU++292XZxpenmL1xZ8lGKiTc9W
         Bqcg==
X-Gm-Message-State: AOAM532ONlct0tiE2Twlf8nNJAy9p1chFGIvlaSNALNsoZ5cn2NlpvSq
        mkHy/Tlc8h+m1ggFrOM9Mdg=
X-Google-Smtp-Source: ABdhPJyTEf2Ca+GSu24CNcebE8hy+cjKJ7OyTtcuEr6vY6SLxtHsjtex8pnt2T8joOHlFkM+fxCPPg==
X-Received: by 2002:a37:4747:: with SMTP id u68mr9830470qka.279.1613750492690;
        Fri, 19 Feb 2021 08:01:32 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id i7sm6670138qke.5.2021.02.19.08.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:01:32 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 19 Feb 2021 11:01:25 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v6 1/2] signaltest: Add JSON output feature
In-Reply-To: <20210217085610.10874-2-dwagner@suse.de>
Message-ID: <d03d30d6-ff6e-8784-d4b8-842598c3c934@redhat.com>
References: <20210217085610.10874-1-dwagner@suse.de> <20210217085610.10874-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 17 Feb 2021, Daniel Wagner wrote:

> Write the test results as JSON output to a file. This allows to
> simplifies any parsing later on.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/signaltest/signaltest.c | 106 +++++++++++++++++++++++++++++-------
>  1 file changed, 86 insertions(+), 20 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index d2b90d93ceca..1d1b070cf12b 100644
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
> @@ -207,6 +208,14 @@ static int lockall;
>  static struct bitmask *affinity_mask = NULL;
>  static int smp = 0;
>  static int setaffinity = AFFINITY_UNSPECIFIED;
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
>  static void process_options(int argc, char *argv[], unsigned int max_cpus)
> @@ -219,17 +228,18 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
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
> @@ -237,6 +247,7 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  		if (c == -1)
>  			break;
>  		switch (c) {
> +		case OPT_AFFINITY:
>  		case 'a':
>  			option_affinity = 1;
>  			/* smp sets AFFINITY_USEALL in OPT_SMP */
> @@ -262,14 +273,39 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
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
>  		case 'S':
>  			if (numa)
>  				fatal("numa and smp options are mutually exclusive\n");
> @@ -277,8 +313,13 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  			num_threads = -1; /* update after parsing */
>  			setaffinity = AFFINITY_USEALL;
>  			break;
> -		case 't': num_threads = atoi(optarg); break;
> -		case 'v': verbose = 1; break;
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
> @@ -339,6 +380,28 @@ static void print_stat(struct thread_param *par, int index, int verbose)
>  	}
>  }
>  
> +static void write_stats(FILE *f, void *data)
> +{
> +	struct thread_param *par = data;
> +	struct thread_stat *s;
> +	unsigned int i;
> +
> +	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
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
> @@ -494,6 +557,9 @@ int main(int argc, char **argv)
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

Signed-off-by: John Kacur <jkacur@redhat.com>
