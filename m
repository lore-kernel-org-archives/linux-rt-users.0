Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558E1C47080
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38394613F6
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhEUVvL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 17:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229634AbhEUVvJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 17:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621633786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gUM0rIkZAssaez/gk6BJKjiM7OLaaPeH0btf9Qv7C44=;
        b=AiL5aU9Aq7oQ5a7ozJs0ymf2w2P78SjaH/Ajey42lYjqI9aXcTcyix0KBpzgCgbC9Bfsfc
        cWNV0yqu/Um9xM9Drs7vK1j457TFv8JlBUgZgcEHllFi1rurag4XxJE1/3c7HcPLtVRAFB
        TsADhFyOYLzFh6ZDuxzdo8vp77C1MFw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-LNd8xf31NlyIQcxKFt2pfA-1; Fri, 21 May 2021 17:49:44 -0400
X-MC-Unique: LNd8xf31NlyIQcxKFt2pfA-1
Received: by mail-qv1-f70.google.com with SMTP id e15-20020a0caa4f0000b02901eedbb09299so16885381qvb.15
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 14:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=gUM0rIkZAssaez/gk6BJKjiM7OLaaPeH0btf9Qv7C44=;
        b=YoenIt09gzzoGA12xLQCW/t3E700lBQUeKiB5rYFoJFFjLYfC3tM3z/0X7ka4ar83L
         ee8vMg8ck7OC6UutfJm80kRaD4DytrLwliDpz4DXF3IG/vApklahoRtWtX1L0BZdVGCP
         MfGXHSnsnZP7pRW2XxM0WTBW1SqUiooGcwVBCnXyv0uLVXa49HN3ryFFPEximeYRznpM
         3+6JqZhr8OwjHEa/9dIh1nupX89JXh9hjh9c8ceYYzLYAW8ZAD97Jxllcczd2oopqRcf
         I21Ld4ZSyiFrs3XFSN/Jadxd4Nj/r/DQhwKV0tRz+5LY6ARJBZ0VxIiNFDGV0jCz5r24
         hEDg==
X-Gm-Message-State: AOAM530icU67m/mlsc/xNesD8seQibzU14RN1zl5HVshYXTZXlI/YxGK
        hzN8n8BH/LlijocbgLbyZkGSOaDUMwd/xTnjOjCItsYM+Fp6sSjJmpU/mt0wa7RdOkoUwpeLSJi
        XtYN04m3j8r/V1Jj4trmY9836smA=
X-Received: by 2002:a37:ae04:: with SMTP id x4mr14278094qke.315.1621633783946;
        Fri, 21 May 2021 14:49:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuzi9F2JmuQilKewfXaTasKoP1anSvH8/4PxgZ2U4qbvER9Uz539InO9ORu+lz34ZoCjkJRA==
X-Received: by 2002:a37:ae04:: with SMTP id x4mr14278080qke.315.1621633783791;
        Fri, 21 May 2021 14:49:43 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id m22sm5814767qkk.65.2021.05.21.14.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:49:43 -0700 (PDT)
Date:   Fri, 21 May 2021 17:49:42 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 08/23] cyclicdeadline: Rename command line
 option --output to --json
In-Reply-To: <20210519170945.21941-9-dwagner@suse.de>
Message-ID: <d07db712-47ca-1d7d-6b15-81eefbe6e19@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-9-dwagner@suse.de>
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
>  src/sched_deadline/cyclicdeadline.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index b81fb3a2091d..4c81891bbe63 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -89,7 +89,7 @@ static int nr_threads;
>  static int use_nsecs;
>  static int mark_fd;
>  static int quiet;
> -static char outfile[MAX_PATH];
> +static char jsonfile[MAX_PATH];
>  
>  static int find_mount(const char *mount, char *debugfs)
>  {
> @@ -605,7 +605,7 @@ static void usage(int error)
>  	       "-h       --help            Show this help menu.\n"
>  	       "-i INTV  --interval        The shortest deadline for the tasks in us\n"
>  	       "                           (default 1000us).\n"
> -	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
> +	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
>  	       "-s STEP  --step            The amount to increase the deadline for each task in us\n"
>  	       "                           (default 500us).\n"
>  	       "-t NUM   --threads         The number of threads to run as deadline (default 1).\n"
> @@ -986,7 +986,7 @@ static void write_stats(FILE *f, void *data)
>  
>  enum options_valud {
>  	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
> -	OPT_OUTPUT, OPT_STEP, OPT_THREADS, OPT_QUIET
> +	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET
>  };
>  
>  int main(int argc, char **argv)
> @@ -1021,7 +1021,7 @@ int main(int argc, char **argv)
>  			{ "duration",	required_argument,	NULL,	OPT_DURATION },
>  			{ "help",	no_argument,		NULL,	OPT_HELP },
>  			{ "interval",	required_argument,	NULL,	OPT_INTERVAL },
> -			{ "output",	required_argument,	NULL,	OPT_OUTPUT },
> +			{ "json",	required_argument,	NULL,	OPT_JSON },
>  			{ "step",	required_argument,	NULL,	OPT_STEP },
>  			{ "threads",	required_argument,	NULL,	OPT_THREADS },
>  			{ "quiet",	no_argument,		NULL,	OPT_QUIET },
> @@ -1047,8 +1047,8 @@ int main(int argc, char **argv)
>  		case 'i':
>  			interval = atoi(optarg);
>  			break;
> -		case OPT_OUTPUT:
> -			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> +		case OPT_JSON:
> +			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
>  			break;
>  		case OPT_STEP:
>  		case 's':
> @@ -1227,8 +1227,8 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	if (strlen(outfile) != 0)
> -		rt_write_json(outfile, 0, write_stats, sched_data);
> +	if (strlen(jsonfile) != 0)
> +		rt_write_json(jsonfile, 0, write_stats, sched_data);
>  
>  	if (setcpu_buf)
>  		free(setcpu_buf);
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

