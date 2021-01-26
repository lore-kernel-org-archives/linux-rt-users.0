Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59192C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287BC206B5
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhA0DyR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388268AbhAZFjo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 00:39:44 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF5C061756
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 21:39:04 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j13so2023474qvu.10
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 21:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=CXv0G64tMuC+llg2a1nHA1vLz1Kf2rAQlFKUkMAg+Y4=;
        b=DgEksh9S6j6s4Q3RYH2dTIkqA5OLIdhwLg7pC+KOY/HQmEFkrJ0nIYlUmiu0GZp+Ad
         n5QtysMj8xRr5u5Xl3WKARHQEhPTaVhqelnmsGrjRzIRLkUpTHSA2R+je1LYagz5KYsz
         fVbGDNKDIsJS1wT12W0v2eT20rriLyv56jDsut6emf3tD7Q2zW3qxU18ViMxx1yzpSeZ
         2Bzo3AG3DhhygWXexHySHm+U1pxUGiAb+ta8aEenaXPD1iZ+MV0zXc1kjrN1e/BzIUVo
         BadXKY55Bx7e6m9rmiBC69IokeDgiIobcdBnpDTYOCiUpF9Z3f586z5br+MeQoXBiAbM
         ihRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=CXv0G64tMuC+llg2a1nHA1vLz1Kf2rAQlFKUkMAg+Y4=;
        b=YQFruZg6DjqQJ/F2Ck2NIpzwV0c/voGlII+6P1lLWnCQUkUjEX1UOnIDxOfE3u8dvs
         wuyy4L6ZC0a/wdaMC+81ZkKPJXyhEG00hcNEvck0LtMGuNI3Hc2GFSrIU5gx6R9Rmgzd
         x0xcO+84WiqOQa1SJV9tM6+e+rrkGvGBvGL0Jy5r/YqPva6byJGxBgoXxkUVK9/fwTdO
         vErHxO5xYduwBbNeQdibO8Jx5Syr4eT4ENremFmiuYqkwubIrqZUJ7aZm1Bg4s/u0O0h
         YsMml+sLU9NeXx/QCpJ94X5Dy9N6m26Qg20zzx11sg5tXG3YgPG2JQo7mbOiFzR7j+/v
         HzlA==
X-Gm-Message-State: AOAM5316xsZZuHt5lno4T2ErW3kMiIVRl2e66Bza+fATMP702HDV0zXI
        yNZ2URzQvu71S/J0nqaqIbM=
X-Google-Smtp-Source: ABdhPJxI/o2Y5km26InMXfUj5hhcvGWE9T0zNBdnksQtuPxa2OKNMVPI1nLtGIhiD2DG5bzW3J1oWQ==
X-Received: by 2002:a0c:ef87:: with SMTP id w7mr4087915qvr.44.1611639543652;
        Mon, 25 Jan 2021 21:39:03 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id r17sm12497447qta.78.2021.01.25.21.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:39:03 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 00:39:02 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 3/6] cyclictest: Use affinity_mask for stearing
 thread placement
In-Reply-To: <20201218141935.24151-4-dwagner@suse.de>
Message-ID: <2b7c33f3-6249-5ef4-94a3-957cb8cbb3bd@redhat.com>
References: <20201218141935.24151-1-dwagner@suse.de> <20201218141935.24151-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 18 Dec 2020, Daniel Wagner wrote:

> We don't need an extra variable to track the state if a bitmask is
> available or not. Check directly if the mask is usable.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 28 ++++------------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index a5ca764da254..0e6519125c2f 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -893,7 +893,6 @@ static int interval = DEFAULT_INTERVAL;
>  static int distance = -1;
>  static struct bitmask *affinity_mask = NULL;
>  static int smp = 0;
> -static int setaffinity = AFFINITY_UNSPECIFIED;
>  
>  static int clocksources[] = {
>  	CLOCK_MONOTONIC,
> @@ -1020,19 +1019,13 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  				break;
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
> @@ -1125,7 +1118,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		case OPT_SMP: /* SMP testing */
>  			smp = 1;
>  			num_threads = -1; /* update after parsing */
> -			setaffinity = AFFINITY_USEALL;
>  			break;
>  		case 't':
>  		case OPT_THREADS:
> @@ -1194,23 +1186,16 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		use_nanosleep = MODE_CLOCK_NANOSLEEP;
>  	}
>  
> -	/* if smp wasn't requested, test for numa automatically */
> -	if (!smp) {
> -		if (setaffinity == AFFINITY_UNSPECIFIED)
> -			setaffinity = AFFINITY_USEALL;
> -	}
> -
>  	if (option_affinity && smp) {
>  		warn("-a ignored due to smp mode\n");
>  		if (affinity_mask) {
>  			numa_bitmask_free(affinity_mask);
>  			affinity_mask = NULL;
>  		}
> -		setaffinity = AFFINITY_USEALL;
>  	}
>  
>  	if (smi) {
> -		if (setaffinity == AFFINITY_UNSPECIFIED)
> +		if (affinity_mask)
>  			fatal("SMI counter relies on thread affinity\n");
>  
>  		if (!has_smi_counter())
> @@ -1756,7 +1741,7 @@ int main(int argc, char **argv)
>  		printf("Max CPUs = %d\n", max_cpus);
>  
>  	/* Restrict the main pid to the affinity specified by the user */
> -	if (affinity_mask != NULL) {
> +	if (affinity_mask) {
>  		int res;
>  
>  		errno = 0;
> @@ -1915,17 +1900,12 @@ int main(int argc, char **argv)
>  		if (status != 0)
>  			fatal("error from pthread_attr_init for thread %d: %s\n", i, strerror(status));
>  
> -		switch (setaffinity) {
> -		case AFFINITY_UNSPECIFIED: cpu = -1; break;
> -		case AFFINITY_SPECIFIED:
> +		if (affinity_mask) {
>  			cpu = cpu_for_thread_sp(i, max_cpus, affinity_mask);
>  			if (verbose)
>  				printf("Thread %d using cpu %d.\n", i, cpu);
> -			break;
> -		case AFFINITY_USEALL:
> +		} else {
>  			cpu = cpu_for_thread_ua(i, max_cpus);
> -			break;
> -		default: cpu = -1;
>  		}
>  
>  		/* find the memory node associated with the cpu i */
> -- 
> 2.29.2
> 
> 
-Fixed spelling of "steering"
Signed-off-by: John Kacur <jkacur@redhat.com>
