From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Problem with Realtime Kernel and Ethernet Card
Date: Thu, 9 Feb 2012 11:34:33 +0100
Message-ID: <20120209103433.GM8621@pengutronix.de>
References: <4F143AB2.6070404@haw-aw.de>
 <CAOY97VZGuFz=txi1HnXjh_WqK+UVNiqRCifrnSxin7x2osbP5g@mail.gmail.com>
 <4F16D7E9.9070707@haw-aw.de>
 <20120118191955.GA4066@pengutronix.de>
 <4F3298E8.9090303@haw-aw.de>
 <20120208184454.GJ8621@pengutronix.de>
 <4F339FA4.5070804@haw-aw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Austin Hendrix <ahendrix@willowgarage.com>,
	linux-rt-users@vger.kernel.org
To: Matthias =?iso-8859-1?Q?S=F6llner?= <m.soellner@haw-aw.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44717 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235Ab2BIKeh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Feb 2012 05:34:37 -0500
Content-Disposition: inline
In-Reply-To: <4F339FA4.5070804@haw-aw.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Feb 09, 2012 at 11:27:48AM +0100, Matthias S=F6llner wrote:
> Ok, this was the problem to see the package. I installed a fresh
> debian-squeeze 6.04 stable for amd64 and now I can find the package.
>=20
> But if i do an sudo apt-get install I get the following error:
>=20
> Die folgenden Pakete haben unerf=FCllte Abh=E4ngigkeiten:
>  linux-image-3.0.0-2-rt-amd64 : H=E4ngt ab von: linux-base (>=3D 3~) =
aber
> 2.6.32-41 soll installiert werden
>                                 Empfiehlt: firmware-linux-free (>=3D =
3~)
> soll aber nicht installiert werden
>                                 Besch=E4digt: initramfs-tools (< 0.99=
~)
> aber 0.98.8 soll installiert werden
You need to install linux-base and initramfs-tools from wheezy.

That is add

	deb http://cdn.debian.net/debian/ wheezy main

to your sources list and install/upgrade the needed packages.

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
