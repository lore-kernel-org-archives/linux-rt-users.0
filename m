From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH] pip_stress: increase usleep for ARM devices
Date: Wed, 10 Dec 2014 15:16:50 -0600
Message-ID: <20141210151650.1995581e@sluggy>
References: <1418199901-3175-1-git-send-email-chase.qi@linaro.org>
	<54885564.2050904@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/F_Y0qVdHqBjTJ61MMYUYrrd"; protocol="application/pgp-signature"
Cc: chase.qi@linaro.org, linux-rt-users@vger.kernel.org,
	milosz.wasilewski@linaro.org, naresh.kamboju@linaro.org,
	anders.roxell@linaro.org, mike.holmes@linaro.org,
	John Kacur <jkacur@gmail.com>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:63204 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932743AbaLJVRH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Dec 2014 16:17:07 -0500
Received: by mail-qg0-f42.google.com with SMTP id q108so752510qgd.15
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Dec 2014 13:17:06 -0800 (PST)
In-Reply-To: <54885564.2050904@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/F_Y0qVdHqBjTJ61MMYUYrrd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Dec 2014 09:15:00 -0500
Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org> wrote:

> On 12/10/2014 03:25 AM, chase.qi@linaro.org wrote:
> > From: Chase Qi <chase.qi@linaro.org>
> >
> > Hello,
> >
> > pip_stress works out of the box on my x86 based laptop, but
> > doesn't work on ARM devices, returned 'no inversion incurred'.
> > Follow the comment to increase usleep value, 2500 worked for
> > pandaboard and 3000 worked for Beaglebone Black board.
> >
> > I propose that increase the usleep value to 3500 from upstream,
> > so that we can use pip_stress right out of the box.
> >
> > Please let me know if this is acceptable.
>=20
> I think they should have modified main() to accept the lock time as a par=
ameter
> instead of simply adding some instructions in the comments
>=20
>  * to show that it works. If you are having difficulty triggering an inve=
rsion,
>  * merely increase the time that the low priority process sleeps while
>  * holding the lock. (usleep);
>  * Also note that you have to run as a user with permission to change
>  * scheduling priorities.
>  */
>=20
> what I would do is actually
> 1. modify main to accept lock_time
> 2. send the patch to the rt-tests team
>=20
>=20
>

I wish we didn't have to deal with timers here. I used barriers when I
wrote pi_stress.c and obviously we don't have that luxury with
pip_stress.c. I guess the best thing we can do right now is add a
parameter to change the default timer value for pip_stress and see if
someone comes up with a brilliant state-machine solution that will work
between processes :).

John and I are about to start a sweep through the tests and will
probably come out with a new rt-tests around the first of the year.=20

Clark

--Sig_/F_Y0qVdHqBjTJ61MMYUYrrd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUiLhLAAoJEEersVlSw9NzMzwP/iJ9x3kUboJ0V4lC+IO1In22
WY3kRtYoBHBCpv6y6WXS8akk64LsVIernerE67RN1a+f3zPqRd1lfU6fhGZ6+Z/K
WJY5kTSj0ywp9CpYe00dunloEgFFBjLCmYvO/C3iElScl9MwTlLUU59CFvMhkaRX
B2wz23qD9fVu5XsU6nn52FpH3ORsYMDFiqOD4qqK5zkMJHJtB+SPsrVsFSDn7UnY
7xiDdI3cVFMqwdugMdlda8BSAuYL3CeKJk4F44ScNwXr8CP0m/G/NNNaVznYYsDd
K9s8cCAqbWi+J78/Hy4CnwyrxmWyh3vm5c1QFaKFgoQ/6G+2FazT3xRoIeuoKqKL
uokFSN4MeUul+l+Ncz2gc3bsb7F2N5q8a84+RYnb1yKqrrLo//9WFM5SZMHb8pA6
mYleWYZdNb76o0e86zEWwXgb9QlojbWT4KP7tEI3cMXOlKlvnOb86SpTcxxffAiP
L4qOZw++yMex31PdL1jsO+R7ek3YeiLVgq/teMP7HYlLgxW4hN5m8AklTJC+mKGF
qIflwOm2Pp5YgfLTbrMOz9+uHqRup+wxNQws3r7UYGrFd0ysYEeNkM9zT8sruSQm
BxCznzjJsZmaUr7P9Ba/Hp2UOJxBlQV+1Bg6ILzK63+feUK8uqGLa66BoAYXVsSb
j4Mh8Sp0Jwu4tdldrv8l
=rSPd
-----END PGP SIGNATURE-----

--Sig_/F_Y0qVdHqBjTJ61MMYUYrrd--
