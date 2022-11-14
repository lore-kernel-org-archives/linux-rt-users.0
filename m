Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88B3C433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Nov 2022 19:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiKNTKF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 14:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiKNTKE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Nov 2022 14:10:04 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E922D186EB;
        Mon, 14 Nov 2022 11:10:02 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9B4E51C09DB; Mon, 14 Nov 2022 20:10:01 +0100 (CET)
Date:   Mon, 14 Nov 2022 20:10:01 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.19.261-rt116
Message-ID: <Y3KSiYf2WAct0Oks@duo.ucw.cz>
References: <166845241635.12044.11510831858945534704@beryllium.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wTHYoaRxRV+Qfko3"
Content-Disposition: inline
In-Reply-To: <166845241635.12044.11510831858945534704@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--wTHYoaRxRV+Qfko3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> I'm pleased to announce the 4.19.261-rt116 stable release.
>=20
> This is just an update to the latest stable release. No RT specific chang=
es.
>=20
> You can get this release via the git tree at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
>   branch: v4.19-rt
>   Head SHA1: edd6d572bf0f165405ed98d1b5ed3f191a9fb33b
>=20
> Or to build 4.19.261-rt116 directly, the following patches should be appl=
ied:
>=20
>   https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz
>=20
>   https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.261.xz
>=20
>
https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.2=
61-rt116.patch.xz

Thank you, I'll take a look.

Just out of curiosity, what happened to -rt115? I see announcements
for -rt114 and then -rt116.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wTHYoaRxRV+Qfko3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY3KSiQAKCRAw5/Bqldv6
8n2EAJ9s5ItFIqMo2PRArwEFkXnRt6qUugCfWqeZmi6qmX/kw2FWhnGGPqpuuLk=
=otDd
-----END PGP SIGNATURE-----

--wTHYoaRxRV+Qfko3--
