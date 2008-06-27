From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: High latencies with linux-2.6.25.4-rt6 on MPC5200
Date: Fri, 27 Jun 2008 16:32:13 +0200
Message-ID: <20080627143213.GG5666@pengutronix.de>
References: <4858C229.2060509@grandegger.com> <20080619131406.GK5724@pengutronix.de> <485A675A.9070509@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z0mFw3+mXTC5ycVe"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:59057 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752412AbYF0OcU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Jun 2008 10:32:20 -0400
Content-Disposition: inline
In-Reply-To: <485A675A.9070509@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--Z0mFw3+mXTC5ycVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,
I finally found some time and did some tests with your config file and the =
shiny
new 2.6.25.8-rt7

On Thu, Jun 19, 2008 at 04:04:10PM +0200, Wolfgang Grandegger wrote:
> Hi Fu,
>
> Luotao Fu wrote:
> Keep in mind that I'm running Linux on a rootfs mounted via NFS.

I have exactly the same test configuration here.

Again everything looks just fine to me. Depending on which debugging Option=
 are
turned on my max. results pended between 70 and 350 us. However I could not
produce any peak worst case values, which are so far away from the average =
like
in your case.

Have you tried the new -rt patch on your board? Still any strange results?

cheers
Luotao Fu

--=20
   Dipl.-Ing. Luotao Fu | Phone: +49-5121-206917-3
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de


--Z0mFw3+mXTC5ycVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIZPntiruQY+UyUmERAu+fAKCA6fkDpnRg1DvEcvBKJlk+rZn8KQCfad++
ADhLU59ZTjMsjMn6BZ/BSNk=
=dH+d
-----END PGP SIGNATURE-----

--Z0mFw3+mXTC5ycVe--
