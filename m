From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: High latencies with linux-2.6.25.4-rt6 on MPC5200
Date: Mon, 30 Jun 2008 10:38:56 +0200
Message-ID: <20080630083856.GA6454@pengutronix.de>
References: <4858C229.2060509@grandegger.com> <20080619131406.GK5724@pengutronix.de> <485A675A.9070509@grandegger.com> <20080627143213.GG5666@pengutronix.de> <4867F13D.9050405@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:53914 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753617AbYF3Ii6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jun 2008 04:38:58 -0400
Content-Disposition: inline
In-Reply-To: <4867F13D.9050405@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

On Sun, Jun 29, 2008 at 10:31:57PM +0200, Wolfgang Grandegger wrote:
> Hi Fu,
>
> Luotao Fu wrote:
>> Hi Wolfgang,
>> I finally found some time and did some tests with your config file and t=
he shiny
>> new 2.6.25.8-rt7
>>
>> On Thu, Jun 19, 2008 at 04:04:10PM +0200, Wolfgang Grandegger wrote:
>>> Hi Fu,
>>>
>>> Luotao Fu wrote:
>>> Keep in mind that I'm running Linux on a rootfs mounted via NFS.
>>
>> I have exactly the same test configuration here.
>
> Interesting, I'm able to trigger latencies up to 600 us with the command
>
>   "# while ls; do ls /bin; done"
>

the same here, only I loop with "ls /", which is literally the same.

> in a telnet session, but it takes a while.
>
>> Again everything looks just fine to me. Depending on which debugging Opt=
ion are
>> turned on my max. results pended between 70 and 350 us. However I could =
not
>> produce any peak worst case values, which are so far away from the avera=
ge like
>> in your case.
>
> Could you send me your .config file? And what version of cyclictest are =
=20
> you using?

Will send it off-list to reduce the list traffic.

cheers
Luotao Fu
--=20
   Dipl.-Ing. Luotao Fu | Phone: +49-5121-206917-3
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIaJugiruQY+UyUmERAsKNAJ9cbig8kj9Zd1G/pNKMlNunLO28jQCeKTHc
aC5eV0FABMBUFAabvFVlsrw=
=Ba8s
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
