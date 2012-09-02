From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Don't reference non-standard realtime group
Date: Sun, 2 Sep 2012 21:49:11 +0200
Message-ID: <20120902194911.GT28643@pengutronix.de>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57011 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab2IBTtN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Sep 2012 15:49:13 -0400
Content-Disposition: inline
In-Reply-To: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jul 13, 2011 at 10:48:31PM +0200, Uwe Kleine-K=F6nig wrote:
> There is no dedicated realtime group in most distributions. So make t=
he
> error message a bit more understandable for people not running Redhat
> MRG.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Closes: http://bugs.debian.org/619938
ping?!

> ---
>  src/lib/rt-utils.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -72,7 +72,8 @@
>  	param.sched_priority =3D 1;
>  	if (sched_setscheduler(0, SCHED_FIFO, &param)) {
>  		fprintf(stderr, "Unable to change scheduling policy!\n");
> -		fprintf(stderr, "either run as root or join realtime group\n");
> +		fprintf(stderr, "Probably missing capabilities, either run as "
> +				"root or increase RLIMIT_RTPRIO limits.\n");
>  		return 1;
>  	}

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
