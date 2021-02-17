Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E84C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CC664DF3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhBQDw7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhBQDwz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:52:55 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F99C061756
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:52:15 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id e15so8649961qte.9
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=NuTfhKVAsZ4TgGr1a8LmI73JMMa6qDpWBNT0yf28ZgY=;
        b=iQDk21VAEpJ4pTFxEgkS3tFW8RjNOf5DN2CJWmKqW/cwizKqljhcCuTv+t5bQQsgm5
         62bY6W/hOpavvtZMoyRI/RIy6RZN3octqxqrTHsdZgqP9+AiIz8NB4oEqGRo7qGrfjwD
         G6gsNOQxqpf8Xk1G9jUT9l2e+Rj1iH3CktCOu5SkMNwNFNW0dfmJGsXRoXFfzYX1RGUc
         VI94Hee+iM0poto6m1B705DIG+AMhbgv0LWYPYsvUEQ7tG171u4y1aFxAMitlrmvOz4u
         1vYp5swBcXK/cKHz2zusTR4QFF9g5ZmYs+WVshvVqWoY12+t11+5uHw1ZxnYDIuBMLc4
         QlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=NuTfhKVAsZ4TgGr1a8LmI73JMMa6qDpWBNT0yf28ZgY=;
        b=JXp6fFs80THTXN4MwtEufLCg0RHXtmt5Xa5M5C+ES76Lo4/WI3LCrWsGvOGmvI7PBj
         yhTUQcATC1rOTbFPBzmCYZU7t7H/CEtDWJiwlvDAYGRMhoTb9Nh9exEC0dTPwvzAWiw3
         PJa4JrciOoqrrjaDGbUuDBxgu34UZ+cwUfR14W22hn0UqEFaMwkGItMiG4UbKLYXWpYw
         QIHY0uYsrpjasm1tFyY5k53Zh5W0kiNsKAjmI9+GcZxbCQ4aBwWjzlmJ8bZV5cPg9KVG
         15ePX0tJk63HqqU0qgOlMNu64/1QJCFIo2gsc0hriRovMRx5eDuIOo2Nk3A4spzsAeM9
         qLgQ==
X-Gm-Message-State: AOAM533B5fPx3+ZciaVkuSK8cYRiXXH3oh6GSbOI92uz2/InxJVpQiKh
        CVM8sxhEJck4ccXERpHOjz3NPQeQAjpzGQ==
X-Google-Smtp-Source: ABdhPJwEJKHie38s/VEse9v2nRE4UcQ7xrk7/Hj65yQ9iXqcfVlJZVNc3ocbLzUlr96u2h6M3aX/Vw==
X-Received: by 2002:ac8:4754:: with SMTP id k20mr16283733qtp.143.1613533934886;
        Tue, 16 Feb 2021 19:52:14 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id l32sm410160qtd.95.2021.02.16.19.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:52:14 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:52:13 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v5 13/13] oslat: Add quiet command line option
In-Reply-To: <20210210175118.19709-14-dwagner@suse.de>
Message-ID: <983a4562-a25f-3b42-66e7-a896d03ff4eb@redhat.com>
References: <20210210175118.19709-1-dwagner@suse.de> <20210210175118.19709-14-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 10 Feb 2021, Daniel Wagner wrote:

> The quiet option is useful for automated test setups where
> only the final result of the run is interesting.
> 
> Furthermore, this makes oslat accept rt-tests standard options.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 987f2002985d..0d9afedbdc82 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -171,6 +171,7 @@ struct global {
>  	uint64_t              workload_mem_size;
>  	int                   enable_bias;
>  	uint64_t              bias;
> +	int                   quiet;
>  	int                   single_preheat_thread;
>  	int                   output_omit_zero_buckets;
>  	char                  outfile[MAX_PATH];
> @@ -565,6 +566,7 @@ static void usage(int error)
>  	       "                       Total memory usage will be this value multiplies 2*N,\n"
>  	       "                       because there will be src/dst buffers for each thread, and\n"
>  	       "                       N is the number of processors for testing.\n"
> +	       "-q  --quiet            print a summary only on exit\n"
>  	       "-s, --single-preheat   Use a single thread when measuring latency at preheat stage\n"
>  	       "                       NOTE: please make sure the CPU frequency on all testing cores\n"
>  	       "                       are locked before using this parmater.  If you don't know how\n"
> @@ -598,8 +600,8 @@ enum option_value {
>  	OPT_BUCKETSIZE=1, OPT_CPU_LIST, OPT_CPU_MAIN_THREAD,
>  	OPT_DURATION, OPT_RT_PRIO, OPT_HELP, OPT_TRACE_TH,
>  	OPT_WORKLOAD, OPT_WORKLOAD_MEM, OPT_BIAS, OPT_OUTPUT,
> -	OPT_SINGLE_PREHEAT, OPT_ZERO_OMIT, OPT_VERSION
> -
> +	OPT_QUIET, OPT_SINGLE_PREHEAT, OPT_ZERO_OMIT,
> +	OPT_VERSION
>  };
>  
>  /* Process commandline options */
> @@ -618,13 +620,14 @@ static void parse_options(int argc, char *argv[])
>  			{ "workload",	required_argument,	NULL, OPT_WORKLOAD },
>  			{ "workload-mem", required_argument,	NULL, OPT_WORKLOAD_MEM },
>  			{ "bias",	no_argument,		NULL, OPT_BIAS },
> +			{ "quiet",	no_argument,		NULL, OPT_QUIET },
>  			{ "single-preheat", no_argument,	NULL, OPT_SINGLE_PREHEAT },
>  			{ "output",	required_argument,      NULL, OPT_OUTPUT },
>  			{ "zero-omit",	no_argument,		NULL, OPT_ZERO_OMIT },
>  			{ "version",	no_argument,		NULL, OPT_VERSION },
>  			{ NULL, 0, NULL, 0 },
>  		};
> -		int i, c = getopt_long(argc, argv, "b:Bc:C:D:f:hm:sw:T:vz",
> +		int i, c = getopt_long(argc, argv, "b:Bc:C:D:f:hm:qsw:T:vz",
>  				       options, &option_index);
>  		long ncores;
>  
> @@ -707,6 +710,10 @@ static void parse_options(int argc, char *argv[])
>  				exit(1);
>  			}
>  			break;
> +		case OPT_QUIET:
> +		case 'q':
> +			g.quiet = 1;
> +			break;
>  		case OPT_SINGLE_PREHEAT:
>  		case 's':
>  			/*
> @@ -825,9 +832,11 @@ int main(int argc, char *argv[])
>  	signal(SIGINT, handle_alarm);
>  	signal(SIGTERM, handle_alarm);
>  
> -	dump_globals();
> +	if (!g.quiet)
> +		dump_globals();
>  
> -	printf("Pre-heat for 1 seconds...\n");
> +	if (!g.quiet)
> +		printf("Pre-heat for 1 seconds...\n");
>  	if (g.single_preheat_thread)
>  		g.n_threads = 1;
>  	else
> @@ -835,12 +844,14 @@ int main(int argc, char *argv[])
>  	run_expt(threads, 1);
>  	record_bias(threads);
>  
> -	printf("Test starts...\n");
> +	if (!g.quiet)
> +		printf("Test starts...\n");
>  	/* Reset n_threads to always run on all the cores */
>  	g.n_threads = g.n_threads_total;
>  	run_expt(threads, g.runtime);
>  
> -	printf("Test completed.\n\n");
> +	if (!g.quiet)
> +		printf("Test completed.\n\n");
>  
>  	write_summary(threads);
>  
> -- 
> 2.30.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
