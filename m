From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: debian 8 rt kernel
Date: Fri, 13 Jan 2017 09:20:16 +0100
Message-ID: <20170113082016.gn24ywehbwwcd76v@pengutronix.de>
References: <CADzbtTJ8BAX+HaBQkxe8_YOjX7RKyghNz5jS8UToEoSbMXXo3w@mail.gmail.com>
 <20170113075215.GF2532@falbala.home.lespocky.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vceneiewmtwzm2ml"
Cc: luca paganotti <luca.paganotti@gmail.com>,
        linux-rt-users@vger.kernel.org, info@pengutronix.de
To: Alexander Dahl <post@lespocky.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35527 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751157AbdAMIUU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Jan 2017 03:20:20 -0500
Content-Disposition: inline
In-Reply-To: <20170113075215.GF2532@falbala.home.lespocky.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--vceneiewmtwzm2ml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 08:52:15AM +0100, Alexander Dahl wrote:
> On Tue, Dec 20, 2016 at 10:01:26AM +0100, luca paganotti wrote:
> > Hi all, I'm new to debian and I would like to install an rt kernel on
> > my debian 8 jessie machine, I've configured the pengutronix repository
> > in my /etc/apt/sources.list.d as:
> > deb http://debian.pengutronix.de/debian jessie main contrib non-free
> > in pengutronix.list file, but I don't know which packages I need to
> > install. I would like to use the rt kernel for my musical work with
> > jack, ardour, etc ...
>=20
> I had a look at this package repository and it contains only very old
> kernels, 2.6.29, 2.6.31 and 2.6.33. If you are on jessie, you may want
> to try linux-image-rt-686-pae or linux-image-rt-amd64 from backports
> which depends on a more recent 4.8 rt kernel. I'm not sure why
> pengutronix still allows access to those outdated kernels.

There are people out there who still rely on those (maybe with
questionable reasons, who knows). If you don't have one of those, please
use the latest and greatest.

rsc
--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--vceneiewmtwzm2ml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iD8DBQFYeI3A+8z+IKgDhyARAhKbAJ4iXkBnUWmzxXahrDvSnyaVLkuC0QCeIaR0
WAHc+HhY3J/oDpHcxcu3SaU=
=6pGW
-----END PGP SIGNATURE-----

--vceneiewmtwzm2ml--
