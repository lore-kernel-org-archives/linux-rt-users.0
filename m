From: Henrik Austad <henrik@austad.us>
Subject: Re: [PATCH] Makefile: Set CC/AR variable only if it doesn't have a
 value
Date: Tue, 5 Jan 2016 22:15:56 +0100
Message-ID: <20160105211556.GA7561@icarus.home.austad.us>
References: <1451847271-31571-1-git-send-email-raj.khem@gmail.com>
 <20160104133903.GG92593@unpythonic.net>
 <186FF0A1-B6ED-49CA-B83F-3335126F671B@gmail.com>
 <20160104162507.GE28361@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Cc: Khem Raj <raj.khem@gmail.com>, Jeff Epler <jepler@unpythonic.net>,
	williams@redhat.com, jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:36274 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbcAEVQB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jan 2016 16:16:01 -0500
Received: by mail-lb0-f193.google.com with SMTP id ti8so19288952lbb.3
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Jan 2016 13:16:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160104162507.GE28361@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 04, 2016 at 05:25:07PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Jan 04, 2016 at 08:20:01AM -0800, Khem Raj wrote:
> >=20
> > > On Jan 4, 2016, at 5:39 AM, Jeff Epler <jepler@unpythonic.net> wrote:
> > >=20
> > > I believe the patch does not have the desired effect, because make(1)
> > > always sets CC automatically:
> > >=20
> > > $ cat raj.mk
> > > CROSS_COMPILE=3Dx86_64-linux-gnu-
> > > CC?=3D$(CROSS_COMPILE)gcc
> > > .PHONY: default
> > > default:
> > > 	@echo CC=3D$(CC)
> > > $ make -f raj.mk
> > > CC=3Dcc
> > >=20
> > > With your patch, those who specify CROSS_COMPILE, or for whom gcc and=
 cc
> > > are different, will get different (worse) behavior.
> >=20
> > Right. I think if CC was used as such with out constructing out of CROS=
S_COMPILE
> > in Makefile then my issue would be fixed too. However this would mean t=
hat cross compiling users
> > now have to pass CC =3D <cross-compiler> themselves instead of CROSS_CO=
MPILE prefix. Is that
> > acceptable ?
>=20
> You could play with something like:
>=20
> ifeq($(origin CC),default)
> CC=3D$(CROSS_COMPILE)gcc
> endif
>=20
> but not sure I'd like the result. If you asked me, I'd drop all that
> CROSS_COMPILE stuff.

Why? Isn't this the normal way of triggering cross-compile? AFIAK, that's=
=20
how the kernel does it, and that seems like a pretty sane way.

And yes, I compile rt-tests to several architectures, so I'm quite fond of=
=20
the CROSS_COMPILE switch. In fact, I might get cross if you cross it out :)

--=20
Henrik Austad

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlaMMowACgkQ6k5VT6v45llLYQCfQ7skepGAllN4phPTtHQ+QvTj
hDAAoNCCnEWgGUqKRrb5aopwW/uCMbXu
=vBTJ
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
