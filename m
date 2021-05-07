Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CCDC433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42E76145E
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbhEGQ7k (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbhEGQ7k (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:59:40 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049B7C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:58:40 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 1so7107398qtb.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=b3l28fgXnHvhdkRGE2zINXnD8s/fhUQi1P2vgP0n9ck=;
        b=kHyLCOUujb9cpCOpeRI6Writs3yEvR67+NyZtqneZhtN5RK0aEW2XExTOKAHRv4G6E
         U1XjCObqPWEwbBvm3W98FAUaLkb29x2eIMwvghbm4NCYbKU+NV5oE5jfsJJu/orO4cwM
         +vbbu/rLXRk6+hFL2DHczxQaOk2SsxhxClDg9VeLFAyfeRsw2cvLwV4IDf7TVHUVxdoV
         oro53x4XR38eoGh++oixgwtkJsFtlBLP6G6Zdz4S/5pjFdSiUKFZcD4uFqxn50sUTtmb
         V+75CFQF0Xbbki8VJ6HriOF9HkXEe8nIqiJ2sIdnyqpZV54mzU8VDjy6Qc4cN7bT3vE8
         qlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=b3l28fgXnHvhdkRGE2zINXnD8s/fhUQi1P2vgP0n9ck=;
        b=dsFA2k7zW/fBnPPv5x9No1lG6Jh2KLt3AwJm8ewdGsfpB86aO3n6jbhyr7Y82kRpLz
         NO8Va5HqpTZ3kwy3od1+5zkCkX6bRdytLo13T0GpsGTVpwu+6BlXSizEZ30iDDcEJVht
         VCXApzCNAz2eMW7+/eQXvdppaw1T8YRvXmcJC3hXtHaQwX48t2bABEa98LHhouOdRY6n
         R8AuZjgEbIU8Z/eVIPWuQMeToeERbKX7EMxR3zHL3e/5PzbyhWbcb99FdtIv/4xkCCdn
         yVUX44R4SnOU+9FPOSvSh32CZapRkLSOyGnrLU1JrJXyAfy1rmN4CiYkMuzKR1PHOYe7
         r9RA==
X-Gm-Message-State: AOAM532IvppZjCvdnDKzuRYdRr20HqzUZskAxJhuv+Wy82juJgnUFARs
        hrtXZRpfgJw7/nn/YHMwwio=
X-Google-Smtp-Source: ABdhPJzMf1BdEAs+WpYuZJbxcr6tQFEVMCbhXP5TpqVBPzEv4iRvFgAps5lKhPLrxUeJn5Pogq7mGw==
X-Received: by 2002:ac8:570f:: with SMTP id 15mr10127435qtw.309.1620406719277;
        Fri, 07 May 2021 09:58:39 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id m124sm5257610qkc.70.2021.05.07.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:58:39 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:58:38 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 30/33] pi_stress: Prepare command line parser
 for long options only
In-Reply-To: <20210320183829.1318-31-dwagner@suse.de>
Message-ID: <3b256f9b-2b62-f56-914e-c8d894271a61@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-31-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Introduce option value enums in order to be able to parse long options
> only.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/pi_tests/pi_stress.c | 45 ++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 49f89b7b0136..73f0e6a402e3 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -1274,23 +1274,29 @@ int process_sched_line(const char *arg)
>  	return retval;
>  }
>  
> +enum option_values {
> +	OPT_DEBUG=1, OPT_DURATION, OPT_GROUPS, OPT_HELP, OPT_INVERSIONS,
> +	OPT_MLOCKALL, OPT_PROMPT, OPT_QUIET, OPT_RR, OPT_SCHED,
> +	OPT_UNIPROCESSOR, OPT_VERBOSE, OPT_VERSION,
> +};
> +
>  void process_command_line(int argc, char **argv)
>  {
>  	for (;;) {
>  		struct option options[] = {
> -			{"debug",		no_argument,		NULL, 'd'},
> -			{"duration",		required_argument,	NULL, 'D'},
> -			{"groups",		required_argument,	NULL, 'g'},
> -			{"help",		no_argument,		NULL, 'h'},
> -			{"inversions",		required_argument,	NULL, 'i'},
> -			{"mlockall",		no_argument,		NULL, 'm'},
> -			{"prompt",		no_argument,		NULL, 'p'},
> -			{"quiet",		no_argument,		NULL, 'q'},
> -			{"rr",			no_argument,		NULL, 'r'},
> -			{"sched",		required_argument,	NULL, 's'},
> -			{"uniprocessor",	no_argument,		NULL, 'u'},
> -			{"verbose",		no_argument,		NULL, 'v'},
> -			{"version",		no_argument,		NULL, 'V'},
> +			{"debug",		no_argument,		NULL, OPT_DEBUG},
> +			{"duration",		required_argument,	NULL, OPT_DURATION},
> +			{"groups",		required_argument,	NULL, OPT_GROUPS},
> +			{"help",		no_argument,		NULL, OPT_HELP},
> +			{"inversions",		required_argument,	NULL, OPT_INVERSIONS},
> +			{"mlockall",		no_argument,		NULL, OPT_MLOCKALL},
> +			{"prompt",		no_argument,		NULL, OPT_PROMPT},
> +			{"quiet",		no_argument,		NULL, OPT_QUIET},
> +			{"rr",			no_argument,		NULL, OPT_RR},
> +			{"sched",		required_argument,	NULL, OPT_SCHED},
> +			{"uniprocessor",	no_argument,		NULL, OPT_UNIPROCESSOR},
> +			{"verbose",		no_argument,		NULL, OPT_VERBOSE},
> +			{"version",		no_argument,		NULL, OPT_VERSION},
>  			{NULL, 0, NULL, 0},
>  		};
>  
> @@ -1298,12 +1304,15 @@ void process_command_line(int argc, char **argv)
>  		if (c == -1)
>  			break;
>  		switch (c) {
> +		case OPT_DEBUG:
>  		case 'd':
>  			debugging = 1;
>  			break;
> +		case OPT_DURATION:
>  		case 'D':
>  			duration = parse_time_string(optarg);
>  			break;
> +		case OPT_GROUPS:
>  		case 'g':
>  			ngroups = strtol(optarg, NULL, 10);
>  			if (ngroups > num_processors) {
> @@ -1314,37 +1323,47 @@ void process_command_line(int argc, char **argv)
>  			}
>  			pi_info("number of groups set to %d\n", ngroups);
>  			break;
> +		case OPT_HELP:
>  		case 'h':
>  			usage(0);
>  			break;
> +		case OPT_INVERSIONS:
>  		case 'i':
>  			inversions = strtol(optarg, NULL, 10);
>  			pi_info("doing %d inversion per group\n", inversions);
>  			break;
> +		case OPT_MLOCKALL:
>  		case 'm':
>  			lockall = 1;
>  			break;
> +		case OPT_PROMPT:
>  		case 'p':
>  			prompt = 1;
>  			break;
> +		case OPT_QUIET:
>  		case 'q':
>  			verbose = 0;
>  			quiet = 1;
>  			break;
> +		case OPT_RR:
>  		case 'r':
>  			policy = SCHED_RR;
>  			break;
> +		case OPT_SCHED:
>  		case 's':
>  			if (process_sched_line(optarg))
>  				pi_error("ignoring invalid options '%s'\n", optarg);
>  			break;
> +		case OPT_UNIPROCESSOR:
>  		case 'u':
>  			uniprocessor = 1;
>  			break;
> +		case OPT_VERBOSE:
>  		case 'v':
>  			verbose = 1;
>  			quiet = 0;
>  			break;
> +		case OPT_VERSION:
>  		case 'V':
>  			printf("pi_stress v%1.2f ", VERSION);
>  			exit(0);
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
