From: Henrik Austad <henrik@austad.us>
Subject: Re: [PATCH] cyclictest: fix #ifdef broken by NO_PTHREAD_SETAFFINITY
Date: Wed, 21 Oct 2015 20:13:50 +0200
Message-ID: <20151021181350.GA32154@icarus.home.austad.us>
References: <alpine.LFD.2.20.1510211833500.6297@riemann>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Henrik Austad <haustad@cisco.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35312 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbJUSNz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Oct 2015 14:13:55 -0400
Received: by wicll6 with SMTP id ll6so103054538wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Oct 2015 11:13:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1510211833500.6297@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 06:34:48PM +0200, John Kacur wrote:
> From 73bc7345eebb2244efc527928fdac7b8e29193cd Mon Sep 17 00:00:00 2001
> From: John Kacur <jkacur@redhat.com>
> Date: Wed, 21 Oct 2015 18:25:37 +0200
> Subject: [PATCH] cyclictest: fix #ifdef broken by NO_PTHREAD_SETAFFINITY
>=20
> Unfortunately c869f3cdcd023eec2f767eb4094caa88178717a4 wasn't sufficient
> to fix #ifdef #else functionality for uclib, broken by the changes for
> bionic.

Yeah, you're right. The wonders of #ifdefs

> In practice this probably didn't break anyone though, except possibly
> for the new bionic code which probaly doesn't have too many adapters
> (yet).
>=20
> This should also help Henrik move the NO_PTHREAD_SETAFFINITY functionalit=
y to
> the bionic file.

I'm ripping all of the NO_PTHREAD_SETAFFINITY out of cyclictest, so if you=
=20
don't mind, hold off pushing this to the repo -I'm cleaning up my mess.

> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 00168e22fc7f..975e7858fb8e 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -83,6 +83,10 @@ int sched_setaffinity (__pid_t __pid, size_t __cpusets=
ize,
>  #define CPU_SET(cpu, cpusetp)
>  #define CPU_ZERO(cpusetp)
> =20
> +#else
> +extern int clock_nanosleep(clockid_t __clock_id, int __flags,
> +			   __const struct timespec *__req,
> +			   struct timespec *__rem);
>  #endif
> =20
>  #ifdef NO_PTHREAD_SETAFFINITY
> @@ -91,11 +95,6 @@ static inline int pthread_setaffinity_np(pthread_t thr=
ead, size_t cpusetsize,
>  {
>      return sched_setaffinity(0, cpusetsize, cpuset);
>  }
> -
> -#else
> -extern int clock_nanosleep(clockid_t __clock_id, int __flags,
> -			   __const struct timespec *__req,
> -			   struct timespec *__rem);
>  #endif
> =20
>  #define USEC_PER_SEC		1000000
> --=20
> 2.4.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Henrik Austad

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlYn1d0ACgkQ6k5VT6v45ll2yACfVKs8ubJRLoeO0Fw38o+gRrxg
29EAoNZ5tiBCyAjFVNVEXwBxz6hPHU6s
=ZAjP
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
