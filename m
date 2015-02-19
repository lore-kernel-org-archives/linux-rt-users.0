From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH] all programs that are linked with -lrttest must depend
 on librttest.a
Date: Thu, 19 Feb 2015 16:44:00 -0600
Message-ID: <20150219164400.67d39390@sluggy>
References: <1424375949-9334-1-git-send-email-r.schwebel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/ZiFZRyZ.DdesKyXIQkm9dto"; protocol="application/pgp-signature"
Cc: Michael Olbrich <m.olbrich@pengutronix.de>,
	linux-rt-users@vger.kernel.org, John Kacur <jkacur@gmail.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:36039 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbbBSWoH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Feb 2015 17:44:07 -0500
Received: by mail-qa0-f45.google.com with SMTP id j7so9065717qaq.4
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2015 14:44:05 -0800 (PST)
In-Reply-To: <1424375949-9334-1-git-send-email-r.schwebel@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/ZiFZRyZ.DdesKyXIQkm9dto
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Feb 2015 20:59:09 +0100
Robert Schwebel <r.schwebel@pengutronix.de> wrote:

> From: Michael Olbrich <m.olbrich@pengutronix.de>
>=20
> Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
> ---
>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 9e479d3c0dca..4ee553849cce 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -73,14 +73,14 @@ cyclictest: cyclictest.o librttest.a
>  signaltest: signaltest.o librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
>=20
> -pi_stress: pi_stress.o
> +pi_stress: pi_stress.o librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
>=20
>  hwlatdetect:  src/hwlatdetect/hwlatdetect.py
>  	chmod +x src/hwlatdetect/hwlatdetect.py
>  	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
>=20
> -rt-migrate-test: rt-migrate-test.o
> +rt-migrate-test: rt-migrate-test.o librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
>=20
>  ptsematest: ptsematest.o librttest.a
> @@ -101,7 +101,7 @@ sendme: sendme.o librttest.a
>  pip_stress: pip_stress.o librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
>=20
> -hackbench: hackbench.o
> +hackbench: hackbench.o librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
>=20
>  librttest.a: rt-utils.o error.o rt-get_cpu.o rt-sched.o
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Makes sense to me. John is working on the next spin of rt-tests so I
CC'd him to pull in this change.

Clark


--Sig_/ZiFZRyZ.DdesKyXIQkm9dto
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU5mcwAAoJEEersVlSw9NzKDgP/0bUyeSwljcV4zfAz0HL6goD
Vf9K3489p0Kvljqb3AgaS+jo5MrhbZSyQbaMJYcp5HvBtKA+jGhLHQUld39vnu79
k2U26a93U7wYavQXjXNbGc36xD2zaB7T9JVd1Yd97k6+y9TM/x/ew1UIGpeOWAKh
pAOuUcGRcFsObRHnAkFLZwwW4Nzgobhoi5OdeE12ZQHj35QT9BKRWistwCp5w6lV
JmeTfKZ7AfE5+cLhCIkYhoJOh7RAaCyuSiSfAAf03j6qwSgSpJ4i4bMVe8t/nRBq
qlQMQZEXtPFtl2SZFLB9+9B0bsSV80eQgiTXEbuG9b1ZcIRInytg/OnRQ/WNlUYf
ngk58Z9kOzzAPHlvxeU3xgxXi6pI7+gvfGIYQiPj70rXqU9x4mOGHR3AVJnIkVgw
i0c7ozeZghVEh1TKw8WxvMkneIrT4FT16iNKQdmYs3FocnE5xoy0SSZn10lG292v
RtpEc+Nc/S8Chxh0qJduzAtAnuVWNiO6MqoBjA9R8st6H9T4rgFstF78P4vEvE9L
h3a1UfYUS3CMtHJ5YBOq8EEKmDyHY8HRu+0rKqRwgTmXktatTsWLS8z7GQKP01og
IImKM2vkNpMKrd+v24cFPpUVR9LVJyLP7vN8urZokTeGog0nXlhbmoz/vAgBxGlg
zKB0QUq43cvYaY3GVHuz
=zHQl
-----END PGP SIGNATURE-----

--Sig_/ZiFZRyZ.DdesKyXIQkm9dto--
