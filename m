Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452A8C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 18:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1886760E93
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 18:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhHJSjo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhHJSjl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 14:39:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1FC0613D3;
        Tue, 10 Aug 2021 11:39:18 -0700 (PDT)
Date:   Tue, 10 Aug 2021 20:39:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628620756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQsW0cIdb0MxFU2big/wvpHz011f15hyxfe4NVpd5WA=;
        b=r2I0PLFV7r9UoHIQPu6hYfrVGP0/a1S+XaPbsZzu403a2bt4NovWlCfYmAGR6X7CAlvpjw
        msF0VJ7+zMBm2VdidzZOIPm1CaVulc2E4eeVynoOduCnBMiSogTlS09Ga9HNTBQP+3NBpw
        pEOhvIwpqD+gs+bH3p6+1jhS+SYAIZkoMrWmiynACz6gp0rqHFckUvQ2U5q36AjPbB7Jdc
        JwmNAHO//Dr3gy6ZGR4lOno2A45NQaqgPyx3MNyKUva0J4ixCyaDNohKFBUpWnHuKUqEEA
        J3BQ+X8ucTgMG7GHKYZnME5rIld8EvGUY3fZqP7ZdL3HOGRevzFwD92OwFidHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628620756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQsW0cIdb0MxFU2big/wvpHz011f15hyxfe4NVpd5WA=;
        b=0Bl05NQmmAdvdHRocvZypnaXKoLk0uXSc+Fwmkfc29sAarRsAtecejDfQxJ+aNZ0dw98T7
        PWVyeXIRH3aoZsDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [SPLAT 1/3] arm_pmu: Sleeping spinlocks down
 armpmu_alloc_atomic()
Message-ID: <20210810183914.2wd7hehdz7y4crla@linutronix.de>
References: <20210810134127.1394269-1-valentin.schneider@arm.com>
 <20210810134127.1394269-2-valentin.schneider@arm.com>
 <20210810135453.roczkohgm2lzhg66@linutronix.de>
 <874kbxqkyk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874kbxqkyk.ffs@tglx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-10 19:16:19 [+0200], Thomas Gleixner wrote:
> On Tue, Aug 10 2021 at 15:54, Sebastian Andrzej Siewior wrote:
> > On 2021-08-10 14:41:25 [+0100], Valentin Schneider wrote:
> >> [    4.172817] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
> >
> > Would it work to allocate the memory upfront and invoke the HP callback
> > via smp_function_call()?
> 
> Huch? If the memory is allocated during the prepare stage then the
> actual hotplug callback can just use it. So what's the SMP function call
> for?

You allocate the memory per-node (based on cpuid id) and you figure that
out on the target CPU. That is the smp-function call for unless there
another way to gather that information.
That is done in
 arm_pmu_acpi_find_alloc_pmu() -> read_cpuid_id()

> Thanks,
> 
>         tglx

Sebastian
