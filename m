Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE4EC6369E
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF00D207BC
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="etudEda3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MIcUkB/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF00D207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-rt-users-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbgKPRUC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:20:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42438 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732711AbgKPRUC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Nov 2020 12:20:02 -0500
Date:   Mon, 16 Nov 2020 18:19:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605547200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d5eIqs+9lW2k53/4xvPilDMYnTDPPLuw+UU8wZcXX98=;
        b=etudEda3u2kGfRNHd/3MXBZWJ5utxS0EQnYs7tTi3OeWm9C9pgmvPzNaLhAiBD6eBkV3eb
        1q47+tdKreJdWVHjh24KHVIlvNuQXWQcmtybUhcNHbJlf4su+KvtNBUGy1r7atfud0/iyk
        ArSXXyfHWxzTKx81AhzZ53JMiw4X1a7vFpfyU65hCLmffT4Lf2oZTpoPfcSv+zMjH2WYaY
        vl8MEQZ5sF4dINm9e32nMKPcsBsawlFf0jrJf+FBlB9LvSUy88khOqAlsQjsoNq6GIZQ2G
        i4CkHmgZBi1KMBg4AxHzXpD7bWMRAaXFQJW9TKfm5E7gEoaOTsYTaWTR/raJJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605547200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d5eIqs+9lW2k53/4xvPilDMYnTDPPLuw+UU8wZcXX98=;
        b=MIcUkB/a1H9kHrTI0PIcXEBu4agE7keM00zLrpYrw/0G6U5EtuIiRqch6KFQMM1NIRBHBE
        J4lkUtjFOHw4T7DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org
Subject: Re: [PATCH RT 1/5] net: Properly annotate the try-lock for the
 seqlock
Message-ID: <20201116171958.2opbksmgbznrjxu2@linutronix.de>
References: <20201110153853.463368981@goodmis.org>
 <20201110154024.958923729@goodmis.org>
 <617eb5e8478df466afa9013b02a2425f7c4c673f.camel@kernel.org>
 <aa57c01bceaaac362d4da6e25427827fabe4d37a.camel@kernel.org>
 <6209c8773bb1d361266046323f266526a810f850.camel@gmx.de>
 <0936e53c297ef3202ce3a48a135053f468c427af.camel@kernel.org>
 <c09b5a4153cfea8ed181bfb48ade0aafa9dab6fb.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c09b5a4153cfea8ed181bfb48ade0aafa9dab6fb.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-15 05:52:33 [+0100], Mike Galbraith wrote:
> On Sat, 2020-11-14 at 13:24 -0600, Tom Zanussi wrote:
> > On Sat, 2020-11-14 at 20:00 +0100, Mike Galbraith wrote:
> >
> > > __raw_write_seqcount_end() is an integral part of write_sequnlock(),
> > > but we do seem to be missing a seqcount_release() in 5.4-rt.
> > >
> >
> > Yep, you're right, it's just the missing seqcount_release() - I'll
> > resubmit with just that.
> 
> Or just drop the backport, since it adds annotation, while the original
> was fixing existing annotation.
> 
> __raw_write_seqcount_begin() called in 5.4-rt try_write_seqlock() is
> not annotated, while write_seqcount_begin() called by the 5.9-rt
> version leads to the broken annotation that the original then fixed.

That is correct.
I was looking at the 5.4-RT series Steven posted and I was under the
impression that this patch was correctly missing in previous RT since I
even added the stable tag.
As Mike said, the previous RT implementation did not use seqlock
annotation, they used a spin-lock instead. So the "try_write_seqlock()"
did the try-lock annotation.
With the reworked seqcount implementation (v5.6-RT time frame) this was
solved differently (closer to what upstream does) and the now the
annotation was wrong and fixed.

Sorry for that.

> 	-Mike

Sebastian
