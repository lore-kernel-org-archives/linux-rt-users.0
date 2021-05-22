Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0470FC2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15C0613D8
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhEVDfr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231237AbhEVDfb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621654388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wFt7yfu1k8VscDsO8ctsxUy4mh6P+6k24FWI3GsGPMo=;
        b=c/9ug3JBImuxrqOR5RnrERt3h52AsxP3QJb3mBnQIqjIxKAcMXLJmPUzIM6oLuosFJySVU
        zOkL8tnrYusClT4gKCyQXukBis9daq4bjbH0VdNlX6doYhxYaTL05zqPP5dmC4HrznJYsc
        kZ1fZhbt1Q+IevJHhAqdbXMuEzMjvxM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-BqJqRq-HPuu0UAV3_iJxlw-1; Fri, 21 May 2021 23:33:07 -0400
X-MC-Unique: BqJqRq-HPuu0UAV3_iJxlw-1
Received: by mail-qt1-f197.google.com with SMTP id o15-20020a05622a138fb02901e0ac29f6b2so17259196qtk.11
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=wFt7yfu1k8VscDsO8ctsxUy4mh6P+6k24FWI3GsGPMo=;
        b=qTLXDgH8eBeJ8vY9mtPAS2R1KaGX0Pq72R2WQF1bO2NkaemQEeyx2dHEbTZdEq/RIx
         OMek28+oRy9Pm7x1XMnro4Z1woG3odXX4UpIoae9qJCbjpAuI6uWlfRh32u8qufZWjVt
         1YwBN5s7LXvnjv5hG6evxP/XClbfE4G5U0uar623fEYxM1oZVdoSGO2O3sBjtHpq4NIm
         QALNsmuKSFUTwJTLs42SKua/SZGj9tkHC6KvH7RXR6DjB7L4TQ+kXm5Gm9dQNRt89ePN
         28Do6BEaa6WcKLkEC31EOE+iZx2Awfl6KwElk8RG7Jz12zuqGQooZkc4dmx0Ke+4roj9
         IYzw==
X-Gm-Message-State: AOAM530bfubxrLrV4nUw2Lj5N3vvjAcmkTFy2eiB945Sikygl8MY5OiU
        XWMCkrVMeCtCHl+wvWWNDue1WSZXC8xqtXxi19ueyPWL1/KBXxRTfbb1HHiKBlxZHN546C2StVq
        ClTxjOuxV8h9BaDIOF7UuJj3++Tg=
X-Received: by 2002:ae9:c010:: with SMTP id u16mr16672003qkk.133.1621654386841;
        Fri, 21 May 2021 20:33:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ111FTcYXdhogpMFjrP7PUObg45pc0sNg5LS5ulEvwJZWDGl2nRbgRnq6IJx4MgxqKLf00A==
X-Received: by 2002:ae9:c010:: with SMTP id u16mr16671988qkk.133.1621654386689;
        Fri, 21 May 2021 20:33:06 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id m15sm5749532qtn.47.2021.05.21.20.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:33:06 -0700 (PDT)
Date:   Fri, 21 May 2021 23:33:04 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 10/23] sigwaittest: Rename command line option
 --output to --json
In-Reply-To: <20210519170945.21941-11-dwagner@suse.de>
Message-ID: <1bf65194-9ec4-f7b1-f4ee-416d8e91b6ac@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-11-dwagner@suse.de>
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
>  src/sigwaittest/sigwaittest.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index fda44724dd62..98a740d2cce2 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -220,8 +220,8 @@ static void display_help(int error)
>  	       "                           days.\n"
>  	       "-f [OPT] --fork[=OPT]      fork new processes instead of creating threads\n"
>  	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
> +	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> -	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p PRIO  --prio=PRIO       priority\n"
>  	       "-q       --quiet           print a summary only on exit\n"
>  	       "-t       --threads         one thread per available processor\n"
> @@ -242,11 +242,11 @@ static int duration;
>  static int interval = 1000;
>  static int distance = 500;
>  static int quiet;
> -static char outfile[MAX_PATH];
> +static char jsonfile[MAX_PATH];
>  
>  enum option_value {
>  	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_DISTANCE, OPT_DURATION,
> -	OPT_FORK, OPT_HELP, OPT_INTERVAL, OPT_LOOPS, OPT_OUTPUT,
> +	OPT_FORK, OPT_HELP, OPT_INTERVAL, OPT_JSON, OPT_LOOPS,
>  	OPT_PRIORITY, OPT_QUIET, OPT_THREADS
>  };
>  
> @@ -267,8 +267,8 @@ static void process_options(int argc, char *argv[])
>  			{"fork",	optional_argument,	NULL, OPT_FORK},
>  			{"help",	no_argument,		NULL, OPT_HELP},
>  			{"interval",	required_argument,	NULL, OPT_INTERVAL},
> +			{"json",	required_argument,      NULL, OPT_JSON},
>  			{"loops",	required_argument,	NULL, OPT_LOOPS},
> -			{"output",	required_argument,      NULL, OPT_OUTPUT },
>  			{"priority",	required_argument,	NULL, OPT_PRIORITY},
>  			{"quiet",	no_argument,		NULL, OPT_QUIET},
>  			{"threads",	optional_argument,	NULL, OPT_THREADS},
> @@ -324,13 +324,13 @@ static void process_options(int argc, char *argv[])
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
> @@ -702,12 +702,12 @@ int main(int argc, char *argv[])
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
>  nomem:
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

