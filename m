Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47411C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 17:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1281261463
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 17:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhEGRI2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 13:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbhEGRIZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 13:08:25 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47425C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 10:07:23 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id w9so5118282qvi.13
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=93D4hvHw2dBsLwR+vVPTIFHB0H1osdLw2qvZdEEaGF8=;
        b=q1HmzwRBLe64EKVb83dR35ubQwLCvSSio/JP6CpVCDZXVHSqc4R7Zw8rNHIWZ5llxw
         YGd2vnO/fGlvn/SEmpRdurvGuvIsTSLisxTNn8fRiEn0+eBco60FUyBe+TsPWN0PmDV/
         WLw/UbVkgwGhxBfxjLoO8JTjHR0WevVNP+aZ3LwHBEtmHdeQRdNTENdxEEx6MDIF6FiZ
         4ebSxovq12E1qm9enhke2vFMVy9OcbjHBltBVScyIiSBypFubzrTNnOlyNYVcY7rjXw+
         GsmC0bi0auZPRcgjBc53j9GDQ8mSPoqH/YIFscVHur74tzjd2RoKkH3hdKdbqNlqGB0n
         AvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=93D4hvHw2dBsLwR+vVPTIFHB0H1osdLw2qvZdEEaGF8=;
        b=L2ew17Yk9sVkcgxEo58fyx5Nl/r0H0XPJ7NW5iDlvTvJxwD/AVMUaDU54G6PHDV5Zw
         1/f0y0w+0AjNju339h+AG8gjaY64kj2eop7cA10rtRmBOFSfjId3FUzpCQU9d+Wl71Uu
         RDuC7MqFgX0qSaNH1koUENxVGeD0LrD6A2SvC+uslDd9CYaV6S93LnS4HXVX1X54cvxk
         rFnMUTt6a8xufB/Ryl81LWkwNPB5+bx7JhHdhYrznnRHTwS2UhEn/SDiq0shQaWe6Poa
         rExK+NOaH5EjTB47pbX+12bcpTYruNPa7TaIourEOykxuRYLBsU3fqAz82s87h5zi9Zw
         2EQQ==
X-Gm-Message-State: AOAM5307lFJXcHoGgizR869duk6iOdkFUpYni+xxDOc2Lz77EWo9wgEJ
        ThvBS2TfvUEroHDO4npzAb8=
X-Google-Smtp-Source: ABdhPJw8uO08qCf2u+azTvy9TwXSrBUmZThsXTHppZvAFw7mSUWiGVopwV0YKE5U2/kVYXjx0LM9Gg==
X-Received: by 2002:a0c:e30c:: with SMTP id s12mr11017820qvl.47.1620407242590;
        Fri, 07 May 2021 10:07:22 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id p11sm5236915qkj.3.2021.05.07.10.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 10:07:22 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 13:07:21 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cyclictest: Move main pid setaffinity handling
 into a function
In-Reply-To: <7204424803922d15bb11bba65bb5672cd76aa20c.1616702706.git.schwenderjonathan@gmail.com>
Message-ID: <851142bc-eadf-e89-821a-c4bd9fe567b@redhat.com>
References: <cover.1616702706.git.schwenderjonathan@gmail.com> <7204424803922d15bb11bba65bb5672cd76aa20c.1616702706.git.schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 25 Mar 2021, Jonathan Schwender wrote:

> Move error handling for setting the affinity of the main pid
> into a separate function.
> This prevents duplicating the code in the next commit,
> where the main thread pid can be restricted to one of
> two bitmasks depending on the passed parameters.
> 
> After feedback from John Kacur, the function is now
> located in src/lib/rt-numa.c.
> This allows other tests to reuse this, if they also
> prefer to warn if numa_sched_setaffinity fails.
> 
> Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
> ---
>  src/cyclictest/cyclictest.c |  8 +-------
>  src/include/rt-numa.h       |  2 ++
>  src/lib/rt-numa.c           | 11 +++++++++++
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index dca9610..460f6ae 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1791,13 +1791,7 @@ int main(int argc, char **argv)
>  
>  	/* Restrict the main pid to the affinity specified by the user */
>  	if (affinity_mask != NULL) {
> -		int res;
> -
> -		errno = 0;
> -		res = numa_sched_setaffinity(getpid(), affinity_mask);
> -		if (res != 0)
> -			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
> -
> +		try_numa_sched_setaffinity(getpid(), affinity_mask);
>  		if (verbose)
>  			printf("Using %u cpus.\n",
>  				numa_bitmask_weight(affinity_mask));
> diff --git a/src/include/rt-numa.h b/src/include/rt-numa.h
> index ca86a45..e9fa312 100644
> --- a/src/include/rt-numa.h
> +++ b/src/include/rt-numa.h
> @@ -18,4 +18,6 @@ int cpu_for_thread_ua(int thread_num, int max_cpus);
>  
>  int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask);
>  
> +void try_numa_sched_setaffinity(__pid_t pid, struct bitmask *cpumask);
> +
>  #endif
> diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
> index babcc63..9a81cfb 100644
> --- a/src/lib/rt-numa.c
> +++ b/src/lib/rt-numa.c
> @@ -138,3 +138,14 @@ int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
>  
>  	return 0;
>  }
> +
> +void try_numa_sched_setaffinity(pid_t pid, struct bitmask *cpumask)
> +{
> +	int res;
> +
> +	errno = 0;
> +	res = numa_sched_setaffinity(pid, cpumask);
> +	if (res != 0)
> +		warn("Couldn't setaffinity for thread %d: %s\n", pid,
> +		     strerror(errno));
> +}
> -- 
> 2.30.2
> 
> 

Yuck. My bad, this is some pretty inelegant error code wrapped around a 
numa call, I don't think it really warrents trying to make an API out of 
it. That said, I might need to do this anyway, when I put back code that 
can run when numa is not available on a target machine.

For now, can you just leave this inline and respin?

Thanks

John Kacur
