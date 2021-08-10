Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3AAC4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 17:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2847760F41
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 17:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhHJRQw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 13:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHJRQt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 13:16:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67A6C0613C1;
        Tue, 10 Aug 2021 10:16:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628615780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJOgpX/DvNeXLH+wklFaeb5GxnL+wyxmMalnayOCByg=;
        b=E19laGCukdtghf6NpQvPRINadLHZxCC7qXXSI7QDrrA4Vblqso+9JgI60Kf050qopKP0lO
        eqzdMnNrXBlorHXXSN4wZsT+WFsGtoeQZQ7WaKcqc6ux+6HJkm6qGMjvfwuyTmxBbYxK17
        Q9eSjF20zBsP/bHmOguQgN9jeVUMhv83q1w+f7hMmURmqykq4N4glGb/tW4o90vCT3UcPB
        VCRP7bkmGB8WHlswanHzsz2Ud8yzOWdUhGYDSG1ipsDoUFulhaOHhWc29E0e7wqnbuibLs
        MtylbqzxPpK36uqChBILG3PxVpXhpy7m94SU5qUquq18X8LNNhMkbNn1NltgMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628615780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJOgpX/DvNeXLH+wklFaeb5GxnL+wyxmMalnayOCByg=;
        b=VKFgl2chLxMFOVq48X9mtpfnqhUuOa7vvNWKfU3FVQHr2U3UDBWX8EmHUplRR6QAm9ykMd
        cRMCrJew8AKIzLCQ==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [SPLAT 1/3] arm_pmu: Sleeping spinlocks down armpmu_alloc_atomic()
In-Reply-To: <20210810135453.roczkohgm2lzhg66@linutronix.de>
References: <20210810134127.1394269-1-valentin.schneider@arm.com>
 <20210810134127.1394269-2-valentin.schneider@arm.com>
 <20210810135453.roczkohgm2lzhg66@linutronix.de>
Date:   Tue, 10 Aug 2021 19:16:19 +0200
Message-ID: <874kbxqkyk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 10 2021 at 15:54, Sebastian Andrzej Siewior wrote:
> On 2021-08-10 14:41:25 [+0100], Valentin Schneider wrote:
>> [    4.172817] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
>
> Would it work to allocate the memory upfront and invoke the HP callback
> via smp_function_call()?

Huch? If the memory is allocated during the prepare stage then the
actual hotplug callback can just use it. So what's the SMP function call
for?

Thanks,

        tglx
