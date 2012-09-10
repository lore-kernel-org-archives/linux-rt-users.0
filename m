From: Clark Williams <williams@redhat.com>
Subject: Re: how to put in higher priority a thread in rt-kernel?
Date: Mon, 10 Sep 2012 11:20:01 -0500
Message-ID: <20120910112001.7570fd7e@redhat.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20120902194911.GT28643@pengutronix.de>
	<50444D2F.3040607@gentil.com>
	<20120904141138.GA14942@beefymiracle.amer.corp.natinst.com>
	<5046A959.3080904@gentil.com>
	<20120906034846.GB14942@beefymiracle.amer.corp.natinst.com>
	<504824F4.2060606@gentil.com>
	<504D1D5A.4030704@gentil.com>
	<1347249175.4436.15.camel@marge.simpson.net>
	<504D793C.7030402@gentil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/w8XtGQ9twTsGHrOAH8zy+I_"; protocol="application/pgp-signature"
Cc: Mike Galbraith <efault@gmx.de>, linux-rt-users@vger.kernel.org
To: gregoire@gentil.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10469 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757709Ab2IJQU3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Sep 2012 12:20:29 -0400
In-Reply-To: <504D793C.7030402@gentil.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/w8XtGQ9twTsGHrOAH8zy+I_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 09 Sep 2012 22:23:08 -0700
Gregoire Gentil <gregoire@gentil.com> wrote:

>=20
>=20
> On 09/09/2012 08:52 PM, Mike Galbraith wrote:
> > On Sun, 2012-09-09 at 15:51 -0700, Gregoire Gentil wrote:
> >> In other words, is there an equivalent of
> >> sched_setscheduler for thread inside the kernel?
> >
> > Yup, and it's even called sched_setscheduler() :)
> >
> > -Mike
> Thanks for answering! I don't think that my question is the smartest one=
=20
> ever asked on this mailing list ;-)
>

I've heard worse :).

My only comment is that I'd think long and hard before setting my
interrupt thread up at fifo:99, since that's where the migration and
watchdog live and you really don't want to impact them.=20

Are you trying to have your interrupt serviced ahead of all the other
system interrupts or just trying to be up above the SCHED_OTHER
threads? If the former, then you just need to be up above wherever the
IRQ threads live (default is fifo:50). If the later then fifo:2 would
be a safe bet. =20

Clark

--Sig_/w8XtGQ9twTsGHrOAH8zy+I_
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlBOEzEACgkQHyuj/+TTEp2iJgCeIvP9j+3hGG/bnLzQrbZSFzRk
++sAnjUGkH0KWhPgsDKUpLHPfNi+AIOM
=IOGS
-----END PGP SIGNATURE-----

--Sig_/w8XtGQ9twTsGHrOAH8zy+I_--
