Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF77DC433E0
	for <linux-rt-users@archiver.kernel.org>; Sat,  6 Feb 2021 03:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F8864DBA
	for <linux-rt-users@archiver.kernel.org>; Sat,  6 Feb 2021 03:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhBFDJW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:09:22 -0500
Received: from sleepmap.de ([85.10.206.218]:59986 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232355AbhBFDBG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Feb 2021 22:01:06 -0500
Date:   Sat, 6 Feb 2021 00:22:12 +0100
From:   David Runge <dave@sleepmap.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YB3TLNN39/XhUyUY@hmbx>
References: <YBVG/PG7syFIUBno@hmbx>
 <20210201083441.ocucdvdrv37goz2s@linutronix.de>
 <20210205112638.xuduvuefy3auycht@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0UeuAIkDJI+OXuHw"
Content-Disposition: inline
In-Reply-To: <20210205112638.xuduvuefy3auycht@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--0UeuAIkDJI+OXuHw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 6 Feb 2021 00:22:12 +0100
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]

On 2021-02-05 12:26:38 (+0100), Sebastian Andrzej Siewior wrote:
> On 2021-02-01 09:34:41 [+0100], To David Runge wrote:
> > + firewire maintainer
> >=20
> > On 2021-01-30 12:46:04 [+0100], David Runge wrote:
> > > On 2021-01-29 18:04:14 (+0100), Sebastian Andrzej Siewior wrote:
> > > > I don't see anything wrong. There is small difference in timing and
> > > > then the RT version does not do a thing while !RT keeps reseting=E2=
=80=A6
> > > > Could you try non-RT with the
> > > > 	threadirqs
> > > >=20
> > > > option?
> > >=20
> > > Yes, (sorry for not including that earlier D:) that fails the same way
> > > as the realtime kernel:
> > > https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.4.91-kernel_threadir=
qs.log
> >=20
> > Could be specific to the chip or the ohci driver. Either way, the probl=
em
> > are the threaded interrupts.
>=20
> David, could you please try a v5.10 kernel with threadirqs? I've been
> just told that it works there on a ppc64 box.

I have now tried with our vanilla 5.10.13 kernel, as I have issues
getting 5.10.12-rt26 to boot at all on my machine (will try to
investigate that tomorrow).

On 5.10.13 with threadirqs the controller is indeed initialized again
(/dev/fw0 appears).
However, no connected device is detected (i.e. /dev/fw1 does not
appear).

Here are the kernel logs with "firewire-ohci debug=3D-1":
https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.10.13.arch1_threadirqs-ker=
nel.log

Thanks for the follow-up!

Best,
David

--=20
https://sleepmap.de

--0UeuAIkDJI+OXuHw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAmAd0yQACgkQVMKPT/Wh
qUl4qxAAvlMpTTx1UwI+TQdWOPbRIWPgWsTd8mQ6a+DWuFyVihS5dyXuvBiXQQyF
YHCMoUxQunGTWpejLiMsImkvG+WGxp8vHTgH8Xp52ODUXq0kslJwiSD2esrSJ6a/
+AG6SObGgKpv1zUGoy+g/BIQb+a4xSPHrlq6W6qAv79F35zGnKfy3bUeagobwbM2
DfzdFtMvipiZvWRCWDKHmelCHM/ZsTgvbZAtFITRbVpEo2rjmAhZZRuOPMs8cCnQ
GRW1zQpa7RmOqkO/vfRy//3j5i13AJ0zMKhOLtpsRMct8GAsgvUuaZ1jZ6tQXb8/
UxFXzItJVRt/MuGjnDFwUeIzDamEt20tbpsf/MMUVMiuEnjvx2/iBehfadzAZ/sz
wAHbbSqG8hzxtkIDiAyQB0C6+LozA/4yYuujmgba1fckOMvz7L9LBuIa1bXU21jQ
ZLLEmVgvCKUSpbil5uiKWtG6X5Ph9DgHbu3CIzy09fAwUCFXIGKIT2V1i8hm8od9
EF4pyIeK1d95FmwBDKuSGVcswqInAB4acMzT4VEMvBNyjl2yEaE2kS/eSV3QC3n8
1mjJ3pK/18+IAzFVFgxcT8Y9uaGLIFiN5e6DzL539psgg1mL7Seqe2y5AFjKxz1a
qxKQQ1rj1wGW3MepvYJKw9MceHLn0GUD1MTXrho8SMQu+pLZCu4=
=6AIq
-----END PGP SIGNATURE-----

--0UeuAIkDJI+OXuHw--
