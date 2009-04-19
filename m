From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] fix argument -C on cyclictest
Date: Sun, 19 Apr 2009 19:52:18 +0200
Message-ID: <20090419175218.GA22205@pengutronix.de>
References: <gsfer5$6sr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: trem <tremyfr@yahoo.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44140 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbZDSRwU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Apr 2009 13:52:20 -0400
Content-Disposition: inline
In-Reply-To: <gsfer5$6sr$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Sun, Apr 19, 2009 at 05:09:25PM +0200, trem wrote:
> The argument -C isn't used in cyclictest, only --context is recognize=
d.
>
> Signed-off-by: trem <trem@mandriva.org>
> ---
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.=
c
> index f878217..e67d0d3 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -777,7 +777,7 @@ static void process_options (int argc, char *argv=
[])
>                        {"help", no_argument, NULL, '?'},
>                        {NULL, 0, NULL, 0}
>                };
> -               int c =3D getopt_long (argc, argv, "a::b:Bc:d:fh:i:Il=
:nNo:p:Pmqrst::vD:",
> +               int c =3D getopt_long (argc, argv, "a::b:Bc:Cd:fh:i:I=
l:nNo:p:Pmqrst::vD:",
>                        long_options, &option_index);
After the commit log I would have expected that you remove C from the
options list.  I would suggest something like "make cyclictest accept -=
C
as documented.  This is the same as --context".

BTW, I just noticed that both -C and --context don't appear in the man
page.

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
