From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Problem with Realtime Kernel and Ethernet Card
Date: Tue, 17 Jan 2012 21:01:22 +0100
Message-ID: <20120117200122.GL14252@pengutronix.de>
References: <4F143AB2.6070404@haw-aw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Matthias =?iso-8859-1?Q?S=F6llner?= <m.soellner@haw-aw.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58368 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab2AQUBY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Jan 2012 15:01:24 -0500
Content-Disposition: inline
In-Reply-To: <4F143AB2.6070404@haw-aw.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jan 16, 2012 at 03:56:50PM +0100, Matthias S=F6llner wrote:
> Hello,
> I installed a RT-Preempt Kernel in Debian 6
> as shown on
> http://pengutronix.de/software/linux-rt/debian_en.html
>=20
> I have a DELL Precision T1600 with onboard network card and additiona=
l
> PCI network-card.
>=20
> The onboard card is a Intel=AE 82579LM Gigabit-LAN.
>=20
> I used linux-image-2.6-rt-686 from Pengutronix APT repository.
That's an 2.6.33.7.2-rt30 kernel. For amd64 there are also newer kernel=
s
available on debian.pengutronix.de (3.0 series) and Debian experimental
(3.2 series). If possible I'd recommend the newer versions.

> Installation worked fine, I can boot my debian with both kernels.
>=20
> If I boot normal debian kernel i have eth0 and eth1. both cards work =
fine.
Normal Debian kernel means 2.6.32 I guess? 2.6.32-36 added a backport o=
f
the e1000e driver from 2.6.38 and this backport is not included in the
2.6.33.7.2-rt30 package because it branched from the Debian kernel
before 2.6.32-36.

> But if I boot RT-Preempt-Kernel the  internal network card is not sho=
wn
> and I only have eth0.
>=20
> With normal debian kernel intel e1000e driver is loaded.
>=20
> What can I do to make my internal network card function properly with
> realtime kernel ?
=20
> I tried to compile the intel network driver myself. But where to I ge=
t
> the right kernel-headers for my RT-Preempt-Kernel?
They should be available on debian.pengutronix.de, too. Just install th=
e
matching headers package, in your case probably
linux-headers-2.6.33.7.2-rt30-1-686.

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
