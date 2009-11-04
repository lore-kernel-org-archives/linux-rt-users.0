From: Tim Blechmann <tim@klingt.org>
Subject: Re: rt file i/o
Date: Wed, 04 Nov 2009 16:52:07 +0100
Message-ID: <4AF1A327.3040103@klingt.org>
References: <hcs6dr$235$1@ger.gmane.org> <5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4257A30136516E0404CA797E"
Cc: linux-rt-users@vger.kernel.org
To: Mark Knecht <markknecht@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.klingt.org ([86.59.21.178]:51008 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756920AbZKDQDL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Nov 2009 11:03:11 -0500
In-Reply-To: <5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4257A30136516E0404CA797E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>    I'm not a developer and cannot really address your specific
> question but for my use of the rt-kernel I put important rt-audio
> files on a 1394 drive and give the 1394 driver higher priorities using
> the IRQ scheduling tools. I don't have any trouble running 2 or 3 1394
> drives recording and playing back 48 channels in Ardour.
>=20
>    While I agree you should do everything the right way technically in
> the code maybe part of your solution is outside of the app you are
> writing and in the use of these support tools?

well, if i understand the rt howto correctly, _no_ disc access is
allowed, neither from rt nor from non-rt threads, since it may produce
page faults, which introduce latencies ...
according to this definition, ardour is not an rt-safe application ...
as for rt-safety, i prefer analyzing the latency hotspots instead of
relying on test results

tim

--=20
tim@klingt.org
http://tim.klingt.org

Avoid the world, it's just a lot of dust and drag and means nothing in
the end.
  Jack Kerouac


--------------enig4257A30136516E0404CA797E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrxoycACgkQdL+4qsZfVsvDUwCeKy1vopok+MPzMOLkVwDUWcOB
G/gAniLl49OIPZSChcbaYgxb7iC4Kh86
=kIfY
-----END PGP SIGNATURE-----

--------------enig4257A30136516E0404CA797E--
