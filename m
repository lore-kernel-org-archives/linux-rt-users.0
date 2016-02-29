From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Subject: RE: Kernel versus patch version
Date: Mon, 29 Feb 2016 02:13:42 +0000
Message-ID: <AF04265A3FC2B144B9892F621A394E13EA3C6010@tethys>
References: <AF04265A3FC2B144B9892F621A394E13EA3C436A@tethys>
 <AF04265A3FC2B144B9892F621A394E13EA3C43F3@tethys>
 <20160227194800.GA2613@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"otavio.salvador@ossystems.com.br" <otavio.salvador@ossystems.com.br>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:40022 "EHLO
	dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbcB2COa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 28 Feb 2016 21:14:30 -0500
In-Reply-To: <20160227194800.GA2613@pengutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Uwe,

Thanks for your suggestion and feedback. Appreciated.

I will use the latest rt-patch with the 3.14.61 kernel.=20

You made a good question regarding the use of the latest 4.4. I would l=
ike to use the latest stable version (as many other I guess), but I'm n=
ot sure about the support. I will re-check about it and perform some te=
sts.

Thanks

Julio

-----Original Message-----
=46rom: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-own=
er@vger.kernel.org] On Behalf Of Uwe Kleine-K=F6nig
Sent: Sunday, February 28, 2016 3:48 AM
To: Julio Cruz Barroso
Cc: linux-rt-users@vger.kernel.org; otavio.salvador@ossystems.com.br
Subject: Re: Kernel versus patch version

Hello,

On Sat, Feb 27, 2016 at 01:48:41PM +0000, Julio Cruz Barroso wrote:
> I'm trying to understand how to fit a kernel version with a RT patch.=
=20
>=20
> In summary, I'm working with a kernel version of 3.14.52 (released by=
=20
> Freescale for the iMX6 family) and I'm not sure about the criteria to=
=20
> choose the RT patch version.

Is there a good reason to stick to 3.14? If not, better use 4.4. If how=
ever there is a good reason, double check it is really good. Usually yo=
u don't want to use the Freescale vendor kernel but a vanilla kernel.
Usually the latter has much better quality and the i.MX6 support is als=
o good.

> The WIKI [1] mention that we need to make sure that the RT-Preempt=20
> version fits the kernel version we intend to use. For example, if we=20
> have a kernel version 3.x.y (without z or security or bug fixes), the=
=20
> RT path must be "patches-3.x.y-rtxx", where xx is the RT patch=20
> release.
>=20
> The RT patch repository [2] doesn't contain a release that fit the
> 3.14.52 kernel.
>=20
> Considering this context, I have a some questions:
>=20
> - Which revision could be more convenient for the 3.14.52 kernel?
> - Can I use a different RT patch release that differ on the .y number
>   (3.x.y)?=20

It might work, but you probably have to resolve some conflicts. And giv=
en there is a 3.14.62 you shouldn't use 3.14.52 any more.

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
s" in the body of a message to majordomo@vger.kernel.org More majordomo=
 info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
