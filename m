Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45686C433DB
	for <linux-rt-users@archiver.kernel.org>; Sun,  7 Feb 2021 09:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014A264E0F
	for <linux-rt-users@archiver.kernel.org>; Sun,  7 Feb 2021 09:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBGJ66 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 7 Feb 2021 04:58:58 -0500
Received: from sleepmap.de ([85.10.206.218]:44530 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBGJ65 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 7 Feb 2021 04:58:57 -0500
Date:   Sun, 7 Feb 2021 10:58:13 +0100
From:   David Runge <dave@sleepmap.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YB+5tdIpbTfnDnIi@hmbx>
References: <YBVG/PG7syFIUBno@hmbx>
 <20210201083441.ocucdvdrv37goz2s@linutronix.de>
 <20210205112638.xuduvuefy3auycht@linutronix.de>
 <YB3TLNN39/XhUyUY@hmbx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6cICrVYnMwOEFd8g"
Content-Disposition: inline
In-Reply-To: <YB3TLNN39/XhUyUY@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--6cICrVYnMwOEFd8g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 7 Feb 2021 10:58:13 +0100
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]

On 2021-02-06 00:22:12 (+0100), David Runge wrote:
> On 2021-02-05 12:26:38 (+0100), Sebastian Andrzej Siewior wrote:
> > On 2021-02-01 09:34:41 [+0100], To David Runge wrote:
> > > + firewire maintainer
> > >=20
> > > On 2021-01-30 12:46:04 [+0100], David Runge wrote:
> > > > On 2021-01-29 18:04:14 (+0100), Sebastian Andrzej Siewior wrote:
> > > > > I don't see anything wrong. There is small difference in timing a=
nd
> > > > > then the RT version does not do a thing while !RT keeps reseting=
=E2=80=A6
> > > > > Could you try non-RT with the
> > > > > 	threadirqs
> > > > >=20
> > > > > option?
> > > >=20
> > > > Yes, (sorry for not including that earlier D:) that fails the same =
way
> > > > as the realtime kernel:
> > > > https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.4.91-kernel_thread=
irqs.log
> > >=20
> > > Could be specific to the chip or the ohci driver. Either way, the pro=
blem
> > > are the threaded interrupts.
> >=20
> > David, could you please try a v5.10 kernel with threadirqs? I've been
> > just told that it works there on a ppc64 box.
>=20
> I have now tried with our vanilla 5.10.13 kernel, as I have issues
> getting 5.10.12-rt26 to boot at all on my machine (will try to
> investigate that tomorrow).

With 5.10.12-rt26 the controller still does not initialize at all
though (/dev/fw0 does not appear):
https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.10.12-rt26-kernel.log

Best,
David

--=20
https://sleepmap.de

--6cICrVYnMwOEFd8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAmAfubUACgkQVMKPT/Wh
qUmVyQ/7B7Nk1LCykpTd4rrzSTmYYdSrNhQJWzs3PCJZd2PWN25OnDypsk422RJm
Hhi1iP7+Op+a2ZZqzJu5Zu+DJ3doHP1fzxGMzLre2nQotk9xitsLrr8QtCoyNAZa
ztdeQXlUNC5fe2C/86cXctkpgR9qjYYefbd2Y4AlYdpNDNf97xE78Tg5yJ1XTmKC
eH3ofkz4JAJfojhsWFQ5Z6wA5nOqcgVl29PmKvGmjS323lcllT5I8ajiGUtUc4/g
JwBcCNoxIYdpTxzKyPD8/JaOjTDkxpUzKmfVPCtXx78OlEkrEsRhLMm7xfX9JTG4
hjjDNCO3HQXO6JDAQJ8Zd3bU94R4n8/h7LF6Uje2nk6F/5qZ/8Bv1OFX0dJUJ9TV
qAjFiv2+bQPRdkwkEezlAxhmR2J1Qz0hwWADiIYVLl6m45PkRL97RnCJx2t3WaE1
Z5lMcg8oNPOkcr/L2cMvqk3wd5DblpzeObspiSF/19mOtmMYO3BnPQKTKAL9vDqw
olIPmCj46oViPSaQ7ttWw4Luc4R6BrLtw24LUrNgZZrNpUAd7xTI1QsCwNtFak6h
pXqd4hchepps9mgOxq4fatYLQNgbidY1XuF7WJ5AjqVkt93/Thvo6GU5xEVB3xG6
tfpP6KeD8zb5VanosxBr1FzWDzlFo7M1+566lADFK4MTmnuzC9I=
=dhh2
-----END PGP SIGNATURE-----

--6cICrVYnMwOEFd8g--
