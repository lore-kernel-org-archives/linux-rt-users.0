From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: High latencies with linux-2.6.25.4-rt6 on MPC5200
Date: Thu, 19 Jun 2008 15:14:07 +0200
Message-ID: <20080619131406.GK5724@pengutronix.de>
References: <4858C229.2060509@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:44465 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757229AbYFSNOI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Jun 2008 09:14:08 -0400
Content-Disposition: inline
In-Reply-To: <4858C229.2060509@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

On Wed, Jun 18, 2008 at 10:07:05AM +0200, Wolfgang Grandegger wrote:
> Hello,
>
> I currently re-doing latency measurement with my TQM5200 board under =20
> Linux 2.6.25. With 2.6.24-rt1 "cyclictest -n -p80 -i1000 -t1" reported a =
=20
> maximum latency of 170us. With 2.6.25.4-rt5 I'm unable to reproduce such =
=20
> reasonable latencies. cyclictest shows quickly latencies up to 600 us. =
=20
> What has changed in the meantime? Any ideas how to get better latencies?
>

I've just brought up my mpc5200b board with 2.6.25.4-rt6 and ran for server=
al
times cyclictest on it. I ran my tests with the same parameter as you menti=
oned.
As non-rt workload I ran an endless loop of "ls /". Based on the issue with=
 rcu,
about which we discussed some times ago I also tried some combinations of
randomly chosen debugging options. So far I was not able to reproduce your
problem. Same for 2.6.25.4-rt5.=20

Could you possibly send me your kernel configuration, so I might probably h=
ave a
try here on my board?

Cheers
--=20
   Dipl.-Ing. Luotao Fu | Phone: +49-5121-206917-3
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de


--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIWlueiruQY+UyUmERAqgDAJ4sMumCMdPsnWQx/PAIy/iFWyqmogCeNTcJ
V23EMuJ78U/wwejBxjPw6Zc=
=e/1f
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--
