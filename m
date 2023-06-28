Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659D9EB64DC
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 08:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjF1IGQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjF1IBt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 04:01:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E03C16
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 00:59:38 -0700 (PDT)
Date:   Wed, 28 Jun 2023 08:42:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687934568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGb0ffys8qzHNLfYTkJM+MXSILcpLbVB+gIbBxsM7AY=;
        b=vfn4Q+4XnuU6O+Y5f6BpXymty4zVXB4MSRe4uJYPRXWO398waC1VUD6rdV9yTRvwkGszf7
        kMywfSpH4XoqFrceCC0W40SHt8FVu0ltc+cBiEHHD+rtCGATPtnjz6bHRssD5qNot68Zx+
        vuma6dmFWMrcdfnLgtIm6tSXZyr1806uLKdIbwLli8KRcmaDKciD4+OCM181xfp3ExXPSA
        pW72/HkZcgb8Cg4INQcd8EuD8q/z70Ubrt6Ne0LwkJLVgY8u4cKYVQO/yjmuRipnkoVvFm
        cr0UESsTv7Xc9JTMwMYNqsr7iHsew5hngNHcIttPZkh8qzRkxPfNnzEI9dFxag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687934568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGb0ffys8qzHNLfYTkJM+MXSILcpLbVB+gIbBxsM7AY=;
        b=hO4i08dd/6BEw6b1+9kzkbGoGGlDIBZ8GGs8DNJNTK9+h9pfgRrX3fTbI8GT6mo9KsGSDY
        ybfiasQnuPgkAKCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <williams@redhat.com>
Cc:     Martin Hicks <martin@sr-research.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: POSIX timer wakeups not preempting RT threads
Message-ID: <20230628064247.JP_3ZbxL@linutronix.de>
References: <CAMkvodZZKriPgWVwQ7R6ZS9eSbmmE3FC3f35QLg6u40NsnGJpg@mail.gmail.com>
 <20230626150816.RW-ysAqX@linutronix.de>
 <CAMLffL_R9AE-mTJnsbGoQE_Kf0GcF9X5UPVehtgjVNHrFmkszw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMLffL_R9AE-mTJnsbGoQE_Kf0GcF9X5UPVehtgjVNHrFmkszw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-06-27 18:22:51 [+0000], Clark Williams wrote:
> Martin,
Hi,

> Building on what Sebastian said, I'd say you have two options for this. T=
he
> first, if you absolutely must use POSIX timers, is to bump the ktimer/*
> threads to a SCHED_FIFO priority at least one above your application. That

Be ware that this thread also handles all _other_ wakeup on the given
CPU.
=E2=80=A6
> Ever since we've been using the PREEMPT_RT series, most people avoid using
> signals for regular event delivery. It's not that the signal mechanism is
> wrong, it's just that it's complicated code, having to handle a lot of
> legacy signal handling behavior that an RTOS probably doesn't care about.=
 I
> suspect that after PREEMPT_RT merges, we'll need to do a thorough audit, =
to
> make sure we don't have any corner cases for unreasonable delays in signal
> delivery, but to this point it hasn't really been a priority.

Other than the locks, you have a memory allocation in the sender's path.

> If it were me I'd do it in a dedicated thread.

Either that or rework the logic so that the proper thread gets the
wakeup.

> Clark

Sebastian
