Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D326BC433EF
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 15:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9808A61050
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 15:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhILPlE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 11:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhILPlC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Sep 2021 11:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631461188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=94bFwwMcvUg9Zpo+PXDqLp1uGEpcRMD8rxylaMRZJC8=;
        b=eOEIBouXCPiucgDSAaW7GBvAs6+7IUcZYSZI4wZ7VtUrBCHID1XWu+EExdjmm0NTsbNuME
        WO++xKawgMQbNigOEV6vLXs7geogumGOaNb1X9NJ7gTOqq2td3sIHpd3YxKL92G6ZG+eTi
        S050c1ZGIgpKU5v9wKSQlEQCAnW3VtY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-TdirPJhaPn-Ln_q_4luVpw-1; Sun, 12 Sep 2021 11:39:46 -0400
X-MC-Unique: TdirPJhaPn-Ln_q_4luVpw-1
Received: by mail-qt1-f197.google.com with SMTP id n19-20020ac81e13000000b0029f679691eeso53827560qtl.20
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 08:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=94bFwwMcvUg9Zpo+PXDqLp1uGEpcRMD8rxylaMRZJC8=;
        b=YbUxN2ZQGyAeT1bc1MWXOtw1BM710vADAORIiBkClKHu9QkTggyi48BF403vYT2vCv
         0xcU+u4fVI9PFE6fq4SESTtHtvHXX5c67delB6AFndgpS1BW+npOkphur/wWr4ZPoJAG
         TrXB2hMFDM7dHCabRKen3n2XRQkv2RprOgPoyzqyjYAICcWj2O3i8OFtKitFodqXpDEI
         5va9WSnOEjWhZ/QQVBi9NH9dd8e2jQ528ewLAHdMlLlK280VDUD1U9EPnr2+PCMnqnQp
         D/AqsNkl0MKspyeB6rTPbrJZGWZOFOe8hVkwP6O+Mq/4hCXp2O55f4ep2WTeg3h9x9ix
         CU7w==
X-Gm-Message-State: AOAM531hFw3FswClgdPMJy8fmyg8My/xbsVC5NN6qk74WtMSpvERUSOm
        KHfoZEblTGT+kk3TuBhxpuzTVp3tO/01ZxAiue4tgl/ZJm+ZkeUzfyfztkqdXNp23rLXysvTD1U
        JMx6Z3Y5p9evpMFjZr3bY7IddH4Q=
X-Received: by 2002:a05:620a:1435:: with SMTP id k21mr6253028qkj.442.1631461186467;
        Sun, 12 Sep 2021 08:39:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0BulHVAF5QNHKMeHS3zKCbn0ClIh3QCgD5M/6rAjTlROd6sAvuWQYdqlQZJbU1Ws3PU7BqQ==
X-Received: by 2002:a05:620a:1435:: with SMTP id k21mr6253011qkj.442.1631461186238;
        Sun, 12 Sep 2021 08:39:46 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id f28sm3400713qkk.10.2021.09.12.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 08:39:45 -0700 (PDT)
Date:   Sun, 12 Sep 2021 11:39:44 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        Venkata.Pyla@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com
Subject: Re: [PATCH 3/3] rteval: misc.py: Sort the list of cpus returned by
 online_cpus()
In-Reply-To: <20210902092452.726905-4-punitagrawal@gmail.com>
Message-ID: <6217d13-7491-3a91-a898-37c9bb7c2634@redhat.com>
References: <20210902092452.726905-1-punitagrawal@gmail.com> <20210902092452.726905-4-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 2 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> online_cpus() returns a list of online cpus in arbitrary order. e.g.,
> on a hexacore system it returns -
> 
>     ['5', '3', '1', '4', '2', '0']
> 
> Generally this wouldn't be a problem but the cyclictest.py module
> matches the unsorted list with the latencies output by "cyclictest"
> which are ordered by core number. This leads to incorrect reporting of
> per-core latencies in the final report generated by rteval. The issue
> was noticed when comparing the rteval report with cyclictest logs
> (enabled by a recent change).
> 
> Fix the inconsistency in core numbering by sorting the list of cpus
> returned by online_cpus(). As the cpus are represented as a string,
> sort with the integer key to avoid issues on systems with large number
> of cores.
> 
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> ---
>  rteval/misc.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/rteval/misc.py b/rteval/misc.py
> index 0dd361ff19fd..ec3641e4a013 100644
> --- a/rteval/misc.py
> +++ b/rteval/misc.py
> @@ -53,6 +53,7 @@ def online_cpus():
>          for c in glob.glob('/sys/devices/system/cpu/cpu[0-9]*'):
>              num = str(c.replace('/sys/devices/system/cpu/cpu', ''))
>              online_cpus.append(num)
> +    online_cpus.sort(key=int)
>      return online_cpus
>  
>  def invert_cpulist(cpulist):
> -- 
> 2.32.0
> 
> 

Thanks for finding that. I'm wondering if it makes more sense
to sort it in cyclictest.py?

John

