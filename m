From: Clark Williams <williams@redhat.com>
Subject: [rt-tests] version 0.63 available
Date: Wed, 27 Jan 2010 10:23:54 -0600
Message-ID: <20100127102354.0b5c0f9d@torg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/VD65l3F.iQiLEE3vtyYxpRe"; protocol="application/pgp-signature"
Cc: LKML <linux-kernel@vger.kernel.org>, Carsten Emde <ce@ceag.ch>,
	Uwe =?ISO-8859-1?B?S2xlaW5lLUv2bmln?=
	<u.kleine-koenig@pengutronix.de>, John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47529 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571Ab0A0QYT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jan 2010 11:24:19 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/VD65l3F.iQiLEE3vtyYxpRe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


The latest version of rt-tests is now available as a tarball from:

http://www.kernel.org/pub/linux//kernel/people/clrkwllms/rt-tests/rt-tests-=
0.63.tar.bz2

Also available in my git repo:

git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

under tag v0.63

This version includes a new option: --numa, which is a counterpart to
the recently introduced --smp option.=20

The --smp option is a shorthand for:  -t -a -n, meaning that one
measurement thread is created per active CPU and is affined to that cpu
and that clock_nanosleep is used for measurements.=20

The --numa option does the same options as --smp, but also makes calls
into libnuma to ensure that measurement threads are always bound to the
memory node that is local to it's cpu (avoiding cross-node memory
references). Each measurement thread's stack and major data structures
are allocated from the local memory node.

Note that to actually use --numa mode, you must pass NUMA=3D1 to the make
build command:

	$ make NUMA=3D1

This is for all you embedded guys that could care less about NUMA :)

Other changes from previous releases are that the hwlatdetect test has
been moved to the python site-library (so that other tests can import
it) and then symlinked to /usr/bin/hwlatdetect. Also, copyright
messages have been updated in the source files (thanks Uwe).=20

Clark

--Sig_/VD65l3F.iQiLEE3vtyYxpRe
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAktgaKEACgkQHyuj/+TTEp1tZwCgm3OiZRwEFlf0ulesae0nFznM
ILYAn372JoaLxroeo5kXzJFD/bFnOP7S
=zvDH
-----END PGP SIGNATURE-----

--Sig_/VD65l3F.iQiLEE3vtyYxpRe--
