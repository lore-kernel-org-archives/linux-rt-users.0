Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC9AC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB4761211
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350796AbhI3Nmr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349986AbhI3Nmr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 09:42:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A612FC06176A
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 06:41:04 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633009263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xRHmSdekwfBnkaoXkoteZKQGZnal8PV+yI2FusGJIAE=;
        b=0pE2IS/eN1BWk3+h5n69fqJF9P7tNHgtwDZm5sFRZWNa3h7Qa9eP1L2u0yq522E7cOR+39
        ghcmzt3e28+oBuSPG4f+GUn7pWJJ0zWMF3o/nqvfpO5UWFg4oJgdlYzzUdzCVRU3xrJeAe
        GoygsnPa/E2QYMLnD+0u9thawE7UgMJ2gVHK88drc8lSKbeEt8eZ0FrJvBRnn6CwWqanjf
        EqqQpKy2bfXMgaezgpKn2Id4fj4zamaGQi6OoJ12yvnJgOgwaCPMXD4ZJWQa1UVcaTi/0u
        EC/cG0bMpz07/wtrMJ8cPw9vETJQ/CQLywwdFBXxqnvd5ld7qBI97wowuwTyiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633009263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xRHmSdekwfBnkaoXkoteZKQGZnal8PV+yI2FusGJIAE=;
        b=9jQIT9qqPJRvWF8iJBH8QpI2U6appJvvXWGYT24xZDfIqHedwq5MY1XnFib9wZu8orGp3b
        EUM7qTbhM0igd0BA==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     Pierre FICHEUX <pierre.ficheux@smile.fr>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
In-Reply-To: <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth> <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
Date:   Thu, 30 Sep 2021 15:47:02 +0206
Message-ID: <87v92i9o5t.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-30, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> With hackbench, the system is sufficiently busy to avoid the going
>> into idle.
>
> Not just that. cyclictest's usage of /dev/cpu_dma_latency has the side
> effect that it may disable some of the PM stuff in the system.
> So your system appears good but then when cyclictest is gone, the
> numbers go up.
>
> Maybe we should drop that so we observe a system without altering its
> behaviour?

+1

Developers wanting to explicitly cause this behavior can use --latency=
to enable it. Having it on as a default is misleading.

John Ogness
