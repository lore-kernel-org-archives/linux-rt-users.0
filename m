From: Clark Williams <williams@redhat.com>
Subject: Re: RFC: NUMA modifications to cyclictest
Date: Wed, 20 Jan 2010 07:39:32 -0600
Message-ID: <20100120073932.479385cb@torg>
References: <20100119171439.24726f2e@torg>
	<alpine.LFD.2.00.1001200741000.2906@localhost.localdomain>
	<201001201223.36670@zigzag.lvk.cs.msu.su>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/p76l_Yoh7LPHY6jetOkbpj2"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15453 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274Ab0ATNjl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2010 08:39:41 -0500
In-Reply-To: <201001201223.36670@zigzag.lvk.cs.msu.su>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/p76l_Yoh7LPHY6jetOkbpj2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Jan 2010 12:23:35 +0300
"Nikita V. Youshchenko" <yoush@cs.msu.su> wrote:

> > > The big difference here is that when using --numa, each measurement
> > > thread (one per cpu) has it's stack allocated from the memory node
> > > associated with it's cpu. Also, the major data structures for each
> > > thread (parameter block, statistics block and histogram) are allocated
> > > from the appropriate node. This is done with calls into libnuma,
> > > which means this will add a dependency on libnuma.
> >
> > That might cause some trouble for embedded folks. :(
>=20
> Maybe make that a compile-time option?

Yeah, I'm beginning to think I need to pull out the autoconf book :(

Clark

--Sig_/p76l_Yoh7LPHY6jetOkbpj2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAktXB5gACgkQHyuj/+TTEp3uDgCdG5gy5I6rGXLbb9mZl0LwEMY9
1cIAoKndNqpcx9eCaRBMebp1bswFoio4
=P1hJ
-----END PGP SIGNATURE-----

--Sig_/p76l_Yoh7LPHY6jetOkbpj2--
