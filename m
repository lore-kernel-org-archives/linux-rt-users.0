From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [patch] cyclictest: CPU affinity now takes arbitrary set of
 cpus.
Date: Wed, 11 Dec 2013 15:35:06 -0600
Message-ID: <20131211153506.1e51328c@sluggy>
References: <CAF+KLxtyOC7jWcnr1XoF6Su3LeywYpVq5Sac258mUJ9hGrEtKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/JCJcK=cS+tPbyBWYaxmDcSM"; protocol="application/pgp-signature"
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Aaron Fabbri <ajfabbri@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:44379 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab3LKVfM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Dec 2013 16:35:12 -0500
Received: by mail-qa0-f43.google.com with SMTP id ii20so5257294qab.9
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Dec 2013 13:35:11 -0800 (PST)
In-Reply-To: <CAF+KLxtyOC7jWcnr1XoF6Su3LeywYpVq5Sac258mUJ9hGrEtKA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/JCJcK=cS+tPbyBWYaxmDcSM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Dec 2013 16:29:37 -0800
Aaron Fabbri <ajfabbri@gmail.com> wrote:

> [This patch is rebased on latest rt-tests.git, and is available in the
> "delivery" branch at https://github.com/ajfabbri/af-rt-tests.git]
>=20
> Change -a (affinity) option to take a set of CPUs, instead of just one.
>=20
> e.g.
>   cyclictest -a4,6-8 -t5
>=20
> will use 5 threads, assigned round-robin to the set of CPUs {4,6,7,8}.
> CPU 4 will get threads 1 and 5, CPU 6 gets thread 2, CPU 7 gets thread 3,=
 and
> CPU 8 gets thread 4.
>=20
> Although this builds without libnuma,  libnuma >=3D v2 is required for th=
ese
> arbitrary CPU sets.  With libnuma v1, the -a option behaves as before.  As
> before, compiling without libnuma is supported. The command usage help is=
 fixed
> up at compile time to always show the correct usage of the -a option.
>=20
> Also note that, since numa_parse_cpustring_all() wasn't available in early
> libnuma v2 versions, we use numa_parse_cpustring().  This means you'll ha=
ve to
> use taskset in some cases (isolcpus kernel parameter) to add the desired =
CPUs to
> the set of allowed cores, e.g.:
>=20
>   taskset -c4-6 cyclictest -a4-6
>=20
> Tested without libnuma (numactl), and with versions 1.0.2 and 2.0.9-rc3.
>=20
> Signed-off-by: Aaron Fabbri <ajfabbri@gmail.com>

Thanks, I cherry-picked the commit from your git tree (the included
patch was too badly line-wrapped for me to use it). The only issue I've
seen so far was that in display_help() your #endif picked up the -A
option which is not dependent on libnuma behavior, so I fixed that up.=20

I'll do some testing and push a new rt-tests out soon.

Clark

--Sig_/JCJcK=cS+tPbyBWYaxmDcSM
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqNqKAAoJEEersVlSw9NzYBgP/ix4dcXxzMGoDJYO7mC/+6H4
wa/0EvR793M7bQDyW/gNP6IiGA8u7paY6t+IoV3OQwrCLS1E2ro91YIOBf9bInke
PwJA8+Lz93nnGe+5O6P/NmAMAaC4N0LOWetU8QOSDd1cdmdvUmVkCCTWW6EEqrGR
OXsub4DNQu5uQ/9/yCBUlR17xTuQZyPl1lZb+0gplYuLFpzm5Rzdtx6VTysjx/Px
bEY3tLYidQ8c6lHW2tK/IAJvMrnEPNPtxoDktBxVRD+3nHSujFQidP1A0ahQCk2H
SMIbxODmF0Bvug743N4hm4DWkoCouAnXe9w7QljFDncR6gSk5TVqbSdaPwxvPI8q
NRqG8Uxfa4uJgrFZ+OE5DrRUunoIep5giQsDD2fdPb02heaPAL0EaDuN4AAW24Oi
1Sr/IfT7Gwhn5NOSk8a/zE9smXMVoHpyKxgtKoQ/wzB6EqqhO/+1x1LfHID5WYjM
Gf6ZCYMth013oZYezbXguO4+TdvqWKtb2yEVvo2q1xKinwwdGiU4V1wDEG/XXBWU
NXJnSdNDjnR+lBVBxnjgQlUm2ozzq2zGJ03zNB5Mv+QUpzDN28XWsBatkxTVHk2d
XU5NZq0BKtsV3gCJF4JZDkUl09FFemOGlluiAfhdMVq0EVfgciUPwf30nvMoHPK9
VhBW8tXhdEBl6/qw6SOL
=f3CF
-----END PGP SIGNATURE-----

--Sig_/JCJcK=cS+tPbyBWYaxmDcSM--
