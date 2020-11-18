Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC57DC56201
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C52246B8
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCH1zyYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgKRVRQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRVRP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 16:17:15 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF329C0613D4
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:17:15 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 199so3316225qkg.9
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ihhC+No8Z48kI7ZScQ9PG9Kv74HH2XnA3kHFNyc9MB4=;
        b=fCH1zyYKcRNtM9I19433+udZCnvh7dZiyn4AXw7VX6o9HC696arSZK+9Y7wescRttu
         WMDejphcykhEvc7yblS2tDhC8OK+i/GFJK9Fll5BDxeWXRF16DVL6q7t+NDv18I9MtGB
         gQyX5BXDrmFm29pvH9yqH6x8JDL6mqaPMLwEWwQtW7hDOJWSTjmJfGGCGprFwtC4Udxc
         ioeE4Ezt69SibEtq44rw/JHtKlZRUAg3Vav3lFEYAFz7MXN8CCmG97DN/vO88j237fgl
         9z6dA+8nkHalFrWc+16bpI0bk60kFSUSB8S4nZDCdceInA1+ckLC6pZ22j8O107Iaa0m
         acpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=ihhC+No8Z48kI7ZScQ9PG9Kv74HH2XnA3kHFNyc9MB4=;
        b=YiHju9+3QKG6vg1E8AzWfJAsRPp34kgdtwtKzAatUHpV5mWVfQ01Qs1bV4iXz4tgz4
         2miJgfl5eGhho26CMsSJbZTIk/mFR0cAO/jfB0l4FJ4ew2+MVCcpHbnQozWqk1xzEK80
         FK9KRsrt1chKMi7k3dZO5JOFrbDY2bXCJasWhBt5HnlT1c9GnDRajzFDuwzhyjYwP06A
         M2r4ETU7hwScHBNrr6Va5CruOgOBoM281Z5aoKi81XAd1SFQCni/Q9XopHEwNk7OEo5k
         lIGxVc+Go6rZ8jLLKP9vl59BZi1mT9M5qTx/0grv8vhOi2AwAm4kP7/J6efpiA3qvxNA
         Zp5Q==
X-Gm-Message-State: AOAM531KIqXZIbQwCojtYy9UWbQKsZ8mLjjs2bX6YIdabu8s9+KaE0rl
        6MJ5IwOSjifUmus3jtHdzMke0zSEbZLw+w==
X-Google-Smtp-Source: ABdhPJzQRdTELLzYtUpRefJrqTcWYlKEbWOpa2kO0y1zFSghJG3vCe/LOAaUrnR159/UzMdaURmnOg==
X-Received: by 2002:a37:793:: with SMTP id 141mr7569610qkh.215.1605734234906;
        Wed, 18 Nov 2020 13:17:14 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id s16sm17782989qkg.5.2020.11.18.13.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:17:14 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 18 Nov 2020 16:17:13 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 5/6] cyclictest: Use parse_cpumask() from
 rt-numa.h
In-Reply-To: <20201113210910.21807-6-dwagner@suse.de>
Message-ID: <72e0e0d-3532-1fbd-a56-c5f28b45cbd9@redhat.com>
References: <20201113210910.21807-1-dwagner@suse.de> <20201113210910.21807-6-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 13 Nov 2020, Daniel Wagner wrote:

> Use the helper funtion from rt-numa.h to parse the cpumask from the
> command line.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 70 ++++++++-----------------------------
>  1 file changed, 14 insertions(+), 56 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 46d88ed155c5..f10f064f7a8e 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -36,6 +36,7 @@
>  #include "rt_numa.h"
>  
>  #include "rt-utils.h"
> +#include "rt-numa.h"
>  
>  #include <bionic.h>
>  
> @@ -905,11 +906,6 @@ static int clocksources[] = {
>  	CLOCK_REALTIME,
>  };
>  
> -static unsigned int is_cpumask_zero(const struct bitmask *mask)
> -{
> -	return (rt_numa_bitmask_count(mask) == 0);
> -}
> -
>  /* Get available cpus according to getaffinity or according to the
>   * intersection of getaffinity and the user specified affinity
>   * in the case of AFFINITY_SPECIFIED, the function has to be called
> @@ -976,53 +972,6 @@ static int cpu_for_thread_ua(int thread_num, int max_cpus)
>  	return 0;
>  }
>  
> -
> -/* After this function is called, affinity_mask is the intersection of the user
> - * supplied affinity mask and the affinity mask from the run time environment
> - */
> -static void use_current_cpuset(const int max_cpus)
> -{
> -	int i;
> -	pid_t pid;
> -	struct bitmask *curmask;
> -
> -	pid = getpid();
> -
> -	curmask = numa_allocate_cpumask();
> -	numa_sched_getaffinity(pid, curmask);
> -
> -	/* Clear bits that are not set in both the cpuset from the environment,
> -	 * and in the user specified affinity for cyclictest
> -	 */
> -	for (i=0; i < max_cpus; i++) {
> -		if ((!rt_numa_bitmask_isbitset(affinity_mask, i)) || (!rt_numa_bitmask_isbitset(curmask, i)))
> -			numa_bitmask_clearbit(affinity_mask, i);
> -	}
> -
> -	numa_bitmask_free(curmask);
> -}
> -
> -static void parse_cpumask(const char *option, const int max_cpus)
> -{
> -	affinity_mask = rt_numa_parse_cpustring(option, max_cpus);
> -	if (affinity_mask) {
> -		if (is_cpumask_zero(affinity_mask)) {
> -			rt_bitmask_free(affinity_mask);
> -			affinity_mask = NULL;
> -		} else {
> -			use_current_cpuset(max_cpus);
> -		}
> -
> -	}
> -	if (!affinity_mask)
> -		display_help(1);
> -
> -	if (verbose) {
> -		printf("%s: Using %u cpus.\n", __func__,
> -			rt_numa_bitmask_count(affinity_mask));
> -	}
> -}
> -
>  static void handlepolicy(char *polname)
>  {
>  	if (strncasecmp(polname, "other", 5) == 0)
> @@ -1156,15 +1105,24 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  			if (smp)
>  				break;
>  			numa_initialize();
> -			if (optarg != NULL) {
> -				parse_cpumask(optarg, max_cpus);
> +			if (optarg) {
> +				parse_cpumask(optarg, max_cpus, &affinity_mask);
>  				setaffinity = AFFINITY_SPECIFIED;
> -			} else if (optind < argc && (atoi(argv[optind]) || argv[optind][0] == '0' || argv[optind][0] == '!')) {
> -				parse_cpumask(argv[optind], max_cpus);
> +			} else if (optind < argc &&
> +				   (atoi(argv[optind]) ||
> +				    argv[optind][0] == '0' ||
> +				    argv[optind][0] == '!')) {
> +				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
>  				setaffinity = AFFINITY_SPECIFIED;
>  			} else {
>  				setaffinity = AFFINITY_USEALL;
>  			}
> +
> +			if (setaffinity == AFFINITY_SPECIFIED && !affinity_mask)
> +				display_help(1);
> +			if (verbose)
> +				printf("Using %u cpus.\n",
> +					numa_bitmask_weight(affinity_mask));
>  			break;
>  		case 'A':
>  		case OPT_ALIGNED:
> -- 
> 2.29.2
> 
> 
    Fixed a minor spelling mistake in the message.
    Signed-off-by: John Kacur <jkacur@redhat.com>

