Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123F1C2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53EC613D0
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhEVDwp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231295AbhEVDwo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621655479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SDyyNWhUipxurstriTGv1jw3OP6VpLtoGcgmf3YglGE=;
        b=OESwC5w5yEBpPI8Y0U8z74CPeAoFr/N1dvtYMuivWXWeoaAt0ONHDUxJZoIOXb6DIS2TLn
        UnVWv/gcT+X/Zwqt8s2UvOvjNnbyAPspuyVuAdF8OS3K1JVS5Q/Uue3b07hCC8Aa/x9oap
        vy3A5aNTzSbC967S2Bz7b2Jnti+HDTY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-ZqVk1reIPJK7D08zxhrzmg-1; Fri, 21 May 2021 23:51:18 -0400
X-MC-Unique: ZqVk1reIPJK7D08zxhrzmg-1
Received: by mail-qt1-f199.google.com with SMTP id r1-20020ac85c810000b02901fa9798cdb5so11028833qta.8
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=SDyyNWhUipxurstriTGv1jw3OP6VpLtoGcgmf3YglGE=;
        b=jfg6YfivZteOq50VKFCBzD4EX+KhIXjZf1htgxMf+eHkAgaX8GP1TIPTQsYnzUnPmR
         Ih4kjgqCfH4vjjo/Pt9h8V/8mjIMK8GOgBrhqG+tSFY3sBqzLaQXBoNwd5dauh/9qSFA
         EjYQncjpLL3NKA/VBkEO1058DcmgU4MLlFkbogTxAnUaZupnkBFy3z7Uttc+iNPvR3SE
         ot+X5okczAzGXkONXIFPYz0TWF4viHaNe2bt1YV7owKgyOxhALcObZcEgSXKByHis4pU
         4GpKZ1MMhFQTv4qb0PjFRfxuJ7M/p+AZheMNFIOpl85n6Nsp/1f2S2ee16EbYRUuCfmw
         VkHQ==
X-Gm-Message-State: AOAM5306NPaS4rIXQK687/txVwKcvvJjXCBvD2QfN54VXB1DojTsbghm
        ZsHpRYJgQIsk4hEQski/kEtJrioBXmb7rTdlPxcwWLmtNlzgtyHXtidfP7aYNv8ermVJNvvEV+a
        H4l9ZJHJggRkWlssmwwgWR6A/IBU=
X-Received: by 2002:a37:d4b:: with SMTP id 72mr12726742qkn.443.1621655477733;
        Fri, 21 May 2021 20:51:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlAO69a3tixl9J/wHekkUJmUjL+uBQ73rMYOHkEmDDXb/UqYNvBGgtEDqUXjBMviAJG7eCGA==
X-Received: by 2002:a37:d4b:: with SMTP id 72mr12726738qkn.443.1621655477584;
        Fri, 21 May 2021 20:51:17 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id o4sm6590708qkb.29.2021.05.21.20.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:51:17 -0700 (PDT)
Date:   Fri, 21 May 2021 23:51:16 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 12/23] svsematest: Rename command line option
 --output to --json
In-Reply-To: <20210519170945.21941-13-dwagner@suse.de>
Message-ID: <153dcfb-b0a7-f2ef-9f7a-91e271b98a7@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-13-dwagner@suse.de>
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
>  src/svsematest/svsematest.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 9485ab6d95c8..8c55b6b7c48d 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -233,8 +233,8 @@ static void display_help(int error)
>  	       "                           days.\n"
>  	       "-f [OPT] --fork[=OPT]      fork new processes instead of creating threads\n"
>  	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
> +	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> -	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p PRIO  --prio=PRIO       priority\n"
>  	       "-S       --smp             SMP testing: options -a -t and same priority\n"
>  	       "                           of all threads\n"
> @@ -257,11 +257,11 @@ static int distance = 500;
>  static int smp;
>  static int sameprio;
>  static int quiet;
> -static char outfile[MAX_PATH];
> +static char jsonfile[MAX_PATH];
>  
>  enum option_value {
>  	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_DISTANCE, OPT_DURATION,
> -	OPT_FORK, OPT_HELP, OPT_INTERVAL, OPT_LOOPS, OPT_OUTPUT,
> +	OPT_FORK, OPT_HELP, OPT_INTERVAL, OPT_JSON, OPT_LOOPS,
>  	OPT_PRIORITY, OPT_QUIET, OPT_SMP, OPT_THREADS
>  };
>  
> @@ -282,8 +282,8 @@ static void process_options(int argc, char *argv[])
>  			{"fork",	optional_argument,	NULL, OPT_FORK},
>  			{"help",	no_argument,		NULL, OPT_HELP},
>  			{"interval",	required_argument,	NULL, OPT_INTERVAL},
> +			{"json",	required_argument,      NULL, OPT_JSON},
>  			{"loops",	required_argument,	NULL, OPT_LOOPS},
> -			{"output",	required_argument,      NULL, OPT_OUTPUT},
>  			{"priority",	required_argument,	NULL, OPT_PRIORITY},
>  			{"quiet",	no_argument,		NULL, OPT_QUIET},
>  			{"smp",		no_argument,		NULL, OPT_SMP},
> @@ -343,13 +343,13 @@ static void process_options(int argc, char *argv[])
>  		case 'i':
>  			interval = atoi(optarg);
>  			break;
> +		case OPT_JSON:
> +			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
>  		case OPT_LOOPS:
>  		case 'l':
>  			max_cycles = atoi(optarg);
>  			break;
> -		case OPT_OUTPUT:
> -			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> -			break;
>  		case OPT_PRIORITY:
>  		case 'p':
>  			priority = atoi(optarg);
> @@ -774,12 +774,12 @@ int main(int argc, char *argv[])
>  		}
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
>  nosem:
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

