Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A02C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 18:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE2A60F5B
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 18:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhKLSiC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 13:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhKLSiC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Nov 2021 13:38:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57733C061766
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Nov 2021 10:35:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlbOF-0000Nt-KJ; Fri, 12 Nov 2021 19:35:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlbOF-0009uB-By; Fri, 12 Nov 2021 19:35:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlbOE-0002JY-4i; Fri, 12 Nov 2021 19:35:06 +0100
Date:   Fri, 12 Nov 2021 19:35:04 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Priority inversion for processes bound to a fixed CPU
Message-ID: <20211112183504.uostmodzkhsi5kkx@pengutronix.de>
References: <20211110104557.uji3nicrymh2lzrc@pengutronix.de>
 <20211112145452.fhpcn4fs7kmuq6y2@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="quojs45z72jz47jv"
Content-Disposition: inline
In-Reply-To: <20211112145452.fhpcn4fs7kmuq6y2@linutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-users@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--quojs45z72jz47jv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sebastian,

On Fri, Nov 12, 2021 at 03:54:52PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-11-10 11:45:57 [+0100], Uwe Kleine-K=F6nig wrote:
> > recently I debugged a problem on an -rt enabled kernel. The relevant
> > part of the analysed trace looks as follows:
> >=20
> >     napi/can0-10-360     [001] d...312  3565.642595: sched_pi_setprio: =
comm=3Dcandump pid=3D2182 oldprio=3D120 newprio=3D14
> >     napi/can0-10-360     [001] d...212  3565.642619: sched_switch: prev=
_comm=3Dnapi/can0-10 prev_pid=3D360 prev_prio=3D14 prev_state=3DR =3D=3D> n=
ext_comm=3Dcantest next_pid=3D915 next_prio=3D39
> >     ....
> > 	  rcuc/0-15      [000] d...212  3565.642633: sched_switch: prev_comm=
=3Drcuc/0 prev_pid=3D15 prev_prio=3D98 prev_state=3DR+ =3D=3D> next_comm=3D=
candump next_pid=3D2182 next_prio=3D14
> > 	 candump-2182    [000] d...3..  3565.642646: sched_pi_setprio: comm=3D=
candump pid=3D2182 oldprio=3D14 newprio=3D120
> >=20
> > So the napi/can0-10 wants to grab a mutex that candump is holding. So
> > candump's priority is bumped from 120 to 14.
> >=20
> > However the napi/can0-10 process (and a few others) are pinned to cpu #1
> > and cantest isn't allowed to run on that one. And so cpu #1 schedules a
> > lower prio task while candump still has to wait a moment before being
> > scheduled on cpu #0.
> >=20
> > I wonder if it would be sensible in such a case not only to increase the
> > importance of candump, but also to allow it to run on the cpu-set the
> > boosting process is allowed to run on until it releases the mutex.
> >=20
> > Would that make sense?
>=20
> Sounds like your problem could be solved by allowing candump to run on
> any CPU. Why not lift that restriction yourself?

I want to give two answers here:

 - There are some realtime requirements on this machine. To get
   the latency of the relevant userspace application down, cpu #1 is
   isolated and only runs the application (here in this test "cantest"),
   the can napi thread and the can irq thread.
   Do you want to suggest that this isn't a good idea?

 - Consider three processes A, B and C with increasing priorities (so C
   is the most important). If A holds a lock that C wants to grab, the
   kernel today already ensures (in the absence of cpu restrictions)
   that A is scheduled before B.
   In the presence of cpu restrictions this fails as this case shows:
   B and C are pinned to cpu #1, A must not run on cpu #1. Then it can
   happen that C waits for A but cpu #1 schedules B even though C being
   blocked should be more important than to run B and so A should be
   run.
   So I think while you are right that I could just allow candump to run
   on cpu #1 here, this is a corner case where the priority inversion
   handling isn't doing the right thing.

> From the trace, you have migration disabled for napi/can0. So that one
> can't be moved. If the lock, that is owned by candump, is a spinlock_t
> than candump has also migration disabled and can't be moved either.

Ah, I didn't know that holding a spinlock implies disabled migration. In
the !RT case this is obvious, with RT not so?! Then boosting not only
the priority but also the set of cpus the process can run on isn't as
effective as I expected.

Best regards and thanks for your response,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--quojs45z72jz47jv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGOs9UACgkQwfwUeK3K
7An53wf9GuWnAp/RCe5fd+uSOj+d821nwkrckzhUy+RkSyQ0ElC6xIcHAlBlQMlR
i/1pWd+gApZVoc0ySFI9R7DEx2jp0jaGBQO6CnAo5AxBp7LfosJjylmVLmvunUVo
CBdHGOmSpHE/dnkYaqhfXFrxCF7obuACPMm6Py82mzEHQLwzZN+sozc4ux5aa3j3
6bzAzTiTBYBdWG2K7/HPz/k9pSQnsf7ddLC1p5XXd3u8tOxfI1nOTfMcYytaAtWh
mpr44HwFAQ6In3j4yS2iitKLqCL2CEAtZe3yrR1Xe4qX0hBiB8zN8aP1CoMpvlrG
5I5cX7/egbgQOjy6gy+Aay8vqs3Upw==
=Odgx
-----END PGP SIGNATURE-----

--quojs45z72jz47jv--
