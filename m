Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C624C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 17:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163D460F22
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 17:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbhHDRCQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:02:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37162 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbhHDRCQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 13:02:16 -0400
Date:   Wed, 4 Aug 2021 19:02:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628096522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njdHwlZDNfjTmyv+M6Q8FrVV+kOhpgWcui0QMoTuTlY=;
        b=u8vUlaDJbguz6JokRpafuQNrTWuOJE0ZyBa+x2B1kj+D+vYyxSZQ61UhN3XfL6GE78Grbs
        CXskFh2Bh5MTTNLOsgKzF1k2hjn58hdbXcUjfcZuThYeyg8tMt/TKKdX6TLUWgSLBHDyms
        1TwHjOxv7l8LjHsIJnMA+sPhJD9WEF5cIzCetxL0JwCnnapRfaUgANrM4D+Rw/BQUJTbzr
        2DrUS7nX2XwDqa4/+M3x+i6cGqPTXp3IfYt7QlOJhK8aS+RX3IYvji7KNOKKXxsMZJT3jn
        7v+ZYJ/K/pVn8HNn714bsbtkCoD+RRVQc2rDGYZVmFAjjMFiPm++BW37LNAagw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628096522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njdHwlZDNfjTmyv+M6Q8FrVV+kOhpgWcui0QMoTuTlY=;
        b=D9QspVkqfxHyT3Xxinc58/7+zTOYxyTgm6M+Lma++Lh3IO6EfB9cigCyzSvfXZ8EKNLD0A
        muJGAISFxTvnFSBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804170200.tvocf4hodvzz632g@linutronix.de>
References: <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
 <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
 <20210804122029.6c5c837a@oasis.local.home>
 <4ffb8f7c-085c-f6cc-e308-3f75b24b8e47@kernel.dk>
 <20210804164735.sq6sjejusa37abkw@linutronix.de>
 <71d37a7d-af53-945e-0c49-3cb902487df4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71d37a7d-af53-945e-0c49-3cb902487df4@kernel.dk>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-04 10:57:11 [-0600], Jens Axboe wrote:
> > The spin_lock_irq() vs local_irq_disable() + spin_lock() is documented
> > in Documentation/locking/locktypes.rst.
> > That said I have no problem by carrying that patch in the RT-patchset
> > and revisit it later.
> 
> Right, I suspect that was added as a pre RT patch dump at some point.
> It's a newer thing. Is it actually possible to set PREEMPT_RT in the
> mainline kernel? Looks like it depends on ARCH_SUPPORTS_RT and nobody
> sets that.

Yes. It is upstream now. The documentation and CONFIG_PREEMPT_RT symbol.
The Kconfig symbol has already users outside of the -RT patch.

You can't enable it yet since we require a few things which are on their
way.

Having the symbol and the documentation helped to convince some people
:) 

> So I agree that just carrying your solution in the RT patchset is fine
> for now, we can revisit later.

Okay.

Sebastian
