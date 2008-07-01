From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: 2.6.24-rc8-rt1: Strange latencies on mpc5200 powerpc - RCU
	issue?
Date: Tue, 1 Jul 2008 23:11:58 +0200
Message-ID: <20080701211158.GA8928@pengutronix.de>
References: <479F2C3C.1020203@grandegger.com> <20080130010716.GB16069@linux.vnet.ibm.com> <47A032E9.4080105@grandegger.com> <20080130102255.GA24890@linux.vnet.ibm.com> <47A0552D.20605@grandegger.com> <20080130105715.GE24890@linux.vnet.ibm.com> <20080130111559.GC20089@pengutronix.de> <486A3EBB.6030905@grandegger.com> <Pine.LNX.4.58.0807011036510.26650@gandalf.stny.rr.com> <486A573E.60107@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Luotao Fu <l.fu@pengutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:59632 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753960AbYGAVMP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Jul 2008 17:12:15 -0400
Content-Disposition: inline
In-Reply-To: <486A573E.60107@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

On Tue, Jul 01, 2008 at 06:11:42PM +0200, Wolfgang Grandegger wrote:
[...]

I'm out of office till next week. I will try to narrow down the issue you
reported on my board asap. Unfortunately I was not able to produce such wor=
st
case results in my test runs till now. Anyhow I'll also have a look at the =
code
segment you found and play a little around there. Hopefully I'll find somet=
hing
useful. ;-)

Cheers
Luotao Fu
--=20
   Dipl.-Ing. Luotao Fu | Phone: +49-5121-206917-3
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de


--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIap2biruQY+UyUmERApIxAJ4gmry6saieIGVb0cfZjCTuY/E8bwCgj7V+
8KRyCCI/5zFxSMpDF/Iq3AI=
=4tfg
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
