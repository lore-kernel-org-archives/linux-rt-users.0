Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B5EC433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 17:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BCB61460
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 17:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhEGRBH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbhEGRBE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 13:01:04 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8FBC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 10:00:04 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id g17so5125381qvl.9
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1vDAyFWAcwzy5DYxLC0gsMFGcsyFNIE3aq949niPsT4=;
        b=rR7dLQUCrnlTLXduIUB6do7t12z484HepW1ppzvCWjyNZ680KKa6ik+Bdo3grEaYRz
         H8kmpodfvkaNpwJ/FhOpMoHS5IrglpzCVmg31P9mYdHDNjWbUaT9wk2yC6l9qFaulOkn
         S7VbFI3MP/pJQ0gHIQj4NNFCNcHpEGEfM48UcBLZ93+rRhlWgedP2xo2/PpraP4LheL8
         qTwx5s6O5p650Cn9+MiqdBduMqde/UJmxCv6rV1ZzWrG6ut2hQ/aWo2+ntklRhcDbvJ5
         NyWIsCo+Le6q9qKKRAIk8lOqXwdFF2fbcZTEzkrmFmj00sOvrwJKp7g0BojF9WHnwSRT
         lshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=1vDAyFWAcwzy5DYxLC0gsMFGcsyFNIE3aq949niPsT4=;
        b=Tefesm7qoT8ZhWSN6i1ZIGmN+8TqQY5rZwg+UxMYTMUuNcChd0j4vH2OTDC/6cR5m3
         KMbu//xpM3x9QbeVeOeRmtI6rZr35A/heH8jFjgskfu666MCXVe2adVOwMi4INQiMbzd
         Xe8RvisqL5OljZoznNm+sSr4XlhJP2qadLTtaMqLqcpb10HMBhQgnmuMlcBxJXvETVmN
         mh6/FusAtnBhkqIsQuKNNVjLwJBDHOPtjd8ik4xy3ZgHAhD0gdb+KzSKz9O9PJCPHqjx
         PqikHV+OPNQXWdvRwWO91Q9TuraPM0vrTkI+EQFryKZ5wJH4Li6tqpQeWBvhLAtq593t
         I9lw==
X-Gm-Message-State: AOAM533WeRcwiVK+GZ+sLrFuQTZLoa7wSQ28kfTSSwOtghUzH69Ig1OR
        36hv5PBMdZ75HDHz33p94R8=
X-Google-Smtp-Source: ABdhPJyFYNsOsGw66EBJzs3gidNQC1spIFY+dSMWYLEH7C49V86oe5wKG5a/knmlLIU0yQ3js3qX4g==
X-Received: by 2002:a05:6214:d84:: with SMTP id e4mr10839750qve.48.1620406803429;
        Fri, 07 May 2021 10:00:03 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id l197sm897164qke.121.2021.05.07.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 10:00:03 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 13:00:02 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 32/33] ssdd: Add quiet command line option
In-Reply-To: <20210320183829.1318-33-dwagner@suse.de>
Message-ID: <8c894999-2434-d159-a1d3-dafabdc8c4dc@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-33-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> The quiet option is useful for automated test setups where
> only the final result of the run is interesting.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/ssdd/ssdd.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
> index 9fa61f39f6e3..50bec824b2e8 100644
> --- a/src/ssdd/ssdd.c
> +++ b/src/ssdd/ssdd.c
> @@ -64,9 +64,11 @@ static const char *get_state_name(int state)
>  
>  #define unused __attribute__((unused))
>  
> +static int quiet;
> +
>  static int got_sigchld;
>  
> -enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP };
> +enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_QUIET };
>  
>  static void usage(int error)
>  {
> @@ -75,6 +77,7 @@ static void usage(int error)
>  	       "ssdd <options>\n\n"
>  	       "-f       --forks=NUM       number of forks\n"
>  	       "-h       --help            print this message\n"
> +	       "-q       --quiet           suppress running output\n"
>  	       "-i       --iters=NUM       number of iterations\n"
>  	       );
>  	exit(error);
> @@ -176,7 +179,8 @@ static int forktests(int testid)
>  	if (!child)
>  		child_process();
>  
> -	printf("forktest#%d/%d/%d: STARTING\n", testid, parent, child);
> +	if (!quiet)
> +		printf("forktest#%d/%d/%d: STARTING\n", testid, parent, child);
>  
>  	act.sa_sigaction = sigchld;
>  	sigemptyset(&act.sa_mask);
> @@ -278,8 +282,8 @@ static int forktests(int testid)
>  	/* There is no need for the tracer to kill the tracee. It will
>  	 * automatically exit when its owner, ie, us, exits.
>  	 */
> -
> -	printf("forktest#%d/%d: EXITING, no error\n", testid, parent);
> +	if (!quiet)
> +		printf("forktest#%d/%d: EXITING, no error\n", testid, parent);
>  	exit(0);
>  }
>  
> @@ -297,10 +301,11 @@ int main(int argc, char **argv)
>  		static struct option long_options[] = {
>  			{"forks",		required_argument,	NULL, OPT_NFORKS},
>  			{"help",		no_argument,		NULL, OPT_HELP},
> +			{"quiet",		no_argument,		NULL, OPT_QUIET},
>  			{"iters",		required_argument,	NULL, OPT_NITERS},
>  			{NULL, 0, NULL, 0},
>  		};
> -		int c = getopt_long(argc, argv, "f:hi:", long_options, &option_index);
> +		int c = getopt_long(argc, argv, "f:hqi:", long_options, &option_index);
>  		if (c == -1)
>  			break;
>  		switch(c) {
> @@ -312,6 +317,10 @@ int main(int argc, char **argv)
>  		case OPT_HELP:
>  			usage(0);
>  			break;
> +		case OPT_QUIET:
> +		case 'q':
> +			quiet = 1;
> +			break;
>  		case 'i':
>  		case OPT_NITERS:
>  			nsteps = atoi(optarg);
> @@ -322,10 +331,12 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	printf("#main : %d\n", getpid());
> -	printf("#forks: %d\n", nforks);
> -	printf("#steps: %d\n", nsteps);
> -	printf("\n");
> +	if (!quiet) {
> +		printf("#main : %d\n", getpid());
> +		printf("#forks: %d\n", nforks);
> +		printf("#steps: %d\n", nsteps);
> +		printf("\n");
> +	}
>  
>  	for (i = 0; i < nforks; i++) {
>  		child = fork();
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
