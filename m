From: Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
Subject: Re: [PATCH] Makefile: Set CC/AR variable only if it doesn't have a
 value
Date: Mon, 4 Jan 2016 20:21:47 +0100
Message-ID: <568AC64B.7040107@essensium.com>
References: <1451847271-31571-1-git-send-email-raj.khem@gmail.com>
 <20160104133903.GG92593@unpythonic.net>
 <186FF0A1-B6ED-49CA-B83F-3335126F671B@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K7lMvaKoJxCPUCd1xtt935EpP82M5CUrk"
Cc: <williams@redhat.com>, <jkacur@redhat.com>,
	<linux-rt-users@vger.kernel.org>
To: Khem Raj <raj.khem@gmail.com>, Jeff Epler <jepler@unpythonic.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 220.77.144.195.ipv4.evonet.be ([195.144.77.220]:31897 "EHLO
	exchange.essensium.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbcADTiH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Jan 2016 14:38:07 -0500
In-Reply-To: <186FF0A1-B6ED-49CA-B83F-3335126F671B@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--K7lMvaKoJxCPUCd1xtt935EpP82M5CUrk
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 04-01-16 17:20, Khem Raj wrote:
>> On Jan 4, 2016, at 5:39 AM, Jeff Epler <jepler@unpythonic.net> wrote:
>> >=20
>> > I believe the patch does not have the desired effect, because make(1=
)
>> > always sets CC automatically:
>> >=20
>> > $ cat raj.mk
>> > CROSS_COMPILE=3Dx86_64-linux-gnu-
>> > CC?=3D$(CROSS_COMPILE)gcc
>> > .PHONY: default
>> > default:
>> > 	@echo CC=3D$(CC)
>> > $ make -f raj.mk
>> > CC=3Dcc
>> >=20
>> > With your patch, those who specify CROSS_COMPILE, or for whom gcc an=
d cc
>> > are different, will get different (worse) behavior.
> Right. I think if CC was used as such with out constructing out of CROS=
S_COMPILE
> in Makefile then my issue would be fixed too. However this would mean t=
hat cross compiling users
> now have to pass CC =3D <cross-compiler> themselves instead of CROSS_CO=
MPILE prefix. Is that
> acceptable ?

 But what is really your issue? Even after this patch, you'll have to run=


make CC=3D<path-to-clang> AR=3D<path-to-clang-ar>

and this will already override it in the current situation.


 Regards,
 Arnout


--=20
Arnout Vandecappelle      arnout dot vandecappelle at essensium dot com
Senior Embedded Software Architect . . . . . . +32-478-010353 (mobile)
Essensium, Mind division . . . . . . . . . . . . . . http://www.mind.be
G.Geenslaan 9, 3001 Leuven, Belgium . . . . . BE 872 984 063 RPR Leuven
LinkedIn profile: http://www.linkedin.com/in/arnoutvandecappelle
GPG fingerprint:  7493 020B C7E3 8618 8DEC 222C 82EB F404 F9AC 0DDF



--K7lMvaKoJxCPUCd1xtt935EpP82M5CUrk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWisZbAAoJELtJ0LEwZJ4flOUP/jcoJjRK7pp2dMovJQ3LNa/p
F6mR7YGDfyZWocY+1GInsRji/1BzX+Bfv/VX5gBjJWK5JM92x6STqQ0+Hyyd4o+K
89QgcwKfGlzidoFJhTFX5G7c3ZNzIZ5yaZ+P/cXE4gRaaZQVU7ZpVYUMBAYJe6ls
1rBkdkw5m1mr86ghaUx4NsYRy59Df0nVdW6fHqO3PnomvioLaN5La+IG7HkqbceU
y3ykzCCFKuOGdmBQ3h0EIHifZdPtKNCmTYelyTIprmB5Dvdmz5dp6FX1R/wq9mKD
7dn0SgOpDK9sMBhVRKrI3JyKJc7AdK+8xQlVANFVj8jvP+LgBOx8heoCwvDKQ5jz
8KWuIc9/udgl2ABjnfDl3mx1MBHCdeg5Z3LwrayXD8FyGsTf3xZ19X3VmAx4aK0M
kYIoaMJCcv79N7NRen16ho7eZF/UoXvpTha5kh/LmyvmfOh8vFa4p3WZWQgAbt8P
9z3QNiv6fNEvonh3pr9rJBwg9XBw00B9vIbEyPlBqv8sXHiqqXGvAGp47tMvB0/I
JgAqrBiMfZMup4tUkLBTkLJkeCc0dpH1vg6odzSUXOV5TOsvmCuwp6GOvnvmnLbI
LqFmwOcR/Q7zHuwjJUG30RDYrQN5xNF0vG6+tHMZD1BSP3zW+Gw8/U+5+9nl1W06
OCSLGMlK2e1/88fOizcS
=lFNK
-----END PGP SIGNATURE-----

--K7lMvaKoJxCPUCd1xtt935EpP82M5CUrk--
