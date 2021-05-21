Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E07CC04FF3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A04F613EE
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhEUVdv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 17:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhEUVdu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 17:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621632746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3lMcu5o+p5Hyo3ZeXuzTFqIzV+kJbF0amz6W/9NAatw=;
        b=gllq4Kls7agZ7nlRLYDoRrtRPIAPTt6uGjXn72vf6hum9DgYl2G0E/9hv81VLSDe01hFSj
        ll6dPoc8nEZh9jO9rANG68pu0TueNQNVcwxRVw5ienr/OScbdIxr1EvOtCEF6+41C7ETku
        fTCDUym/0vEZGu6RY9uZAHJ2CebFLQg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-lL0a4rZTO_CAHduscq4lQA-1; Fri, 21 May 2021 17:32:24 -0400
X-MC-Unique: lL0a4rZTO_CAHduscq4lQA-1
Received: by mail-qv1-f69.google.com with SMTP id x2-20020a0cda020000b02901edb4c412fdso18362117qvj.11
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 14:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=3lMcu5o+p5Hyo3ZeXuzTFqIzV+kJbF0amz6W/9NAatw=;
        b=pER0+XAEmgP3bncFu5LPo2GT1y6Kcao/ja67BDIJWQEHJXMPWRRocGQaBW5EojVCFY
         DOX1CygApNkLViOJSfgWi37RgOoablL136NwNcNVo1uk6/AoARR0OAqtzZOEl4n460XG
         sj4GvHwL0NZIpwIL9JXYRsMwWCjlbxwMq+lTS5uh1Pu3F/KPR05SIyLbLWSDsNK3+pQr
         Ynu1Ecltxu1Um1s7TIy8gBhogHCHcuidPM7OTUhWY4CqcTdpUDKFXAkDrWx75+QjkPYd
         D0m4o3NWtXu+YPqHW//zwiHQYhs6AwDa18nCD5EnREDjUaJa6gqSgPhiTdWMO1StiA51
         42lg==
X-Gm-Message-State: AOAM533gvDJXqI+gMmccbe/dsrz01nNgcqO5mWFdTycUOxVauMi8Jt5N
        Gp5+ynAGfzy6AtczEed7gBdCG3pGB8zw2VwqyiO6GUKbWy/mspCTjpLzdJNEEKILeejVXt5Aqn1
        MKFe2Bi9n1R/MEv2Qnw5/yfbCrZM=
X-Received: by 2002:a37:38d:: with SMTP id 135mr15801353qkd.136.1621632744165;
        Fri, 21 May 2021 14:32:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU87DEClkbX1ezeJr1PvKsUqSFDfy07jzcMTM8DwMa6GvorQ08aBEiZDKg1wqb0L6hdCq+jw==
X-Received: by 2002:a37:38d:: with SMTP id 135mr15801334qkd.136.1621632743992;
        Fri, 21 May 2021 14:32:23 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id l4sm5327190qkp.48.2021.05.21.14.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:32:23 -0700 (PDT)
Date:   Fri, 21 May 2021 17:32:22 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 02/23] cyclictest: Rename command line option
 --output to --json
In-Reply-To: <20210519170945.21941-3-dwagner@suse.de>
Message-ID: <f5502999-7c47-8ef0-513e-f3c457407a33@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 19 May 2021, Daniel Wagner wrote:

> The initial idea was to have several different output format
> supported but it turns out everyone is happy with JSON, so
> there is no need to add another format.
> 
> Thus let's make the command line option more specific and
> rename it to --json.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 59dda1973b1a..a561443fa67b 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -218,7 +218,7 @@ static struct timespec globalt;
>  
>  static char fifopath[MAX_PATH];
>  static char histfile[MAX_PATH];
> -static char outfile[MAX_PATH];
> +static char jsonfile[MAX_PATH];
>  
>  static struct thread_param **parameters;
>  static struct thread_stat **statistics;
> @@ -832,6 +832,7 @@ static void display_help(int error)
>  	       "-H       --histofall=US    same as -h except with an additional summary column\n"
>  	       "	 --histfile=<path> dump the latency histogram to <path> instead of stdout\n"
>  	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
> +	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
>  	       "	 --laptop	   Save battery when running cyclictest\n"
>  	       "			   This will give you poorer realtime results\n"
> @@ -841,7 +842,6 @@ static void display_help(int error)
>  	       "			   latency is hit. Useful for low bandwidth.\n"
>  	       "-N       --nsecs           print results in ns instead of us (default us)\n"
>  	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
> -	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
>  	       "	 --policy=NAME     policy of measurement thread, where NAME may be one\n"
>  	       "                           of: other, normal, batch, idle, fifo or rr.\n"
> @@ -944,14 +944,14 @@ enum option_values {
>  	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_CLOCK,
>  	OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
>  	OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
> -	OPT_INTERVAL, OPT_LOOPS, OPT_MLOCKALL, OPT_REFRESH,
> +	OPT_INTERVAL, OPT_JSON, OPT_LOOPS, OPT_MLOCKALL, OPT_REFRESH,
>  	OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
>  	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION,
>  	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRIGGER,
>  	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
>  	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
>  	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
> -	OPT_TRACEMARK, OPT_POSIX_TIMERS, OPT_OUTPUT
> +	OPT_TRACEMARK, OPT_POSIX_TIMERS,
>  };
>  
>  /* Process commandline options */
> @@ -979,13 +979,13 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  			{"histofall",        required_argument, NULL, OPT_HISTOFALL },
>  			{"histfile",	     required_argument, NULL, OPT_HISTFILE },
>  			{"interval",         required_argument, NULL, OPT_INTERVAL },
> +			{"json",             required_argument, NULL, OPT_JSON },
>  			{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
>  			{"loops",            required_argument, NULL, OPT_LOOPS },
>  			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
>  			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
>  			{"nsecs",            no_argument,       NULL, OPT_NSECS },
>  			{"oscope",           required_argument, NULL, OPT_OSCOPE },
> -			{"output",           required_argument, NULL, OPT_OUTPUT },
>  			{"priority",         required_argument, NULL, OPT_PRIORITY },
>  			{"quiet",            no_argument,       NULL, OPT_QUIET },
>  			{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
> @@ -1080,6 +1080,9 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		case 'i':
>  		case OPT_INTERVAL:
>  			interval = atoi(optarg); break;
> +		case OPT_JSON:
> +			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
>  		case 'l':
>  		case OPT_LOOPS:
>  			max_cycles = atoi(optarg); break;
> @@ -1095,9 +1098,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		case 'o':
>  		case OPT_OSCOPE:
>  			oscope_reduction = atoi(optarg); break;
> -		case OPT_OUTPUT:
> -			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> -			break;
>  		case 'p':
>  		case OPT_PRIORITY:
>  			priority = atoi(optarg);
> @@ -2134,8 +2134,8 @@ int main(int argc, char **argv)
>  	if (!verbose && !quiet && refresh_on_max)
>  		printf("\033[%dB", num_threads + 2);
>  
> -	if (strlen(outfile) != 0)
> -		rt_write_json(outfile, ret, write_stats, NULL);
> +	if (strlen(jsonfile) != 0)
> +		rt_write_json(jsonfile, ret, write_stats, NULL);
>  
>  	if (quiet)
>  		quiet = 2;
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

