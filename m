From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: 3.14.3-rt5: at91: Crash early at boot
Date: Mon, 16 Mar 2015 19:19:00 +0100
Message-ID: <20150316181900.GA4638@lukather>
References: <20140613142506.GL3448@lukather>
 <20150217083859.GB26177@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Cc: linux-rt-users@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas@free-electrons.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36171 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932524AbbCPSUN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Mar 2015 14:20:13 -0400
Content-Disposition: inline
In-Reply-To: <20150217083859.GB26177@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 17, 2015 at 09:38:59AM +0100, Sebastian Andrzej Siewior wrote:
> * Maxime Ripard | 2014-06-13 16:25:06 [+0200]:
>=20
> >Preemptible hierarchical RCU implementation.
> >NR_IRQS:16 nr_irqs:16 16
> >Unable to handle kernel NULL pointer dereference at virtual address 0000=
0000
> >pgd =3D c0004000
> >[00000000] *pgd=3D00000000
> >Internal error: Oops: 5 [#1] PREEMPT ARM
> >Modules linked in:
> >CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.3-rt4+ #11
> >task: c05ecb28 ti: c05e2000 task.ti: c05e2000
> >PC is at wake_up_process+0x8/0x40
> >LR is at kthread_create_on_node+0xb0/0x178
> =E2=80=A6
> >Do you know what could be the cause of this, or is this any known issue?
>=20
> No. This is very early in the boot process. I upgrade the at91's timer
> patches but have no HW to actually check if this is still working.

Do you have a link to these patches?

Maybe we can test them out.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBx6TAAoJEBx+YmzsjxAgSrQP/2S2ONYCJOCRuuHiyxjsCcGx
nYgwzbJcO+HYXthkIzWf9w296qLid3pmeCc7DatxMB+ynAxjVZUmazqcbvVuF6RS
i57werGVtLng0+p+Sl4MNNQlZuIU2jU4XVV1umipkk6nS/qNINNITDBOPFZFfngA
moWLwIE4oxf4Cf5JT6b7pKAqUQEmcq/eiRbu5orLQUZhXyhmu/9j23TMi/85tztV
9OKzpGwZmtVU/MGcDeoI70tRCrzFMcHsYAcLzVN1v9N4q4j+w1TlU+pp8eMKYK92
5vUZr1GlbMRbHsfIHDjNMl8cA410wdiRTrVWx39tVaANuuIqRum8R6t/LG3tQziY
z206MOuwoANSTAn5JJSJ2+nD6lmdJ7yEQ/q2xzg3/JWEd/Xt6ftig09DgTfevPmJ
AIAc7mueKG5dXu5iXCvGb9s20opSKB9swvRfzxDK2XJOnqNEWwQhB7DYt12u4VE7
1h4G9ptJFX6lA4jD8ap/+daezlYm+epxQqn26s4J0N6G1WaUL/9QPGhmDDvJy1AK
Ta+jtKnKEXBIaZ5Yc0mydKsR99dfv7G+2m1B1XqUxWCRnohsWPkzi+qVmPuR1XGU
sjG/ZOmcwIJTZsfxuy7EobbrcFqfwhUy2+uuUnXESiLuvfl2TsZQEqLDgjLLQjZQ
15S/n7bthdDFCoj5uqt3
=zpug
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
