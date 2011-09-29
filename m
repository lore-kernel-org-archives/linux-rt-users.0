From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] rt-tests, cyclictest - fix printf format for 32 bit
 systems
Date: Thu, 29 Sep 2011 09:35:36 +0200
Message-ID: <20110929073536.GE6949@pengutronix.de>
References: <4E839D28.5020603@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49842 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab1I2Hfj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Sep 2011 03:35:39 -0400
Content-Disposition: inline
In-Reply-To: <4E839D28.5020603@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Sep 28, 2011 at 03:18:16PM -0700, Frank Rowand wrote:
>=20
> The printf() format for a uint64_t is %l on a 64 bit system and %ll o=
n
> a 32 bit system.  Use the ugly but portable format descriptor.
>=20
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> ---
>  src/cyclictest/cyclictest.c |    3 	2 +	1 -	0 !
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> Index: b/src/cyclictest/cyclictest.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -24,6 +24,7 @@
>  #include <time.h>
>  #include <errno.h>
>  #include <limits.h>
> +#include <inttypes.h>
>  #include <linux/unistd.h>
> =20
>  #include <sys/prctl.h>
> @@ -1561,7 +1562,7 @@ int main(int argc, char **argv)
>  		print_tids(parameters, num_threads);
>  		if (break_thread_id) {
>  			printf("# Break thread: %d\n", break_thread_id);
> -			printf("# Break value: %lu\n", break_thread_value);
> +			printf("# Break value: %" PRIu64 "\n", break_thread_value);
If you consider this ugly, you might prefer

	printf("# Break value: %llu\n", (unsigned long long)break_thread_value=
);

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
