Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA7AC04FF3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 20:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4846135A
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 20:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhEUUXE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 16:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhEUUXD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 16:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621628499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJaAaIiLck2SnWIAuYb2+IuH8Cu0sOUOe5SJcpWY064=;
        b=b57Ys5tyxa2HYbRqh1YFVpnPR2zvYp4h0GB9q2YSprt3DJ3eQZ6hHnvOKB6CbqD7lfCq+I
        hOtnhTh9h0PQLzjJ1mzYYXKetR/MKxW6x6T0p3VpJcoz+YGhkDOTB5cNhXMCF2qmX5FOf8
        3I10IdQ4utHQNQe1u0di8YU9xtSzwTU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-38U6fybNOEuoj9wbYzxCsQ-1; Fri, 21 May 2021 16:21:37 -0400
X-MC-Unique: 38U6fybNOEuoj9wbYzxCsQ-1
Received: by mail-qt1-f198.google.com with SMTP id x19-20020ac87a930000b02901f6125bcda0so4325029qtr.19
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 13:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=sJaAaIiLck2SnWIAuYb2+IuH8Cu0sOUOe5SJcpWY064=;
        b=TrjWilwfahlP4Pz4XfHKhFmJYRs34Fh14xfWcr78CFHtSv46G8s6rB3Y9fe54a1yAv
         m50ydauNK3uE07ehSG/gwQh86CNqaE3HI9XlCxYjzg11G9Ynn/7ACgJby2p9E67dBjFr
         6/5efp/zIzSN5c6Tegpm6SuQdWFdqp45Gc+yNxEdGZNkRMbvSyc7w+uP5UV95EgTgqfg
         4GARvYgJou4pUNfQuZfFRhIt3YcCl84JooZQlx5+IKK83Z79f8mfjW4DhxhJDDXm6shI
         HRvpLDqb6KlHQV4DVCDr1rNP1lyXO/3kO0NlJfHQUUZPftWBACzmrDw0AqSqM8YDvjaC
         qt6Q==
X-Gm-Message-State: AOAM5303JuVE6zm88d7wtDqQgoRvQdBvuRQk/fKhqWU4Q1WqFisXXX5p
        ZBhMVvM1z5kGf7xAB9DCpydsnGP9w6bonrlRGRQ1LrrHHcpRQXQBKxodGVH0IQZwBBFPuhrGZx7
        T2okVXlwStOskRSYN7bnSWFqPBrg=
X-Received: by 2002:a05:620a:675:: with SMTP id a21mr14063881qkh.333.1621628497302;
        Fri, 21 May 2021 13:21:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1mdwe/9E8YQcC+ygLco37ipIAowxphQCi/vgWWIvv8Lvu2Qs/1DtlImGLtOoINJ3z5pRntA==
X-Received: by 2002:a05:620a:675:: with SMTP id a21mr14063865qkh.333.1621628497144;
        Fri, 21 May 2021 13:21:37 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id 104sm5195885qta.90.2021.05.21.13.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:21:36 -0700 (PDT)
Date:   Fri, 21 May 2021 16:21:35 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 2/2] cyclictest: Add --mainaffinity=[CPUSET] option.
In-Reply-To: <20210518083712.8237-3-schwenderjonathan@gmail.com>
Message-ID: <93e1e1-6569-467d-afbb-d9586c8c1cec@redhat.com>
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

