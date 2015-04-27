From: Clark Williams <clark.williams@gmail.com>
Subject: Re: rt-tests, cyclictest libnuma and isolcpus
Date: Mon, 27 Apr 2015 12:58:46 -0500
Message-ID: <20150427125846.1de46037@sluggy>
References: <20150427173222.04e8a1b1@md1em3qc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//5W83Im67j/peiqdTck6nJV"; protocol="application/pgp-signature"
Cc: "Gary S. Robertson" <gary.robertson@linaro.org>,
	John Kacur <jkacur@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Henning Schild <henning.schild@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:34101 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbbD0R67 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Apr 2015 13:58:59 -0400
Received: by qcyk17 with SMTP id k17so58828134qcy.1
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2015 10:58:57 -0700 (PDT)
In-Reply-To: <20150427173222.04e8a1b1@md1em3qc>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_//5W83Im67j/peiqdTck6nJV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2015 17:32:22 +0200
Henning Schild <henning.schild@siemens.com> wrote:

> Hi,
>=20
> i did not quickly find out which list to send this mail to, please cc if
> there is one.
>=20
> The current cyclictest from git contains a compatibilty hack for older
> versions of libnuma, specifically the one that debian shipped. That
> hack breaks the -a option on a system that uses isolcpus. Have a look
> at src/cyclictest/rt_numa.h around line 90.
>=20
> The HAVE_PARSE_CPUSTRING_ALL-case should be the default, especially now
> that even debian has a more recent version of the numa library.
>=20
> Henning

I've CC'd my co-maintainer (John Kacur) and the linux-rt list, which is
where we argue^wdiscuss changes to cyclictest.

Thanks for the info, we'll look at removing the hack.

Clark

--Sig_//5W83Im67j/peiqdTck6nJV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVPnjZAAoJEEersVlSw9NzO5IP/jcYCAIxF95Bfscxo9LFK7fT
sxVCDEkuUMIn1tyEqLgbpYEEZUjcXcJ4BPY8zjZUoPPjRqH48/ufAULma5D7XNjB
TVhpj6Z0d2RH39GQzHj4ZZFBoPVfdhscNEEfY15ydo0KM+MqkUgbxNOmhMkX10QV
gZYMsXpVi2ma7KpqFXamYZJbNcZUTR0gzQ8ell7ritxg1pEucrapTjh2sjcK20iJ
qzaExbIa/MnqdZEClOTVvCEI3Ia3O4BpG9GREYM7qlBHLENcWKEQuV2u6mFnxEPW
wDrQnDWPDg326pBvZIeaojYRDSucmyuQkbBgB7sZsag5mtZkxWvMakWT7seF1RJA
YwqtpcKf56jESkRAK6b+V8eQzi1aHpMlbl7eOmu0/GWrpQJTWyw4q0TivkncSewM
6DI56TQ44n7jhrh75xZocA+BUoJor5iRf4DnTV3PAu1XIivdUEiI7/hoF1S4TOjL
kMlwaxfBydcYzfc1b/Szr7y2janG6cpxl7hspq8k6dIs/tuVy94/Fn4toTNxEN1Q
o/aJOgNhiJfLsvqsnWxZy+rnykiNg+mjrA35gbocR//gMvIO6/JjKpudBQSIB3Jk
iUkNJZ/4UJ4wnMOEn4e9al68gC+ZvaViI+9CYwtV8cbZeQ6IkNrvLLJf0PdF1OL4
pzdpTJI0qyv1mGJLQzyu
=dL6f
-----END PGP SIGNATURE-----

--Sig_//5W83Im67j/peiqdTck6nJV--
