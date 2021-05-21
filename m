Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364B4C04FF3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA18613EA
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhEUVtC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 17:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhEUVtB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 17:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621633657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RW8lznhKo3TyxFe6hUyJZ3D//z3sbra3QviHazwc1Rc=;
        b=KvzlbAJT4++nGb0dG5yc3P7AW+mXT/h6Cl6D6zO0Kbe40z9bArXj/NfKU4bQeDYChXx34b
        lEKqalLa5Hy+FHrvHugteGZRJm1vHArZZZOb4ge5ChHWj3aswDop03I+Yiv+t92FAUVzSa
        y3OIEm9ViH3nFYiVD/RSlr3rHKrP4bQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-_HTjBbllNVWKvgA0ZH-VUg-1; Fri, 21 May 2021 17:47:35 -0400
X-MC-Unique: _HTjBbllNVWKvgA0ZH-VUg-1
Received: by mail-qk1-f197.google.com with SMTP id b3-20020a05620a0cc3b02902e9d5ca06f2so9048048qkj.19
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 14:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=RW8lznhKo3TyxFe6hUyJZ3D//z3sbra3QviHazwc1Rc=;
        b=Xy+441naLak8o1RiZ23pkmbt1TRdbGOsJOQsiVJXw14OfPevnnu/uMfksTtbElcWDE
         B9ZNtfSFgbNRD5XslwnR0Ja6kIF6VHVLT2h5rvcPlxlGD16U8QakfYgwAcMchYXHp3lx
         CmvIrIhOMX0OeBeP/96KFoycYYLkm6RcZ9FHsyhK73/oqVblv/MVtJdHRkCA/+qTJKNN
         /KJp6IwpypDsYdT4x31f5ZJ+bDwUuqXrEbNmFLX0IeoyM3pHCt9Te0c00YaNaiDsKJFE
         BdmP/iIGmYAE2yciLjuXrCANI/Ytx+bJzthXdYhiDp1IhfJDZVqH2t3iljJ7Ve42cD00
         FB+w==
X-Gm-Message-State: AOAM531fqLbKgEf7+iqcf17j+ibH1j59pRfg1NiokGAsmjpMWN+HmrUJ
        WNuFhEvOn6AjQ/+llXp4YXN5XZu7F6fmZzbIMJVEOx0kKhWK9d6PRLD/00cn8LosrxNjPvZnF6n
        de+g91KREF6QKCazghd9/VB+vkV8=
X-Received: by 2002:a05:622a:413:: with SMTP id n19mr13586921qtx.238.1621633655467;
        Fri, 21 May 2021 14:47:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLn6Q4bgRP0V0DbaIMyEjLZZ4AE7BD2H2MrsQ1rYmsV1dL4aT2Q6mEGuhkBPbJhsVTCD3PQg==
X-Received: by 2002:a05:622a:413:: with SMTP id n19mr13586913qtx.238.1621633655309;
        Fri, 21 May 2021 14:47:35 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id l65sm5786888qke.7.2021.05.21.14.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:47:35 -0700 (PDT)
Date:   Fri, 21 May 2021 17:47:33 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 07/23] rt-migrate-test: Rename command line
 option --output to --json
In-Reply-To: <20210519170945.21941-8-dwagner@suse.de>
Message-ID: <a1f8483-e664-201e-18d4-3ba96536aea@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-8-dwagner@suse.de>
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
>  src/rt-migrate-test/rt-migrate-test.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 1e0abdd6c0fa..0c4dabeee249 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -102,7 +102,7 @@ static int done;
>  static int loop;
>  static int duration;
>  static int quiet;
> -static char outfile[MAX_PATH];
> +static char jsonfile[MAX_PATH];
>  
>  static pthread_barrier_t start_barrier;
>  static pthread_barrier_t end_barrier;
> @@ -162,9 +162,9 @@ static void usage(int error)
>  	       "                           days.\n"
>  	       "-e       --equal           Use equal prio for #CPU-1 tasks (requires > 2 CPUS)\n"
>  	       "-h       --help            Print this help message\n"
> +	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
>  	       "-l LOOPS --loops=LOOPS     Number of iterations to run (50)\n"
>  	       "-m TIME  --maxerr=TIME     Max allowed error (microsecs)\n"
> -	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p PRIO  --prio=PRIO       base priority to start RT tasks with (2)\n"
>  	       "-q       --quiet           print a summary only on exit\n"
>  	       "-r TIME  --run-time=TIME   Run time (ms) to busy loop the threads (20)\n"
> @@ -175,8 +175,8 @@ static void usage(int error)
>  }
>  
>  enum option_value {
> -	OPT_CHECK=1, OPT_DURATION, OPT_EQUAL, OPT_HELP, OPT_LOOPS,
> -	OPT_MAXERR, OPT_OUTPUT, OPT_PRIO, OPT_QUIET, OPT_RUN_TIME,
> +	OPT_CHECK=1, OPT_DURATION, OPT_EQUAL, OPT_HELP, OPT_JSON,
> +	OPT_LOOPS, OPT_MAXERR, OPT_PRIO, OPT_QUIET, OPT_RUN_TIME,
>  	OPT_SLEEP_TIME
>  };
>  
> @@ -190,9 +190,9 @@ static void parse_options(int argc, char *argv[])
>  			{"duration",	required_argument,	NULL, OPT_DURATION},
>  			{"equal",	no_argument,		NULL, OPT_EQUAL},
>  			{"help",	no_argument,		NULL, OPT_HELP},
> +			{"json",	required_argument,      NULL, OPT_JSON},
>  			{"loops",	required_argument,	NULL, OPT_LOOPS},
>  			{"maxerr",	required_argument,	NULL, OPT_MAXERR},
> -			{"output",	required_argument,      NULL, OPT_OUTPUT },
>  			{"prio",	required_argument,	NULL, OPT_PRIO},
>  			{"quiet",	no_argument,		NULL, OPT_QUIET},
>  			{"run-time",	required_argument,	NULL, OPT_RUN_TIME},
> @@ -221,6 +221,9 @@ static void parse_options(int argc, char *argv[])
>  		case 'h':
>  			usage(0);
>  			break;
> +		case OPT_JSON:
> +			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
>  		case OPT_LOOPS:
>  		case 'l':
>  			nr_runs = atoi(optarg);
> @@ -229,9 +232,6 @@ static void parse_options(int argc, char *argv[])
>  		case 'm':
>  			max_err = usec2nano(atoi(optarg));
>  			break;
> -		case OPT_OUTPUT:
> -			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> -			break;
>  		case OPT_PRIO:
>  		case 'p':
>  			prio_start = atoi(optarg);
> @@ -663,8 +663,8 @@ int main (int argc, char **argv)
>  
>  	print_results();
>  
> -	if (strlen(outfile) != 0)
> -		rt_write_json(outfile, check < 0, write_stats, NULL);
> +	if (strlen(jsonfile) != 0)
> +		rt_write_json(jsonfile, check < 0, write_stats, NULL);
>  
>  	if (stop) {
>  		/*
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

