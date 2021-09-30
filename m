Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C1AC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 15:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6906613D1
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 15:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349186AbhI3PEl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348704AbhI3PEj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 11:04:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F49C06176A
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 08:02:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633014174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V10D3zAaUJDPArsUDJOGVrDeFeSVuYvdMvu38U7HUx8=;
        b=XtI+PyMK1gG+DKi6p/7q9VB92TvGflUf659NjfVbjFCsDwYCeB9i7PgXvy6foYPXGvu7D3
        NPNPlWluUxg9s9r5M+eb08djJVGsQUI/E0Dtoixif9j27ydRRfgpMITfvswNjISv8j/NDw
        E/+NpfnMXK5YH91QhNFbriwsFL047H128ugBmIpcqHIYDzEXNhDx0Rg2WEWd8iiSoPzmd+
        MnH0TnOMdPvClLC8WOa/af8K+MX4iiFfLJOE/LVraPKhW+hGmAVio3jRnAR4XYIORy997W
        R1Q/tgDDr3vXBo4x4n7nBwTv7W9gJ0MWchApJh1Kg30bIt0w2ikXSy0+hMRgyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633014174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V10D3zAaUJDPArsUDJOGVrDeFeSVuYvdMvu38U7HUx8=;
        b=7/f8cCJvlFJFM5VL4BVPs3AFHgfyiO/MpnKgCgCmacqfr/5S0NiLSrgfaPRbyS4HJWBD3z
        HLCuK9140PWk1QBg==
To:     John Kacur <jkacur@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Clark Williams <williams@redhat.com>,
        Pierre FICHEUX <pierre.ficheux@smile.fr>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
In-Reply-To: <6034cc70-fb69-d9d-ce31-673d4d42adc@redhat.com>
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth> <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
 <87v92i9o5t.fsf@jogness.linutronix.de>
 <6034cc70-fb69-d9d-ce31-673d4d42adc@redhat.com>
Date:   Thu, 30 Sep 2021 17:08:54 +0206
Message-ID: <87pmsq9kdd.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-30, John Kacur <jkacur@redhat.com> wrote:
>>>> With hackbench, the system is sufficiently busy to avoid the going
>>>> into idle.
>>>
>>> Not just that. cyclictest's usage of /dev/cpu_dma_latency has the side
>>> effect that it may disable some of the PM stuff in the system.
>>> So your system appears good but then when cyclictest is gone, the
>>> numbers go up.
>>>
>>> Maybe we should drop that so we observe a system without altering its
>>> behaviour?
>> 
>> +1
>> 
>> Developers wanting to explicitly cause this behavior can use --latency=
>> to enable it. Having it on as a default is misleading.
>
> Where does this "--latency=" option apply to?

It is the value written to /dev/cpu_dma_latency, which AFAIK writes the
maximum acceptable latency (in microseconds). This translates to the
allowed C states. cyclictest currently writes 0, which should keep the
processor in C0. For example, setting it to 1-5, should allow C0 and C1.

Using --laptop will cause cyclictest to avoid touching
/dev/cpu_dma_latency. But nobody would know that unless they looked at
the code.

IMHO, systems should be configured for production use and cyclictest
should just _measure_ latencies at a specified priority level. But by
default cyclictest is adjusting global system behavior during
measurements, thus providing results that the system (as it is actually
configured) would not be able to provide.

I realize that nobody wants to touch defaults. But I'm not sure users
are aware how important the --laptop option is for realistic
measurements. In fact, the description of --laptop even encourages users
_not_ to use it. :-/

John Ogness
