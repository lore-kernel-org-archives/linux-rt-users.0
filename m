Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B862C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Mar 2022 19:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiCYTqk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiCYTqX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Mar 2022 15:46:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D952BC1FE
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Mar 2022 12:27:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648236463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JfydAyDAsZAFNAngXFtaXDNQOR2Cj6aPIN10rHkwcu8=;
        b=wF4zfsjA/NZyghlXVuaERsIfqeLMrd7YWJg3X/ntD8/FC2mFPRZk29Ub+ty1LCPIYn71vJ
        ejxGaXJV9BPeoLAYwbOJj3CcznQqXmLKaeFbqu02h/uHAIeKE6KahhW21reUq0wbbqjJh/
        3w+q6ajFf83JA4QUZUlyLkNvIzzbuXTufyhMoWhAkCxfqtZnyFC1qq8mUD9+9v+N5qu94u
        yA9UE+6+BbIfehUvb9V31lIJKtUcdSAX+T77REGI2Q7rccM/KmpIHJ/HONYDlL0xhF3v+U
        oU8LoApeLM/H2QJaSrJap9ZxMfDMk62QUU4NDvTBrJRX8wN8+t35NzLtPa543Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648236463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JfydAyDAsZAFNAngXFtaXDNQOR2Cj6aPIN10rHkwcu8=;
        b=QYLNikRTwYtpQQeYz93zew4qvb5t4G0Gvi3uhdJST6nA3HxcjP2xlHtoPOzUypq2Mly87T
        NeeLxJYaXJaoIGBQ==
To:     Gautam Thaker <ghthaker@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: 5.15.28-rt35 #2 SMP PREEMPT_RT: Should scheduling latency be as
 large as 800 usec?
In-Reply-To: <CA+1+E3XkM=4ZPbbOGtj7kuWtJfciAJ+=M-UrOn-9YA2_B2mjmA@mail.gmail.com>
References: <CA+1+E3UVmbLA76t_JkZMMC6FHsmc_EOKeLztvgN6nAhTjjK5bQ@mail.gmail.com>
 <871qyse8ra.fsf@jogness.linutronix.de>
 <CA+1+E3WxTOMbh5OCub2wNiNWNELA2fcDL1hXgzJzr-Yc-FuoTQ@mail.gmail.com>
 <87lewzohkk.fsf@jogness.linutronix.de>
 <CA+1+E3WBGf1Q9aXAMiN3gfUEEqWQDfzPH-Hg6-G8FrZEBSZUYw@mail.gmail.com>
 <87r16qzbpu.fsf@jogness.linutronix.de>
 <CA+1+E3XkM=4ZPbbOGtj7kuWtJfciAJ+=M-UrOn-9YA2_B2mjmA@mail.gmail.com>
Date:   Fri, 25 Mar 2022 20:33:42 +0106
Message-ID: <877d8hhlxt.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-03-25, Gautam Thaker <ghthaker@gmail.com> wrote:
> Even after I set  to "-g performance"  and set "-d 3.2GHz -u 3.2GHz"  I get:
>
> ..[same for all CPUS 0-30 as well]
> analyzing CPU 31:
>   driver: intel_cpufreq
>   CPUs which run at the same hardware frequency: 31
>   CPUs which need to have their frequency coordinated by software: 31
>   maximum transition latency: 20.0 us.
>   hardware limits: 1.20 GHz - 3.20 GHz
>   available cpufreq governors: conservative, ondemand, userspace,
> powersave, performance, schedutil
>   current policy: frequency should be within 3.20 GHz and 3.20 GHz.
>                   The governor "performance" may decide which speed to use
>                   within this range.
>   current CPU frequency is 1.20 GHz.
>
> The current CPU freq is at 1.2 GHz.   SHould "current CPU frequency"
> be at 3.2 GHz now all the time?

Yes, it should.

> And even at 1.2GHz, if that freq is steady, why should 'hwlatdetect'
> report the 800 usec latency?

Why do you think it is steady?

> It seems my issues are something other
> than  "cpufreq-set" policy I am using. (SMIs?)

Perhaps your BIOS is performing some scaling via SMIs.

It might be interesting to burn your CPUs and see if they ramp up. And
then perform your cyclictest and hwlatdetect tests while they burn.

An effective way to burn your CPUs is just send them into infinite
loops:

for c in $(seq $(nproc)); do ( while true; do echo -n; done & ); done

Be sure check cpufreq-info while this is running.

John Ogness
