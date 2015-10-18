From: Jeremy Jongepier <jeremy@autostatic.com>
Subject: Re: 3.18 RT freezes on Raspberry Pi 2
Date: Sun, 18 Oct 2015 22:46:23 +0200
Message-ID: <5624051F.3070903@autostatic.com>
References: <3671201425478878@web10j.yandex.ru>
 <loom.20150306T043408-818@post.gmane.org>
 <loom.20150309T025355-426@post.gmane.org>
 <20150309141038.GC13768@linutronix.de> <3863561427712041@web3j.yandex.ru>
 <loom.20150331T153850-579@post.gmane.org>
 <loom.20150927T172648-968@post.gmane.org> <560B9543.1020106@autostatic.com>
 <loom.20150930T110905-205@post.gmane.org>
 <loom.20151011T141552-925@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jAs2AiDNgOAWBU57LQMvFfLCbwQsUcMTp"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from autostatic1.autostatic.cyso.net ([93.94.224.100]:49374 "EHLO
	smtp.autostatic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbJRUqb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 18 Oct 2015 16:46:31 -0400
Received: from [192.168.1.147] (535178DA.cm-6-2b.dynamic.ziggo.nl [83.81.120.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: autostatic)
	by smtp.autostatic.com (Postfix) with ESMTPSA id 7E0359D6
	for <linux-rt-users@vger.kernel.org>; Sun, 18 Oct 2015 22:46:23 +0200 (CEST)
In-Reply-To: <loom.20151011T141552-925@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jAs2AiDNgOAWBU57LQMvFfLCbwQsUcMTp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/11/2015 02:28 PM, Oliver wrote:
> $ cyclictest --smp -p51 -m
> makes the rpi 2 freeze after a few minutes at most.

Running now for more than 5 minutes and no freeze (4.1.7-rt8).

Jeremy


--jAs2AiDNgOAWBU57LQMvFfLCbwQsUcMTp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWJAUfAAoJEF63J34m6LiUZZoP/jHHOpZ40rSYyip85NpueOBl
04nh7MTgHqotU4lZR6/vPJW0HOaMogXr56C9i9dDUTpRQhkHQbI2tY3pmed90qGN
SN6STvtLItjIKG8SAZnDXNRmOii00yHg19CCL3ruOAmQ426M3e3mWyRYiWq5X0K6
R/y4ZXvf80xPc1cJuyVsDymKj4c4dnD8mp5YpqswVAhakWl7HIiedtXYWAb4NmhJ
jUvj7azICRS8q0Yhc+akdU9MYm3kpQbaCX5xFUb6cwEgiKjaOljCADGMrlbigPZA
/cEoDmj5FRQJfX8R4v2O9VlSSmErCEmsdHgXO2abxed2oconzbRMMsaZWMFlhjZj
Gj1pFAgDZsIH7Xk2sk1jMkecBYEL6M8x1E2Vd9V39x6e2gDgN0+7MeLKJj2Gd/zl
PRoqYyjwTNKPKRNaAkrikoKqnnO/JobbXlJnCViFQKgPDaGzXA8BryJoRZqVqE7j
xKMMXOAHbJEVLU9g509tEWJ/EqdOjRMcjv9P2z1vyo6mvOZKhGWHt16cAoGmkrOu
7uXgNTgKWj4G4Rh1ODsFSWuERGsANwXVxh+wi7w6v1Ae9YVkEcZ2w+jx27jjFhep
aIlW0BHXf+tW4O8RFVAwwXEZx5QmjoBZALdPwEst9qz2eyJS0FY4E5eI9G0uZhPQ
JqRTIjCW/a8pybWcn6RA
=zMzS
-----END PGP SIGNATURE-----

--jAs2AiDNgOAWBU57LQMvFfLCbwQsUcMTp--
