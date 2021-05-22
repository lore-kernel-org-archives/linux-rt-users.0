Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3893C2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8538561073
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhEVDfs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231228AbhEVDfc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621654447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=quHvIW1ydjQXaSwFUFGoFvWqMXWNdGI5B2kNvDA7fU0=;
        b=Z0eMkmh3FsdfGN8V88plSDAVbNAGN8BOJVxnrzFzeVdYroWZRx30d91I0yVDO0ZzLB9KFV
        cG5Sn7l6FTt7X/rjkn7t3GQZapr4wPdMfXyQa4Liqilp0E2QwnPu+sOk6/hKysloSFUBTQ
        r8Iea+2ZVlStKUCpcKkGTpBYvNo9II4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-Tcc59s29PyaF6IclAF2qjg-1; Fri, 21 May 2021 23:34:05 -0400
X-MC-Unique: Tcc59s29PyaF6IclAF2qjg-1
Received: by mail-qt1-f198.google.com with SMTP id z14-20020ac8710e0000b029020e9ce69225so6599817qto.7
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=quHvIW1ydjQXaSwFUFGoFvWqMXWNdGI5B2kNvDA7fU0=;
        b=H6td7MZQTfKO3yauTmvDY++xA8F6s8EqXuMk7+dVExz7v9U3nKTN735pj9RjvQs1Oc
         BgoNR9xhxMOi4+V1NoTjoeDIFuhz9U7EzFafOBXejWiEkqpCJBZiQcYOUKNBvSbZPUKG
         0REl9KhribTYwvA3SWddd1oC17UBP7k82+i+oHAFO5osa6IKYDHENCaeD3XP7SWB7RvR
         3hPbYfb6FyGJlHe0LkvA5iV737IfOi0qZ6Qb5pYSgiRa81Kas+MHe35Ts8FdEZHcLdHO
         k2SklenxGRgql/2mc2fGY+7fhCZX0f5PwYSDA/nvneUCfVdutXD+F25Vuwy16bGVyYDU
         PhwQ==
X-Gm-Message-State: AOAM532yswykP4dA29JPWzx75x52pJh7xre9dPnNX6rwhDNuV/MaM7E3
        G6e4x8wiflLZI38CkM4uWwPjD4zc4WzTTiTSk82YqwL3YT6iKJ+vY92I20WUYAHVB6Sth7rXE68
        2Yjca+Pq1fr83FyUCs7G7ejiLpPE=
X-Received: by 2002:ad4:56a8:: with SMTP id bd8mr17258426qvb.9.1621654445430;
        Fri, 21 May 2021 20:34:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzfaqyVG+6kB8sCfL27/IUE6UzCr9Vcchq0+9XTRiALhz4GCV0oL3Hot+T4raQRQG3taHBzg==
X-Received: by 2002:ad4:56a8:: with SMTP id bd8mr17258415qvb.9.1621654445264;
        Fri, 21 May 2021 20:34:05 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id z24sm5903742qtm.53.2021.05.21.20.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:34:04 -0700 (PDT)
Date:   Fri, 21 May 2021 23:34:03 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 11/23] ssdd: Rename command line option
 --output to --json
In-Reply-To: <20210519170945.21941-12-dwagner@suse.de>
Message-ID: <1657d19e-a1a-3fea-2536-3bb9d4ffb086@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-12-dwagner@suse.de>
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
>  src/ssdd/ssdd.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
> index 3ead14d0127e..421688c7f47c 100644
> --- a/src/ssdd/ssdd.c
> +++ b/src/ssdd/ssdd.c
> @@ -67,11 +67,11 @@ static const char *get_state_name(int state)
>  #define unused __attribute__((unused))
>  
>  static int quiet;
> -static char outfile[MAX_PATH];
> +static char jsonfile[MAX_PATH];
>  
>  static int got_sigchld;
>  
> -enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_OUTPUT, OPT_QUIET };
> +enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_JSON, OPT_QUIET };
>  
>  static void usage(int error)
>  {
> @@ -80,7 +80,7 @@ static void usage(int error)
>  	       "ssdd <options>\n\n"
>  	       "-f       --forks=NUM       number of forks\n"
>  	       "-h       --help            print this message\n"
> -	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
> +	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
>  	       "-q       --quiet           suppress running output\n"
>  	       "-i       --iters=NUM       number of iterations\n"
>  	       );
> @@ -306,7 +306,7 @@ int main(int argc, char **argv)
>  		static struct option long_options[] = {
>  			{"forks",		required_argument,	NULL, OPT_NFORKS},
>  			{"help",		no_argument,		NULL, OPT_HELP},
> -			{"output",		required_argument,	NULL, OPT_OUTPUT},
> +			{"json",		required_argument,	NULL, OPT_JSON},
>  			{"quiet",		no_argument,		NULL, OPT_QUIET},
>  			{"iters",		required_argument,	NULL, OPT_NITERS},
>  			{NULL, 0, NULL, 0},
> @@ -323,8 +323,8 @@ int main(int argc, char **argv)
>  		case OPT_HELP:
>  			usage(0);
>  			break;
> -		case OPT_OUTPUT:
> -			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> +		case OPT_JSON:
> +			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
>  			break;
>  		case OPT_QUIET:
>  		case 'q':
> @@ -374,8 +374,8 @@ int main(int argc, char **argv)
>  		"One or more tests FAILED" :
>  		"All tests PASSED");
>  
> -	if (strlen(outfile) != 0)
> -		rt_write_json(outfile, error, NULL, NULL);
> +	if (strlen(jsonfile) != 0)
> +		rt_write_json(jsonfile, error, NULL, NULL);
>  
>  	exit(error);
>  }
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

