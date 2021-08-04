Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A0DC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 15:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF2660F14
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 15:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbhHDP6C (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 11:58:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36740 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbhHDP6C (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 11:58:02 -0400
Date:   Wed, 4 Aug 2021 17:57:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628092668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W0Ka5WCXvs7z/8LE8URZtq9Ty222C5WzSPRlUoQqkNY=;
        b=KHATt7/bumFM7H1Dp5bPJemVp613Uhui7ukuKAUzFED6PWGeoPSLdmhg5CrDnExiHyarkN
        GQUuuZBi7l53qHGbTMaGq0r5Uq0bDfxDaszEmV8Osq5fjI0pp9PoYFQFUCl6X6ktA/9VYs
        rtn6tjWnrn0qZVxg7wwUFYbReHiRdEGqkOCltwmUaJMeombqmTQ9DG+HtOdGjtr7IZblcC
        RmD5C/bTbrXNdP0nfv/1DRiPsOhDZWquhnY9B7CVkpKHucCBv/KEKAzP9hAXp1cn81w2Rp
        3kw+p/RkTl6DW1Qkr+HXa8FeE7mEh+Pz3697EBpzFuSAfZOM60kCD0fAZw9uMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628092668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W0Ka5WCXvs7z/8LE8URZtq9Ty222C5WzSPRlUoQqkNY=;
        b=mhI6U25PdgsJYnNEO9b7dvbd5BXW+UYc4zmswcjNz7jlIGMUY2csfDyo61g1gVh9MX9KWJ
        O7t0UxI19WRX2pDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
References: <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
 <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
 <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-04 09:49:48 [-0600], Jens Axboe wrote:
> 
> That'd work on non-RT as well, but it makes it worse on non-RT as well with
> the irq enable/disable dance. While that's not the end of the world, would
> be nice to have a solution that doesn't sacrifice anything, yet doesn't
> make RT unhappy.

There were plans to make local_irq_disable() mostly a nop (similar to
what ppc64 does). But I have no idea what happened. I hope that work
gets picked up.

Sebastian
