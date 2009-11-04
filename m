From: Tim Blechmann <tim@klingt.org>
Subject: Re: rt file i/o
Date: Wed, 04 Nov 2009 18:32:41 +0100
Message-ID: <4AF1BAB9.5080104@klingt.org>
References: <hcs6dr$235$1@ger.gmane.org> <5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com> <4AF1A327.3040103@klingt.org> <20091104171412.GB1702@opentech.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6DD7F7EC97796937FE6B8AE8"
Cc: y@opentech.at, Mark Knecht <markknecht@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.klingt.org ([86.59.21.178]:42660 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807AbZKDRco (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Nov 2009 12:32:44 -0500
In-Reply-To: <20091104171412.GB1702@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DD7F7EC97796937FE6B8AE8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> well, if i understand the rt howto correctly, _no_ disc access is
>> allowed, neither from rt nor from non-rt threads, since it may produce=

>> page faults, which introduce latencies ...
>=20
> I would be supprised if the rt howto states that page-faults in non-rt
> threads is a critical problem - that would not significantly impact RT
> performance - atelast not the worst case - it will (as every other syst=
em
> load) impact the average case. so having a non-rt thread reading disk-f=
iles
> to a buffer and a rt-thread processing this buffer should be perfectly =
fine.

that is what i thought for years ... but according to [1] a page fault
in an rt process freezes the entire process with both rt and non-rt
threads until the page fault is handled ...

tim

[1]
http://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application#Latenc=
ies_caused_by_Page-faults

--=20
tim@klingt.org
http://tim.klingt.org

Your mind will answer most questions if you learn to relax and wait
for the answer.
  William S. Burroughs


--------------enig6DD7F7EC97796937FE6B8AE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrxur4ACgkQdL+4qsZfVstYpgCePUQEIXcvwptAXRSjzpX7G3+q
jDMAn0m7ZU+G/o2gxUrCm8XkpfCP+GXz
=cv2f
-----END PGP SIGNATURE-----

--------------enig6DD7F7EC97796937FE6B8AE8--
