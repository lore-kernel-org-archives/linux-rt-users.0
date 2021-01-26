Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF9BC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9873922B3B
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbhAZGdv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbhAZGc3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 01:32:29 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7E7C061573
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:31:49 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e15so11526700qte.9
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4waOzVAcTgLSvlglNNgSpj2hykdr1iX6HnFMXhcYPFA=;
        b=DjM4SRMs2m18LAZb8gkaeeZSqzRCiOwnbRmPY8Sh21LI0kx4Bai/RQ5WV2/NYeFMEn
         +ZiYg5ltj+W5ZtAeU39EsfX98Ip6PnfzPILhUK9fSGeb6Vz0VuFlo3aaOOEtUNP+NCqv
         Anh6WgPvnviyvhfAJ4d6v+llb6YjQkcuEIvHq+ccv5GV8sDm4ZF0YzMK0dqnZiIRyxf7
         4tNIkFbBw5wzZpNdGKF2a3Kgw82ePuBC42MYEO+ogJJIsO6ocVAKtBqWjkJJxBCUgWP5
         PKh3SktYTVbWryvG0YGhU9S0zx6xtOy6MKgHf18TYS0Ly0u/OA4Y4fvkPghPjsSa+maF
         5mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=4waOzVAcTgLSvlglNNgSpj2hykdr1iX6HnFMXhcYPFA=;
        b=qVbCUABUT7yXnfci9R6xaE1/na8wBUKbJYx45szvGD1MpgLm3gcd9XB1qzfEDLo7vN
         gr3SYa6833girSvSQKTw957Uk8IbfpUMAGCyLHuDWEogyHio7l0nhuu7eIHKUwYtiBKL
         LAXGOCICSdlAyL9CYILIdvx8X1PMg8rhtnrBKUhFQY+s78Mw6TDwPOQl+mFmOXrIJkju
         SIZV5lW/kQY/sEw3TgWj9bRTQWb9nSlCA57sKipJQHUwdqBMd0noyLQPbw/Wyxb644T6
         iZBerSZBKalRW0dPx5Oeo2BKqhzqQlzp1i/Odb/vY3ee8hRUEsVuMoaLWygphbkyN3oo
         1RBw==
X-Gm-Message-State: AOAM531U5yOI4mt9l6mIhKn0qisWPZb+UzVv/euVPdN6byrgMAxgtle/
        ySikyOZc3U4u5Agkv1ZTg80=
X-Google-Smtp-Source: ABdhPJyT9XNL0KJSQx835ewaGMJm0qAoU3tT3AbBrWppUGvNsZt0b+9tY2nzoX678aqQk+H8fIFEoQ==
X-Received: by 2002:ac8:7257:: with SMTP id l23mr3819361qtp.264.1611642708606;
        Mon, 25 Jan 2021 22:31:48 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id c17sm13847015qkb.13.2021.01.25.22.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 22:31:48 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 01:31:47 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 08/20] signaltest: Use affinity_mask for stearing
 thread placement
In-Reply-To: <20201218161843.1764-9-dwagner@suse.de>
Message-ID: <174fc12b-364-9cfa-dfbe-537083e1acad@redhat.com>
References: <20201218161843.1764-1-dwagner@suse.de> <20201218161843.1764-9-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 18 Dec 2020, Daniel Wagner wrote:

> We don't need an extra variable to track the state if a bitmask is
> available or not. Check directly if the mask is usable.
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/signaltest/signaltest.c | 44 ++++++++-----------------------------
>  1 file changed, 9 insertions(+), 35 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index b3a82f8c4f65..e19fc9a740a9 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -205,15 +205,13 @@ static int verbose;
>  static int quiet;
>  static int lockall;
>  static struct bitmask *affinity_mask = NULL;
> -static int smp = 0;
> -static int setaffinity = AFFINITY_UNSPECIFIED;
>  
>  /* Process commandline options */
>  static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  {
> -	int option_affinity = 0;
>  	int error = 0;
>  	int numa = 0;
> +	int smp = 0;
>  
>  	for (;;) {
>  		int option_index = 0;
> @@ -238,26 +236,19 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  			break;
>  		switch (c) {
>  		case 'a':
> -			option_affinity = 1;
>  			/* smp sets AFFINITY_USEALL in OPT_SMP */
>  			if (smp)
>  				break;
>  			numa = 1;
>  			if (optarg) {
>  				parse_cpumask(optarg, max_cpus, &affinity_mask);
> -				setaffinity = AFFINITY_SPECIFIED;
>  			} else if (optind < argc &&
>  				   (atoi(argv[optind]) ||
>  				    argv[optind][0] == '0' ||
>  				    argv[optind][0] == '!')) {
>  				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
> -				setaffinity = AFFINITY_SPECIFIED;
> -			} else {
> -				setaffinity = AFFINITY_USEALL;
>  			}
>  
> -			if (setaffinity == AFFINITY_SPECIFIED && !affinity_mask)
> -				display_help(1);
>  			if (verbose)
>  				printf("Using %u cpus.\n",
>  					numa_bitmask_weight(affinity_mask));
> @@ -275,7 +266,6 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  				fatal("numa and smp options are mutually exclusive\n");
>  			smp = 1;
>  			num_threads = -1; /* update after parsing */
> -			setaffinity = AFFINITY_USEALL;
>  			break;
>  		case 't': num_threads = atoi(optarg); break;
>  		case 'v': verbose = 1; break;
> @@ -294,16 +284,8 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  	if (num_threads < 2)
>  		error = 1;
>  
> -	/* if smp wasn't requested, test for numa automatically */
> -	if (!smp) {
> -		if (setaffinity == AFFINITY_UNSPECIFIED)
> -			setaffinity = AFFINITY_USEALL;
> -	}
> -
> -	if (option_affinity) {
> -		if (smp)
> -			warn("-a ignored due to smp mode\n");
> -	}
> +	if (smp && affinity_mask)
> +		warn("-a ignored due to smp mode\n");
>  
>  	if (error) {
>  		if (affinity_mask)
> @@ -365,7 +347,7 @@ int main(int argc, char **argv)
>  		}
>  
>  	/* Restrict the main pid to the affinity specified by the user */
> -	if (affinity_mask != NULL) {
> +	if (affinity_mask) {
>  		int res;
>  
>  		errno = 0;
> @@ -400,21 +382,13 @@ int main(int argc, char **argv)
>  			par[i].bufmsk = VALBUF_SIZE - 1;
>  		}
>  
> -		switch (setaffinity) {
> -		case AFFINITY_UNSPECIFIED:
> -			cpu = -1;
> -			break;
> -		case AFFINITY_SPECIFIED:
> +		if (affinity_mask)
>  			cpu = cpu_for_thread_sp(i, max_cpus, affinity_mask);
> -			if (verbose)
> -				printf("Thread %d using cpu %d.\n", i, cpu);
> -			break;
> -		case AFFINITY_USEALL:
> +		else
>  			cpu = cpu_for_thread_ua(i, max_cpus);
> -			break;
> -		default:
> -			cpu = -1;
> -		}
> +
> +		if (verbose)
> +			printf("Thread %d using cpu %d.\n", i, cpu);
>  
>  		par[i].id = i;
>  		par[i].prio = priority;
> -- 
> 2.29.2
> 
> 

In git you wrote Reviewed by instead of Signed-off-by:
Why?
