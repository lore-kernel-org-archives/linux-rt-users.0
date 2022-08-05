Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F44C00140
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Aug 2022 17:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiHERkA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240682AbiHERj5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Aug 2022 13:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C6AD25C51
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Aug 2022 10:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659721193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZvGv+gtmXXd9FWmxEU/Cyg1Bl3Tn5ciIahaLIwnWWEI=;
        b=R69zzWUXrDXb1lt355iMGAXgotUjJdyn9LR0xv06IJm6tysbz4fhDlT+hJWkyM3h7jKE+Y
        pl1SrvWhL9JcHwv3xv5RPBrZPZTHA0P5GlT+jztuGflk6+LBCUGRINz97XaFmdJ7uBqsuK
        1aU5prH3EYoMlHoWXgzs8WDVU7+49U4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-wrdalz9TNZ-3U_bTzAXvrA-1; Fri, 05 Aug 2022 13:39:52 -0400
X-MC-Unique: wrdalz9TNZ-3U_bTzAXvrA-1
Received: by mail-qk1-f200.google.com with SMTP id bm34-20020a05620a19a200b006b5f1d95ceeso2473818qkb.5
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Aug 2022 10:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=ZvGv+gtmXXd9FWmxEU/Cyg1Bl3Tn5ciIahaLIwnWWEI=;
        b=vo5huay8Uz3/QHmvNwTCfr9DQi57bEl/cGknTTDa8ADmhwioFqEKdWPKgUi49TUw5o
         VQy6WY57QNdavM6bVrYZatX0lZlxABUikU0RG80Tg0nQ65u2OtpEBIQC8ymdUkIhj/Sw
         eKtdI9bjFa1HtSa5RhanFRXPm3WJv1QUiGjM1ECDK6LGvLgg0ACxYZQlOmXN1Z17Qbxy
         BWs0vtiOmbPKZzAM5o6Zgb4h0ioieKl4YBOMsiUDUCJi3lahBRZoGP+bGd4DmlgttNNN
         w/2xAAnnapLGqtXoxbva4+pBwWE5pWx8URi8CkOeCXH4JvFu/FckMlJ59BYzRY6xuaX3
         O4BA==
X-Gm-Message-State: ACgBeo2oRqNYsnG0Hi7Pg1EHPjm8IieaghdGk6MjHsPjxt5AEeD84JeB
        VbbBQbVkNi39BvAftl3z/K7QiMKlENtSEpgPjADYXEm+NN6qysb1gEpdIOyu6PK1wDxkvkIJ71U
        cZYOMXtThn5uZoPN3f6JUpfCxBUM=
X-Received: by 2002:ac8:590d:0:b0:31f:31c8:7402 with SMTP id 13-20020ac8590d000000b0031f31c87402mr7031486qty.475.1659721191609;
        Fri, 05 Aug 2022 10:39:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR71L6TJU/I+7GyxCcr6q6tDyyhuoCypcSJsQcrxMu81ncCpKmjfCZNmklMyaS4Jf6AhN0QUKA==
X-Received: by 2002:ac8:590d:0:b0:31f:31c8:7402 with SMTP id 13-20020ac8590d000000b0031f31c87402mr7031478qty.475.1659721191367;
        Fri, 05 Aug 2022 10:39:51 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id g6-20020ac80706000000b0034068f9d8fcsm2874363qth.20.2022.08.05.10.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:39:50 -0700 (PDT)
Date:   Fri, 5 Aug 2022 13:39:49 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Fix loads cpulist restriction
In-Reply-To: <xhsmh5yj6d28f.mognet@vschneid.remote.csb>
Message-ID: <e56b7aa-347b-b446-d6e-31b0ec10e693@redhat.com>
References: <20220805134239.1257029-1-vschneid@redhat.com> <xhsmha68ida4r.mognet@vschneid.remote.csb> <4473578c-46de-9fdd-a09e-4d85489110d8@redhat.com> <xhsmh5yj6d28f.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 5 Aug 2022, Valentin Schneider wrote:

> On 05/08/22 13:04, John Kacur wrote:
> > On Fri, 5 Aug 2022, Valentin Schneider wrote:
> >
> >> On 05/08/22 14:42, Valentin Schneider wrote:
> >> > A recent batch of commits, one of them being:
> >> >
> >> >   39115f0a826d ("rteval: Make use of systopology instead of misc in hackbench")
> >> >
> >> > has made the loads modules use CpuList.expand_cpulist() (which produces a
> >> > list(int)) instead of misc.expand_cpulist() (which produces a list(str)).
> >> > However, the bits handling restricting CPU affinity based on a user
> >> > argument still expects to handle a list(str), which results in:
> >> >
> >> >   [DEBUG] [kcompile] node 0 has no available cpus, removing
> >> >   [...]
> >> >   [DEBUG] [hackbench] node 0 has no available cpus, removing
> >> >
> >>
> >> This is lacking some context, so here's more:
> >>
> >> This was triggered on an arm64 system (Ampere eMAG), any sort of affinity
> >> restriction suffices, e.g.
> >>
> >>  $ rteval -O -D -v --loads-cpulist=2-3
> >>
> >> I can reproduce that on my x86 laptop:
> >>
> >>   $ sudo ./rteval-cmd -O -D -v --loads-cpulist=2-3
> >>   [DEBUG] [kcompile] systopology: 1 node system (8 cores per node)
> >>   [DEBUG] [kcompile] node 0 has no available cpus, removing
> >>   [DEBUG] [kcompile] node 0 has no available cpus, removing
> >>   [DEBUG] [hackbench] node 0 has no available cpus, removing
> >>
> >>
> > Thanks
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> >
> > re python sets for cpu (cpuset is an overloaded term)
> > The idea isn't bad it could work.
> >
> > Right now I am trying reduce the number of duplicated interfaces.
> > Even a seemingly simple change to use lists of ints instead of lists of
> > strings of ints can uncover problems. So, I probbaly would not be so open
> > to python sets for cpus at the moment, but could be in the future.
> >
> > It is probably more work than you realize though, and I would require a
> > full solution, which means replacing the uses of the current interfaces in
> > cyclictest (measurement module), kcompile, hackbench, stressng. You could
> > create a personal fork and have a go at it though if you like!
> >
> 
> I think I'll tinker with a new class and figure out what features it would
> need, and then I'll sit on it and push it further down my todolist - like
> you said, the primary ingredient here is gonna be time :)
> 
> 
Also, CpuList was really just designed as a helper class to SysTopology 
and not really mean as a general interface. I do have plans to separate 
some of that functionality out into a more generic interace we can use.
It might make more sense at that time, to start thinking about whether 
sets would work better or not. So, like anything open source, you're 
welcome to play with it, but you might want to chat with me a little if 
you're serious about it, we could maybe hash out a coherent plan.

John

