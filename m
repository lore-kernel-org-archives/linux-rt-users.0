Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDABC00140
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Aug 2022 17:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbiHERdq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbiHERdo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Aug 2022 13:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EFA0E0A
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Aug 2022 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659720823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ws/VTEAofNBLcFeK9uup29+7p1qGgU97omDX39MU3Tg=;
        b=Kjpqid2nfqW2FhP9tf70iFd9fRFs5q/crW8ApYr35mkhOYz9lTXiJemzMUDy88zVkkn76P
        ND0WAyt/gcT5zAOUn3fr1+ILTcHmemhqYWF73S3sAZHM01GG5CLApoPDyyIBlN6cN5Z7og
        zAMKxxbNHNb+mbspTmluqwsRqBP8bZg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-su9MOSfUPVO6lScn05caNA-1; Fri, 05 Aug 2022 13:33:39 -0400
X-MC-Unique: su9MOSfUPVO6lScn05caNA-1
Received: by mail-wm1-f70.google.com with SMTP id v24-20020a7bcb58000000b003a37681b861so608959wmj.9
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Aug 2022 10:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=ws/VTEAofNBLcFeK9uup29+7p1qGgU97omDX39MU3Tg=;
        b=QiQeZ8kJ+uIC/05wocL2PpaZ0tTnjpSMity079Sz1FH9MiPkVQ6ySFUIqbbYELvQdO
         W8Jth9sZDrvuAQQ6PzRh5eTjuMai6wLI2SVLt5zozJ7nxc+Xu9FXCAoxVOd2nS0y4Aqb
         PYrNuE3Le540R4wj+M79BM8Pl6aeYb6H5mCIUQjrsiQq379M+q1Kfx99nLImvldjMlqb
         Zgk7y4JDAcX8OSD6ptr9kdVkjSWyakCYSzlVPSKrbwdpagDPpdDNDxno4bk77IGFDH7f
         SRz/Pvm3qzeB1NZThu9JC1OUsXrFHR9vWUfVeQamHrcX7mk0WoJQabUiuwJ+8qoIacDp
         abvQ==
X-Gm-Message-State: ACgBeo3RSG9dYNbhfPEGc6QmFQ0iL+EsPtKaUgVEkqTkSE+8wdmTQFQY
        3H6lv+mAtwJYB6TIZaHMeFfB72KKMjOQcu7UqkAfd9lQWw9LN8LSs7+J/a7ovcyqGb5x8qvqm/n
        LPeF131ZWD3dXsz7kjIfcarX/EUhaaCM9yPMA2ePvsff+E3gt5tyRk+JiQ5xEgguMV5LI71Sefi
        j6VM0=
X-Received: by 2002:adf:e0cb:0:b0:21e:9ed9:d862 with SMTP id m11-20020adfe0cb000000b0021e9ed9d862mr4997218wri.518.1659720818056;
        Fri, 05 Aug 2022 10:33:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5t50hZlkDntsFfmSw/AoOpJee7c90A8aujhJVpzvCH40W59QXq5o+LM8PI9N+z8e84FGcvrw==
X-Received: by 2002:adf:e0cb:0:b0:21e:9ed9:d862 with SMTP id m11-20020adfe0cb000000b0021e9ed9d862mr4997207wri.518.1659720817857;
        Fri, 05 Aug 2022 10:33:37 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003a4efb794d7sm6689578wmb.36.2022.08.05.10.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:33:37 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Fix loads cpulist restriction
In-Reply-To: <4473578c-46de-9fdd-a09e-4d85489110d8@redhat.com>
References: <20220805134239.1257029-1-vschneid@redhat.com>
 <xhsmha68ida4r.mognet@vschneid.remote.csb>
 <4473578c-46de-9fdd-a09e-4d85489110d8@redhat.com>
Date:   Fri, 05 Aug 2022 18:33:36 +0100
Message-ID: <xhsmh5yj6d28f.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 05/08/22 13:04, John Kacur wrote:
> On Fri, 5 Aug 2022, Valentin Schneider wrote:
>
>> On 05/08/22 14:42, Valentin Schneider wrote:
>> > A recent batch of commits, one of them being:
>> >
>> >   39115f0a826d ("rteval: Make use of systopology instead of misc in hackbench")
>> >
>> > has made the loads modules use CpuList.expand_cpulist() (which produces a
>> > list(int)) instead of misc.expand_cpulist() (which produces a list(str)).
>> > However, the bits handling restricting CPU affinity based on a user
>> > argument still expects to handle a list(str), which results in:
>> >
>> >   [DEBUG] [kcompile] node 0 has no available cpus, removing
>> >   [...]
>> >   [DEBUG] [hackbench] node 0 has no available cpus, removing
>> >
>>
>> This is lacking some context, so here's more:
>>
>> This was triggered on an arm64 system (Ampere eMAG), any sort of affinity
>> restriction suffices, e.g.
>>
>>  $ rteval -O -D -v --loads-cpulist=2-3
>>
>> I can reproduce that on my x86 laptop:
>>
>>   $ sudo ./rteval-cmd -O -D -v --loads-cpulist=2-3
>>   [DEBUG] [kcompile] systopology: 1 node system (8 cores per node)
>>   [DEBUG] [kcompile] node 0 has no available cpus, removing
>>   [DEBUG] [kcompile] node 0 has no available cpus, removing
>>   [DEBUG] [hackbench] node 0 has no available cpus, removing
>>
>>
> Thanks
> Signed-off-by: John Kacur <jkacur@redhat.com>
>
> re python sets for cpu (cpuset is an overloaded term)
> The idea isn't bad it could work.
>
> Right now I am trying reduce the number of duplicated interfaces.
> Even a seemingly simple change to use lists of ints instead of lists of
> strings of ints can uncover problems. So, I probbaly would not be so open
> to python sets for cpus at the moment, but could be in the future.
>
> It is probably more work than you realize though, and I would require a
> full solution, which means replacing the uses of the current interfaces in
> cyclictest (measurement module), kcompile, hackbench, stressng. You could
> create a personal fork and have a go at it though if you like!
>

I think I'll tinker with a new class and figure out what features it would
need, and then I'll sit on it and push it further down my todolist - like
you said, the primary ingredient here is gonna be time :)

