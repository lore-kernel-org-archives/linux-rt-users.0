From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] rt-tests - allow build without NUMA
Date: Fri, 23 Sep 2011 21:46:32 +0200
Message-ID: <20110923194632.GT20550@pengutronix.de>
References: <4E7CDD4B.2070202@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43812 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab1IWTqg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Sep 2011 15:46:36 -0400
Content-Disposition: inline
In-Reply-To: <4E7CDD4B.2070202@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Sep 23, 2011 at 12:26:03PM -0700, Frank Rowand wrote:
>=20
>=20
> "NUMA=3D0 make" does not remove numa from the build.  Fix.
>=20
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> ---
>  Makefile |    2 	1 +	1 -	0 !
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: b/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/Makefile
> +++ b/Makefile
> @@ -26,7 +26,7 @@ else
>  	CFLAGS	+=3D -O0 -g
>  endif
> =20
> -ifdef NUMA
> +ifeq ($(NUMA),"1")
>  	CFLAGS +=3D -DNUMA
>  	NUMA_LIBS =3D -lnuma
>  endif
can we please addionally get something like:

	machinetype =3D $(shell uname -m | sed -e s/i.86/i386;s/mips.*/mips/;s=
/ppc.*/powerpc)
	ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
	NUMA =3D 1
	endif

instead of the unconditional NUMA=3D1 we currently have?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
