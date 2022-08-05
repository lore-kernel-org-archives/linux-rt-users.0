Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ACFC00140
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Aug 2022 14:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiHEOnK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 10:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbiHEOnJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Aug 2022 10:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84B1132449
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Aug 2022 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659710587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pbV9FmShBk/JQi+cS9JK3gwbJ2Z++l5SkeUHmcJrteQ=;
        b=ZK4mOA+49r8oLNupvNdoR2xaVaN75xLgPXDCZ8QjQGwgtPfyxHQSy4Dr2qnLAzypR6RMBJ
        kRDgHwrxn/3ufBk2SyycGcPpCywAu1RCo9ZvvJKDFhC3ZoV7JD4LZkKMp2YFy7ps+LWHOr
        vyoa1miCiUi0I5U2bPrgllSY9XQOaXY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-1xtB5WV8P-WRbu-cdqB58Q-1; Fri, 05 Aug 2022 10:43:05 -0400
X-MC-Unique: 1xtB5WV8P-WRbu-cdqB58Q-1
Received: by mail-wm1-f69.google.com with SMTP id v64-20020a1cac43000000b003a4bea31b4dso4289375wme.3
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Aug 2022 07:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=pbV9FmShBk/JQi+cS9JK3gwbJ2Z++l5SkeUHmcJrteQ=;
        b=pgoNiJ+vN4Mw78/0nOweTWfnuZEtcGspoqWFExD9y1XT0v61zCOkSjBWMPBOciFfd0
         JHSz2R9djS0WHwfhawNJH6jDs4Q1HBxVElZ0MAHCZf+IzdMTryuPKERospuhGjit73Yb
         PSepJL0wWL02uIzM8dX9HWQI0wTGTvgRpa5mybL3cJ1stO5J2jGQc6X+nT/zNjNGzW2j
         6/+RXPOZPlG9ufObTysbCaSLddhPo2tocj0B7v///y8M4BBEit84efCSbOGYds4p1nJM
         SCeJTidKv1lo2wHVlRO/nLrETGp7Tg2Xpvl2/JNdCcYoO+rFQxLZIYbGR5FojeJSqMHx
         FwsA==
X-Gm-Message-State: ACgBeo3lYVnoeZesbWCyI0Ch/Gd955YNKkBM7GtNVMXmusPVWHMKakkE
        t9XmuDQjIlH2lHf4gDeQ3vFsHJGcFYecJYoHvKd91B7FsnsguzcNQfHHlGji4sIY6/1Pox8ZvO9
        oBhFntHm/utTy9ooiSUZOtryWm8k=
X-Received: by 2002:adf:e588:0:b0:21f:ace:dd82 with SMTP id l8-20020adfe588000000b0021f0acedd82mr4518356wrm.226.1659710581925;
        Fri, 05 Aug 2022 07:43:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6a6WQ2f962QSffAiv6R2AIY7D7osMOf3nWQZdBeRnNlk1hPtuV/IVdoh2ieHvxdauE8hI7lA==
X-Received: by 2002:adf:e588:0:b0:21f:ace:dd82 with SMTP id l8-20020adfe588000000b0021f0acedd82mr4518347wrm.226.1659710581728;
        Fri, 05 Aug 2022 07:43:01 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c190a00b003a32251c3f9sm11875284wmq.5.2022.08.05.07.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:43:01 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com
Subject: Re: [PATCH] rteval: Fix loads cpulist restriction
In-Reply-To: <20220805134239.1257029-1-vschneid@redhat.com>
References: <20220805134239.1257029-1-vschneid@redhat.com>
Date:   Fri, 05 Aug 2022 15:43:00 +0100
Message-ID: <xhsmha68ida4r.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 05/08/22 14:42, Valentin Schneider wrote:
> A recent batch of commits, one of them being:
>
>   39115f0a826d ("rteval: Make use of systopology instead of misc in hackbench")
>
> has made the loads modules use CpuList.expand_cpulist() (which produces a
> list(int)) instead of misc.expand_cpulist() (which produces a list(str)).
> However, the bits handling restricting CPU affinity based on a user
> argument still expects to handle a list(str), which results in:
>
>   [DEBUG] [kcompile] node 0 has no available cpus, removing
>   [...]
>   [DEBUG] [hackbench] node 0 has no available cpus, removing
>

This is lacking some context, so here's more:

This was triggered on an arm64 system (Ampere eMAG), any sort of affinity
restriction suffices, e.g.

 $ rteval -O -D -v --loads-cpulist=2-3

I can reproduce that on my x86 laptop:

  $ sudo ./rteval-cmd -O -D -v --loads-cpulist=2-3
  [DEBUG] [kcompile] systopology: 1 node system (8 cores per node)
  [DEBUG] [kcompile] node 0 has no available cpus, removing
  [DEBUG] [kcompile] node 0 has no available cpus, removing
  [DEBUG] [hackbench] node 0 has no available cpus, removing

