From: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH] Makefile: Set CC/AR variable only if it doesn't have a value
Date: Tue, 5 Jan 2016 13:20:01 -0800
Message-ID: <C069DDF5-10C5-45A6-930E-5F2DC1F58ACF@gmail.com>
References: <1451847271-31571-1-git-send-email-raj.khem@gmail.com> <20160104133903.GG92593@unpythonic.net> <186FF0A1-B6ED-49CA-B83F-3335126F671B@gmail.com> <20160104162507.GE28361@pengutronix.de> <20160105211556.GA7561@icarus.home.austad.us>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: multipart/signed; boundary="Apple-Mail=_752EEABD-AD45-4CFE-9005-E17468E5E3AF"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jeff Epler <jepler@unpythonic.net>, williams@redhat.com,
	jkacur@redhat.com, linux-rt-users@vger.kernel.org
To: Henrik Austad <henrik@austad.us>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36335 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbcAEVUH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jan 2016 16:20:07 -0500
Received: by mail-pf0-f179.google.com with SMTP id 65so181232179pff.3
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Jan 2016 13:20:05 -0800 (PST)
In-Reply-To: <20160105211556.GA7561@icarus.home.austad.us>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--Apple-Mail=_752EEABD-AD45-4CFE-9005-E17468E5E3AF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1


> On Jan 5, 2016, at 1:15 PM, Henrik Austad <henrik@austad.us> wrote:
>=20
> On Mon, Jan 04, 2016 at 05:25:07PM +0100, Uwe Kleine-K=F6nig wrote:
>> On Mon, Jan 04, 2016 at 08:20:01AM -0800, Khem Raj wrote:
>>>=20
>>>> On Jan 4, 2016, at 5:39 AM, Jeff Epler <jepler@unpythonic.net> =
wrote:
>>>>=20
>>>> I believe the patch does not have the desired effect, because =
make(1)
>>>> always sets CC automatically:
>>>>=20
>>>> $ cat raj.mk
>>>> CROSS_COMPILE=3Dx86_64-linux-gnu-
>>>> CC?=3D$(CROSS_COMPILE)gcc
>>>> .PHONY: default
>>>> default:
>>>> 	@echo CC=3D$(CC)
>>>> $ make -f raj.mk
>>>> CC=3Dcc
>>>>=20
>>>> With your patch, those who specify CROSS_COMPILE, or for whom gcc =
and cc
>>>> are different, will get different (worse) behavior.
>>>=20
>>> Right. I think if CC was used as such with out constructing out of =
CROSS_COMPILE
>>> in Makefile then my issue would be fixed too. However this would =
mean that cross compiling users
>>> now have to pass CC =3D <cross-compiler> themselves instead of =
CROSS_COMPILE prefix. Is that
>>> acceptable ?
>>=20
>> You could play with something like:
>>=20
>> ifeq($(origin CC),default)
>> CC=3D$(CROSS_COMPILE)gcc
>> endif
>>=20
>> but not sure I'd like the result. If you asked me, I'd drop all that
>> CROSS_COMPILE stuff.
>=20
> Why? Isn't this the normal way of triggering cross-compile? AFIAK, =
that's
> how the kernel does it, and that seems like a pretty sane way.

except, kernel lets you override CC if you want to.

>=20
> And yes, I compile rt-tests to several architectures, so I'm quite =
fond of
> the CROSS_COMPILE switch. In fact, I might get cross if you cross it =
out :)

All you would need is to add

CC =3D ${CROSS_COMPILE}gcc in one place in your Make env

>=20
> --
> Henrik Austad


--Apple-Mail=_752EEABD-AD45-4CFE-9005-E17468E5E3AF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlaMM4UACgkQuwUzVZGdMxT8DQCfaSKYxi6b43AlIkoabuYeSHFV
rIIAnjjVinWYV1fwD9a+Gmo/vfBgXV5P
=jaF0
-----END PGP SIGNATURE-----

--Apple-Mail=_752EEABD-AD45-4CFE-9005-E17468E5E3AF--
