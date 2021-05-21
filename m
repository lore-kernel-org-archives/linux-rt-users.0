Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0185DC04FF3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBFEE61164
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhEUVnA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 17:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhEUVm6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 17:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621633294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2wTDeVqXyxgYJaIPdmX27B5ixLEzQdnXTcpJDjh420c=;
        b=OTiwJk5jP/gkWe7gc+K4x0ovS6rXYEzD3gfprrSWZclbl4x2zbGnhYAD7p4RGqKnGML+LO
        QXSY1RB/wATyAPD77MXJIbHyL7fRrBX0KgXbo35qJvf9uGXGYaC4QARZMHdMc8zudVgsTG
        AiGQt2H5/zI4g1lZkTwL6O6m0S3gPso=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Z9SDKcLIPjuZP9kQKFXy9g-1; Fri, 21 May 2021 17:41:33 -0400
X-MC-Unique: Z9SDKcLIPjuZP9kQKFXy9g-1
Received: by mail-qv1-f72.google.com with SMTP id w4-20020a0c8e440000b02901f0640ffdafso13561050qvb.13
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 14:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2wTDeVqXyxgYJaIPdmX27B5ixLEzQdnXTcpJDjh420c=;
        b=BifnXZm3k2u3ApPz1tnLF6wqCNW3aQrrK2HSyJw13etUrVBMjLb6kgyrlWuTlCtqBk
         TWwMzOIQFzOlMlFmvzadZ+hqRTDm5tfq1CptHDlx1++BQh0LsbTbCkAh7pdmE8a3f851
         yWWk7pcrSGDyGdcg6b5HVpN4ENKqt6sBebIXoVAhSHAA3JeoDMHW9aQHXbt2ZBbMv0s8
         p/4DP1cQNfdvyzwCCDncpLsBaHfvUqP0NvIpdy2HYUecDfke+YTqU9LtLfwlH6VtzWu8
         JNogk6c/H05LDfFL3RpF8h9QWLrWTrH4AKc5bCF/6caBrLT70u+A1LW3c0Yhc29zRXLd
         nEQQ==
X-Gm-Message-State: AOAM530y/QLv/DU0A8RLzZyzHiF2u1jydWz4KtvMk3tUh/d97pgUqfYV
        1DCnae9LwCFehQeadS4LMhhcJ++BykaRjTUxZUnracfB0iD3DVMOhezW6LxfkHRXcM3TFXQJbjR
        lUs+XBydp39Doezt2WjbXpOaKULg=
X-Received: by 2002:a05:622a:15c9:: with SMTP id d9mr13803029qty.103.1621633292527;
        Fri, 21 May 2021 14:41:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7d7HlzeLwoMYhfs8i67/4KuwxqOmSmYnAYRlo5j+8Rk1NhJK22DfVRKC1u4/u6H7Wec3lEA==
X-Received: by 2002:a05:622a:15c9:: with SMTP id d9mr13803014qty.103.1621633292365;
        Fri, 21 May 2021 14:41:32 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id a23sm5701993qkl.6.2021.05.21.14.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:41:32 -0700 (PDT)
Date:   Fri, 21 May 2021 17:41:30 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 05/23] pmqtest: Rename command line option
 --output to --json
In-Reply-To: <20210519170945.21941-6-dwagner@suse.de>
Message-ID: <0f254f9-396e-33fb-bcb1-bbf71dc96b8e@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-6-dwagner@suse.de>
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
>  src/pmqtest/pmqtest.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index af10b416600c..edda7c69652e 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -231,8 +231,8 @@ static void display_help(int error)
>  	       "-f TO    --forcetimeout=TO force timeout of mq_timedreceive(), requires -T\n"
>  	       "-h       --help            print this help message\n"
>  	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
> +	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> -	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p PRIO  --prio=PRIO       priority\n"
>  	       "-q       --quiet           print a summary only on exit\n"
>  	       "-S       --smp             SMP testing: options -a -t and same priority\n"
> @@ -260,13 +260,12 @@ static int sameprio;
>  static int timeout;
>  static int forcetimeout;
>  static int quiet;
> -static char outfile[MAX_PATH];
> +static char jsonfile[MAX_PATH];
>  
>  enum option_value {
>  	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_DISTANCE, OPT_DURATION,
> -	OPT_FORCETIMEOUT, OPT_HELP, OPT_INTERVAL, OPT_LOOPS,
> -	OPT_OUTPUT, OPT_PRIORITY, OPT_QUIET, OPT_SMP, OPT_THREADS,
> -	OPT_TIMEOUT
> +	OPT_FORCETIMEOUT, OPT_HELP, OPT_INTERVAL, OPT_JSON, OPT_LOOPS,
> +	OPT_PRIORITY, OPT_QUIET, OPT_SMP, OPT_THREADS, OPT_TIMEOUT
>  };
>  
>  static void process_options(int argc, char *argv[])
> @@ -285,8 +284,8 @@ static void process_options(int argc, char *argv[])
>  			{"forcetimeout",required_argument,	NULL, OPT_FORCETIMEOUT},
>  			{"help",	no_argument,		NULL, OPT_HELP},
>  			{"interval",	required_argument,	NULL, OPT_INTERVAL},
> +			{"json",	required_argument,      NULL, OPT_JSON },
>  			{"loops",	required_argument,	NULL, OPT_LOOPS},
> -			{"output",	required_argument,      NULL, OPT_OUTPUT },
>  			{"priority",	required_argument,	NULL, OPT_PRIORITY},
>  			{"quiet",	no_argument,		NULL, OPT_QUIET},
>  			{"smp",		no_argument,		NULL, OPT_SMP},
> @@ -340,13 +339,13 @@ static void process_options(int argc, char *argv[])
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
> @@ -647,12 +646,12 @@ int main(int argc, char *argv[])
>  		mq_unlink(mqname);
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

