Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C12C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 12:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9FF611AD
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 12:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353772AbhIIM4w (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 08:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353223AbhIIMsZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 08:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631191635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OYTsbTZCJwkjWcVStXNTZqvwOOw0Fwx8UUnH72iUIgo=;
        b=YAzyQAaOY+c9hr49ns0kT2QoCHI84UaKSs7v0wWDUt7DH4CS1RQvKdG00k3spqe0q5LGL5
        7qOXIn3DlkqC7aXl0MF5LdJ+eFmleMxZrinOtDKv46WTXacVhYli0EsHSNy03V1POmYDM6
        Zlm5YcH90fpZTENkSFola0Oc+O0amxE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-6siD4_hINUGQ2HwR4GWCtA-1; Thu, 09 Sep 2021 08:47:14 -0400
X-MC-Unique: 6siD4_hINUGQ2HwR4GWCtA-1
Received: by mail-qt1-f198.google.com with SMTP id r5-20020ac85e85000000b0029bd6ee5179so4307439qtx.18
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 05:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=OYTsbTZCJwkjWcVStXNTZqvwOOw0Fwx8UUnH72iUIgo=;
        b=UVKg+a8kCIJiWIw5Y47t1pjOFWtJ0rqC694GOiX/xfWGiBSmRQ//4gmttdj6UJKz8D
         rS4zP8VMRu25JMoDzsT0nOOv2+uAOXuj+SIwsOamCnoM6I4xiZiuRH+jmcKmt+rg2MEu
         wT9Wvl20XKVsGmFiUXXbnnPFj5kRn2BbYk89qgKQchFHwRI12C2fceQ/maomVqh4Ktmp
         XB5vkgl+jZhi0hTtEKGQeZ42mmuijR5AwX+WF6KCOZO6T9M1R4ORPQVW8H7DfU1Zne9w
         66s5W+R4LqGiGuCaZ2WI4c7MM9NTKg0JGWRZMEtxRADaIFxsmpT0sGt+1+6zSsbMC35a
         cXEQ==
X-Gm-Message-State: AOAM531bwi3lkXBuMvb+XS7Ns2M0vqgul/ekF+iarOIWBzHgm33TXB+E
        +KtTHXzl1bqWtTauN8Z3Ri0EVR2GHgFnGBWCu/VvtI83L08a7I706jkNTgiQJVQAw6W20Vo19uC
        CqSEb/oNqh3Wh0z+quyx3VHKjR/c=
X-Received: by 2002:ae9:ef85:: with SMTP id d127mr2467492qkg.265.1631191633155;
        Thu, 09 Sep 2021 05:47:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDDwazOqnnaMyVVmdbXaq6pigim5z2056VcY/dRGFpPOaaSiv5kagMYdz+m8DCZR2b3DpLEA==
X-Received: by 2002:ae9:ef85:: with SMTP id d127mr2467485qkg.265.1631191633002;
        Thu, 09 Sep 2021 05:47:13 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id o23sm1223537qkk.40.2021.09.09.05.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:47:12 -0700 (PDT)
Date:   Thu, 9 Sep 2021 08:47:11 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/5] rteval: kernel.py: Add support for kthreads running
 with deadline policy
In-Reply-To: <20210901080816.721731-4-punitagrawal@gmail.com>
Message-ID: <3ec9f755-404c-88b4-8efb-a29fb18f392@redhat.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com> <20210901080816.721731-4-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 1 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> When running rteval on a system with kthreads running with "deadline"
> policy, an exception is encountered when parsing the output of "ps".
> 
>     [DEBUG] cmd: /usr/bin/ps -eocommand,pid,policy,rtprio,comm
>     Traceback (most recent call last):
>     ...
>       File "...rteval/rteval/sysinfo/kernel.py", line 60, in kernel_get_kthreads
> 	ret_kthreads[v[0]] = {'policy' : policies[bytes.decode(v[1])],
>       KeyError: 'DLN'
> 
> The kernel uses deadline policy for "schedutil" cpufreq governor
> threads. Fix the crash in rteval by adding support for "deadline" to
> the list of policies.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/sysinfo/kernel.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/sysinfo/kernel.py b/rteval/sysinfo/kernel.py
> index 97ad9402b13e..f2e9d72ac2ef 100644
> --- a/rteval/sysinfo/kernel.py
> +++ b/rteval/sysinfo/kernel.py
> @@ -44,7 +44,7 @@ class KernelInfo:
>  
>  
>      def kernel_get_kthreads(self):
> -        policies = {'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
> +        policies = {'DLN': 'deadline', 'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
>          ret_kthreads = {}
>          self.__log(Log.DEBUG, "getting kthread status")
>          cmd = '%s -eocommand,pid,policy,rtprio,comm' % getcmdpath('ps')
> -- 
> 2.32.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>

