From: Clark Williams <williams@redhat.com>
Subject: Re: Mainline patch-3.14.4-5.xz
Date: Mon, 2 Jun 2014 17:07:51 -0500
Message-ID: <20140602170751.172fa3db@sluggy>
References: <538A6552.3050501@pavlinux.ru>
	<20140602114658.3c81b2f8@sluggy>
	<538CF47A.3070207@pavlinux.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/e.aD/FktBrFBQPl8dtH.GHA"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Pavel Vasilyev <pavel@pavlinux.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38865 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbaFBWH7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Jun 2014 18:07:59 -0400
In-Reply-To: <538CF47A.3070207@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/e.aD/FktBrFBQPl8dtH.GHA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 03 Jun 2014 02:02:34 +0400
Pavel Vasilyev <pavel@pavlinux.ru> wrote:

> 02.06.2014 20:46, Clark Williams =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>
> >> What to do? :)
> >>
> > I thought I was the only one to do crazy rebasing like this :)
> >
> > I kept the #ifdef CONFIG_PREEMPT_LAZY block (the RT code) in
> > include/linux/thread_info.h and removed the definition of
> > tif_need_resched() in include/linux/preempt.h.
>=20
> Code migrate from <linux/thread_info.h>  to <linux/preempt.h>
>=20
> https://www.kernel.org/diff/diffview.cgi?file=3D%2Fpub%2Flinux%2Fkernel%2=
Fv3.x%2Fincr%2Fpatch-3.14.4-5.xz;z=3D78
>=20
> https://www.kernel.org/diff/diffview.cgi?file=3D%2Fpub%2Flinux%2Fkernel%2=
Fv3.x%2Fincr%2Fpatch-3.14.4-5.xz;z=3D82
>=20
> Link: http://marc.info/?l=3Dlinux-kernel&m=3D139705352130896
>=20

Yes, I saw that right *after* I replied to your email :)

I'm on my second try now...

Clark

--Sig_/e.aD/FktBrFBQPl8dtH.GHA
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlOM9bcACgkQHyuj/+TTEp3dFQCgmH/BKJoB4p3cwbzjC1Otc5jy
OfwAn3TuoZGeswuQzOjuyCaIDp6KYh2+
=to5F
-----END PGP SIGNATURE-----

--Sig_/e.aD/FktBrFBQPl8dtH.GHA--
