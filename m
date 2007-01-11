From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: generating 100% load for cyclictest ?
Date: Thu, 11 Jan 2007 16:30:04 +0100
Message-ID: <20070111153004.GE19781@pengutronix.de>
References: <45A65009.8070902@imc-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:52794 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750723AbXAKPaG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jan 2007 10:30:06 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
Content-Disposition: inline
In-Reply-To: <45A65009.8070902@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 11, 2007 at 03:56:09PM +0100, Steven Scholz wrote:
> Hi,
>=20
> on http://rt.wiki.kernel.org/index.php/Cyclictest some test cases mention=
 a
> "100% load".
>=20
> How is this load created? Any recommendations?
>=20
> I am testing on an embedded system with a small rootfs. So I don't have a
> gcc running on the target that could compile the kernel or something ...

Even Without extra softwares you can easily produce custom load in=20
many manners. i.E. you can cause a high CPU consumption by simple doing
cat /dev/zero >/dev/null
or you can grab another machine in the network to do some flood pings
towards the emb. system, which will cause high frequented irqs on the
network device.
If you just want to give your machine some custom load, this should be
enough. If you want to analyze the system in some specific load
situation, you might want to take some benchmarking tools. Hackbench is
i.E. a good start.

cheers
Luotao Fu
--=20
     Dipl.-Ing. Luotao Fu | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFplf8iruQY+UyUmERAggSAJ9QcZwUKaX2g2RtDu5V2IK3t5KMywCbBrpt
QPwyCf7KXHb7r1/ktoUJfkY=
=tBv0
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
