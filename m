Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60323C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jan 2022 18:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382040AbiAUSQv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Jan 2022 13:16:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351856AbiAUSQu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Jan 2022 13:16:50 -0500
Date:   Fri, 21 Jan 2022 19:16:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642789009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BGTHsHDeNpAG/ZvDWQS1YfsjUFcWQ4ALdxBER110fgA=;
        b=PSKK3/PXy275H1SD4lhilVWFgY8WrupUeL/6nmPrHLobLlfuHct5geHZdyvEsDcDFHKLAe
        0kOg3rVG8V1iZUH/+qUKiYtVT/fQBfhdHtGfYinQ8oR7W4ts/+ipTyIVOI7Chd4zdkHHQW
        EDJcsg+fBVB5+rSsXsX/3k1emNl8fOlVCkM4B89125wQQFZZJKUSCTUHDudGhD+XrzrEY/
        GfFANchDpPgauY3Z/1e9ToX7R2e1/A5wQiCVTLcIg3hMwv1Dfo6n+aAwGRwnKrXTEsW5s3
        lyjMZxnXRABvzKkL1lkou5zitb3u+sLfODhrQR2Hdt9lfUKF25dj5VEh22Qx6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642789009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BGTHsHDeNpAG/ZvDWQS1YfsjUFcWQ4ALdxBER110fgA=;
        b=WOcx4nI/Of+CETaCbRuxiD7JwXUFKvmRbhDXUmifTJmTSkHxvY4KcJ22kmWwNJ21Ip/wJA
        VUhIKvpXnRQEkSCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-numa: optionally ignore runtime cpumask
Message-ID: <Yer4kB0fmR41u19Y@linutronix.de>
References: <YerAW90QwEg9yXAb@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YerAW90QwEg9yXAb@fuller.cnet>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-01-21 11:16:59 [-0300], Marcelo Tosatti wrote:
> 
> use_current_cpuset() function does:
> 
> /*
>  * After this function is called, affinity_mask is the intersection of
>  * the user supplied affinity mask and the affinity mask from the run
>  * time environment
>  */
> static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
> 
> However, when using isolcpus kernel command line option, the CPUs 
> specificied at isolcpus= are not part of the run time environment
> cpumask.
> 
> This causes "cyclictest -a isolatedcpus" to fail with:
> 
> WARN: Couldn't setaffinity in main thread: Invalid argument
> FATAL: No allowable cpus to run on
> # /dev/cpu_dma_latency set to 0us
> 
> To fix this, add an environment variable IGNORE_RUNTIME_CPU_AFFINITY_MASK
> that when set to a value other than 0, will override the runtime cpu
> affinity mask (retrieved with numa_sched_getaffinity) with a bit set
> for each CPU in numa_num_configured_cpus:

This looks hacky and not documented. What about using all CPUs which
part of current affinity mask by default. And then either specify the
requested CPU mask or use explicitly all CPUs.

Sebastian
