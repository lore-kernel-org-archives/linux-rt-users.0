From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Kernel versus patch version
Date: Sat, 27 Feb 2016 20:48:00 +0100
Message-ID: <20160227194800.GA2613@pengutronix.de>
References: <AF04265A3FC2B144B9892F621A394E13EA3C436A@tethys>
 <AF04265A3FC2B144B9892F621A394E13EA3C43F3@tethys>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"otavio.salvador@ossystems.com.br" <otavio.salvador@ossystems.com.br>
To: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41557 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751389AbcB0TsD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 14:48:03 -0500
Content-Disposition: inline
In-Reply-To: <AF04265A3FC2B144B9892F621A394E13EA3C43F3@tethys>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Sat, Feb 27, 2016 at 01:48:41PM +0000, Julio Cruz Barroso wrote:
> I'm trying to understand how to fit a kernel version with a RT patch.=
=20
>=20
> In summary, I'm working with a kernel version of 3.14.52 (released by
> Freescale for the iMX6 family) and I'm not sure about the criteria to
> choose the RT patch version.=20

Is there a good reason to stick to 3.14? If not, better use 4.4. If
however there is a good reason, double check it is really good. Usually
you don't want to use the Freescale vendor kernel but a vanilla kernel.
Usually the latter has much better quality and the i.MX6 support is als=
o
good.

> The WIKI [1] mention that we need to make sure that the RT-Preempt
> version fits the kernel version we intend to use. For example, if we
> have a kernel version 3.x.y (without z or security or bug fixes), the
> RT path must be "patches-3.x.y-rtxx", where xx is the RT patch
> release.=20
>=20
> The RT patch repository [2] doesn't contain a release that fit the
> 3.14.52 kernel.
>=20
> Considering this context, I have a some questions:
>=20
> - Which revision could be more convenient for the 3.14.52 kernel?
> - Can I use a different RT patch release that differ on the .y number
>   (3.x.y)?=20

It might work, but you probably have to resolve some conflicts. And
given there is a 3.14.62 you shouldn't use 3.14.52 any more.

> - Must I need to patch the kernel to 3.14.61 and use the latest RT
>   patch release by Steve [3] some days ago?=20

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
