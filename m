Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77726C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4103A206B9
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbhA0Dxv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbhAZFFp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 00:05:45 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86DC061574
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 21:05:06 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c12so11490071qtv.5
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 21:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=FoL7S9YvRnxdz+vYwmu+o2885iQRIbWOlkabul64dP0=;
        b=lj/NfmEdZjRrsi7XlbA220uwwtXr6bTzSjaIZxWXY6fimORg1Wwvn8WOu96vnqnz9R
         mtHi8Fm6y+qe6lU05jT2qg+7SdPdker9hmxq4PxNoV5l6v/Q4Ldnhi//pCtnQBTqVsYC
         6paeBkegMTypizc7K89XiGMSODpgStOVDr5/GUZ4535V82uTjj1iG9BinUXZ+veP5mS+
         Jrr4D741Z8Do2ESmkX9EaTD5o5kh2LxA6ZEs+m4lGcMm7OlAy1dJ25KwNHBeRaIe+h0q
         6hDd3dI2xfTMU2VPIaeN5LZrGvRJzM/tcs6A+7XMM5PxOiNqtROS6NmfEr+CQdW/knrT
         ir6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=FoL7S9YvRnxdz+vYwmu+o2885iQRIbWOlkabul64dP0=;
        b=KB+ES+06EtOixL0EeMg2Rqu10UBaGX3pnrRcbwKdiy64hcxgxpKmPYNjnjZJ15+5vg
         6TYebeg3XzmZTbAq0Zl7nuUYyMWDy0qgppYZcPe936ntnyODh0rjhiddIjFrAdfdOQUu
         akFmTjaAsuOtES0oiKUpqGOjbuQmpXQGrqeJXmqfiQX+1QGkzzCQriztc5nZGjuVfGi7
         hpeTqh5zZNOfaNwICdA5ugXDWeJ/D8dsuzhJDP1IK/or5HKM3jWedzI70DZFPAasbkki
         XLwHGM7ZDDgjqf2/izkPx1vqMTg7m6DEwcg8f71XtzTrDiH38V6OeBDwjKFTRpiocyKS
         niUg==
X-Gm-Message-State: AOAM531n7ssfBCjhjXStuB4ogv8SQvwWOytfI8/tcS9juo+IYQ1g/EXX
        1uq84obVT3PN9Ejg33u/bF0=
X-Google-Smtp-Source: ABdhPJx8X2Ijn0kg//gaZwjBWeDyOm47uPms132Et5HKwxPChhOSiRyErPI//8nP74E7t85BH7XxRw==
X-Received: by 2002:ac8:66cb:: with SMTP id m11mr3792308qtp.378.1611637505284;
        Mon, 25 Jan 2021 21:05:05 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id t68sm13629790qkd.35.2021.01.25.21.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:05:04 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 00:04:56 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 00/20] rt-numa.h cleanups
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
Message-ID: <47fed8-c9dd-83ba-87bd-8c527e475912@redhat.com>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 18 Dec 2020, Daniel Wagner wrote:

> This series cleans up the rt-numa.h header.
> 
> As we have a hard dependency on libnuma we can simplify the code in
> cyclictest. This allows remove all the small helpers in rt_numa.h. And
> with this we can remove the header and reduce the confusion with
> rt-numa.h

I'm not entirely convinced. The code has been moving in this direction,
but I don't know what motivation there is for libnuma people to provide 
libnuma on architectures without numa. This is what the code used to do, 
it wrapped these calls in a way that we could call them whether numa was 
available or not. On Fedora there is no libnuma (numactl) for arm 
processors currently afaik as an example. But, there are a lot of good 
changes here and I  want the code to go forward, so there is no point 
holding on to functionality that we largely got rid of, but if in the
future we have arches that won't work on some distributions,
we may be forced to reimpliment the numa wrappers.

> 
> While at it, I simplified the --smp vs --affinity vs --threads
> logic. There is no need for additional variables to keep state. With
> this we also make --affinity to behave as with the rest of
> rt-tests. That is a plan -a will be the same as with -S. There is no
> need for -S anymore but I think we should leave it in place for
> backwards compatibility. I suspect, there must be a lot of muscle
> memory out there :)

This is really good. Note, the first step that got us here, was the code
that just detected whether numa was available and used it automatically
if it was, unless smp was specified. Believe it or not though, some of
the motivation for that was to reduce the alphabet soup of options on
cyclictest. If -S is no longer needed, it should be removed, people can
learn new muscle memory. (I'm typing this on a Canadian (English layout)
keyboard after using a German keyboard for 13+ years.)


> 
> Since signaltest has the same code as cyclictest, cleanup this tool as
> well.
> 
> With all those cleanups in cyclictest and signaltest, rt-numa.h
> contains only a three functions. The final part of the series is to
> remove unnecessary function arguments (max_cpus). This also fixes the
> theoretical problem that a sparse cpumask would not be handled
> correctly.
> 
> changes v2:
>   - added more cleanup patches (7-20)
> 
> Daniel Wagner (20):
>   cyclictest: Always use libnuma
>   cyclictest: Use numa API directly
>   cyclictest: Use affinity_mask for stearing thread placement
>   cyclictest: Mimik --smp behavior with --affinity
>   cyclictest: Simplify --smp vs --affinity vs --threads argument logic
>   cyclictest: Move verbose message into main
>   signaltest: Always use libnuma
>   signaltest: Use affinity_mask for stearing thread placement
>   signaltest:  Simplify --smp vs --affinity vs --threads argument logic
>   rt-numa: Remove unused definitions and numa_initialize()
>   rt-numa: Add generic cpu_for_thread() helper
>   rt-numa: Use mask size for iterator limit
>   rt-numa: Remove max_cpus argument from parse_cpusmask
>   rt-numa: Use error message helpers
>   signaltest: Remove unused max_cpus argument from process_options
>   cyclictest: Remove unused max_cpus argument from process_options
>   rt-numa: Use CPU_SETSIZE as upper loop limit
>   rt-numa: Remove used max_cpus argument from cpu_for_thread()
>   cyclictest: Remove max cpus used verbose information
>   cyclictest: Remove unecessary local variable
> 
>  src/cyclictest/cyclictest.c | 177 +++++++++++++-----------------------
>  src/cyclictest/rt_numa.h    |  98 --------------------
>  src/include/rt-numa.h       |  13 +--
>  src/lib/rt-numa.c           |  44 ++++-----
>  src/oslat/oslat.c           |   3 +-
>  src/signaltest/signaltest.c |  80 ++++------------
>  6 files changed, 101 insertions(+), 314 deletions(-)
>  delete mode 100644 src/cyclictest/rt_numa.h
> 
> -- 
> 2.29.2
> 
> 
