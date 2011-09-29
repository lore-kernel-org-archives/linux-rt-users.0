From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: 3.0.0-1-rt-amd64: Suspend hangs
Date: Thu, 29 Sep 2011 21:31:18 +0200
Message-ID: <20110929193118.GJ6949@pengutronix.de>
References: <20110930010128.ede515e66ed1a331ad625a2a@johnohagan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: johnohagan <mail@johnohagan.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42182 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757381Ab1I2TbV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Sep 2011 15:31:21 -0400
Content-Disposition: inline
In-Reply-To: <20110930010128.ede515e66ed1a331ad625a2a@johnohagan.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Sep 30, 2011 at 01:01:28AM +1000, johnohagan wrote:
> Running Debian testing on an HP Mini 5102 with non-RT kernel, suspend
> to ram, suspend to disk and resume work as expected. With the RT
> kernels from both testing and Sid, attempting to suspend may result i=
n
=46or the people not running Debian:

	wheezy aka testing currently has 3.0.2 + 3.0.1-rt11
	sid aka unstable currently has 3.0.4-rt14

> a lock-up, with a blank screen and high fan operation. Keyboard and
> Sysrq keys are unresponsive and a hard shutdown is necessary. This
> happens randomly AFAIKT, of the order of half the time, possibly more
> often if larger programs are running, but still occurs in single-user
> mode.
>=20
> I ran the tests using /sys/power/pm_test described here:
> https://raw.github.com/torvalds/linux/master/Documentation/power/basi=
c-pm-debugging.txt
>=20
> The freeze occurs with pm_test set to "processors", but not with "pla=
tform".=20
>=20
> With "single no_console_suspend" on the kernel command-line and tryin=
g
> STD, the screen messages are normal up to the point of saving the
> image, and remain there after the freeze. For STR the screen is blank
> when the freeze happens.
>=20
> There is one tainted module on my system, brcmsmac, which I
> blacklisted for the testing.
>=20
> I've submitted this as Debian bug #643301, and am sending this summar=
y
> here on the advice of Debian maintainers.

I asked for a kernel log on a serial console (don't know if that is
possible for John to provide). If you have other tips to debug that ...

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
