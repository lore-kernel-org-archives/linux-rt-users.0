Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79172C433DB
	for <linux-rt-users@archiver.kernel.org>; Sat, 30 Jan 2021 11:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EAB64E04
	for <linux-rt-users@archiver.kernel.org>; Sat, 30 Jan 2021 11:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhA3Lqu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 30 Jan 2021 06:46:50 -0500
Received: from sleepmap.de ([85.10.206.218]:54574 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhA3Lqr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 30 Jan 2021 06:46:47 -0500
Date:   Sat, 30 Jan 2021 12:46:04 +0100
From:   David Runge <dave@sleepmap.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YBVG/PG7syFIUBno@hmbx>
References: <YAwPoaUZ1gTD5y+k@hmbx>
 <YBJZk9/77+E0TRk4@lx-t490>
 <YBMvmU+kp11f7+wF@hmbx>
 <20210129170414.ugrlb6hpcnbiqqbf@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1CfPGX6UjLI+Mcey"
Content-Disposition: inline
In-Reply-To: <20210129170414.ugrlb6hpcnbiqqbf@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--1CfPGX6UjLI+Mcey
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 Jan 2021 12:46:04 +0100
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]

On 2021-01-29 18:04:14 (+0100), Sebastian Andrzej Siewior wrote:
> I don't see anything wrong. There is small difference in timing and
> then the RT version does not do a thing while !RT keeps reseting=E2=80=A6
> Could you try non-RT with the
> 	threadirqs
>=20
> option?

Yes, (sorry for not including that earlier D:) that fails the same way
as the realtime kernel:
https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.4.91-kernel_threadirqs.log

Best,

David

--=20
https://sleepmap.de

--1CfPGX6UjLI+Mcey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAmAVRvwACgkQVMKPT/Wh
qUn7nxAAvHbMZEth1i2weR6EeCEbOesl2La2Ntv8F4nthS14shTUcXR3KnASAVDk
Cn4G/YDs0lXApguu8wARq67kkkt/WY733kdCqom366fJuSlB216McXDIYFYrcp69
7bhWTQ6f0wcK5Z2AI5E5oBAMvxWrWYlNIvYTlOZIpsHjoWY53fTzpV1mfiw92D0i
Bu0SNgz/h1xl/GlKf0ytTcZOmqEa0qdEx7y0PrCEyql3TCnuXpTz4hUEvUTBFWqd
EcpLaN5i0pOkJKEc7eKBqrwNQbsIvlAGWVTSXStfpVyqYsMrbPkKwAwbZtGHixDE
XCsaQuz8PNNnNGEPblMyKgNFT6d3iXWkBg535ma+TYgxJ/tVkWvE5nLDtrzziN7v
8ra6zZCANF88Z8wsd1Y3Ed6x1Lg4xdl7KmB4Ofzcj6nAZWccUbL8FHkBqox+6DTc
4oREoHqBQ7hmcucVa/rEUWYH1RHRwPmztHathcz+0kfNNPuiT6OGvdOAup3lpZ1x
5YBWErgwwdXag/wn72y13VNKyc5cI6R8+cP9TbWMowrzYO0v0NorwnB0tb2QJM+I
sP2MzrvNKPTUVoJazXa+nKpkx9QNSZM5CowzgfIV9KTvSLc8ZJX3PPx4mv141brW
32tmHk9r8kD0pUuwgPv0OD1Xo13dLYBOA3AIHg27qPHZr4x7NJ0=
=nYJA
-----END PGP SIGNATURE-----

--1CfPGX6UjLI+Mcey--
