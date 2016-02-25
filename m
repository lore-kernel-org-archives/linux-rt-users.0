From: Josh Cartwright <joshc@ni.com>
Subject: Re: Kernel thread's CPU affinity with isolcpus kernel boot argument
Date: Thu, 25 Feb 2016 08:43:08 -0600
Message-ID: <20160225144308.GG9598@jcartwri.amer.corp.natinst.com>
References: <5698D4D0.3020907@etas.com>
 <20160225141806.GB16161@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w2JjAQZceEVGylhD"
Cc: Mathias Koehrer <mathias.koehrer@etas.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:41934 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760148AbcBYOnW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 09:43:22 -0500
In-Reply-To: <20160225141806.GB16161@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--w2JjAQZceEVGylhD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 25, 2016 at 03:18:06PM +0100, Sebastian Andrzej Siewior wrote:
> * Mathias Koehrer | 2016-01-15 12:15:28 [+0100]:
>=20
> >However, I noticed that most kernel threads use the affinity mask 0xff.
> >I can change this by using ???taskset???. However, I am wondering if
> >there is mechanism that forces the kernel to consider the value of
> >???isolcpus??? also for kernel threads.
>=20
> not that I am aware of. There are a few per-CPU threads which have to
> stay the way they are. I would have expected that others like kworker/u*
> respect the isol CPUs and stay away.

I suppose the higher level question to Mathias is: are you seeing these
threads perturb your application?  Or, are you just observing they are
affinitized to isolcpus?

  Josh

--w2JjAQZceEVGylhD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWzxL5AAoJEKp7ZBKwQFArXTYH+wZKy2c8yq4XdCuqZXKGOgzJ
o6HRxkMj6fDpBu1jP5Jn6Vjb8vEQEgVGb93qV2UDUjRA3We+6drYl401J2kddRz0
HQFj8Rq+qHlYhfJsiLkqT1OxrzWMZcS0zHmjLxd+HlBuP/KoSc2AzsNbVFB0HnfG
Tcnvey16+9AidjoO47LsMnW44R7kuddvdh9mlNofGLqRxPteVDNlrxkeA4a2yJQv
Axj/f+Qox+sx/BnmHzuWmpYOQ8rTOgrfWnM8Civcn8VbH+Z+0uER8iCekKIq43mQ
F9gH609dd/L2PvS3kuZBOfci7U09uCEnNV+hQ2zYc591zvft4VOEfdtyFIorMf8=
=K4dt
-----END PGP SIGNATURE-----

--w2JjAQZceEVGylhD--
