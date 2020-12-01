Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11804C64E7A
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904E72085B
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8t+VDZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgLAHR5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgLAHR4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 02:17:56 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625CFC0613CF
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:17:16 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id f20so589333ioc.12
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ddJ85bJMjPHWkEaSd1PSglwH6pP89+HOWdb8beRGxlQ=;
        b=Q8t+VDZmpkTcIXAZNCjxRGFUMESdqy0nQbrOzXSNt22DxOEnuAL5gFPYUKaPcvUBIr
         cn78Ce923HaC4unkE8v9v9J9sNA/PhZ3FJKbZfqrK5MoaNLGY2zU7TE0zAtXSLLR84Q9
         nN7whdE5h3HQzT39INP++brkWWd7WFGmFTMwpOwHEnM/r+xosO3pg3wYzliiM3ZVigXT
         /lZkXHVAGJIhur3dY0y5jRHa7qfS519R2OIj9ShaleviP2Y5Ugq3YSG185tit+xbPmFh
         42Ej0gzb7SqrgCEZmIUTY01uAe9lDG4rkiPlhZNL3+WFuXD3jloahzok9rLqDKNEF6vT
         B0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=ddJ85bJMjPHWkEaSd1PSglwH6pP89+HOWdb8beRGxlQ=;
        b=SyUY+JOrhKAiuua5zVjP4pe5wnc4P+tCI/7ZlftEYAf4ws91b+VVx4qAG29HAxFFvm
         fpJS08FyUJEX2O8240JvbuMyhRcQULSRksbCJAAAzrGTmFOnAHYH9sklhMwPen7OoULg
         YNLwIt0+2RNNr4PYHluZVrml0eQvmJuSqv9QhdcSByT61Ube5j2ZplsuX1zrxtYpxP3P
         ez+p+e3OA6L8rpzWdoPP35CPnECVQQUNVLwBJtlNj5wmo1qkjB54C2bee+GdwFjEzeAw
         YiZICUqYU6j4vEeyvYXOzXGZvsVfUV0HbSAk3X+YpZDfXxxbXCENE+5IfuFa01zEPA+X
         hR9g==
X-Gm-Message-State: AOAM533ftnV7GTRhZC/pkp8UVE2JUTCNhj5XfMC7Dk2sHIaef+KSOsOQ
        wYO5Qm+jrms6MMfm4CdqW8I/YI+fZmLoLw==
X-Google-Smtp-Source: ABdhPJwo2uhLYS2MVEeaEqeuBt46IvaKWsPmNzNOU/r8uZIz7v1/ZGpIpw+AOXRu/FJspOopz0U63A==
X-Received: by 2002:a6b:ef0b:: with SMTP id k11mr1396537ioh.210.1606807035797;
        Mon, 30 Nov 2020 23:17:15 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id a13sm661488ilh.0.2020.11.30.23.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:17:15 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 1 Dec 2020 02:17:11 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 12/12] rt-migrate-test: Add quiet command line
 option
In-Reply-To: <20201118190642.16006-13-dwagner@suse.de>
Message-ID: <e1a93c45-14ba-a948-64fb-69da5959f76@redhat.com>
References: <20201118190642.16006-1-dwagner@suse.de> <20201118190642.16006-13-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 18 Nov 2020, Daniel Wagner wrote:

> The quiet option is useful for automated test setups where
> only the final result of the run is interesting. This avoids
> to fill up the logs.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/rt-migrate-test/rt-migrate-test.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index f1b7e5e4fe8c..9bf716c9178c 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -98,6 +98,7 @@ static unsigned long long now;
>  static int done;
>  static int loop;
>  static int duration;
> +static int quiet;
>  
>  static pthread_barrier_t start_barrier;
>  static pthread_barrier_t end_barrier;
> @@ -160,6 +161,7 @@ static void usage(int error)
>  	       "-l LOOPS --loops=LOOPS     Number of iterations to run (50)\n"
>  	       "-m TIME  --maxerr=TIME     Max allowed error (microsecs)\n"
>  	       "-p PRIO  --prio=PRIO       base priority to start RT tasks with (2)\n"
> +	       "-q       --quiet           print a summary only on exit\n"
>  	       "-r TIME  --run-time=TIME   Run time (ms) to busy loop the threads (20)\n"
>  	       "-s TIME  --sleep-time=TIME Sleep time (ms) between intervals (100)\n\n"
>  	       "  () above are defaults \n"
> @@ -180,11 +182,12 @@ static void parse_options(int argc, char *argv[])
>  			{"loops",	required_argument,	NULL, 'l'},
>  			{"maxerr",	required_argument,	NULL, 'm'},
>  			{"prio",	required_argument,	NULL, 'p'},
> +			{"quiet",	no_argument,		NULL, 'q'},
>  			{"run-time",	required_argument,	NULL, 'r'},
>  			{"sleep-time",	required_argument,	NULL, 's'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long(argc, argv, "cD:ehl:m:p:r:s:",
> +		int c = getopt_long(argc, argv, "cD:ehl:m:p:qr:s:",
>  			long_options, &option_index);
>  		if (c == -1)
>  			break;
> @@ -199,6 +202,7 @@ static void parse_options(int argc, char *argv[])
>  		case 'l': nr_runs = atoi(optarg); break;
>  		case 'm': max_err = usec2nano(atoi(optarg)); break;
>  		case 'p': prio_start = atoi(optarg); break;
> +		case 'q': quiet = 1; break;
>  		case 'r':
>  			run_interval = atoi(optarg);
>  			break;
> @@ -532,7 +536,8 @@ int main (int argc, char **argv)
>  	intv.tv_sec = nano2sec(INTERVAL);
>  	intv.tv_nsec = INTERVAL % sec2nano(1);
>  
> -	print_progress_bar(0);
> +	if (!quiet)
> +		print_progress_bar(0);
>  
>  	setup_ftrace_marker();
>  
> @@ -552,7 +557,8 @@ int main (int argc, char **argv)
>  
>  		nanosleep(&intv, NULL);
>  
> -		print_progress_bar((loop * 100)/nr_runs);
> +		if (!quiet)
> +			print_progress_bar((loop * 100)/nr_runs);
>  
>  		end = get_time();
>  		ftrace_write("Loop %d end now=%lld diff=%lld\n", loop, end, end - now);
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
