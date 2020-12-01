Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89528C64E7A
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05EEA2087C
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvSlKA7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgLAHBX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgLAHBX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 02:01:23 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD08C0613D2
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:00:43 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id k3so585036ioq.4
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=OCYT1k6YrHMVF8lyK4iUmh5Ic1fNpFHlp818l9fv900=;
        b=kvSlKA7n619eIAPecXvvBfGAB+Jq4ssTacbm0KmCaYBn1fXj+KSWw8arsFwIspoqKy
         7fHiZ4rA7uDOpX+o6pDv5qvaQsSe8uIsgWMN32dlnkYUX63/vmw4sZq+nm3hP6szNyu1
         3qvGHpM6XwCCYfn/tCaRb5QH3vCjHyyjkLd0sw6JBo0fZzgV3nyuzjrd7Ln/oXVQy+e+
         OcaJ7F0fl6X4qu0JbQ+HJHBMK1TE4CUdlZEhJclP96iWqhSyFcVr+RS7kFR69v1q4xqv
         H9zI1VPemGhEY1TLApFwKP2Xe9a1uA7nU+Zxosf5Zs5gBXfhFrT5pLaYcNJlXUvWD5CF
         109w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=OCYT1k6YrHMVF8lyK4iUmh5Ic1fNpFHlp818l9fv900=;
        b=CU/kVvCqCRLAgVnRAkjVggo+sEOUikf7jXSb52HwOcEkngjwZio08wSnEBEDP3xzdi
         i2jJb2Y+UPMVKSIERbA8ms9U3NbVM2GtWUkQhTaCGxGenUbKs+FP3OKwIaRyTgDzFaWR
         A1QaCAAMSdK16Uap8FhfPgfbuX8EJ37ybyCU5CxO4q/Qrc5M7djuQez0p57eMseI65bL
         hX1HVtAk+A17DSa4ndgfJc2u1gkki1Y4PwSmxx5ga95Ibbk8aiJBpnRTDMIxwgAggEnV
         A7cisC7CBPLHoD8G+PHzjbxTz7HldUTAYH9ocr06Jsz6oiHX/xZQjCHeJdtCvLa4THhk
         OHZQ==
X-Gm-Message-State: AOAM530TfxwwP46imGJwd4ix5Sa2fsAJS5G3L6Gi4dBLuQrin2yVImPJ
        USJ39jliFxl1mVznUZiqadc=
X-Google-Smtp-Source: ABdhPJxROPRmacMoXlbNGMZjG+1nnVpAmzPXTqWVG8ZdTzfDY3YSq61swh8kFWHu2zjNaYz5sBI4Sw==
X-Received: by 2002:a02:3716:: with SMTP id r22mr1534112jar.104.1606806042673;
        Mon, 30 Nov 2020 23:00:42 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id t8sm589580ilf.80.2020.11.30.23.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:00:42 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 1 Dec 2020 02:00:38 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 03/12] cyclicdeadline: Add quiet command line
 option
In-Reply-To: <20201118190642.16006-4-dwagner@suse.de>
Message-ID: <5ea99ed-d0b2-d427-d672-70eb1124cb6c@redhat.com>
References: <20201118190642.16006-1-dwagner@suse.de> <20201118190642.16006-4-dwagner@suse.de>
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
>  src/sched_deadline/cyclicdeadline.8 |  6 +++++-
>  src/sched_deadline/cyclicdeadline.c | 22 +++++++++++++++++-----
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
> index def42f77044a..59b60ca7bd31 100644
> --- a/src/sched_deadline/cyclicdeadline.8
> +++ b/src/sched_deadline/cyclicdeadline.8
> @@ -17,7 +17,7 @@ cyclicdeadline \- This program is used to test the deadline scheduler (SCHED_DEA
>  .PP
>  .SH SYNOPSIS
>  .B cyclicdeadline
> -.RI "[-a [CPUSET]] [-D TIME] [-h]  [-i INTV] [-s STEP] [-t NUM]"
> +.RI "[-a [CPUSET]] [-D TIME] [-h]  [-i INTV] [-s STEP] [-t NUM] [-q]"
>  .PP
>  .SH DESCRIPTION
>  .B cyclicdeadline
> @@ -43,6 +43,10 @@ The amount to increase the deadline for each task in us. (default 500us)
>  .TP
>  .B \-t \-\-threads NUM
>  The number of threads to run as deadline (default 1)
> +.TP
> +.B \-q, \-\-quiet
> +Print a summary only on exit. Useful for automated tests, where only
> +the summary output needs to be captured.
>  .br
>  .SH AUTHOR
>  cyclicdeadline was written by Steven Rostedt <rostedt@goodmis.org>
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 7adc91465f44..40b514c5e7e0 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -108,6 +108,8 @@ static int use_nsecs;
>  
>  static int mark_fd;
>  
> +static int quiet;
> +
>  static int find_mount(const char *mount, char *debugfs)
>  {
>  	char type[100];
> @@ -627,6 +629,7 @@ static void usage(int error)
>  	       "-s STEP     --step         The amount to increase the deadline for each task in us\n"
>  	       "                           (default 500us).\n"
>  	       "-t NUM      --threads      The number of threads to run as deadline (default 1).\n"
> +	       "-q          --quiet        print a summary only on exit\n"
>  	       );
>  	exit(error);
>  }
> @@ -966,13 +969,18 @@ static void loop(struct sched_data *sched_data, int nr_threads)
>  
>  	while (!shutdown) {
>  		for (i = 0; i < nr_threads; i++)
> -			print_stat(stdout, &sched_data[i], i, 0, 0);
> +			print_stat(stdout, &sched_data[i], i, 0, quiet);
>  		usleep(10000);
> -		printf("\033[%dA", nr_threads);
> +		if (!quiet)
> +			printf("\033[%dA", nr_threads);
>  	}
>  	usleep(10000);
> -	for (i = 0; i < nr_threads; i++)
> -		printf("\n");
> +	if (!quiet) {
> +		printf("\033[%dB", nr_threads + 2);
> +	} else {
> +		for (i = 0; i < nr_threads; ++i)
> +			print_stat(stdout, &sched_data[i], i, 0, 0);
> +	}
>  }
>  
>  int main(int argc, char **argv)
> @@ -1006,9 +1014,10 @@ int main(int argc, char **argv)
>  			{ "help",	no_argument,		NULL,	'h' },
>  			{ "interval",	required_argument,	NULL,	'i' },
>  			{ "threads",	required_argument,	NULL,	't' },
> +			{ "quiet",	no_argument,		NULL,	'q' },
>  			{ NULL,		0,			NULL,	0   },
>  		};
> -		c = getopt_long(argc, argv, "a::c:D:hi:t:", options, NULL);
> +		c = getopt_long(argc, argv, "a::c:D:hi:t:q", options, NULL);
>  		if (c == -1)
>  			break;
>  		switch (c) {
> @@ -1035,6 +1044,9 @@ int main(int argc, char **argv)
>  		case 'D':
>  			duration = parse_time_string(optarg);
>  			break;
> +		case 'q':
> +			quiet = 1;
> +			break;
>  		case 'h':
>  			usage(0);
>  			break;
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
