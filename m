Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8008FC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jan 2022 17:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiA1RoU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jan 2022 12:44:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235029AbiA1RoT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jan 2022 12:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643391858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=br5UZqNuFHXyE2MqLi7FzxCUr4yJGEP7fwcuIFrKsoU=;
        b=WNK4KK7911K1QYRTvSP0f6TdFJd7US7cYJ4Bb3mHyoaTvbuhuMqLAeRSyNsVhld9so24Vp
        i0rvyanL1QCQrcAM/xeCYqrqIh2ztsTwi6Xdif58qoTt1eLvm6Gs28IkAUoyrhGjAegD2Y
        AfDBkkmHkxXeqH7WJUHIvalAzVy7cVU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-pjwZQUUrNCeA95eRkBRc0g-1; Fri, 28 Jan 2022 12:44:17 -0500
X-MC-Unique: pjwZQUUrNCeA95eRkBRc0g-1
Received: by mail-qv1-f69.google.com with SMTP id d5-20020a0cffa5000000b004257627bf5fso6540763qvv.23
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jan 2022 09:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=br5UZqNuFHXyE2MqLi7FzxCUr4yJGEP7fwcuIFrKsoU=;
        b=v6Ix8ek838vCYyz8elNP3232sGs/UjXYb2lA7Q4lXIp7gf5LVlNNRFf8ITjuIuRqeK
         0QGIfyZZssOPFd3OiJmUZc7zHn4Sd3+yYat662Jc+9E0rsaPzGE+dfxWByi328S7uDzw
         6wj81vX2cKIvN2vSiu7QwMkjqE+KwosN7zOf5sEWsbYCdQw67wXll1HR9Y3A+oiNLpdF
         9BN5puCeopAi52SBic0QjqG1NNDZNg8iAlN0WKNx+ymBuFTp2WzzxnC9HKJzqZyz19sX
         p2aWkqUrETOl3WhZcSz8/ynpU/E6LYvgVF3Ku5e6iwqIh4ItmtzVi/4/+s6zlNz8TJca
         LF0Q==
X-Gm-Message-State: AOAM530apjPqeFhDHXVdFbBeruqn0c3DiiW1ureop0kLoGZbrRGR5/gy
        O6YwXGWh1ivaDPN+kb+Ezh1u6SAmeD/HiHUjpKphX8H+Cef1PjT8gIq9nybgiegwdXHEOofXkLa
        yQClLmnQXDpKhmF8G4ZayOBXnvKc=
X-Received: by 2002:a05:620a:4014:: with SMTP id h20mr4265087qko.275.1643391856432;
        Fri, 28 Jan 2022 09:44:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/pfQSYXOqyyleKJPEY0n1iww6MFk9CFNqSiHGqoOI9hbJH4sMLnmplR69b5GiDeHlOoqvdg==
X-Received: by 2002:a05:620a:4014:: with SMTP id h20mr4265068qko.275.1643391856117;
        Fri, 28 Jan 2022 09:44:16 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id w10sm1788717qkp.8.2022.01.28.09.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:44:15 -0800 (PST)
Date:   Fri, 28 Jan 2022 12:44:14 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] rt-numa: ignore runtime cpumask if -a CPULIST is
 specified
In-Reply-To: <YfBFaNrP/1LCgWoN@fuller.cnet>
Message-ID: <7ba75eb3-8a8d-65fa-8458-f7f38bad2cb4@redhat.com>
References: <YerAW90QwEg9yXAb@fuller.cnet> <YfBEDR4E2dNK8XzK@fuller.cnet> <YfBFaNrP/1LCgWoN@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 25 Jan 2022, Marcelo Tosatti wrote:

>  
> When using isolcpus kernel command line option, the CPUs
> specified at isolcpus= are not part of the run time environment
> cpumask.
> 
> This causes "cyclictest -a isolatedcpus" to fail with:
> 
> WARN: Couldn't setaffinity in main thread: Invalid argument
> FATAL: No allowable cpus to run on
> # /dev/cpu_dma_latency set to 0us
> 
> To fix this, ignore the runtime cpumask if neither "+", "!"
> or "all" are specified in the cpu list string.
> 
> Suggested by Sebastian Andrzej Siewior.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> 
> v2: fix changelog typo
> 
> diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
> index ee5ab99..d887355 100644
> --- a/src/lib/rt-numa.c
> +++ b/src/lib/rt-numa.c
> @@ -9,6 +9,7 @@
>  #include <errno.h>
>  #include <sched.h>
>  #include <pthread.h>
> +#include <stdlib.h>
>  
>  #include "rt-error.h"
>  #include "rt-numa.h"
> @@ -96,13 +97,21 @@ int cpu_for_thread_ua(int thread_num, int max_cpus)
>   * the user supplied affinity mask and the affinity mask from the run
>   * time environment
>   */
> -static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
> +static void use_current_cpuset(char *str, int max_cpus, struct bitmask *cpumask)
>  {
>  	struct bitmask *curmask;
>  	int i;
>  
>  	curmask = numa_allocate_cpumask();
> -	numa_sched_getaffinity(getpid(), curmask);
> +
> +	if (strchr(str, '!') == NULL && strchr(str, '+') == NULL &&
> +	    strstr(str, "all") == NULL) {
> +		int conf_cpus = numa_num_configured_cpus();
> +
> +		for (i = 0; i < conf_cpus; i++)
> +			numa_bitmask_setbit(curmask, i);
> +	} else
> +		numa_sched_getaffinity(getpid(), curmask);
>  
>  	/*
>  	 * Clear bits that are not set in both the cpuset from the
> @@ -131,7 +140,7 @@ int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
>  		return 0;
>  	}
>  
> -	use_current_cpuset(max_cpus, mask);
> +	use_current_cpuset(str, max_cpus, mask);
>  	*cpumask = mask;
>  
>  	return 0;
> 
> 

I agree that our current method is too restrictive, so I like the basic 
idea here.

I think we also need to differentiate between -a with no arguments
and -a all. -a with no arguments should inherit the cpumask from the 
runtime environment but -a all, should be the same as specifying all the 
cpus and ignoring the inherited cpumask.

The work of the function parse_cpumask() is essentially in the call to 
numa_parse_cpustring_all() and then pointing the affinity_mask to the 
result. So your patch is unnecessarily complicated. Just don't call 
use_current_cpuset(). All that is needed is to change parse_cpumask()
with

-       use_current_cpuset(max_cpus, mask);
+       if (strchr(str, '!') != NULL || strchr(str, '+') != NULL)
+               use_current_cpuset(max_cpus, mask);

So, if you want to send me the above patch, I'll apply it.

While testing, I noticed that there is a bug in calling parse_cpumask
such that -aall works but -a all (with a space) was not working correctly.
I will send a patch for that.

Thanks

John

