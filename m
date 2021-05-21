Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA6DC04FF3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00AA9613EC
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhEUVka (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 17:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhEUVka (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 17:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621633146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4TQuASdVnOQI/MnuK3nk9/hQa465HsvpznHM5+4tsOU=;
        b=QuCr/tX57uDjUsMj75V5ebQ3zXsX83gZ87evjYHeSSLw0+ggWi1EUs5FkEJK5cQ/MkYYaJ
        7OO9ZlBxBeiarNbvL2MZKZm9TQ8BqpJdU7Igbq96SqHHz9hajkzE1MhaHSBLj6cwDcMBWa
        cWqJ1Qn3CauOOUDmAcDjhvr36AznHPw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212--EUt5uZFPM-EPGdmwQLqzg-1; Fri, 21 May 2021 17:39:04 -0400
X-MC-Unique: -EUt5uZFPM-EPGdmwQLqzg-1
Received: by mail-qt1-f200.google.com with SMTP id a7-20020a05622a02c7b02901fbef073c99so10184577qtx.15
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 14:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4TQuASdVnOQI/MnuK3nk9/hQa465HsvpznHM5+4tsOU=;
        b=ozmcKQdGF2CGpdNWXjvXzzHxgAzQC8DMBl2kXlHo0p304rm4BD8PbRAV3PLkxYgHds
         CXRLHIFJUfig14CWaItZ1JTxpJPXYSEdW76idhDukJWLfHw8FiZuwISmiOLz2Va/4enT
         J4+KpQoztTttGB3MJYmR1PaxMZLmxtwY1ifrLwzpUdRmIHjGBUIT/aqwMenK+6BJXVWZ
         cfISrcP8i9o5m9gcEsT6HFg6TocKLdRO8+MpQCH8/PfnnsFN6rWWluFtmrerM/krwxky
         lFJ9MNg/lvCeN1dlxscI95zbUgCaBBTS8UfAT1rcO7nwbIkDutMKvVYonORi4DrvTGMG
         rJkQ==
X-Gm-Message-State: AOAM531KIwOjuZ1ANOT7/uPJI+eGskW0aRUOAzM36oQ7w14nReXtgSdi
        nXzAq+hrhCgQkR890I15P4pwG1gwcGHxiz+XfT7RV7nF+6ffAh4uLwTQKY8TrTnODmt56TTTdp2
        oB/zEyVIG6ruF7tnlDnpm39TpIk8=
X-Received: by 2002:a05:620a:14a9:: with SMTP id x9mr15841803qkj.57.1621633144292;
        Fri, 21 May 2021 14:39:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzf4Ee1dgeJbZOXsOrGLb+qWjJR8eB00kHM6WlltKTZ4ZEBfWR19qG9Txc4+0+P2zFzv0EZw==
X-Received: by 2002:a05:620a:14a9:: with SMTP id x9mr15841792qkj.57.1621633144125;
        Fri, 21 May 2021 14:39:04 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id h16sm5266543qke.43.2021.05.21.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:39:03 -0700 (PDT)
Date:   Fri, 21 May 2021 17:39:02 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 04/23] pi_stress: Rename command line option
 --output to --json
In-Reply-To: <20210519170945.21941-5-dwagner@suse.de>
Message-ID: <4d7ec03b-6be-7471-2462-54192bb4a53@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-5-dwagner@suse.de>
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
>  src/pi_tests/pi_stress.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 3f93d4aadd53..7782ea717c55 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -100,7 +100,7 @@ int debugging = 0;
>  int quiet = 0;	/* turn off all prints, default = 0 (off) */
>  
>  /* filename for JSON output */
> -char outfile[MAX_PATH];
> +char jsonfile[MAX_PATH];
>  
>  /* prompt to start test */
>  int prompt = 0;
> @@ -342,8 +342,8 @@ int main(int argc, char **argv)
>  	finish = time(NULL);
>  	summary();
>  
> -	if (strlen(outfile) != 0)
> -		rt_write_json(outfile, retval, write_stats, NULL);
> +	if (strlen(jsonfile) != 0)
> +		rt_write_json(jsonfile, retval, write_stats, NULL);
>  
>  	if (lockall)
>  		munlockall();
> @@ -992,8 +992,8 @@ void usage(int error)
>  	       "-g N     --groups=N        set the number of inversion groups\n"
>  	       "-h       --help            print this message\n"
>  	       "-i INV   --inversions=INV  number of inversions per group (default is infinite)\n"
> +	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
>  	       "-m       --mlockall        lock current and future memory\n"
> -	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-p       --prompt          prompt before starting the test\n"
>  	       "-q       --quiet           suppress running output\n"
>  	       "-r       --rr              use SCHED_RR for test threads [SCHED_FIFO]\n"
> @@ -1287,7 +1287,7 @@ int process_sched_line(const char *arg)
>  
>  enum option_values {
>  	OPT_DEBUG=1, OPT_DURATION, OPT_GROUPS, OPT_HELP, OPT_INVERSIONS,
> -	OPT_MLOCKALL, OPT_OUTPUT, OPT_PROMPT, OPT_QUIET, OPT_RR, OPT_SCHED,
> +	OPT_JSON, OPT_MLOCKALL, OPT_PROMPT, OPT_QUIET, OPT_RR, OPT_SCHED,
>  	OPT_UNIPROCESSOR, OPT_VERBOSE, OPT_VERSION,
>  };
>  
> @@ -1300,8 +1300,8 @@ void process_command_line(int argc, char **argv)
>  			{"groups",		required_argument,	NULL, OPT_GROUPS},
>  			{"help",		no_argument,		NULL, OPT_HELP},
>  			{"inversions",		required_argument,	NULL, OPT_INVERSIONS},
> +			{"json",		required_argument,	NULL, OPT_JSON},
>  			{"mlockall",		no_argument,		NULL, OPT_MLOCKALL},
> -			{"output",		required_argument,	NULL, OPT_OUTPUT},
>  			{"prompt",		no_argument,		NULL, OPT_PROMPT},
>  			{"quiet",		no_argument,		NULL, OPT_QUIET},
>  			{"rr",			no_argument,		NULL, OPT_RR},
> @@ -1344,13 +1344,13 @@ void process_command_line(int argc, char **argv)
>  			inversions = strtol(optarg, NULL, 10);
>  			pi_info("doing %d inversion per group\n", inversions);
>  			break;
> +		case OPT_JSON:
> +			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
>  		case OPT_MLOCKALL:
>  		case 'm':
>  			lockall = 1;
>  			break;
> -		case OPT_OUTPUT:
> -			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> -			break;
>  		case OPT_PROMPT:
>  		case 'p':
>  			prompt = 1;
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

