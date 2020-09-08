Return-Path: <SRS0=F8C2=CR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4712C43461
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 18:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B392074D
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 18:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YsccOOLn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5AXXdruc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbgIHR6u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbgIHQMM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Sep 2020 12:12:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E82C061384;
        Tue,  8 Sep 2020 05:24:07 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:19:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599567544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TKB0Ut4fYAZZpMyUAHpg5+GM/8+7pBIdQzcnhOdCgo=;
        b=YsccOOLnpaNU0AeEi73XtFvyvX1+md+SrQ89Tiv2DSQaVovO6y89KZYJ+vT19GvUk+X/pl
        YA7i6ITJuUhC1QS/p9mq7eASD67dswoI5G3yhTQ3r/b0JMpy6FDDYhUwEFtoqUiPIeWtQ2
        JEh1TCrFBs4fxg9sxVhGCvlXYXu6l8qaqxMWak1dkbHAAJKh5uRAzKRL/WJ9WLz9HUv3iG
        KuSA8KcqKXZMFQte3gge8lWtN3bBnlqhbmZq5gOIPxXNMfiCXF3efcxprvxs9T0Tjqs7hu
        oEdUdEVGorBNmUE62YyloHit+W8g46g5gDp71iVpY4kSRlzQlgNOIbhzgg9TZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599567544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TKB0Ut4fYAZZpMyUAHpg5+GM/8+7pBIdQzcnhOdCgo=;
        b=5AXXdrucoyJKR2vHzH/dqb+e7+I4yv770rfHOl7a1C/ryCrnRuaA+irKIxoasY9T3t0HI3
        zaAveCBqdPfk50Bw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: v5.9-rc3-rt3 boot time networking lockdep splat
Message-ID: <20200908121902.zlfd3balosnu7ies@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
 <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-09-05 06:47:29 [+0200], Mike Galbraith wrote:
> [   22.024936] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   22.024936] WARNING: possible circular locking dependency detected
> [   22.024937] 5.9.0.gc70672d-rt3-rt #8 Tainted: G            E
> [   22.024938] ------------------------------------------------------
> [   22.024939] ksoftirqd/0/10 is trying to acquire lock:
> [   22.024941] ffff983475521278 (&sch->q.lock){+...}-{0:0}, at: sch_direc=
t_xmit+0x81/0x2f0
> [   22.024947]
>                but task is already holding lock:
> [   22.024947] ffff9834755212b8 (&s->seqcount#9){+...}-{0:0}, at: br_dev_=
queue_push_xmit+0x7d/0x180 [bridge]
> [   22.024959]
>                which lock already depends on the new lock.
>=20
> [   22.024960]
>                the existing dependency chain (in reverse order) is:
> [   22.024961]
>                -> #1 (&s->seqcount#9){+...}-{0:0}:
> [   22.024963]        lock_acquire+0x92/0x3f0
> [   22.024967]        __dev_queue_xmit+0xce7/0xe30
=E2=80=A6
>                -> #0 (&sch->q.lock){+...}-{0:0}:
> [   22.025015]        validate_chain+0xa81/0x1230
> [   22.025016]        __lock_acquire+0x880/0xbf0
> [   22.025017]        lock_acquire+0x92/0x3f0
> [   22.025018]        rt_spin_lock+0x78/0xd0
> [   22.025020]        sch_direct_xmit+0x81/0x2f0
=E2=80=A6

>                other info that might help us debug this:
>=20
> [   22.025061]  Possible unsafe locking scenario:
>=20
> [   22.025061]        CPU0                    CPU1
> [   22.025061]        ----                    ----
> [   22.025062]   lock(&s->seqcount#9);
> [   22.025064]                                lock(&sch->q.lock);
> [   22.025065]                                lock(&s->seqcount#9);
> [   22.025065]   lock(&sch->q.lock);
> [   22.025066]
>                 *** DEADLOCK ***

This has nothing to do with the bridge but with the fact that you use a
non standard queue class (something else than pfifo_fast).

The flow in CPU1 is the default flow but the second lock is a trylock.
CPU0 is from sch_direct_xmit() where it drops the the
root_lock/qdisc.lock and re-acquires it. This shouldn't fail because the
CPU1 a try-lock of the seqlock first and then the seqcount is "not
acquired". So if we annotate the seqcount as a try_acquire then it
should not do this anymore.

Sebastian
