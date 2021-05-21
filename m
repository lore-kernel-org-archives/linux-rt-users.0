Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5404FC04FF3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385B2613EA
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhEUVwr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 17:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhEUVwq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 17:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621633882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hg3VSc9p8yMG5wPQSIfsvWr89WGoghoty8B0zmiI+s0=;
        b=LgP2jCmxnxCPnFtXF3gnYexht0PCFPyfInGN11Mt/V/vgvkNdScQs56b32QQOV/nqNb3rr
        HnhWGnFGV0VuL96e0YLRxJ92nAvzQ5V5+E77NLP0KrWkhXS36YDa4YDqgq1drYZYhsvIzm
        YFkN2EQxtoG3PeuYztK3OZjEBs7hAKI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-HEuVv4lnM62gr8YvNwNZcA-1; Fri, 21 May 2021 17:51:20 -0400
X-MC-Unique: HEuVv4lnM62gr8YvNwNZcA-1
Received: by mail-qk1-f198.google.com with SMTP id b203-20020a3767d40000b02903a6207bfef5so2169000qkc.1
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 14:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=hg3VSc9p8yMG5wPQSIfsvWr89WGoghoty8B0zmiI+s0=;
        b=qwZRB+7c2bB9/EEWEwmhePHIpgUbDe7YF3I0/RNqBR5vQPh4CqNUGSoUBko7aeQK/N
         2ej/phCttZ785YNmIP6PC/GNOSvY5Fktp4LQwYD3C2NgEIHG7d0k16bqh0IRsaye6w/a
         W69lawVDaEDh3aixqxq8MVEcH9JYg/Si5kBqMsXzchrWu1v8q4SHLq03yb8doZzWua6f
         hbLcthG35JESZFb5LFrienmaqZHVq6jvCp1xj5oJQrdfYGIxJxq5tUg3g7Yhq7RiW4wr
         6i8q7q+4hKa4MXy6EDuBPo9fwbD72ZcTcuZxZKhzkxGVsgK8QTzm5wI8Uli/J6Dvajw+
         q8Yg==
X-Gm-Message-State: AOAM531REBEueWqo6OfvsqT2pJHuenjHAeXDL8A2HNQKz7ztFTgR/ZU8
        BXt6CEdg4avf1G1I/OH3nejaX8QHeqZ0nd6pCc7a1FGmi1oQvxDRSHVXUEnj8qqA6mMQWmjWQCD
        DtFb+XppVIgANLmMGQxtF7qHjAak=
X-Received: by 2002:a05:620a:22f2:: with SMTP id p18mr15132124qki.410.1621633880543;
        Fri, 21 May 2021 14:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0B9BpXKNeULZXYYm+XhVKcPEJyAzdx1EfiS6XWh78UgcK7pF/p6l+MbrWOgHFQrnCHJHMdg==
X-Received: by 2002:a05:620a:22f2:: with SMTP id p18mr15132115qki.410.1621633880371;
        Fri, 21 May 2021 14:51:20 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id x11sm781113qkh.129.2021.05.21.14.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:51:20 -0700 (PDT)
Date:   Fri, 21 May 2021 17:51:18 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 09/23] signaltest: Rename command line option
 --output to --json
In-Reply-To: <20210519170945.21941-10-dwagner@suse.de>
Message-ID: <631330f6-8f79-a050-491d-75b65d178e2@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-10-dwagner@suse.de>
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
>  src/signaltest/signaltest.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index f43920e1a853..2dd22070cb5d 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -187,9 +187,9 @@ static void display_help(int error)
>  		"                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
>  		"                           days.\n"
>  		"-h       --help            display usage information\n"
> +		"         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
>  		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
>  		"-m       --mlockall        lock current and future memory allocations\n"
> -		"         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
>  		"-q       --quiet           print a summary only on exit\n"
>  		"-t NUM   --threads=NUM     number of threads: default=2\n"
> @@ -210,12 +210,12 @@ static struct bitmask *affinity_mask = NULL;
>  static int smp = 0;
>  static int numa = 0;
>  static int setaffinity = AFFINITY_UNSPECIFIED;
> -static char outfile[MAX_PATH];
> +static char jsonfile[MAX_PATH];
>  
>  enum option_values {
>  	OPT_AFFINITY=1, OPT_BREAKTRACE,
> -	OPT_DURATION, OPT_HELP, OPT_LOOPS,
> -	OPT_MLOCKALL, OPT_OUTPUT, OPT_PRIORITY,
> +	OPT_DURATION, OPT_HELP, OPT_JSON,
> +	OPT_LOOPS, OPT_MLOCKALL, OPT_PRIORITY,
>  	OPT_QUIET, OPT_SMP, OPT_THREADS, OPT_VERBOSE
>  };
>  
> @@ -233,9 +233,9 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  			{"breaktrace",	required_argument,	NULL, OPT_BREAKTRACE},
>  			{"duration",	required_argument,	NULL, OPT_DURATION},
>  			{"help",	no_argument,		NULL, OPT_HELP},
> +			{"json",	required_argument,	NULL, OPT_JSON},
>  			{"loops",	required_argument,	NULL, OPT_LOOPS},
>  			{"mlockall",	no_argument,		NULL, OPT_MLOCKALL},
> -			{"output",	required_argument,	NULL, OPT_OUTPUT},
>  			{"priority",	required_argument,	NULL, OPT_PRIORITY},
>  			{"quiet",	no_argument,		NULL, OPT_QUIET},
>  			{"smp",		no_argument,		NULL, OPT_SMP},
> @@ -287,6 +287,9 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  		case 'h':
>  			display_help(0);
>  			break;
> +		case OPT_JSON:
> +			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
>  		case OPT_LOOPS:
>  		case 'l':
>  			max_cycles = atoi(optarg);
> @@ -295,9 +298,6 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  		case 'm':
>  			lockall = 1;
>  			break;
> -		case OPT_OUTPUT:
> -			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> -			break;
>  		case OPT_PRIORITY:
>  		case 'p':
>  			priority = atoi(optarg);
> @@ -558,8 +558,8 @@ int main(int argc, char **argv)
>  		if (stat[i].values)
>  			free(stat[i].values);
>  	}
> -	if (strlen(outfile) != 0)
> -		rt_write_json(outfile, ret, write_stats, par);
> +	if (strlen(jsonfile) != 0)
> +		rt_write_json(jsonfile, ret, write_stats, par);
>  
>  	free(stat);
>   outpar:
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

