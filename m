Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B13AC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Nov 2021 10:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F7061027
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Nov 2021 10:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhKJKsv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 05:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJKss (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Nov 2021 05:48:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C08C061764
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Nov 2021 02:46:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkl79-0005P5-9p
        for linux-rt-users@vger.kernel.org; Wed, 10 Nov 2021 11:45:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkl78-0003Fg-PC
        for linux-rt-users@vger.kernel.org; Wed, 10 Nov 2021 11:45:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkl78-0007ur-OV
        for linux-rt-users@vger.kernel.org; Wed, 10 Nov 2021 11:45:58 +0100
Date:   Wed, 10 Nov 2021 11:45:57 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     linux-rt-users@vger.kernel.org
Subject: Priority inversion for processes bound to a fixed CPU
Message-ID: <20211110104557.uji3nicrymh2lzrc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gtorc7atvacf453o"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-users@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--gtorc7atvacf453o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

recently I debugged a problem on an -rt enabled kernel. The relevant
part of the analysed trace looks as follows:

    napi/can0-10-360     [001] d...312  3565.642595: sched_pi_setprio: comm=
=3Dcandump pid=3D2182 oldprio=3D120 newprio=3D14
    napi/can0-10-360     [001] d...212  3565.642619: sched_switch: prev_com=
m=3Dnapi/can0-10 prev_pid=3D360 prev_prio=3D14 prev_state=3DR =3D=3D> next_=
comm=3Dcantest next_pid=3D915 next_prio=3D39
    ....
	  rcuc/0-15      [000] d...212  3565.642633: sched_switch: prev_comm=3Drcu=
c/0 prev_pid=3D15 prev_prio=3D98 prev_state=3DR+ =3D=3D> next_comm=3Dcandum=
p next_pid=3D2182 next_prio=3D14
	 candump-2182    [000] d...3..  3565.642646: sched_pi_setprio: comm=3Dcand=
ump pid=3D2182 oldprio=3D14 newprio=3D120

So the napi/can0-10 wants to grab a mutex that candump is holding. So
candump's priority is bumped from 120 to 14.

However the napi/can0-10 process (and a few others) are pinned to cpu #1
and cantest isn't allowed to run on that one. And so cpu #1 schedules a
lower prio task while candump still has to wait a moment before being
scheduled on cpu #0.

I wonder if it would be sensible in such a case not only to increase the
importance of candump, but also to allow it to run on the cpu-set the
boosting process is allowed to run on until it releases the mutex.

Would that make sense?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gtorc7atvacf453o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGLouIACgkQwfwUeK3K
7AnjnAf/fTe+zqTVtv8PeumztDzehaJ2g4ucvq0feqSUedo6jVLxx6e/LbqJU1l8
mm7ezjgZ6wb9tPKotNfGfufApCegzX0f8z3UbD4IB3nt67vPv1q+cMO45K8yU4Zw
8VN4F1aLVUOIgjHV66mHmVu3zoHdlpxI1iYZXpOJA6o6uIgNDtuBT3LLsFnNvehq
i43Sl22hAU0vf/khAiBtlvGRMzQjRYZSl+JSIXLuikgGL6t+Yi4HSB8pBNmGpYOs
ZOO9CSvz4BHTLS9IRNDpmJ/uuKpubJEZiDVo9U6ay9sWfsrd2Xo0RxqNEEJr4l9A
puN5ixbLXm9cMbQsEcRnwxHoCIhQdA==
=4cp6
-----END PGP SIGNATURE-----

--gtorc7atvacf453o--
