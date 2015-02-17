From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH v2 0/2] rt-migrate-test: few sanity fixes
Date: Tue, 17 Feb 2015 13:27:38 -0600
Message-ID: <20150217132738.55cc923d@sluggy>
References: <5476FAF2.1060702@linux.com>
	<cover.1424194150.git.egorov@linux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/YFx1jXf1vBx2IzJn./L0h+_"; protocol="application/pgp-signature"
Cc: 716237@bugs.debian.org, linux-rt-users@vger.kernel.org,
	jkacur@redhat.com, bigeasy@linutronix.de
To: Boris Egorov <egorov@linux.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:34509 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbbBQT1o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 14:27:44 -0500
Received: by mail-qc0-f179.google.com with SMTP id r5so30419354qcx.10
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 11:27:43 -0800 (PST)
In-Reply-To: <cover.1424194150.git.egorov@linux.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/YFx1jXf1vBx2IzJn./L0h+_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Feb 2015 23:43:57 +0600
Boris Egorov <egorov@linux.com> wrote:

> Few fixes for rt-migrate-test, one to fix arithmetic error and others
> to properly handle options passed by user.
>=20
> Difference of this series from the first patch:
>=20
> * value checks now taking place in parse_options() instead of main()
> * added second sanity patch
>=20
> Boris Egorov (2):
>   rt-migrate-test: exit early if nr_runs is non-positive
>   rt-migrate-test: use variables instead of macros
>=20
>  src/rt-migrate-test/rt-migrate-test.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> --=20

I've pulled these into my tree and they will be in rt-tests-0.91.
Should come out this week.

Clark

--Sig_/YFx1jXf1vBx2IzJn./L0h+_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU45YqAAoJEEersVlSw9NzUUsP/1S+My9Uo8pECG5woqbN1hiz
JExPZsGw2nmO3fYvnwLWIrCiH1VCFu+Rbl2R5U84+HBkEIYBcjRkBJ85dwgDGrHE
DmmECEvez8AGg3oq4TAGLWvhFcj7cjYXhxlFleVhEh8HewJf4Zda7s+gzC9uLckH
783W1Q5e3Ew15uQkFMIbXFRbPN7BcAxk+QqOiFpXUv0FTtFjD32PD/3nwU4B0TYo
5wl0q7Dfuzlek3ut1y8zKpYRru56/wZseWL/lMFaFixzV+TvcMkIoL1B8y+uQDxn
s5+pg0wMPTew4o3Y+J0d/wjr6JL8Xjjxzf1h/8lbLE8MnWxzK4wjaViHfK4cI0Ta
7Oc5AlAr48NaYIflCJRokNQymlqveQP2883sPJvclLhfqhh30BMHvXb3vBj4AS9G
42n3AlUBE+5b8Cqvn7BcJ8d8kS2ulIt+aE33G/N8e2eHryDy98WfqXobjuYplHUD
lDVNsrRsoevpKjhUMrrznGB/HWxBmb4CmbVpB2EnUPKGt8wBIXG+VtJJVrj2crQg
+2fGqQcYo/R/VMPb8fmQF88MymT4zxpBVLgkUwsjhXM+beIXym8wYzTW1O/7v/vM
V1Jl/U8PRhxP93wp9u/1cFrxhitLRDm9BPCa7TukcA6nMI8HAWit5J4gr6mZdy0V
wA73Vo2R7ZBMKivNwXG5
=sQDa
-----END PGP SIGNATURE-----

--Sig_/YFx1jXf1vBx2IzJn./L0h+_--
