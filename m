Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96CFC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 17:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C4B64FEB
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 17:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhCKR4d (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:56:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCKR4V (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Mar 2021 12:56:21 -0500
Date:   Thu, 11 Mar 2021 18:56:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615485380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1MTYr/km/mUqBeRUosqKPsmDCLQGGJXa1fN3yicmL1U=;
        b=D6FWauLS7ZeGGM6jroTeoerxt5GINS18jcKSfupgjMPCtgwvUylxyk2SXm2KL8psGpTo2V
        w6qWNQWjz9a4s0CpjGclkxE4nxDLU5QEW3qFDdq3a8iLkYcMeI1uwmLAw7qqjt2rCx2SYa
        Uq19HDUeswKK3azTTuW3Cbl5qIPlFTKkvToe/j6agN6v+e26bmYUY4V+RThPtOJJcubglP
        Gq4zKamLk1Y+nDRd9LEKcUhjFSClKnqqsimoLI6xFoqVqBBz838l9mlnrTni03mRPsUFLm
        vLKgu7pALduzRrnBKYmfAfirRx0dLthyr8KNzLd03sWUKkYFuyON4mgDKCmKXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615485380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1MTYr/km/mUqBeRUosqKPsmDCLQGGJXa1fN3yicmL1U=;
        b=orqolce0vqZtYdqeYJysDVVA83VqTuVwlhZ6SQXS93cnOLEXhqhxgw0QLcHhbnOI3Meryr
        AMfF8MAIBo/LOlCQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: PREEMPT_RT benchmark
Message-ID: <YEpZwgED/4ddmsVf@lx-t490>
References: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
 <9be68ca5-9fec-161c-1b37-1b47c0a1d845@monom.org>
 <CAKkbJ-x4Er7RKhvrThtmmf-MT5uakdkc2G0ZL06i-fGsmBzmSg@mail.gmail.com>
 <YEpCkqfg4umsS4lv@lx-t490>
 <CAKkbJ-weFeM5EiBObqULkanBZpA6M9_Pfzu0seZ_cKBnNzEwyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKkbJ-weFeM5EiBObqULkanBZpA6M9_Pfzu0seZ_cKBnNzEwyQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Michel Macena Oliveira wrote:
> Ahmed S. Darwish wrote:
> > [ again, no top-posting please... ]
...
> >
> >
> > Well, if you do it for the benchmark, but not for production, then of
> > course, the benchmark is meaningless.
>
> Then in case of a RT application for production I should "live" with
> this problem?
>

Well, you should have an over-all realtime strategy for your product.

This includes thermal requirements for both CPU (communicated with the
provider, due to the possible removal of power-saving support in SW) and
system enclosure... then you know if you can "live with it" or not.

> > If you're interested, I presented a small talk about the topic here:
> > https://linutronix.de/PDF/Realtime_and_graphics-acontradiction2021.pdf
>
> Thanks, really helpful, but if I understand, in your application
> you've used Intel CAT to mitigate the latency and plan to use Intel
> MBA as well. Is that true?

Sorry for being picky, but this was part of another e-mail sub-thread.
You should've kept it there...

Anyway, the answer to your question is yes. You need to talk to Intel
for MBA support on non-Xeon CPUs though, as the instructions are only
available under an NDA. I cannot comment further on this.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
