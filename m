Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ACAC00140
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Aug 2022 17:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbiHEREr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241091AbiHEREq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Aug 2022 13:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8575D76970
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Aug 2022 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659719084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KyxKJgk6uK+7Sy9+oDfIiZxFN+ShJ3RihQ89CtPBebY=;
        b=OhulO6djxXAqBpGHspEH6FEo2Uo+D0qXImWjtUAzRYfNCIh/IMio+g9FFskd1LbT+0lx/L
        UyFLm3qHOtdqMU5iYyBw4CLg5DIvtCLxQLHxguFLTQT29rncOlVVQ33J130eVdKhl37NNj
        nGZikKF4iiUDFzIexFl+otNmPUNDuBA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-iFKvYOHjNfW0E7a774yolg-1; Fri, 05 Aug 2022 13:04:42 -0400
X-MC-Unique: iFKvYOHjNfW0E7a774yolg-1
Received: by mail-qk1-f198.google.com with SMTP id ay35-20020a05620a17a300b006b5d9646d31so2407849qkb.6
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Aug 2022 10:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=KyxKJgk6uK+7Sy9+oDfIiZxFN+ShJ3RihQ89CtPBebY=;
        b=uvzforFsV1GrblUrgCNavz/bxa9kh+gt9uHwROY5uVLPankTu4IZTXxJZPdkVM1m7w
         5MPi5zSq3/Bdri9muuqJaGcAWrNRYwQ2l58tIYu5uaUV3Pc4nahC6i6+KyIZliCONLGi
         qQKBeNsxEIrzbV9Zswl3EEmRtqlShL8iUQI5rYoYLJVG3owXYy88qSwjc35MH1zYPrr1
         HqDD/XZa1hIxIXmHWhIpdDqRldYjTLeQpsAIxwNjvyYmRolZRM35mhKXHSbNhlsgZLx7
         DuRDLaVDMne/afuPdYhOPnwQaO6COFL60ISF5A27x8fAHw46k478/GroAgeEuLcgzylg
         +T5w==
X-Gm-Message-State: ACgBeo05G+gwyHh68ARpV8BXS+2n0n154ELBs5QiJ3xM9Q9OEQviRzY7
        aqgvycr/g10MOfRlqW6UbpkMaetbRbXkieGNF6CrvuqbUxoc+la3KnUmgMTX+sta5zWY8tgYLoc
        tYOMII/oX1IDel0jl+qUr3hSFPS0=
X-Received: by 2002:ac8:5a13:0:b0:33d:8166:c00e with SMTP id n19-20020ac85a13000000b0033d8166c00emr6719870qta.334.1659719082154;
        Fri, 05 Aug 2022 10:04:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5cKRyJ2fjbZkHHxouoKwk+DHN1ZBJvEMJp063NPTb8KGoV2/PfU7uvRNXfYMj6mFTYVLuXxg==
X-Received: by 2002:ac8:5a13:0:b0:33d:8166:c00e with SMTP id n19-20020ac85a13000000b0033d8166c00emr6719839qta.334.1659719081686;
        Fri, 05 Aug 2022 10:04:41 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id k5-20020ac81405000000b0031ef6dd9700sm2864541qtj.55.2022.08.05.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:04:41 -0700 (PDT)
Date:   Fri, 5 Aug 2022 13:04:35 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Fix loads cpulist restriction
In-Reply-To: <xhsmha68ida4r.mognet@vschneid.remote.csb>
Message-ID: <4473578c-46de-9fdd-a09e-4d85489110d8@redhat.com>
References: <20220805134239.1257029-1-vschneid@redhat.com> <xhsmha68ida4r.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 5 Aug 2022, Valentin Schneider wrote:

> On 05/08/22 14:42, Valentin Schneider wrote:
> > A recent batch of commits, one of them being:
> >
> >   39115f0a826d ("rteval: Make use of systopology instead of misc in hackbench")
> >
> > has made the loads modules use CpuList.expand_cpulist() (which produces a
> > list(int)) instead of misc.expand_cpulist() (which produces a list(str)).
> > However, the bits handling restricting CPU affinity based on a user
> > argument still expects to handle a list(str), which results in:
> >
> >   [DEBUG] [kcompile] node 0 has no available cpus, removing
> >   [...]
> >   [DEBUG] [hackbench] node 0 has no available cpus, removing
> >
> 
> This is lacking some context, so here's more:
> 
> This was triggered on an arm64 system (Ampere eMAG), any sort of affinity
> restriction suffices, e.g.
> 
>  $ rteval -O -D -v --loads-cpulist=2-3
> 
> I can reproduce that on my x86 laptop:
> 
>   $ sudo ./rteval-cmd -O -D -v --loads-cpulist=2-3
>   [DEBUG] [kcompile] systopology: 1 node system (8 cores per node)
>   [DEBUG] [kcompile] node 0 has no available cpus, removing
>   [DEBUG] [kcompile] node 0 has no available cpus, removing
>   [DEBUG] [hackbench] node 0 has no available cpus, removing
> 
> 
Thanks
Signed-off-by: John Kacur <jkacur@redhat.com>

re python sets for cpu (cpuset is an overloaded term)
The idea isn't bad it could work.

Right now I am trying reduce the number of duplicated interfaces.
Even a seemingly simple change to use lists of ints instead of lists of 
strings of ints can uncover problems. So, I probbaly would not be so open 
to python sets for cpus at the moment, but could be in the future.

It is probably more work than you realize though, and I would require a 
full solution, which means replacing the uses of the current interfaces in 
cyclictest (measurement module), kcompile, hackbench, stressng. You could 
create a personal fork and have a go at it though if you like!

John

