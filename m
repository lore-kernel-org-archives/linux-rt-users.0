Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.klingt.org ([86.59.21.178]:60404 "EHLO klingt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbeHULSm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Aug 2018 07:18:42 -0400
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
 <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
 <0a8f899a-589d-a84b-dadb-50def9c0b4c3@santannapisa.it>
From: Tim Blechmann <tim@klingt.org>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <d2d27af1-e2dd-e1b6-2629-a56fe7218a02@klingt.org>
Date: Tue, 21 Aug 2018 15:59:16 +0800
MIME-Version: 1.0
In-Reply-To: <0a8f899a-589d-a84b-dadb-50def9c0b4c3@santannapisa.it>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="sira6I2NzXRdCyRhGRuNoEXry6aFidzLL"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Juri Lelli <juri.lelli@gmail.com>
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>, Alessio Balsini <alessio.balsini@santannapisa.it>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sira6I2NzXRdCyRhGRuNoEXry6aFidzLL
Content-Type: multipart/mixed; boundary="gdInwU4YRS3tl6zFENUF7DbkXbKDPayh3";
 protected-headers="v1"
From: Tim Blechmann <tim@klingt.org>
To: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Juri Lelli <juri.lelli@gmail.com>
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>,
 linux-rt-users@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Alessio Balsini <alessio.balsini@santannapisa.it>
Message-ID: <d2d27af1-e2dd-e1b6-2629-a56fe7218a02@klingt.org>
Subject: Re: SCHED_DEADLINE as user
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
 <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
 <0a8f899a-589d-a84b-dadb-50def9c0b4c3@santannapisa.it>
In-Reply-To: <0a8f899a-589d-a84b-dadb-50def9c0b4c3@santannapisa.it>

--gdInwU4YRS3tl6zFENUF7DbkXbKDPayh3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

>> alsa is basically driven by the hardware, which delivers/requests data=

>> every ~1.3ms.
>=20
> this is exactly the use-case we considered in that old paper back in LA=
C
> 2011, and let me just add that there is more experimentation and detail=
s
> and results in Giacomo's MSc thesis:
>=20
> =C2=A0 https://retis.sssup.it/?q=3Dnode/77
>=20
> FYI, we restarted activities on this use-case just recently, considerin=
g
> a couple of further dimensions:
>=20
> 1) support for heterogeneous platforms with the aim of achieving a soun=
d
> support for Arm big.LITTLE on Android, and apply it to the Android vide=
o
> & audio processing pipelines;
>=20
> 2) proper consideration of power switching capabilities of the platform=

> (assuming the user would block the CPU frequency to its maximum is not
> really multimedia-friendly);
>=20
> 3) support for multi-threaded processing workflows on multi-cores, as
> typically needed by (high-performance) audio applications, either with =
a
> single multi-threaded audio processing client, or, e.g., with JACK, wit=
h
> a DAG of computations that can take advantage of underlying multi-core
> processing.
>=20
> In this context, we've been playing also with the hierarchical extensio=
n
> to SCHED_DEADLINE we sent last year on LKML
>=20
> =C2=A0 https://lkml.org/lkml/2017/3/31/658
>=20
> I hope we can share some good write-up & experimental results pretty
> soon about some of the above...

very interesting! thanks for the links ...


> I'm not sure I'm getting this: AFAIU, from this viewpoint, what you
> could get
> with DEADLINE, is very similar to what you can get already with RT
> throttling
> on RT (RR/FIFO), setting up properly CPU cgroups & limits. Why do you t=
hink
> DEADLINE would allow you to avoid a watchdog thread, that you need with=

> RT instead ?

interesting, wasn't aware of rt throttling ... (haven't done much linux
audio developments for almost 10 years). will give it another read ...

cheers,
tim


--gdInwU4YRS3tl6zFENUF7DbkXbKDPayh3--

--sira6I2NzXRdCyRhGRuNoEXry6aFidzLL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCgAGBQJbe8ZVAAoJEAIkvWiom07DWVQP/j0iMyzdHJNHLmHfOLxBSVUH
ttcu+A7Dz5tO6n80ux/xOLnbdcmLhU+EJJIx6Ipc6JvOvODr1bT2xCoqYPk1SW9Z
2SFoWGBAm1WGtlSAYh5OLmVD9SX4rIJVs6VCHpsKmFoYT5xRlPVayV0VWOJXag7y
dpH+GVzlaIwOqz7DBeRGI683EddeEviKGRsYPOvD/hnvU5GoOe1z844sw6uITw8z
BZxnKz60Iquf2DUXQH1DSA0xCOLLAchDxxs16wjY5CN2/dSaTiJph0OaD+ivntCZ
n3PmbszfdJ28c1KiNd8aNZEwD9v2pnxHIJpHHcucvxsrsc6B2yt5Rf3zRviQlHy+
oReByg48BX6YbQkqeOobJGXy4gbVWQHBBn/LI+c2vUdEOTNusZV4TPeYbEuloQuX
/YyQ5+LioxrWQofD5KYiNsKFBMe0CCJf+ypbjmRuvVKr1jIyXJi6ph4GM4GBFiJF
ptjbjm95tJisNdTWoEs7KH90PWTjfE/QIfa75eOOHMkOPyEuE+TuDaf4EtAuPhZj
SnnuVdsR0uyMar2TRRI7OIv883rVcxaoxtGGPn8cmr5pR+KPAdvYgRR0tl3vtyuK
ewAmtYCki8nC/xlpQKfi+uJUGbhRqeXuuXeGZIvHlQxZel2LvBAck09g23MM4yjf
DiLocNVSoN0T4I0z/218
=o7bi
-----END PGP SIGNATURE-----

--sira6I2NzXRdCyRhGRuNoEXry6aFidzLL--
