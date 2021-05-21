Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE09C04FF3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E96613EC
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhEUVrV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 17:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhEUVrU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 17:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621633557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0QdD+crm9TELUPK7FBPLutb7mL1OqUa5rDA4VMiyVgA=;
        b=g0y9wRSG8CJeXX47gh/w1dKoGQB5V9a6gFCdAqJxvMMeL9fCPIsDKm/jcC+RK6VGTOtFFW
        jcgQ8DUXk7eba8Q0YXkmZC+5hL2O4PCfAqvhJ9Crb5cRD4mmqmyQCioEC/vPlPQ5yEAieI
        GiLClGwCzcLmEzT9FujGaeMKY4OyxCQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-JhpHOuHtNBOxNaz-ajLAUw-1; Fri, 21 May 2021 17:45:55 -0400
X-MC-Unique: JhpHOuHtNBOxNaz-ajLAUw-1
Received: by mail-qv1-f72.google.com with SMTP id r11-20020a0cb28b0000b02901c87a178503so18374074qve.22
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 14:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=0QdD+crm9TELUPK7FBPLutb7mL1OqUa5rDA4VMiyVgA=;
        b=psYw/SBkDvmA+t//rkZlY9cArYs17MZtKB/ZqQ3JNCBvwHjZq9YX4MFLu27Jimkn+p
         0MSAb9z+aOSJaCPqQO0OOqVlrfeYYit/Xlukzo+7uawPYTObKV6NyZWckfrYnE+yLrNE
         QVCSzwpaKJ1IGfaUG8oIC6BIT90DSFjw8RwrS2h0eevRxscQKrpOJf5d9BwOpj/lQH56
         jv7UkReaumUnarzl9kXmt87lHFNgSaYhSCvQ4ob7B1yBYYTGrYtV+pBZEhqL/xjlJ8TE
         4M/GyhdTA4RR38Cou3iy38dqzrg+mF5DNtbh3eaiHJKbPZ5dhASKqepqaoXfpsOm6L60
         uQDw==
X-Gm-Message-State: AOAM5328IWMPNafmwTJBbXFUobh4Gb4Cx92HB8v/1h5MnibR7T1ecVcd
        1qAMuS/E3669URJbx+B5kwCLK2seOEtbB7i7Yx/m0NP//VDBrfK8wAULB4cfI/j16MjJvV3wJYx
        0pVh6/v+K3K9o2AjkPMCL3EjDd4A=
X-Received: by 2002:a37:e0e:: with SMTP id 14mr2491525qko.374.1621633554878;
        Fri, 21 May 2021 14:45:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/uQb9rbjlLkGZd6AZNqnPHxKgJrTlyssvNmiPRK22KGYjQeuzN9gbvSTbwYTdImZwwmwCQA==
X-Received: by 2002:a37:e0e:: with SMTP id 14mr2491510qko.374.1621633554718;
        Fri, 21 May 2021 14:45:54 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id x19sm5251122qts.19.2021.05.21.14.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:45:54 -0700 (PDT)
Date:   Fri, 21 May 2021 17:45:53 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 06/23] ptsematest: Rename command line option
 --output to --json
In-Reply-To: <20210519170945.21941-7-dwagner@suse.de>
Message-ID: <b4b41df1-c217-6054-1852-a8118c174487@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-7-dwagner@suse.de>
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
>  src/ptsematest/ptsematest.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index 70eb79e89635..5822164386de 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -155,8 +155,8 @@ static void display_help(int error)
>  	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
>  	       "                           days.\n"
>  	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
> +	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> -	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p PRIO  --prio=PRIO       priority\n"
>  	       "-q       --quiet           print a summary only on exit\n"
>  	       "-S       --smp             SMP testing: options -a -t and same priority\n"
> @@ -182,11 +182,11 @@ static int distance = 500;
>  static int smp;
>  static int sameprio;
>  static int quiet;
> -static char outfile[MAX_PATH];
> +static char jsonfile[MAX_PATH];
>  
>  enum option_value {
>  	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_DISTANCE, OPT_DURATION,
> -	OPT_HELP, OPT_INTERVAL, OPT_LOOPS, OPT_OUTPUT, OPT_PRIORITY,
> +	OPT_HELP, OPT_INTERVAL, OPT_JSON, OPT_LOOPS, OPT_PRIORITY,
>  	OPT_QUIET, OPT_SMP, OPT_THREADS
>  };
>  
> @@ -205,8 +205,8 @@ static void process_options(int argc, char *argv[])
>  			{"duration",	required_argument,	NULL, OPT_DURATION},
>  			{"help",	no_argument,		NULL, OPT_HELP},
>  			{"interval",	required_argument,	NULL, OPT_INTERVAL},
> +			{"json",	required_argument,      NULL, OPT_JSON },
>  			{"loops",	required_argument,	NULL, OPT_LOOPS},
> -			{"output",	required_argument,      NULL, OPT_OUTPUT },
>  			{"priority",	required_argument,	NULL, OPT_PRIORITY},
>  			{"quiet",	no_argument	,	NULL, OPT_QUIET},
>  			{"smp",		no_argument,		NULL, OPT_SMP},
> @@ -250,6 +250,9 @@ static void process_options(int argc, char *argv[])
>  		case 'i':
>  			interval = atoi(optarg);
>  			break;
> +		case OPT_JSON:
> +			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
>  		case OPT_HELP:
>  		case '?':
>  		case 'h':
> @@ -259,9 +262,6 @@ static void process_options(int argc, char *argv[])
>  		case 'l':
>  			max_cycles = atoi(optarg);
>  			break;
> -		case OPT_OUTPUT:
> -			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> -			break;
>  		case OPT_PRIORITY:
>  		case 'p':
>  			priority = atoi(optarg);
> @@ -515,12 +515,12 @@ int main(int argc, char *argv[])
>  		pthread_mutex_destroy(&syncmutex[i]);
>  	}
>  
> -	if (strlen(outfile) != 0) {
> +	if (strlen(jsonfile) != 0) {
>  		struct params_stats ps = {
>  			.receiver = receiver,
>  			.sender = sender,
>  		};
> -		rt_write_json(outfile, 0, write_stats, &ps);
> +		rt_write_json(jsonfile, 0, write_stats, &ps);
>  	}
>  
>  nomem:
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

