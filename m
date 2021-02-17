Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D23C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6BA64DF3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhBQDvb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBQDva (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:51:30 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64589C061756
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:50:50 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id h8so11633085qkk.6
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=h/H6wwFyNXZsXKgT3/MQgNxo8VLi6MVvo0XBjUP0WQ4=;
        b=M5jENBgVoG+c3YdYzFR4cOdQBeHoBnjNfeJ4qBuzOMzLYsmATv2baAQPbH0tG1BLwE
         9xgn17gfS36AUoh5j19JwlDfdJ95SZl57ZISArGsdBvHchuRI4GTB/5QqBllcmLxd5+R
         QZLWENR+ghYip2Pa2QiT8Em4kLpGFJxMatbhVkQft/PUJYwRQ1HtaZxAbRhWh2l/+riF
         ACDBr2giDEvAk1iaw9GCIkv2wHfZZPy6V3ot0mIFGL563YInXId3MVUrk62S8muKAVtU
         YmlBJzcOSGD4ApOFN2jpd9dkorZx548PejjiLJRDjn+kD2bd9T/k0Q+Md0t2w3zgwZDk
         8tbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=h/H6wwFyNXZsXKgT3/MQgNxo8VLi6MVvo0XBjUP0WQ4=;
        b=TVKvY0RR3XJi4hdMkS59UvHwz4EP1KvuCLGp5uJek/VaDLHNejEgJXSjrPW6GvGEEA
         eFEf1R7IQifKqn852PI8VGN/SnTjOD2MkaMR2ceSfXmMBCNHcYRwEmhJI9P4DC1n98Un
         3lqUEtqekmeHP0pA/PxznwBwgEKxhWpLpr7Ifx9xSwfDJhM+QcUWca3YGFJdD6s3R+Wr
         pSORECYbyV8VUdUK+2k9s4tTeZpq8UxXmwNfM9sTC6lXO2PUKSE2qXmULFAfPz5+zher
         4YJq8wC++EvopYFebIQaoTDujx7HXRB9Y7hfTtLRuMyrvs/uDPVPlwSVxxN4gCmULpLA
         aOCw==
X-Gm-Message-State: AOAM533+ls+/C05jpJgTc06/P/okGBHWBcxDCMUN5dEFBssE9Gam6iR2
        s1ZXt/xM0vMvCdAYVQfwA+I=
X-Google-Smtp-Source: ABdhPJz9OUt4RFiulp/NAPwmcGXqxXzE75aQ2Nca4mza4JJ4ZjmDwXucnSuxw163FBsXyatjxT3sbg==
X-Received: by 2002:a37:4ed1:: with SMTP id c200mr9230281qkb.55.1613533849633;
        Tue, 16 Feb 2021 19:50:49 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id p16sm451044qtq.24.2021.02.16.19.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:50:49 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:50:48 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v5 04/13] cyclictest: Add JSON output feature
In-Reply-To: <20210210175118.19709-5-dwagner@suse.de>
Message-ID: <e7e94ada-1e36-d6d-1538-e4e0defeed5b@redhat.com>
References: <20210210175118.19709-1-dwagner@suse.de> <20210210175118.19709-5-dwagner@suse.de>
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
>  src/cyclictest/cyclictest.c | 46 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 7c45732c1553..3d0cf3f84b69 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -11,6 +11,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdint.h>
> +#include <inttypes.h>
>  #include <stdarg.h>
>  #include <unistd.h>
>  #include <fcntl.h>
> @@ -217,6 +218,7 @@ static struct timespec globalt;
>  
>  static char fifopath[MAX_PATH];
>  static char histfile[MAX_PATH];
> +static char outfile[MAX_PATH];
>  
>  static struct thread_param **parameters;
>  static struct thread_stat **statistics;
> @@ -838,6 +840,7 @@ static void display_help(int error)
>  	       "			   latency is hit. Useful for low bandwidth.\n"
>  	       "-N       --nsecs           print results in ns instead of us (default us)\n"
>  	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
> +	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
>  	       "	 --policy=NAME     policy of measurement thread, where NAME may be one\n"
>  	       "                           of: other, normal, batch, idle, fifo or rr.\n"
> @@ -945,7 +948,7 @@ enum option_values {
>  	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
>  	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
>  	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
> -	OPT_TRACEMARK, OPT_POSIX_TIMERS,
> +	OPT_TRACEMARK, OPT_POSIX_TIMERS, OPT_OUTPUT
>  };
>  
>  /* Process commandline options */
> @@ -979,6 +982,7 @@ static void process_options(int argc, char *argv[])
>  			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
>  			{"nsecs",            no_argument,       NULL, OPT_NSECS },
>  			{"oscope",           required_argument, NULL, OPT_OSCOPE },
> +			{"output",           required_argument, NULL, OPT_OUTPUT },
>  			{"priority",         required_argument, NULL, OPT_PRIORITY },
>  			{"quiet",            no_argument,       NULL, OPT_QUIET },
>  			{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
> @@ -1073,6 +1077,9 @@ static void process_options(int argc, char *argv[])
>  		case 'o':
>  		case OPT_OSCOPE:
>  			oscope_reduction = atoi(optarg); break;
> +		case OPT_OUTPUT:
> +			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
>  		case 'p':
>  		case OPT_PRIORITY:
>  			priority = atoi(optarg);
> @@ -1690,6 +1697,40 @@ static void rstat_setup(void)
>  	return;
>  }
>  
> +static void write_stats(FILE *f, void *data)
> +{
> +	struct thread_param **par = parameters;
> +	unsigned int i, j, comma;
> +	struct thread_stat *s;
> +
> +	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
> +	fprintf(f, "  \"resolution_in_ns\": %u,\n", use_nsecs);
> +	fprintf(f, "  \"thread\": {\n");
> +	for (i = 0; i < num_threads; i++) {
> +		fprintf(f, "    \"%u\": {\n", i);
> +
> +		fprintf(f, "      \"histogram\": {");
> +		s = par[i]->stats;
> +		for (j = 0, comma = 0; j < histogram; j++) {
> +			if (s->hist_array[j] == 0)
> +				continue;
> +			fprintf(f, "%s", comma ? ",\n" : "\n");
> +			fprintf(f, "        \"%u\": %" PRIu64,j, s->hist_array[j]);
> +			comma = 1;
> +		}
> +		if (comma)
> +			fprintf(f, "\n");
> +		fprintf(f, "      },\n");
> +		fprintf(f, "      \"cycles\": %" PRIu64 ",\n", s->cycles);
> +		fprintf(f, "      \"min\": %" PRIu64 ",\n", s->min);
> +		fprintf(f, "      \"max\": %" PRIu64 ",\n", s->max);
> +		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
> +		fprintf(f, "      \"cpu\": %d,\n", par[i]->cpu);
> +		fprintf(f, "      \"node\": %d\n", par[i]->node);
> +		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
> +	}
> +	fprintf(f, "  }\n");
> +}
>  
>  int main(int argc, char **argv)
>  {
> @@ -2035,6 +2076,9 @@ int main(int argc, char **argv)
>  	if (!verbose && !quiet && refresh_on_max)
>  		printf("\033[%dB", num_threads + 2);
>  
> +	if (strlen(outfile) != 0)
> +		rt_write_json(outfile, argc, argv, write_stats, NULL);
> +
>  	if (quiet)
>  		quiet = 2;
>  	for (i = 0; i < num_threads; i++) {
> -- 
> 2.30.0
> 
> 
   - Added a space after a comma in fprintf
    Signed-off-by: John Kacur <jkacur@redhat.com>

