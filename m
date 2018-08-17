Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.klingt.org ([86.59.21.178]:48020 "EHLO klingt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeHQNRN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Aug 2018 09:17:13 -0400
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
From: Tim Blechmann <tim@klingt.org>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
Date: Fri, 17 Aug 2018 18:08:20 +0800
MIME-Version: 1.0
In-Reply-To: <20180817095106.GB27071@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QaaPsBqbVmGN5sldjBFBg00UJ0uf5tdde"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QaaPsBqbVmGN5sldjBFBg00UJ0uf5tdde
Content-Type: multipart/mixed; boundary="4HeAirrtoNint8MkzLk49T5oU5vFK54Ul";
 protected-headers="v1"
From: Tim Blechmann <tim@klingt.org>
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>,
 linux-rt-users@vger.kernel.org
Message-ID: <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
Subject: Re: SCHED_DEADLINE as user
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
In-Reply-To: <20180817095106.GB27071@localhost.localdomain>

--4HeAirrtoNint8MkzLk49T5oU5vFK54Ul
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

hi juri,

>>> i wonder, what's the preferred way to obtain SCHED_DEADLINE privilege=
s
>>> as non-root user?
>>
>> Hi Tim,
>>
>> It is still not possible to use sched deadline as a non-root user :-(.=

>=20
> Indeed, but Tim, is this hindering you from experimenting/using
> DEADLINE?

it's a showstopper for using it in audio applications, which are running
as user.
audio applications typically use SCHED_FIFO. however they are
rate-monotonic by design, so i wanted to evaluate how SCHED_DEADLINE
behaves here.

> Asking because we might want to have a look at how to relax the current=

> privileges requirement.

please :)

cheers,
tim


--4HeAirrtoNint8MkzLk49T5oU5vFK54Ul--

--QaaPsBqbVmGN5sldjBFBg00UJ0uf5tdde
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCgAGBQJbdp6UAAoJEAIkvWiom07D+tEP/jiANh2TLXziIj+CJRWjiTa2
wa0RxMuY6VvRs9YQyLcjxQlbN97DLtrw0Lo3JZKWsqs9TqdMxFnliD9a2BiWjg7/
U1JVhyWeZ6icfGMFhMJq1czXji1Ak6dc3BopBQTGwjt4s918nyRdreqGKTCLicq2
ka5Ybh5Qtx+Pd6ch/ILAej/K3cnVXnWFMj5JBkNeg/P33D79L+lFi1zZJCUADIp8
xjRYe4hjvjzaYe7lvf6RrW8ysAh6OvWrvsV3zu1/selCCZiRfHD69e7eFBwPeU/J
+8DyU4KoLB+L5IxSoORsA2iiZl5arDtrL7TwKywNB543PSzu1nRuRurvyrhURr0x
n19pVn5x9OEVT0eEVG+9Ab0vUX9DeIuNZmmo6fyZyBylu5U2G7C9xo1NMpIEgNVm
O/u5z1Wdbp9WwaEzlk3xS2tontvG6L0bvQRImzlAuq3jgZXImG0Aexzbpew4E8vm
T9UZ4kRbQqniilymorEnfnIIwNPfPfQBevWD8me5N6rkqlObk5G8A6xv2Gi429/U
iu9pGXTf6OfQ7vEtfAF1io3KYFMqp3wUDJHNDizwqNr8hWxuv/bDpjMZHbEEQHUC
Guip1dIifNqkrWzgs9um0feL18Jx0ZCySahDrVe0ZezJObTzxUeGzJV14wlOc9+k
WlFV1BfSuweMvqD2JwYj
=sP81
-----END PGP SIGNATURE-----

--QaaPsBqbVmGN5sldjBFBg00UJ0uf5tdde--
