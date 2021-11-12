Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA298C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C699D61075
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 14:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhKLO5p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 09:57:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbhKLO5p (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Nov 2021 09:57:45 -0500
Date:   Fri, 12 Nov 2021 15:54:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636728893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJKXXvD1gZ76k2AgghsMGgQ7dgTq5fxx7yYxVamAVdg=;
        b=PTZIrmiPizVBc/OvgBDG9MNETXHfA9KIfpq5JhgpVD8xJ5EnD+6Zvjpj8EX8Sv0s11ccEf
        DdUhaKN3a3swXkdJe1wW5AoJ8w6xmyasD24IJpo3Xei/bP1v4JJGWiItHA1BHjXN4EdpeE
        D6w+TfplooB39h5Kak7sY6skRSYA4VNZKwnArj4zkXT0RS33JYCmfvMhV2oTLb4s11zc/s
        /V9qmhPtBfAYbPz4ZQMs+5UlaN26Ckbv3bNRNRN0qsgTFNwXfsE4ndszJG3TyJdXwS3RVi
        zn9wdUASVmAydjfVhfzQoM4EdKsg3+GZ8mwJJYh9+QjC1Oa4zT8KbUOvSc1IWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636728893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJKXXvD1gZ76k2AgghsMGgQ7dgTq5fxx7yYxVamAVdg=;
        b=/8m8ixke6ZX4NxOQQeP89kPYM3O5xaa34a+NnANHgzEaotPYAV5wnAQKai8Wc9JMLiZG4j
        LKPahVdFd/aLv8AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Priority inversion for processes bound to a fixed CPU
Message-ID: <20211112145452.fhpcn4fs7kmuq6y2@linutronix.de>
References: <20211110104557.uji3nicrymh2lzrc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211110104557.uji3nicrymh2lzrc@pengutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-10 11:45:57 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> Hello,
Hi Uwe,

> recently I debugged a problem on an -rt enabled kernel. The relevant
> part of the analysed trace looks as follows:
>=20
>     napi/can0-10-360     [001] d...312  3565.642595: sched_pi_setprio: co=
mm=3Dcandump pid=3D2182 oldprio=3D120 newprio=3D14
>     napi/can0-10-360     [001] d...212  3565.642619: sched_switch: prev_c=
omm=3Dnapi/can0-10 prev_pid=3D360 prev_prio=3D14 prev_state=3DR =3D=3D> nex=
t_comm=3Dcantest next_pid=3D915 next_prio=3D39
>     ....
> 	  rcuc/0-15      [000] d...212  3565.642633: sched_switch: prev_comm=3Dr=
cuc/0 prev_pid=3D15 prev_prio=3D98 prev_state=3DR+ =3D=3D> next_comm=3Dcand=
ump next_pid=3D2182 next_prio=3D14
> 	 candump-2182    [000] d...3..  3565.642646: sched_pi_setprio: comm=3Dca=
ndump pid=3D2182 oldprio=3D14 newprio=3D120
>=20
> So the napi/can0-10 wants to grab a mutex that candump is holding. So
> candump's priority is bumped from 120 to 14.
>=20
> However the napi/can0-10 process (and a few others) are pinned to cpu #1
> and cantest isn't allowed to run on that one. And so cpu #1 schedules a
> lower prio task while candump still has to wait a moment before being
> scheduled on cpu #0.
>=20
> I wonder if it would be sensible in such a case not only to increase the
> importance of candump, but also to allow it to run on the cpu-set the
> boosting process is allowed to run on until it releases the mutex.
>=20
> Would that make sense?

Sounds like your problem could be solved by allowing candump to run on
any CPU. Why not lift that restriction yourself?
=46rom the trace, you have migration disabled for napi/can0. So that one
can't be moved. If the lock, that is owned by candump, is a spinlock_t
than candump has also migration disabled and can't be moved either.

> Best regards
> Uwe

Sebastian
