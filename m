Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12BFC56201
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752D52467A
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHwk45dA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgKRVBP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgKRVBO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 16:01:14 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9935C0613D4
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:01:14 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id k4so3248878qko.13
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=xIEehVT70yspMEkkaKrPL9NOCXA0NQWRdojzc1fAxMI=;
        b=uHwk45dAt2PKamG1t+3HkgxExUjdS6e3FeHBroH8IYuSC3XakJpsEWjuDXfjkHtdoV
         RGQ9lOz5723W44ngtYVUkKpQJclnRJAEsuA6IpAOQaML20/5uomFZu2XMPgqE6zjEpzI
         p5s506O4yP0aH0tQ33+qBUCGh2FiGOWvU0YRQ0RGHYe681G+TSmIU1TxdWDVjlKpC92g
         t8RqApfYqEOIBC/+c0SGjvcHZZk1HzGcaxSyhf4vhxXVaJVpTibiJMoJGXIvwdBo74xC
         GLvZdhMUakPfHpNPVlRetNZI8BW+UcSioQXFb+SU1RCM1n4fzAW9CBl7GM30w+lU3TR9
         tDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=xIEehVT70yspMEkkaKrPL9NOCXA0NQWRdojzc1fAxMI=;
        b=A5NvgGX3tI4Jjpbh7Rs6v8lTUHi2QAUvGdQ6cqgyxs/O9cicVTWLWIVf5NFJHzTB8t
         ttFIF85c83AzwaDhZjaEcuOohO/DBBwaio0+0K4fxdy+L6lfjXDL+0RdDxWwOHNcNji0
         aW3gFJpQbO/qHcFp31HqhHUnK7pi0vLDMYkni9XGHozGPjlkpDJgMTRC+hzhzKOWXE3N
         A5Dc0hrf8n6XF/wqZexz6Zk9l3zArwDDURHjtrNZfqP/0lDTXWGOlNqFsDLzAyQelC70
         rsUp/WCAmD09UdH+5JpFbTPfJDWISXVrZeRgO19LNROumn+/MJFnDSbCQZmSZ6gu6NC5
         nTRw==
X-Gm-Message-State: AOAM5336vLQVLrm540NrfPhu7YSjUYPEPaMquhYDv33L+FszuD62CtXZ
        nL5CjqiHMz61aMD69Ktk17I=
X-Google-Smtp-Source: ABdhPJy8fsV4ZEBlD+suVdZBBDLlI/zSvszR7BeGzrFDOlhDDveucBUQHP5QXXos18ahpSQdNmGyLw==
X-Received: by 2002:a05:620a:7e8:: with SMTP id k8mr6703102qkk.273.1605733273947;
        Wed, 18 Nov 2020 13:01:13 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id 137sm17306830qkj.109.2020.11.18.13.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:01:13 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 18 Nov 2020 16:01:12 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 3/6] cyclictest: Remove deadcode checking for
 NUMA
In-Reply-To: <20201113210910.21807-4-dwagner@suse.de>
Message-ID: <913fbbf3-3037-308e-b482-5a143b247833@redhat.com>
References: <20201113210910.21807-1-dwagner@suse.de> <20201113210910.21807-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 13 Nov 2020, Daniel Wagner wrote:

> The NUMA library is always present for cyclictest, thus NUMA config is
> always defined. Remove deadcode.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 3282ab1b856b..46d88ed155c5 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1327,14 +1327,9 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  
>  	/* if smp wasn't requested, test for numa automatically */
>  	if (!smp) {
> -#ifdef NUMA
>  		numa_initialize();
>  		if (setaffinity == AFFINITY_UNSPECIFIED)
>  			setaffinity = AFFINITY_USEALL;
> -#else
> -		warn("cyclictest was not built with the numa option\n");
> -		numa = 0;
> -#endif
>  	}
>  
>  	if (option_affinity) {
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
