From: Clark Williams <williams@redhat.com>
Subject: Re: Mainline patch-3.14.4-5.xz
Date: Mon, 2 Jun 2014 11:46:58 -0500
Message-ID: <20140602114658.3c81b2f8@sluggy>
References: <538A6552.3050501@pavlinux.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/tqniHs1bZ4S9lYZnFFg5W9k"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>
To: pavel@pavlinux.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:8313 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755484AbaFBQrH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Jun 2014 12:47:07 -0400
In-Reply-To: <538A6552.3050501@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/tqniHs1bZ4S9lYZnFFg5W9k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 01 Jun 2014 03:27:14 +0400
Pavel Vasilyev <pavel@pavlinux.ru> wrote:

> Vanila patch:
>=20
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -118,8 +118,6 @@ static inline __deprecated void set_need_resched(void)
>            */
>   }
>=20
> -#define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
> -
>   #if defined TIF_RESTORE_SIGMASK && !defined HAVE_SET_RESTORE_SIGMASK
>   /*
>    * An arch can define its own version of set_restore_sigmask() to get t=
he
>=20
> RT Code (same file):
>=20
>=20
> #ifdef CONFIG_PREEMPT_LAZY
> #define tif_need_resched() (test_thread_flag(TIF_NEED_RESCHED) || \
>                  test_thread_flag(TIF_NEED_RESCHED_LAZY))
> #define tif_need_resched_now() (test_thread_flag(TIF_NEED_RESCHED))
> #define tif_need_resched_lazy() (test_thread_flag(TIF_NEED_RESCHED_LAZY))
>=20
> #else
> #define tif_need_resched() (test_thread_flag(TIF_NEED_RESCHED))
> #define tif_need_resched_now() (test_thread_flag(TIF_NEED_RESCHED))
> #define tif_need_resched_lazy() (0)
>=20
> #endif
>=20
> 1 out of 1 hunk ignored -- saving rejects to file include/linux/thread_in=
fo.h.rej
>=20
>=20
> What to do? :)
>=20
I thought I was the only one to do crazy rebasing like this :)

I kept the #ifdef CONFIG_PREEMPT_LAZY block (the RT code) in
include/linux/thread_info.h and removed the definition of
tif_need_resched() in include/linux/preempt.h.

Clark

--Sig_/tqniHs1bZ4S9lYZnFFg5W9k
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlOMqoIACgkQHyuj/+TTEp1+0QCfR/FpcHfk9jgyGfX54FACTVvo
jU8An3tkAhUtLkQLeN/WhlKGhaV9/deg
=ii2n
-----END PGP SIGNATURE-----

--Sig_/tqniHs1bZ4S9lYZnFFg5W9k--
