Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3217C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 21:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8294E61076
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 21:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhKLVFf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhKLVFe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Nov 2021 16:05:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C153C061766
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Nov 2021 13:02:42 -0800 (PST)
Date:   Fri, 12 Nov 2021 22:02:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636750960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R219ik1UtA7P0doIRklYHzhrawit8AVBDViOm68XA6s=;
        b=mYgtIAHQTxoMcLWIAAiRof3HLMDiYHcs/vDupJ4HGYjdFYPi48A/2xRdmih6LGvu5sHI+N
        cVrJMUc9szvgx3WYy6k6Rhskar0p+5ptTjFFUgm8YA3VML9xC+ELt0DQdb2GJpyw5+W9mr
        SilLLnmPhdXLqKqX30EqWBVvYDaoMnw5snFwJO0mP1SKO8nnfq87TXTrQdSUVhIpNX23Rw
        0uReTGodGVFfLklo7p0eIdMKtGAXR2EOTUsJ9MruoYyBZlp3kJ/zDEFjsMoVMRZ99/JMPB
        iNyg+k4LPEsPl+Hn7tyEJh+QJLtk4uE6BnzwzHaE1Qta1H0XAfWkZb2G+ZHDCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636750960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R219ik1UtA7P0doIRklYHzhrawit8AVBDViOm68XA6s=;
        b=lbZ2CxjnXrKh7cjGJRUtppPoqI6HmL7qdHwUqA8A82lQ7sTW6wTJ80wzHQR3BwpAvVuJRw
        mpK08coBLK2JZqAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Priority inversion for processes bound to a fixed CPU
Message-ID: <20211112210239.rhiyoxl775424um6@linutronix.de>
References: <20211110104557.uji3nicrymh2lzrc@pengutronix.de>
 <20211112145452.fhpcn4fs7kmuq6y2@linutronix.de>
 <20211112183504.uostmodzkhsi5kkx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211112183504.uostmodzkhsi5kkx@pengutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-12 19:35:04 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> Hello Sebastian,
Hi Uwe,

> > Sounds like your problem could be solved by allowing candump to run on
> > any CPU. Why not lift that restriction yourself?
>=20
> I want to give two answers here:
>=20
>  - There are some realtime requirements on this machine. To get
>    the latency of the relevant userspace application down, cpu #1 is
>    isolated and only runs the application (here in this test "cantest"),
>    the can napi thread and the can irq thread.
>    Do you want to suggest that this isn't a good idea?

I don't know the whole setup but isolating CPUs doesn't sound bad. Also
the part where CPU0 had a task with "lower" priority was brief.

>  - Consider three processes A, B and C with increasing priorities (so C
>    is the most important). If A holds a lock that C wants to grab, the
>    kernel today already ensures (in the absence of cpu restrictions)
>    that A is scheduled before B.
>    In the presence of cpu restrictions this fails as this case shows:
>    B and C are pinned to cpu #1, A must not run on cpu #1. Then it can
>    happen that C waits for A but cpu #1 schedules B even though C being
>    blocked should be more important than to run B and so A should be
>    run.
>    So I think while you are right that I could just allow candump to run
>    on cpu #1 here, this is a corner case where the priority inversion
>    handling isn't doing the right thing.

Correct. Today we can disable migration after a lock has been acquired.
"Earlier" we needed to disable migration first and then acquire lock. So
it was possible that  pinned the task to a CPU which was idle at the
time and then we acquired the lock and couldn't run because a task with
higher priority was blocking us. So things improved here ;)

Even if we ignore the kernel related constrains, it is not obvious if
the user wants to violate the CPU restrictions. In terms of priority
inheritance this is well defined. It terms of hyperthreading, big/little
you may not want a migration. Also in term of a kernel-thread this might
not be wanted, somestimes these are pinned for reason.

> > From the trace, you have migration disabled for napi/can0. So that one
> > can't be moved. If the lock, that is owned by candump, is a spinlock_t
> > than candump has also migration disabled and can't be moved either.
>=20
> Ah, I didn't know that holding a spinlock implies disabled migration. In
> the !RT case this is obvious, with RT not so?! Then boosting not only
> the priority but also the set of cpus the process can run on isn't as
> effective as I expected.

This is unfortunate but we disable CPU migration while obtaining
spinlock_t / rwlock_t for the same reason as upstream does. Dropping
this part would violate kernel code. You could try to drop that and
check how long it takes until the kernel falls apart ;)
Nobody wanted to lift that restriction and handle things differently.
This led to the part where migrate_disable() is also implemented for !RT
in today kernel and used by the highmem code for example.

> Best regards and thanks for your response,
> Uwe

Sebastian
