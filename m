From: Clark Williams <williams@redhat.com>
Subject: Re: Difficulties with cyclictest on AMD CPU
Date: Mon, 28 Apr 2014 09:24:24 -0500
Message-ID: <20140428092424.71629805@sluggy>
References: <535CE374.7050907@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/mlOfOkOjM2ErZez9VkSA4Sb"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Stefan Jenisch <stefan.jenisch@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37976 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbaD1OY1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Apr 2014 10:24:27 -0400
In-Reply-To: <535CE374.7050907@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/mlOfOkOjM2ErZez9VkSA4Sb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 27 Apr 2014 13:01:08 +0200
Stefan Jenisch <stefan.jenisch@gmail.com> wrote:
>=20
> So my guess is that the cpu goes into some sort of powersave mode from=20
> time to time. The wakeup from these powersave state results in=20
> latencies. Currently I am looking for a proper solution to this problem=20
> and what I have tried so far:
>=20
> - BIOS upgrade
> - Upgraded to linux-3.10.12-rt25
> - Disabling all sort of powersave modes in the kernel config
> - Activated cpufreq-performance (which seems to be ignored anyway)
> - Searched the BIOS for any powersave modes to deactivate (none found)
>=20
> I got rather clueless on what else to try! Does anyone has a helping=20
> hint on how to solve this one???
>=20
> With many thanks in advance,
>=20
> Stefan J.
>=20

Did you get this message when starting cyclictest?

# /dev/cpu_dma_latency set to 0us


That's a hack that is supposed to prevent the system from entering
deeper C-states than C-state 0.=20

What version of rt-tests are you running?

Clark

--Sig_/mlOfOkOjM2ErZez9VkSA4Sb
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlNeZJgACgkQHyuj/+TTEp0BQACgtUzRLz3kkmhrzJqKhnnIGOcu
epwAoI7wrOHBdcpT27Hr/iOv0O1NrWfe
=MzL2
-----END PGP SIGNATURE-----

--Sig_/mlOfOkOjM2ErZez9VkSA4Sb--
