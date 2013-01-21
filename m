From: Clark Williams <williams@redhat.com>
Subject: Re: RT_PREEMPT autodetection from user program
Date: Mon, 21 Jan 2013 09:37:59 -0600
Message-ID: <20130121093759.045119c8@redhat.com>
References: <97041258-E312-4163-96B2-9077EED68E0B@mah.priv.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/d/ToXcVzqKEsSsxxMoFTXT9"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Michael Haberler <mail17@mah.priv.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40186 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134Ab3AUPiE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Jan 2013 10:38:04 -0500
In-Reply-To: <97041258-E312-4163-96B2-9077EED68E0B@mah.priv.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/d/ToXcVzqKEsSsxxMoFTXT9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Jan 2013 01:49:59 +0100
Michael Haberler <mail17@mah.priv.at> wrote:

> Hi,
>=20
> I need to autodetect the RT kernel for an application which runs under RT=
AI, Xenomai, RT_PREEMPT and vanilla kernels.=20
>=20
> To support a unified binary, I need to runtime detect the RT OS - what ar=
e my best options for RT_PREEMPT? from https://rt.wiki.kernel.org/index.php=
/RT_PREEMPT_HOWTO#Checking_the_Kernel I gather the single method:
>=20
> parsing 'ps' output for IRQ handlers being kthreads, i.e. for '[IRQ' or '=
[irq'
>=20
> any chance of doing better than that, or parsing of utsname.release for "=
-rt"?  A false positive on a vanilla kernel could be a safety hazard.
>=20
>

A PREEMPT_RT kernel creates /sys/kernel/realtime when it boots. You
can just check for the existence of that file.

Clark

--Sig_/d/ToXcVzqKEsSsxxMoFTXT9
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlD9YNcACgkQHyuj/+TTEp0XDQCg1nKdGdVjnMOU10OOmKKxOtu2
FRMAniT/A1jA1X65PwxSB6IpEkhsbq9i
=6fsF
-----END PGP SIGNATURE-----

--Sig_/d/ToXcVzqKEsSsxxMoFTXT9--
