From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: 3.0.0-1-rt-amd64: Suspend hangs
Date: Mon, 3 Oct 2011 21:14:52 +0200
Message-ID: <20111003191452.GK6949@pengutronix.de>
References: <20110930010128.ede515e66ed1a331ad625a2a@johnohagan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: johnohagan <mail@johnohagan.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51746 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab1JCTOy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Oct 2011 15:14:54 -0400
Content-Disposition: inline
In-Reply-To: <20110930010128.ede515e66ed1a331ad625a2a@johnohagan.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello John,

On Fri, Sep 30, 2011 at 01:01:28AM +1000, johnohagan wrote:
> Running Debian testing on an HP Mini 5102 with non-RT kernel, suspend
> to ram, suspend to disk and resume work as expected. With the RT
> kernels from both testing and Sid, attempting to suspend may result i=
n
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
Can you please test the following two things:

 - Can you reproduce with the kernel parameter:

	maxcpus=3D1

   ?
 - Does onlining/offlining of the 2nd cpu work reliably? That is:

 	echo 0 > /sys/devices/system/cpu/cpu1/online
	echo 1 > /sys/devices/system/cpu/cpu1/online

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
