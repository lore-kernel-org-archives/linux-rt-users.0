From: Jonathon Fernyhough <jonathon@manjaro.org>
Subject: Re: Security etc. status of -rt patches versus mainline
Date: Mon, 13 Nov 2017 21:39:10 +0000
Message-ID: <9f283e6f-a2f6-2b9d-bb84-acdd02cdf0ee@manjaro.org>
References: <2fa58167-d2cb-989e-ca0b-2e252d32cdc8@manjaro.org>
 <20171113165546.GA30279@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OS1TTcxd3GPKCE6KaiCwnOHKMdL2vi8SK"
Cc: linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.manjaro.org ([176.9.38.148]:32884 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbdKMVjS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Nov 2017 16:39:18 -0500
In-Reply-To: <20171113165546.GA30279@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OS1TTcxd3GPKCE6KaiCwnOHKMdL2vi8SK
Content-Type: multipart/mixed; boundary="db2tSbq6VFdEDkgC3WPRue7PxgKOOo8x3";
 protected-headers="v1"
From: Jonathon Fernyhough <jonathon@manjaro.org>
To: Julia Cartwright <julia@ni.com>
Cc: linux-rt-users@vger.kernel.org
Message-ID: <9f283e6f-a2f6-2b9d-bb84-acdd02cdf0ee@manjaro.org>
Subject: Re: Security etc. status of -rt patches versus mainline
References: <2fa58167-d2cb-989e-ca0b-2e252d32cdc8@manjaro.org>
 <20171113165546.GA30279@jcartwri.amer.corp.natinst.com>
In-Reply-To: <20171113165546.GA30279@jcartwri.amer.corp.natinst.com>

--db2tSbq6VFdEDkgC3WPRue7PxgKOOo8x3
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 13/11/17 16:55, Julia Cartwright wrote:
> As Uwe mentioned, it's possible that you can just merge in the latest
> upstream 4.9.y release for your usecase.  Otherwise, you can wait for u=
s
> to kick out an updated release (hopefully soon).
>=20

Ah, that's good to know.

I tried applying the 4.9.47-rt37 patches against 4.9.61 and only one
chunk fails to apply (all others succeed with offsets), so I'll give it
a go. :)


J


--db2tSbq6VFdEDkgC3WPRue7PxgKOOo8x3--

--OS1TTcxd3GPKCE6KaiCwnOHKMdL2vi8SK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdsbkdwQr/phcwiC9nAiiVUQvr/AFAloKEQEACgkQnAiiVUQv
r/Bm2Q//b7fxD1HWQ8UAPC6LbsVVlTIrYU9JRWtgTUl6F5kTVmBIOwLFLXWJEjq3
1OXImTKkYfngfV7/AWMnCMvYaCzLEf4Rfvosg5hGJ4DP2X9qc+9xw6GA8hebs4Fo
aLSB7HcPOzF8vS5iHVbYoP1B0T4J42th2EawUB5JyTeX4XxdcoexAKKmDoyRLR/3
RUV4LpQ1kfuRwJmcaV0T0/eGzfJ3CY6gzL0sYG4zw4RdQ4gUU0TYcY8uR/2i3JS2
h7vRKLEfxSSAFWvUqts6K3dT0Uafz5slxjwPdaUuTtsIxjATlJJW/upaIkH0YvB1
+jybyHgGpvzu2kmtzKMPQOxFyVa5LCE1BNXDn94+zF50rh4TcK0XcJhJ4KsUFcO4
AMR5774mAfPVvf1bjuem61PEm5kZm+uH01BIbv85c5Dn79QCYnfISjr3vZNbgKQ8
nHRgnuJoJl3gTa76x0ILrez7Q0qxktzj/zUNlm5B/lM4VXQDPPreAN3Sy4UVJ8MR
a7lY53PM1l3z5pRfWCDIPEZv9P/32mMS/d01cpd5QPjEf4G89I83R3zKHTddq+Og
051j103CINADBwZxPJxErhHgwEKFJfzo5kJbuPthBDE+G9KNXkOCllvWuil6k7sa
Ixx7TCbjrYb0Ao5DPL99FP+e1jvhLp3jaP7+wvFnUOwNCYKSIvw=
=O6A6
-----END PGP SIGNATURE-----

--OS1TTcxd3GPKCE6KaiCwnOHKMdL2vi8SK--
