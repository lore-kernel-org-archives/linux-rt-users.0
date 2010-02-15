From: Clark Williams <williams@redhat.com>
Subject: Re: Tweak Latency on Intel ATOM
Date: Mon, 15 Feb 2010 08:38:47 -0600
Message-ID: <20100215083847.1a4a7ef0@torg>
References: <loom.20100209T081421-234@post.gmane.org>
	<20100210163818.7f54ec3a@torg>
	<4B73B7B5.4070509@gmx.net>
	<20100211093447.3c0a97cd@torg>
	<4B7914C6.8080005@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_//t0u58tajivxmm+=c9AvHME"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Max =?ISO-8859-1?B?TfxsbGVy?= <mxmr@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4848 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556Ab0BOOiz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Feb 2010 09:38:55 -0500
In-Reply-To: <4B7914C6.8080005@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_//t0u58tajivxmm+=c9AvHME
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Feb 2010 10:32:54 +0100
Max M=FCller <mxmr@gmx.net> wrote:
=20
> >
> > I'd say you're doing pretty good keeping under 50us. You might want to
> > try it under a heavier load than the shell script you've been running.
> > If you don't want to fool with rteval, try kicking off a kernel compile
> > in another window like this:
> >
> > $ while true; do make -j4 clean bzImage modules; done
> >
> > and then run cyclictest. A kernel compile with parallel jobs (-j) is a
> > good overall load of computation and I/O.
> >
> >  =20
>=20
> I tested now like you told me with irqbalance and cpuspeed services=20
> disabled. I hope i made the right for disabling irqbalance, i used the=20
> kernel parameter acpi_no_irqbalance. Is this correct? Unfortunately the=20
> results were nearly equal as before.

I don't think you're going to get much better results on the Atom. I
have an MSI Nettop box with the dual-core version and I saw about the
same results as you.

What sort of scheduling deadlines are you trying to meet?=20

Clark

--Sig_//t0u58tajivxmm+=c9AvHME
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAkt5XHsACgkQHyuj/+TTEp1TdQCfXREs8loyNB6UJXSvW7MqRxDp
QGwAnipUSWRY2qYS2sTBiX8QE+zDHrN2
=yH7A
-----END PGP SIGNATURE-----

--Sig_//t0u58tajivxmm+=c9AvHME--
