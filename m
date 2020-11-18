Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0C8C5519F
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC62C246B0
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0zxLo4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKRVKx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgKRVKw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 16:10:52 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851C3C0613D4
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:10:51 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id m65so2747440qte.11
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MV2v69Bxp3OePYG5mJneoO4ap9CE4uv1YI1HRbtQyik=;
        b=S0zxLo4AEh1k/5wX7Z9eWiHOLafChIwCOHIKDgvhyQDfXA86efDQFdJrjaHLCr9NSD
         qb9zryfnAbnGMCTNyGs3TwMErYe7vAEgVKeuXmdaY/Qx4AOmqLtqFYUznXm5zyPxk0Bt
         iJGUOiffjIO87LwfoRsxwlLQnO56VDqzOoCvCIWM7eJdv1pipN4mSccLXjpIhIfzRGeY
         yboRdBBbSBZ69DascIsHq17KwoGZp0TMlxVdzXsLKpU/CRCKVcbO/9EMM2dXg/ceJqMW
         GLY4K7aD95jPIP5K1q5wqAQ1u4csqPQq68Vw5wuZcY3tWv7fPmRr+xAXRfo7gUCVzFrL
         500A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=MV2v69Bxp3OePYG5mJneoO4ap9CE4uv1YI1HRbtQyik=;
        b=MhWXE5EteGpwGxOH0l9n+YMU2p64gBm+AcHxPyQ7O6I1/Rdh7FeDm7WueqvjAUGveh
         NVTzuYgKn7Gg9xJwQOhQTbUCdZkSHwGyY0PlTLMdEheHlcUkWmchoMSpLJXlGkH9Ei59
         68BElyi8u+PkPYjqNmvQs6nxTIILW264jmO5yiD/VTTYqqqWkeKFQA80xH+bcfFkqRBW
         0mSHj8/dwP69bcmoUcy95nttgR3pCMkPEgOeCO4NxjUnHXxlDPzCK7Zmy15XDohlXkMf
         89l3Mnl5zjPQN0QL3FxTTANHrtOnG5YBN5rg3wdBgL4K+Fb9bnCSVJCsCOxUF6hIlcoX
         Qsfg==
X-Gm-Message-State: AOAM531wRaGU8nHdT1n2kPiRqsFNXoFSZQHvMhilPZxhcY9nGO6CXQSr
        mGUchgYNkE3HMU82k21onyQ=
X-Google-Smtp-Source: ABdhPJwtBBs9T7d9bD8KgE7kM5xn4esuymSs2ytAvfvIggIcO0KvqHoP0F1u4h+YbJRdkMquVjkn7A==
X-Received: by 2002:ac8:6953:: with SMTP id n19mr7214489qtr.184.1605733850800;
        Wed, 18 Nov 2020 13:10:50 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id k4sm8178229qtp.5.2020.11.18.13.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:10:50 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 18 Nov 2020 16:10:49 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 5/6] cyclictest: Use parse_cpumask() from
 rt-numa.h
In-Reply-To: <20201113210910.21807-6-dwagner@suse.de>
Message-ID: <72e684d-8580-d84e-9d6f-ab9f52827fc6@redhat.com>
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
Signed-off-by: John Kacur <jkacur@redhat.com>
