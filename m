From: Clark Williams <williams@redhat.com>
Subject: Re: Measuring scheduling latency for RT threads
Date: Wed, 19 Nov 2014 11:59:12 -0600
Message-ID: <20141119115912.2a2a0565@sluggy>
References: <trinity-4b6e4283-c92f-4553-af86-5fb9e1fb1541-1416401016597@3capp-gmx-bs35>
	<546C98F5.1020103@meduna.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/FnZhp0xJS9Np.MhiDLUtkb."; protocol="application/pgp-signature"
Cc: Stanislav Meduna <stano@meduna.org>, linux-rt-users@vger.kernel.org
To: =?UTF-8?B?SsO8cmdlbg==?= Lanner <jue.lanner@gmx.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756313AbaKSR7l (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Nov 2014 12:59:41 -0500
In-Reply-To: <546C98F5.1020103@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/FnZhp0xJS9Np.MhiDLUtkb.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Nov 2014 14:19:49 +0100
Stanislav Meduna <stano@meduna.org> wrote:

> On 19.11.2014 13:43, "J=C3=BCrgen Lanner" wrote:
>=20
> > My first goal is to find out about the worst case latency:
> > Is there a way I can find out how long (worst case) a RT thread
> > being ready to run is just waiting to be dispatched? =20
>=20
> ftrace, trace-cmd, kernelshark
>=20
> The latency for the highest prio runnable task is available
> right away with the wakeup tracer. For other tasks you can
> trace the scheduling functions and interpret the results
> using a script (or look at them graphically using kernelshark).
>=20
> Note that the function tracing is not free and will skew
> the results a bit, but should be good enough to identify
> the offenders.
>=20

You might want to establish a baseline of what the expected latency on
your hardware will be. Try the 'cyclictest' application from the
rt-tests package. Run that for some number of hours to see if you have
any hardware issues that may cause delays.=20

When run this way:

	$ sudo cyclictest --numa -p95 -mu

The program will kick off a measurement thread at fifo:95 on each
online core. It will the loop until you kill it with ^c, sleeping for
an interval and then measuring the delta between ideal wakeup time and
actual wakeup time of the measurement thread, something like this:

	t1 =3D gettime()
	loop:
		sleep(interval)
		t2=3Dgettime()
		delta =3D t2 - (t1+interval)
		print delta
		t1=3Dgettime()
		goto loop

That will show you the actual scheduling latency seen on each core.=20

Clark

--Sig_/FnZhp0xJS9Np.MhiDLUtkb.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUbNp0AAoJEEersVlSw9NzW8AP/2d5ymvHuZwSQEyUPU/H4CYw
NEnNcnmKxjIjDcHqB9eNSRIPODnT9cgSczHnF9VDkEeRahpMQAs85MynZWVxBcvd
7cY+vZWDQ83URvU68qnTKpzoMR+XGxRFeVujFIZ6MxLuAuRQ8NXanKPEiSqSLor5
DTHEcm4dmUcWmXJxshkeJS04HM1fusHtyUA18SDa91yts9Md7Fr4QQYmErZyDBuP
EtrVDhUjU7L6pzp14bCdpkRRXKvcr/s0MDQt0qzg3MkNiUuPtIm2faNI6Yidl2Nr
qvUwf1Tb/j8inX8a+qyiIzDaMCIG0Uhpa05z+Oly2glHzQdWYcBOhaV7hlkA0L54
NcM+B9/YC12e7gVQoZqOFHG7f3+x7ZZB2eUCcX/od5AcN9PhFIYTFrLwpKaGZKVo
qWyZBDDKndnx5omf6xlwr3c4uTFlsL/h2F3cr4Ynw/m7+JPKVHhMnXiYiZRL0+qb
w07vljlwDQR0cZk9BgnItV5GctGmAogD52svfuNpu9tbLaTh6zK5Z/+BvDuK1g0K
WM4EJQA9vVbuvybEfvMpoE/twarC/F7kopGhvvWFkKh0d4UTKC2QltWqWaYG8Ecd
Xj3MutVIxTuSSPGbC7iA3Px3kAqzF8Gkdr9BKx00dB2YolwVyz9Nfd3BIEE3k980
p7qC8qlz1UPIbD4LJhil
=yUdS
-----END PGP SIGNATURE-----

--Sig_/FnZhp0xJS9Np.MhiDLUtkb.--
