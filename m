Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5BEC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 13:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126BD61132
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 13:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353606AbhIINoK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 09:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355821AbhIIMrZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 08:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631191574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1kcSLGXTQvqd2aLi+yqOoa2aDshhs5YVvJy8sddyTyk=;
        b=iB3Vf4aCBIOU0q96o3z23Lh8Qp+CQrAlEuzWm5F9X4Y4Rl0vDSwHwLvZl/OtFLkkUyBtqs
        kM7Tawz7DknRbOazqOH9iLb0HoB1+Uw12WwXJ8/oIvmNr7MUYGvdSPjRvKC0+Q+D6Wnp42
        WVir9qCJaRHGFEufRHrgYWeIoICoVCY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-gMJU8gZgMtezYDm2VZWzBw-1; Thu, 09 Sep 2021 08:46:13 -0400
X-MC-Unique: gMJU8gZgMtezYDm2VZWzBw-1
Received: by mail-qk1-f197.google.com with SMTP id p23-20020a05620a22f700b003d5ac11ac5cso4029420qki.15
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 05:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1kcSLGXTQvqd2aLi+yqOoa2aDshhs5YVvJy8sddyTyk=;
        b=PqQTAVX8ypkP8H/53Myj+hR5u9i+Jom1rZHdSSS+FMAKwFS6hq+634+S/qz6bYT29T
         L80P5bl9Wpr5V9QACjuncsV0103smByBbBvGEiksMrRFQHRpz9K5wbV175OR6t2SKnAD
         eIpEqPHsleOK9rcuXrZUFHee08ngKjy1joKSZcFCz88/hUljLlz76l32aIDISPPar+Wf
         hduX717UY8FQzXGq4kp0X3w3Dyx/2leqf/pm5zstDeELRmZWnA+przIFZWHf27h3tKSM
         MYwXjywQvraHoKW9TiN+vXoymPXYbRGKilz5RiXv7GUb2cAbqxrora5PfMOPpdgUXDiL
         uzlw==
X-Gm-Message-State: AOAM531iiRNhBBFJJ0T+/5vTulA7bmeUWjX4awcMUaO7IhvqL2OE2pqV
        Byk/YqMblhcILk36o1xXdTun1Vjwib7toiQ6YYifs1mTvUCW2RvbdXW+N+wrQP9ZBpAcxZLkmkb
        JtZCwzuOW1ZgGgIJZBCipixP+YeE=
X-Received: by 2002:a05:622a:10:: with SMTP id x16mr2661042qtw.88.1631191572812;
        Thu, 09 Sep 2021 05:46:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/7LvCv9kS1vPqI1r19VQ2v2CHfiVvUht/51c8UPWKRkN4vlbofbIa5pPdCWZEs8V+TtzzEA==
X-Received: by 2002:a05:622a:10:: with SMTP id x16mr2661013qtw.88.1631191572558;
        Thu, 09 Sep 2021 05:46:12 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id i14sm1203363qka.66.2021.09.09.05.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:46:12 -0700 (PDT)
Date:   Thu, 9 Sep 2021 08:46:11 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/5] rteval: hackbench.py: Enable running on a system
 with low memory
In-Reply-To: <20210901080816.721731-5-punitagrawal@gmail.com>
Message-ID: <4273ee11-b665-53e1-57b6-1e8f443168a5@redhat.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com> <20210901080816.721731-5-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 1 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> The hackbench workload refues to run on RockPro64, a hexacore 64bit
> Arm board with 4GB memory, complaining about insufficient memory
> per-core.
> 
> On further investigation, it turns out that workload is using an
> arbitrary limit of 0.75 GB/core but will quite happily run on much
> lower lower memory systems.
> 
> Instead of preventing execution, convert the info message to a warning
> when the memory is lower than expected but continue execution. This
> should enable the workload to be used on a wider range of systems.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/modules/loads/hackbench.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
> index 3b692070e9d9..ab028c495d8b 100644
> --- a/rteval/modules/loads/hackbench.py
> +++ b/rteval/modules/loads/hackbench.py
> @@ -55,9 +55,8 @@ class Hackbench(CommandLineLoad):
>          if ratio >= 0.75:
>              mult = float(self._cfg.setdefault('jobspercore', 2))
>          else:
> -            self._log(Log.INFO, "Low memory system (%f GB/core)! Not running" % ratio)
> +            self._log(Log.WARN, "Low memory system (%f GB/core)!" % ratio)
>              mult = 0
> -            self._donotrun = True
>  
>          sysTop = SysTopology()
>          # get the number of nodes
> -- 
> 2.32.0
> 
> 

I'm not sure that I can accept this. The number isn't entirely arbitrary, 
it's based on verifying machines as realtime capable for customers, in 
which case I'd rather it fails early. Maybe there is some other way to 
indicate that the user is okay with lower memory system, such as passing 
an --embedded flag or something of that nature?

