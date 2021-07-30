Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFB6C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 20:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1C060F48
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 20:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhG3Uta (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 16:49:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58840 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhG3Ut3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jul 2021 16:49:29 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627678163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uqi2XqGkI8u0LpsGdXDAcsLF+VndL2iSN5iYDs7Vj2E=;
        b=HS9dY7/0A/gGRrSJkeh/un5zvIV3mG7lRXVGzKipoXN6/ONKyo0q14r7kPGOxKRcfE4qzt
        UHkclIfsEDYfhnX9dKwF6+FB/EAyJfbJhmbii4akdtLMUDb2UXiS0wAgmRsCKpIrVVLyY8
        Dx9ulhXvJvyAtCx40H4WBVjuKfGxTl/sdLmGkG24wlWRGaEmsQb3VoenytRP7sHtWS0CNw
        dmgAQiEIcHv6Tx119T64QiSdMVWzxQRoln89k36gQEyFGlbKRFXLBB+oo5g9x3GDSTsdlL
        ryU/19aaZO/IlPwAFRExYPPIggOPbgV4gYYj2o/H4nZDdcv2XNMxJXyDXOlYdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627678163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uqi2XqGkI8u0LpsGdXDAcsLF+VndL2iSN5iYDs7Vj2E=;
        b=ys5OwQ6pwA6iphMbA2d9rWNeASY9bCQNC9TYiTpQU3om337x2Bj9s67Cs6iebdU0qiaR4E
        Cg61xH8RY8+t3KBQ==
To:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: v5.14-rc3-rt1 losing wakeups?
In-Reply-To: <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
References: <20210730110753.jvli6alm63h5lefy@linutronix.de>
 <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
Date:   Fri, 30 Jul 2021 22:49:22 +0200
Message-ID: <87pmuzsf1p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Mike,

On Fri, Jul 30 2021 at 17:21, Mike Galbraith wrote:
> On Fri, 2021-07-30 at 13:07 +0200, Sebastian Andrzej Siewior wrote:
>> Dear RT folks!
>>
>> I'm pleased to announce the v5.14-rc3-rt1 patch set.
>
> Damn, I was hoping to figure out wth is going on before the 62 patch
> version of tglx/rtmutex branch made its way out into the big wide
> world, but alas, I was too slow.
>
> I started meeting GUI hangs as soon as I merged the 62 patch series
> into my 5.13-rt based master tree.  I took tglx/rtmutex (977db8e523f5)
> back to 5.13-rt to make sure it wasn't some booboo I had made in the
> rolled forward tree, but the hangs followed the backport, and I just
> met them in virgin v5.14-rc3-rt1, so unfortunately it wasn't some local
> booboo, there's a bug lurking.  Maybe a config sensitive one, as what
> I'm seeing on my box seems unlikely to escape into the wild otherwise.
>
> First symptom is KDE/Plasma's task manager going comatose.  Notice soon

KDE/Plasma points at the new fangled rtmutex based ww_mutex from
Peter. I tried to test the heck out of it...

Which graphics driver is in use on that machine?

> been helpful anyway, box at a glance looks fine.  With lockdep enabled,
> a failing kernel gets so buggered it isn't even able to crashdump.

Ouch.

Thanks,

        tglx
