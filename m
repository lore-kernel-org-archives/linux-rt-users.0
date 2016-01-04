From: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH] Makefile: Set CC/AR variable only if it doesn't have a value
Date: Mon, 4 Jan 2016 08:20:01 -0800
Message-ID: <186FF0A1-B6ED-49CA-B83F-3335126F671B@gmail.com>
References: <1451847271-31571-1-git-send-email-raj.khem@gmail.com> <20160104133903.GG92593@unpythonic.net>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: multipart/signed; boundary="Apple-Mail=_8232DE15-9580-46AD-8B00-A8A49DD57BC2"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: williams@redhat.com, jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33654 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbcADQUG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Jan 2016 11:20:06 -0500
Received: by mail-pf0-f169.google.com with SMTP id q63so168372355pfb.0
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Jan 2016 08:20:06 -0800 (PST)
In-Reply-To: <20160104133903.GG92593@unpythonic.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--Apple-Mail=_8232DE15-9580-46AD-8B00-A8A49DD57BC2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jan 4, 2016, at 5:39 AM, Jeff Epler <jepler@unpythonic.net> wrote:
>=20
> I believe the patch does not have the desired effect, because make(1)
> always sets CC automatically:
>=20
> $ cat raj.mk
> CROSS_COMPILE=3Dx86_64-linux-gnu-
> CC?=3D$(CROSS_COMPILE)gcc
> .PHONY: default
> default:
> 	@echo CC=3D$(CC)
> $ make -f raj.mk
> CC=3Dcc
>=20
> With your patch, those who specify CROSS_COMPILE, or for whom gcc and =
cc
> are different, will get different (worse) behavior.

Right. I think if CC was used as such with out constructing out of =
CROSS_COMPILE
in Makefile then my issue would be fixed too. However this would mean =
that cross compiling users
now have to pass CC =3D <cross-compiler> themselves instead of =
CROSS_COMPILE prefix. Is that
acceptable ?

>=20
> I believe this idea has been discussed before, but it is hard to =
search
> for because few search engines will let you search on "CC ?=3D" and =
not
> just ignore the "?=3D".
>=20
> Also I am not sure why you are submitting this patch on -rt-users, it
> doesn't seem to be particularly relevant to the RT patchset.

See the MAINTAINERS file, I just followed whats in there.

>=20
> Jeff


--Apple-Mail=_8232DE15-9580-46AD-8B00-A8A49DD57BC2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlaKm7UACgkQuwUzVZGdMxSBTgCfTYPodZvpROdBRglfZ1iMP7D8
1YcAoI27P5yKBkZQw+ddLh4VGqCZ7lM+
=efhG
-----END PGP SIGNATURE-----

--Apple-Mail=_8232DE15-9580-46AD-8B00-A8A49DD57BC2--
