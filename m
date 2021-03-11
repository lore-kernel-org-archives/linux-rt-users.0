Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D93C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 12:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6DC64FC3
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 12:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhCKM6u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhCKM60 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Mar 2021 07:58:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C29BC061574
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Mar 2021 04:58:26 -0800 (PST)
Date:   Thu, 11 Mar 2021 13:58:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615467504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZblhYSqwelKK27T7VIBot2Eooam0rHaxXRjr5Z9jJsw=;
        b=cNVpemUqk6FhWQvIBuC8ivFucrNzmDR9I2IIL3Lsp1LL2jVJt3rxobPyUQm/N34x8p27t5
        KCSxiSD73kPrXRMg8YQQdcK9IvtWkKDjCqWLSlWNgf+8DPzzZNORIiBnwvj3hjIMKbdP86
        7rAWeiBsXPeQ+URiPqg4u/VBRQ/D7g2PjMUjTVrxthdl31wIIg6OmZgZtLFAkJuAW9ryrg
        EcfwYhBOPCNYqqrYR0ijoTEKDdayRJ2QOattLs5aTslRulJNdFknrPWDICCJUrlsZlvPTe
        k1BD6RQrbnT/y4K8FahDTfMd5obYoWDfi8pPyQd1MxiD06SWe85fFHDF8MA2bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615467504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZblhYSqwelKK27T7VIBot2Eooam0rHaxXRjr5Z9jJsw=;
        b=ep8MIDS4oAbaSCdFAiCFhpSgqctp75VE59+vyfdRNWghLxW8TuiifxFZMHEeTXp6Z/vTXy
        PwNRnY1M5RhCYNDg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: PREEMPT_RT benchmark
Message-ID: <YEoT7Wvk8V1cbHng@lx-t490>
References: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 10, 2021 at 05:07:47PM -0300, Michel Macena Oliveira wrote:
>
> I'm currently developing a time benchmark application where I want
> to measure a real time thread latency. My application is based on
> Cyclictest from
> the rt-tests suit.
...
>
> I programmed in such way that it would be equivalent to Cyclict test
>
...
>
> At least that's what I expected, but my latencies are much bigger than
> Cyclictest ones.
>

I don't know the nature of the "time benchmark" application you are
writing.

Just a small hint that if you're doing any heavy OpenGL graphics within
that application, the latency can shoot up significantly. On some of our
Intel boxes, this can lead to an increase of 100-200 microseconds.

That's because since Intel Gen9+ GPUs, Intel shares the Last-Level Cache
(and thus also memory bandwidth) between the GPU and the CPU. This
benefits graphical applications, but hurts predicatbility significantly.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
