From: Clark Williams <williams@redhat.com>
Subject: rt-tests version 0.60 available
Date: Tue, 29 Dec 2009 12:40:59 -0600
Message-ID: <20091229124059.36c9eabf@torg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/+CY695wSBepccfdzYkLRtsT"; protocol="application/pgp-signature"
Cc: LKML <linux-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Michael Olbrich <m.olbrich@pengutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10977 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbZL2SlL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Dec 2009 13:41:11 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/+CY695wSBepccfdzYkLRtsT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

rt-tests version 0.60 is now available at:

git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

or as a source tarball from:

http://www.kernel.org/pub/linux//kernel/people/clrkwllms/rt-tests/rt-tests-=
0.60.tar.gz

This version contains John Kacur's new test 'pip', which is a priority
inheritance stress test (similar to pi_stress), but process-based
rather than purely pthreads.=20

It also adds an unbuffered output option to cyclictest (from Michael
Olbrich) so that programs parsing the output of cyclictest can get more
up-to-date information (rather than waiting for a std output flush).=20

Clark

--Sig_/+CY695wSBepccfdzYkLRtsT
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAks6TT8ACgkQHyuj/+TTEp2ppACfUfzHQTc/1lAgiGopmW6yVmlk
l38AoMwrdDg2I7LO6MnQPZPjUlm7n3+D
=/L/M
-----END PGP SIGNATURE-----

--Sig_/+CY695wSBepccfdzYkLRtsT--
