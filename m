Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4ABC433B4
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 May 2021 20:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287616144A
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 May 2021 20:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhENUR0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 May 2021 16:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhENURY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 May 2021 16:17:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BD8C061574;
        Fri, 14 May 2021 13:16:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621023371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8OzCfKmakEi7mIeoNSOphmisK282OO0DAOPR2qw2dE8=;
        b=K/3EN/pCZIKGRAiYRdeJwytLW+CgkywrQwy8FqQjeh1BSrmYWtUyjHb494Me7h69uoY/L5
        6DpBDZxrNpfsCHtr94+YOVXpPCIl47e1cbKr3osxFvxqjQjXgamKjr5YWsMC4pnOKhfy/t
        dvJtzxFwpz2Q43c/LBFBtzPPb1GbG7+y63f7DFxYOZisagC9QDkLk4g59OWheviZAY9lHQ
        IVvkLnflYit6IJ/GjpQyrWqgMspmz2PambFP3DJFD9zR2eLd/xBB+rSX4gJnlb12hCrpIS
        8BUKmhxZ+n2lfgh23A8RSa6GOHQicU/G17EK3VhG+Hv1YsaXMKlJUFxDTjHRyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621023371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8OzCfKmakEi7mIeoNSOphmisK282OO0DAOPR2qw2dE8=;
        b=Xw07Y33FusZAjphc4Xf3aHfhnpW/zP3T+MBM+kzvjHTdvHxR5seCPOOdnNGA02t4cNxj6r
        Ydnf0PxwA7RZmfCA==
To:     Jakub Kicinski <kuba@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     netdev@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, sassmann@redhat.com,
        "David S. Miller" <davem@davemloft.net>, stable-rt@vger.kernel.org
Subject: Re: [PATCH net-next] net: Treat __napi_schedule_irqoff() as __napi_schedule() on PREEMPT_RT
In-Reply-To: <20210514115649.6c84fdc3@kicinski-fedora-PC1C0HJN>
References: <YJofplWBz8dT7xiw@localhost.localdomain> <20210512214324.hiaiw3e2tzmsygcz@linutronix.de> <87k0o360zx.ffs@nanos.tec.linutronix.de> <20210514115649.6c84fdc3@kicinski-fedora-PC1C0HJN>
Date:   Fri, 14 May 2021 22:16:10 +0200
Message-ID: <87v97l2hrp.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, May 14 2021 at 11:56, Jakub Kicinski wrote:
> On Thu, 13 May 2021 00:28:02 +0200 Thomas Gleixner wrote:
>> > ---
>> > Alternatively __napi_schedule_irqoff() could be #ifdef'ed out on RT and
>> > an inline provided which invokes __napi_schedule().
>> >
>> > This was not chosen as it creates #ifdeffery all over the place and with
>> > the proposed solution the code reflects the documentation consistently
>> > and in one obvious place.  
>> 
>> Blame me for that decision.
>> 
>> No matter which variant we end up with, this needs to go into all stable
>> RT kernels ASAP.
>
> Mumble mumble. I thought we concluded that drivers used on RT can be
> fixed, we've already done it for a couple drivers (by which I mean two).
> If all the IRQ handler is doing is scheduling NAPI (which it is for
> modern NICs) - IRQF_NO_THREAD seems like the right option.

Yes. That works, but there are a bunch which do more than that IIRC.

> Is there any driver you care about that we can convert to using
> IRQF_NO_THREAD so we can have new drivers to "do the right thing"
> while the old ones depend on this workaround for now?

The start of this thread was about i40e_msix_clean_rings() which
probably falls under the IRQF_NO_THREAD category, but I'm sure that
there are others. So I chose the safe way for RT for now.

> Another thing while I have your attention - ____napi_schedule() does
> __raise_softirq_irqoff() which AFAIU does not wake the ksoftirq thread.
> On non-RT we get occasional NOHZ warnings when drivers schedule napi
> from process context, but on RT this is even more of a problem, right?
> ksoftirqd won't run until something else actually wakes it up?

Correct. I sent a patch for the r8152 usb network driver today which
suffers from that problem. :)

As I said there, we want a (debug/lockdep) check in __napi_schedule()
whether soft interrupts are disabled, but let me have a look whether
that check might make more sense directly in __raise_softirq_irqoff().

Thanks,

        tglx
