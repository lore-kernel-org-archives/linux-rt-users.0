Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC34C433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 16:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FED3613CD
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 16:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349514AbhI3QSL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 12:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349496AbhI3QSK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 12:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633018587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N9Q4Qlg6S8O8LpgQpRkKZXaKlXwzKrVQbZ/KMG0zLls=;
        b=efaXLqDpPDjLatPif3EpyPPP0NBsi15Q49w3U/VQiXbl7MRPMstYZQa5zCowWNJ1XTSYLo
        bXN4QMjOcDdxLE/HmcE8ELQzLrhMiyn0APX6nWt53jYSnqQeWZTpe98Q2dh8/VJwzLR2Q9
        3Hm9HoyZ1sjJPMicpEmWf++bRSO3N4Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-zpNtq-pwNS2b_UXKc4o1Ng-1; Thu, 30 Sep 2021 12:16:26 -0400
X-MC-Unique: zpNtq-pwNS2b_UXKc4o1Ng-1
Received: by mail-qk1-f200.google.com with SMTP id bk9-20020a05620a1a0900b0045df00f93a9so13981737qkb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 09:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=N9Q4Qlg6S8O8LpgQpRkKZXaKlXwzKrVQbZ/KMG0zLls=;
        b=AcHtdOCCr+w4EWdDaRucAZBtjds54A1MiBRq3MaNzb4knKGuqxEkRQ7l4sFzsDNGvo
         8QCmvvy5SYS+Qm2RFj46VX4kli8Qem+G5WGEJfiImYykJv7u0aJdk3JmiHouG4vnZ1GN
         LhPz3tgjGGHvC6H2OavFmVhlbZyPfQCLEnw2VXIajyOIPs74eBLPolOAxBiVmlFVNr8V
         nXGBwDb+MfoCa4b10cm8sS74CxaRx0lvBt1hDpCaPJcQblP3aQdMB1o66tOGXM7epFE1
         sMFL8U21UCQx3vSiIWg0g+Gc+xFupfKmQth0v5KLmCUIIdwipdgGqHv+gIyXDBjAVkIj
         o4uw==
X-Gm-Message-State: AOAM53134m4uPlVWUxWO/0LAH6nmfsPi0va1f1qVobC6wR4v1CCdZKoE
        yTp0bXWoEY1+T6t4iCdlfEleanyP6nUTxj3Y9U+mClU/mV8mS96hNdM2TWEFzdSs7zXzfzMQIyL
        jjtj+I0AzbzcA64EJPJXReeqVLpM=
X-Received: by 2002:ad4:4651:: with SMTP id y17mr4824109qvv.62.1633018585705;
        Thu, 30 Sep 2021 09:16:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKKyXlAu88yT/Ncrwt78FPnRem6haM+mVwbMyRVbauH1kFDujfGodJqQzcKqQw2YTR6M1WcA==
X-Received: by 2002:ad4:4651:: with SMTP id y17mr4824072qvv.62.1633018585374;
        Thu, 30 Sep 2021 09:16:25 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id j2sm2065843qta.84.2021.09.30.09.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 09:16:24 -0700 (PDT)
Date:   Thu, 30 Sep 2021 12:16:23 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Clark Williams <williams@redhat.com>,
        Pierre FICHEUX <pierre.ficheux@smile.fr>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
In-Reply-To: <87pmsq9kdd.fsf@jogness.linutronix.de>
Message-ID: <49773379-4c5b-b6be-5125-9884e2b364aa@redhat.com>
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com> <87y27e53a2.fsf@stealth> <20210930132319.eixnv6rb66ui6x6j@linutronix.de> <87v92i9o5t.fsf@jogness.linutronix.de> <6034cc70-fb69-d9d-ce31-673d4d42adc@redhat.com>
 <87pmsq9kdd.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 30 Sep 2021, John Ogness wrote:

> On 2021-09-30, John Kacur <jkacur@redhat.com> wrote:
> >>>> With hackbench, the system is sufficiently busy to avoid the going
> >>>> into idle.
> >>>
> >>> Not just that. cyclictest's usage of /dev/cpu_dma_latency has the side
> >>> effect that it may disable some of the PM stuff in the system.
> >>> So your system appears good but then when cyclictest is gone, the
> >>> numbers go up.
> >>>
> >>> Maybe we should drop that so we observe a system without altering its
> >>> behaviour?
> >> 
> >> +1
> >> 
> >> Developers wanting to explicitly cause this behavior can use --latency=
> >> to enable it. Having it on as a default is misleading.
> >
> > Where does this "--latency=" option apply to?

I see this option was dropped from the help, will add it back.

> 
> It is the value written to /dev/cpu_dma_latency, which AFAIK writes the
> maximum acceptable latency (in microseconds). This translates to the
> allowed C states. cyclictest currently writes 0, which should keep the
> processor in C0. For example, setting it to 1-5, should allow C0 and C1.
> 
> Using --laptop will cause cyclictest to avoid touching
> /dev/cpu_dma_latency. But nobody would know that unless they looked at
> the code.
> 
> IMHO, systems should be configured for production use and cyclictest
> should just _measure_ latencies at a specified priority level. But by
> default cyclictest is adjusting global system behavior during
> measurements, thus providing results that the system (as it is actually
> configured) would not be able to provide.

The thing is, we are not just trying to measure an environment, we are 
also simulating a realtime application. If your realtime environment 
doesn't disable c-states, then your realtime application probably should.

It's always a question of are we trying to measure a worse case scenario 
or a best case scenario.

If I remove this default we're going to get a slew of reports from people 
using cyclictest wondering why they aren't getting good realtime 
performance.

> 
> I realize that nobody wants to touch defaults. But I'm not sure users
> are aware how important the --laptop option is for realistic
> measurements. In fact, the description of --laptop even encourages users
> _not_ to use it. :-/

I agree, but I just wanted to quickly inform people on this email thread, 
how to disable the default of writing to cpu_dma_latency, before we create 
any patches to improve this.

