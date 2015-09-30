From: Jeremy Jongepier <jeremy@autostatic.com>
Subject: Re: 3.18 RT freezes on Raspberry Pi 2
Date: Wed, 30 Sep 2015 09:54:43 +0200
Message-ID: <560B9543.1020106@autostatic.com>
References: <3671201425478878@web10j.yandex.ru>
 <loom.20150306T043408-818@post.gmane.org>
 <loom.20150309T025355-426@post.gmane.org>
 <20150309141038.GC13768@linutronix.de> <3863561427712041@web3j.yandex.ru>
 <loom.20150331T153850-579@post.gmane.org>
 <loom.20150927T172648-968@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="djdMXqwqwfbIPoJ2uDPARGbDfJqEE2Rcc"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from autostatic1.autostatic.cyso.net ([93.94.224.100]:43924 "EHLO
	smtp.autostatic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbI3IAG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Sep 2015 04:00:06 -0400
Received: from [10.94.224.18] (vpngateway2.network.cyso.net [109.235.73.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: autostatic)
	by smtp.autostatic.com (Postfix) with ESMTPSA id 1DE2AEFA
	for <linux-rt-users@vger.kernel.org>; Wed, 30 Sep 2015 09:54:44 +0200 (CEST)
In-Reply-To: <loom.20150927T172648-968@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--djdMXqwqwfbIPoJ2uDPARGbDfJqEE2Rcc
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello Oliver,

On 09/27/2015 05:44 PM, Oliver wrote:
> Hi
>=20
> Same issue in RPi 2 running linux 4.1.6 with PREEMPT_RT_FULL.
>=20
> Kodi-video playback gives skipped frames and freezes after a few minute=
s
> which does not happen when rt is disabled (with FIQ enabled or disabled=
, it
> does not matter).
>=20
> Turning off FIQ as suggested by Mikhail gives the expected behaviour fo=
r
> cyclictest and also prevents the freezes in kodi which is great, so tha=
nks
> for that hint!

Try removing all FIQ related stuff from your cmdline.txt and just use
the defaults. Works fine for me with 4.1.7-rt8.

Jeremy

>=20
> However, I still get skipped frames in kodi.
>=20
> Is it possible there is another/related issue?
>=20
> Oliver



--djdMXqwqwfbIPoJ2uDPARGbDfJqEE2Rcc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWC5VEAAoJEF63J34m6LiU4iIP/j/lnlU0RzOJb9870/VYoD9i
VMBJqEPziSOtRRnNqyHOIIrI700tdXDvsn0vTbZu6fAY3BqY350RSjMK8ywQ92V9
xo5aa0bfhB19Akccm1buIZvzjxXP0JtpEmIckv2WPtQSi1YMI26Y7sCoxR3Ez8Da
TZh8SG28qhiIuaQRP6T7C8kKyXYVfnlOtnPADZzEDtp2BDu2HaM3H6ODK7OJlbwv
iAr2kckMSHMPnqxPp3AGIZW6Pvo3zu+PotFquITmOX6C3OXhefXo4kP59tkoBWrt
vRDPapInZDifIj6+GPJVCwtsQ0Aamb2TnDlMC0u1JGoTMuWRI09l1CDEtXQ28GJL
y4Vj0E6Dg6qIEzCUu+3hV8aiqvfwiGe1qxSBQH3zGA8pKUmUpNgKnRFnDy2oHhxq
sLweXpB418q9O5RlU6uS8nlAo+9QCIdxv8n3Z7Ptk0fNpWb0X4QeQcTrEU0eCjb9
urHonWwZmsjtVwB5I2RPRe0VZ3ceTuUcJTpDvWMhjncvOfPsOj/JOLGExMRydCcG
vz8mbuHRGNf4GvyeFV5pLX/YajvI4req45riEpUuRqJ/hBL1oAv73tsuaLXp443L
3586DCTqZX71tZnvCdqd5Ayx+6H6dcVPZ62aYEgo4+pcjhUDu+F/H40O1uqzRwoJ
cciwppoRkMjqpOmDrROz
=oN3S
-----END PGP SIGNATURE-----

--djdMXqwqwfbIPoJ2uDPARGbDfJqEE2Rcc--
