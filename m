From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RESEND] [PATCH V2 ]cyclictest: fix invalid comment of debugfs
	mount directory.
Date: Mon, 8 Jun 2009 06:53:53 +0200
Message-ID: <20090608045353.GA11319@pengutronix.de>
References: <1243821987.20635.42.camel@centos51> <1243919642.20635.53.camel@centos51> <1244425929.20635.90.camel@centos51>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	lclaudio@uudg.org
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55371 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbZFHEx4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jun 2009 00:53:56 -0400
Content-Disposition: inline
In-Reply-To: <1244425929.20635.90.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Mon, Jun 08, 2009 at 10:52:09AM +0900, GeunSik Lim wrote:
> Dear Clark Williams,=20
>=20
> This is tracing(ftrace) directory's comment related patch file.
> Please, merge this patch.
>=20
>=20
>=20
> Regards,
> GeunSik Lim.=20
>=20
>=20
> Subject: [RESEND] [PATCH V2 ]cyclictest: Fix invalid comment of debug=
fs mount directory.
>=20
> The "debugfs/tracing" name is invalid as the mountpont of debugfs fil=
esystem.
>=20
> For example,
> /sys/kernel/debug/tracing/ or
> /debug/tracing/ or
> /debugfs/tracing/ ...
>=20
> Fix directory name normally from debugfs/tracing to */tracing.
>=20
>          Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
>          Reviewed-by  : Luis Claudio R. Goncalves <lclaudio@uudg.org>
hhm, I don't know how Clark handles these flags, but I wouldn't count
the comments by Luis Claudio R. Goncalves as review.  Still more as you
didn't follow his advice and I would only add this tag after the
reviewer is OK with the result.
<nitpick>
In the kernel the colons and names usually are not aligned.
</nitpick>

> ---
>  src/cyclictest/cyclictest.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.=
c
> index be9a3f9..2186de2 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -179,7 +179,9 @@ static char functiontracer[MAX_PATH];
>  static char traceroptions[MAX_PATH];
> =20
>  /*
> - * Finds the path to the debugfs/tracing
> + * Finds the path to the tracing direcroty inside the default=20
s/direcroty/directory/

> + * mountpoint of debugfs filesystem.
> + * - debugfs related reference: http://lwn.net/Articles/334546/
set_debugfileprefix doesn't depend on a "default mountpoint", it parses
/proc/mounts, so it should even work if you mount it somewhere below /h=
ome.

And I'm not convinced that adding a link to lwn is a good idea.  I woul=
d
expect that the normal cyclictest hacker knows about debugfs.

So what about simply

+ * Finds the tracing directory in a mounted debugfs.

?  Ah, just see that is similar to the suggestion by Luis Claudio R.
Goncalves.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
