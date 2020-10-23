Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC2DC4363A
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 16:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA848206DD
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 16:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD/xtuv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbgJWQHV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750019AbgJWQHV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 12:07:21 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C7C0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 09:07:20 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id bl9so927361qvb.10
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=vq/3jEpdDa7QN09GsdmWsoQt16nW7Wou+JNbZj96Uo4=;
        b=fD/xtuv9uTklYEuFrOs9WS+ez7XPBPVs3EMpTCBQ0pbjes9p92zbvXguwV7CdVYNTw
         Rgzztp2fRoGbfT6Qu2Cem/o8zv2g1vVmr1whGgUsrqVRud1pJAJM6jO2qsGJV2HCxlzc
         oVGYg8ZVOzanoTfVnY3s+QaVm0bVK0HhJqw+kKCg1l9l8s3ehPXZ0IB/O7tjiQUKKs16
         VILVzyS6RkEOuPLm071g0zkA10eVN137UQtaX3QCN7SYWGUTQYcj8eitX7pxcbcJk4j9
         fgZ3uPn1A9c7xSbSTeFd6T+lAQXpYXIBv1t/8KZdWdhT81Gy3PgpaU58SFzMqM8oIqLy
         qHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=vq/3jEpdDa7QN09GsdmWsoQt16nW7Wou+JNbZj96Uo4=;
        b=bDzWc++moX2J0ehVxmgFMUPysa4Gh/FSs0yLxMztXLLCUtOZj2237w7tTgn2psMBaR
         FM5mEV4ei2gLTgPwkp5pi5TpKFNpfN0d41XAyVi1F9UUWIhcpBP4yARlvPDA2o23HZ/z
         OqxRLGSzEI40RLaDU0rG3q5RjIcRRlAXTUTikj1u2EV2Fyr50bBaj2nT60dVcN8Cuwb7
         Ws74pDOh2jKqsQ44M0AjNgNoJYYhoqppHYNYRczTIJg7dUhQ5o5XmY3l1XiZmxilhnhq
         s5fyZeJyH8EiOhMjw/z3OQ29+/6HQfN9fsdsxkq1JZYolYOmyWI3+YatVY8KhnC/kqgP
         S/jA==
X-Gm-Message-State: AOAM532ZXTVHtKCalbaijBND6atMEgF1Qd054ZnwhdvJUrTCTEFN/cIf
        JYtZkhGomsCMI2u+Vk15B/A=
X-Google-Smtp-Source: ABdhPJy3PbJLRi8fsDRZZqi2KjiQKetT7eSbmodLU5pTVoPjnnrZumjdjGCzv2pqw1jHYYxq5/2JNw==
X-Received: by 2002:a05:6214:d4e:: with SMTP id 14mr3145505qvr.52.1603469239900;
        Fri, 23 Oct 2020 09:07:19 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id p5sm1127933qte.95.2020.10.23.09.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:07:19 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 12:07:18 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 04/18] cyclicdeadline: Add long command line
 options
In-Reply-To: <20201007085653.11961-5-dwagner@suse.de>
Message-ID: <847bac6b-b577-c54-40a9-8acb18dec517@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Use getopt_long to parse long version of the commands.
> 
> Change the 'a/affinity' option to handle all cases including what '-c'
> did. We still keep '-c' silently supported to avoid breaking existing
> users.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sched_deadline/cyclicdeadline.8 | 17 +++++-------
>  src/sched_deadline/cyclicdeadline.c | 42 ++++++++++++++++++++---------
>  2 files changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
> index 6df7faf445f9..def42f77044a 100644
> --- a/src/sched_deadline/cyclicdeadline.8
> +++ b/src/sched_deadline/cyclicdeadline.8
> @@ -17,7 +17,7 @@ cyclicdeadline \- This program is used to test the deadline scheduler (SCHED_DEA
>  .PP
>  .SH SYNOPSIS
>  .B cyclicdeadline
> -.RI "[-ha] [-c CPUSET] [-D TIME] [-i INTV] [-s STEP] [-t NUM]"
> +.RI "[-a [CPUSET]] [-D TIME] [-h]  [-i INTV] [-s STEP] [-t NUM]"
>  .PP
>  .SH DESCRIPTION
>  .B cyclicdeadline
> @@ -25,26 +25,23 @@ is a cyclictest style program for testing the deadline scheduler
>  .PP
>  .SH OPTIONS
>  .TP
> -.B \-a
> -Use all CPUs
> -.TP
> -.B \-c CPUSET
> +.B \-a \-\-affinity [CPUSET]
>  Comma / hypen separated list of CPUs to run deadline tasks on
>  .TP
> -.B \-D TIME
> +.B \-D \-\-duration TIME
>  Specify a length for the test to run
>  Append 'm', 'h', or 'd' to specify minutes, hours, or days
>  .TP
> -.B \-h
> +.B \-h \-\-help
>  Show this help menu
>  .TP
> -.B \-i INTV
> +.B \-i \-\-interval INTV
>  The shortest deadline for the tasks in us. (default 1000us)
>  .TP
> -.B \-s STEP
> +.B \-s \-\-step STEP
>  The amount to increase the deadline for each task in us. (default 500us)
>  .TP
> -.B \-t NUM
> +.B \-t \-\-threads NUM
>  The number of threads to run as deadline (default 1)
>  .br
>  .SH AUTHOR
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 310880805553..5f5cdfa08f14 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -17,6 +17,7 @@
>  #include <ctype.h>
>  #include <errno.h>
>  #include <signal.h>
> +#include <getopt.h>
>  
>  #include <sys/syscall.h>
>  #include <sys/types.h>
> @@ -635,18 +636,19 @@ static void usage(int error)
>  	printf("cyclicdeadline V %1.2f\n", VERSION);
>  	printf("Usage:\n"
>  	       "cyclicdeadline <options>\n\n"
> -	       "-a                         Use all CPUs\n"
> -	       "-c CPUSET                  Comma/hyphen separated list of CPUs to run deadline\n"
> -	       "                           tasks on.\n"
> -	       "-D TIME                    Specify a length for the test run.\n"
> +	       "-a [CPUSET] --affinity     Comma/hyphen separated list of CPUs to run deadline\n"
> +	       "                           tasks on. An empty CPUSET runs on all CPUs a deadline\n"
> +	       "                           task.\n"
> +	       "                           on CPU 4, and thread #5 on CPU 5.\n"
> +	       "-D TIME     --duration     Specify a length for the test run.\n"
>  	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
>  	       "                           days\n"
> -	       "-h                         Show this help menu.\n"
> -	       "-i INTV                    The shortest deadline for the tasks in us\n"
> +	       "-h          --help         Show this help menu.\n"
> +	       "-i INTV     --interval     The shortest deadline for the tasks in us\n"
>  	       "                           (default 1000us).\n"
> -	       "-s STEP                    The amount to increase the deadline for each task in us\n"
> +	       "-s STEP     --step         The amount to increase the deadline for each task in us\n"
>  	       "                           (default 500us).\n"
> -	       "-t NUM                     The number of threads to run as deadline (default 1).\n"
> +	       "-t NUM      --threads      The number of threads to run as deadline (default 1).\n"
>  	       );
>  	exit(error);
>  }
> @@ -1033,15 +1035,29 @@ int main (int argc, char **argv)
>  		exit(-1);
>  	}
>  
> -	while ((c = getopt(argc, argv, "+hac:i:s:t:D:")) >= 0) {
> +	for (;;) {
> +		static struct option options[] = {
> +			{ "affinity",	optional_argument,	NULL,	'a' },
> +			{ "duration",	required_argument,	NULL,	'D' },
> +			{ "help",	no_argument,		NULL,	'h' },
> +			{ "interval",	required_argument,	NULL,	'i' },
> +			{ "threads",	required_argument,	NULL,	't' },
> +			{ NULL,		0,			NULL,	0   },
> +		};
> +		c = getopt_long(argc, argv, "a::c:D:hi:t:", options, NULL);
> +		if (c == -1)
> +			break;
>  		switch (c) {
>  		case 'a':
> -			all_cpus = 1;
> +		case 'c':
>  			if (!nr_threads)
>  				nr_threads = cpu_count;
> -			break;
> -		case 'c':
> -			setcpu = optarg;
> +			if (optarg)
> +				setcpu = optarg;
> +			else if (optind < argc)
> +				setcpu = argv[optind];
> +			else
> +				all_cpus = 1;
>  			break;
>  		case 'i':
>  			interval = atoi(optarg);
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

Go ahead and send me a patch to remove the -c option
no need to retain this for silent backwards compatibility.

Thanks
