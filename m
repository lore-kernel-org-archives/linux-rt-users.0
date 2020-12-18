Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DD9C4361B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E8E23B28
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbgLRQuC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbgLRQuC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:50:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFACC0617A7
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Dec 2020 08:49:22 -0800 (PST)
Date:   Fri, 18 Dec 2020 17:49:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608310160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nDG+x4XEBVjyEzV945PP9xvSR8azcYEUN0ROHcIC7ck=;
        b=r4RvSDfnce2g+IhCfm+stoUdov69aYEEdgTbNA67HE+NW8+c67W9rXI4LH5Jviv1RgKQdT
        +6KpS7hyZ4d1Ilc43ok4fD7GatcZ70t5jvqZBAm2E8rEsDBHE7unkvx/fdivhGC8Q2a6cG
        AWnn76+cqzzJxdwcaLkuL5UeyLwFYBKZLg2Dr8EshGuTAonqDO5V/8ELIaL8L+v3QdBIIH
        ekJzFVyFLvhGXQTWfBkgR3sExhlblYnYbPapBrjvqv8LOAlXmVRYzxbourM9U1XOd9N9SN
        If6vsQSiCQ/jcJcP0ldSQ2CEU/vB6Kdx2VWcKJvmj4eYnLDC+qOqYKiClJGlag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608310160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nDG+x4XEBVjyEzV945PP9xvSR8azcYEUN0ROHcIC7ck=;
        b=k8ksxqEykGmK8Z/KNxreEHnyzrj4jqSTENNb4X+okLHuY0zAwN4/J7KhlIiCAF8e9Gj+L9
        nLfSaR/LCGSohtBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alison Chaiken <achaiken@aurora.tech>
Cc:     Paul Thomas <pthomas8589@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: net latency, long wait for softirq_entry
Message-ID: <20201218164919.nklchwwxzzoi36bt@linutronix.de>
References: <CAD56B7dKyiUBQctrrpLYU6XM5cjfXD10E1fFMU5GpAe00g_TZQ@mail.gmail.com>
 <20201218135230.hb25ii2a3sbqrucw@linutronix.de>
 <CAFzL-7ujcJ4KDbgVoq-N6GRTWfemCA6hfqOzBGwcaDzt=0rGzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFzL-7ujcJ4KDbgVoq-N6GRTWfemCA6hfqOzBGwcaDzt=0rGzQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-12-18 08:18:05 [-0800], Alison Chaiken wrote:
> > Having a thread to run the tick-timer would avoid that scenario.
> >
> 
> Didn't ktimersoftd used to be such a thread?   It's still not entirely
> clear to me at least why it was removed.

Yes, ktimersoftd was such a thread that is why I am suggesting it. It
would be probably just a quick duct tape.

All of the reasons why it has been introduced disappeared in the
previous softirq rework. The NAPI handover works, posixtimer need no
additional love and so on (the original motivation to have it).

The problem, that Paul reported, should also exist for !RT with the
`threadirqs' switch (untested but it is the same code).
It is worth noting that in his report the latency was increased because
the timer-tick woke the ksoftirqd thread. Rightfully you could say that
this would not have happen with the timer thread. 
However, the usb-storage driver (just to pick an easy to trigger
scenario for my case) also wakes the ksoftirqd if a transfer completes.
If the ethernet interrupt fires before ksoftirqd completes its task then
we have the same situation without the involvement of the timer :)

> -- Alison Chaiken
>    Aurora Innovation

Sebastian
