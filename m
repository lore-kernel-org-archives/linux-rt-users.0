Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A94C04FF3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 20:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6F5613EB
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 20:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhEUU0U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 16:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhEUU0T (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 16:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621628695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJaAaIiLck2SnWIAuYb2+IuH8Cu0sOUOe5SJcpWY064=;
        b=eP/GStuRO6PPY3U2F5qVQTulMcMYqvwDr4dY4UiJZrWu1Zi7r2f6EMhzyuvZQzujzygD9f
        TiVqePxcmjcSWHdPDfNw9ApMj6FPwaVQYSjydDaJSXiD8pSHciwuc+uZbswRAZYFxQ28lv
        9ghRSopktaK5YzvYLVkRVnaL79UouZs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-MwhsJ9DnM7SmQp3innw13A-1; Fri, 21 May 2021 16:24:54 -0400
X-MC-Unique: MwhsJ9DnM7SmQp3innw13A-1
Received: by mail-qt1-f199.google.com with SMTP id b20-20020ac87fd40000b02901e1370c5e12so16436931qtk.17
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 13:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=sJaAaIiLck2SnWIAuYb2+IuH8Cu0sOUOe5SJcpWY064=;
        b=sKfA6Vo3YkSObX/O3zNIjFB21Xdr7ulE0EmtNIIlJPVujAkP0lIwf6txsNi2tHgZSO
         nVHj54YDL4zF8O+x5eRSuu9WUj3MLq8L9mMej4vlRDXB85W3UqWiatKj/gQL5HNatWVW
         gP7bTthoFCmJp4JByjLfdTqVgVla4F07zEg/RqwGyMB5SIcESgRDAioLsDhkeHqRrzxu
         Nbiw2Z0Tjm3B9UbAJ6Pm2NF0xuakwjYTQyWANuy66szf63lf98vaCNZ90+ucaHWQpDPW
         5XuOcjTVtXK/nXdlsEiBDXPnkyCC2sk+KsyIOghVGs3Mnt0V8eHWYzFV7RxeVCfmGeG/
         ODTA==
X-Gm-Message-State: AOAM5336nXdL6aGstxmRVuKAg9Dj49QoEBsbS3DodPe2YYkJw+qrABTB
        C07j9pzva4p1zwtoYzt3qRgJHiB1nZc4FDQHWJFkm2MxkgWg93rKii5E1N9kqoPgAH3zAQkPRgO
        ajWtdl7oAkmL13ZEBwaLUdQbRGmk=
X-Received: by 2002:a05:620a:12f2:: with SMTP id f18mr14923417qkl.122.1621628694153;
        Fri, 21 May 2021 13:24:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv+rN2GW0zPqGAqPZjLtzb2HwYARolzPAthTS6h+Z5L4d48JfdyiYHr3Nms8S87Kiq7aRWSg==
X-Received: by 2002:a05:620a:12f2:: with SMTP id f18mr14923398qkl.122.1621628694002;
        Fri, 21 May 2021 13:24:54 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id 7sm6078399qtu.38.2021.05.21.13.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:24:53 -0700 (PDT)
Date:   Fri, 21 May 2021 16:24:48 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 2/2] cyclictest: Add --mainaffinity=[CPUSET] option.
In-Reply-To: <20210518083712.8237-3-schwenderjonathan@gmail.com>
Message-ID: <db548620-e1a6-c4cb-3e48-3247865148eb@redhat.com>
References: <20210518083712.8237-1-schwenderjonathan@gmail.com> <20210518083712.8237-3-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 18 May 2021, Jonathan Schwender wrote:

> This allows the user to specify a separate cpuset for the main pid,
> e.g. on a housekeeping CPU.
> If --mainaffinity is not specified, but --affinity is, then the
> current behaviour is preserved and the main thread is bound
> to the cpuset specified by --affinity
> 
> Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
> ---
>  src/cyclictest/cyclictest.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 3bab3b2..a2103c7 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -836,6 +836,8 @@ static void display_help(int error)
>  	       "	 --laptop	   Save battery when running cyclictest\n"
>  	       "			   This will give you poorer realtime results\n"
>  	       "			   but will not drain your battery so quickly\n"
> +	       "         --mainaffinity=[CPUSET]  Run the main thread on CPU #N. This only affects\n"
> +	       "                           the main thread and not the measurement threads\n"
>  	       "-m       --mlockall        lock current and future memory allocations\n"
>  	       "-M       --refresh_on_max  delay updating the screen until a new max\n"
>  	       "			   latency is hit. Useful for low bandwidth.\n"
> @@ -891,6 +893,7 @@ static int quiet;
>  static int interval = DEFAULT_INTERVAL;
>  static int distance = -1;
>  static struct bitmask *affinity_mask = NULL;
> +static struct bitmask *main_affinity_mask = NULL;
>  static int smp = 0;
>  static int setaffinity = AFFINITY_UNSPECIFIED;
>  
> @@ -944,7 +947,7 @@ enum option_values {
>  	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_CLOCK,
>  	OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
>  	OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
> -	OPT_INTERVAL, OPT_LOOPS, OPT_MLOCKALL, OPT_REFRESH,
> +	OPT_INTERVAL, OPT_LOOPS, OPT_MAINAFFINITY, OPT_MLOCKALL, OPT_REFRESH,
>  	OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
>  	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION,
>  	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRIGGER,
> @@ -981,6 +984,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  			{"interval",         required_argument, NULL, OPT_INTERVAL },
>  			{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
>  			{"loops",            required_argument, NULL, OPT_LOOPS },
> +			{"mainaffinity",     required_argument, NULL, OPT_MAINAFFINITY},
>  			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
>  			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
>  			{"nsecs",            no_argument,       NULL, OPT_NSECS },
> @@ -1083,6 +1087,16 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		case 'l':
>  		case OPT_LOOPS:
>  			max_cycles = atoi(optarg); break;
> +		case OPT_MAINAFFINITY:
> +			if (optarg) {
> +				parse_cpumask(optarg, max_cpus, &main_affinity_mask);
> +			} else if (optind < argc &&
> +			           (atoi(argv[optind]) ||
> +			            argv[optind][0] == '0' ||
> +			            argv[optind][0] == '!')) {
> +				parse_cpumask(argv[optind], max_cpus, &main_affinity_mask);
> +			}
> +			break;
>  		case 'm':
>  		case OPT_MLOCKALL:
>  			lockall = 1; break;
> @@ -1802,7 +1816,9 @@ int main(int argc, char **argv)
>  	}
>  
>  	/* Restrict the main pid to the affinity specified by the user */
> -	if (affinity_mask != NULL) {
> +	if (main_affinity_mask != NULL) {
> +		set_main_thread_affinity(main_affinity_mask);

Am I missing something here, if there is a main_affinity_mask we set that
but then skip over the affinity_mask. Don't we want to check both?

> +	} else if (affinity_mask != NULL) {
>  		set_main_thread_affinity(affinity_mask);
>  		if (verbose)
>  			printf("Using %u cpus.\n",
> -- 
> 2.31.1
> 
> 

