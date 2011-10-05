From: johnohagan <mail@johnohagan.com>
Subject: Re: 3.0.0-1-rt-amd64: Suspend hangs
Date: Thu, 6 Oct 2011 02:01:52 +1100
Message-ID: <20111006020152.e7b0c625e5cc4c707a601420@johnohagan.com>
References: <20110930010128.ede515e66ed1a331ad625a2a@johnohagan.com>
	<20111003191452.GK6949@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from razor.vivawebhost.com ([173.237.190.106]:35059 "EHLO
	razor.vivawebhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554Ab1JEPCB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Oct 2011 11:02:01 -0400
In-Reply-To: <20111003191452.GK6949@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 3 Oct 2011 21:14:52 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello John,
>=20
> On Fri, Sep 30, 2011 at 01:01:28AM +1000, johnohagan wrote:
> > Running Debian testing on an HP Mini 5102 with non-RT kernel,
> > suspend to ram, suspend to disk and resume work as expected. With
> > the RT kernels from both testing and Sid, attempting to suspend may
> > result in a lock-up, with a blank screen and high fan operation.
> > Keyboard and Sysrq keys are unresponsive and a hard shutdown is
> > necessary. This happens randomly AFAIKT, of the order of half the
> > time, possibly more often if larger programs are running, but still
> > occurs in single-user mode.
> >=20
> > I ran the tests using /sys/power/pm_test described here:
> > https://raw.github.com/torvalds/linux/master/Documentation/power/ba=
sic-pm-debugging.txt
> >=20
> > The freeze occurs with pm_test set to "processors", but not with
> > "platform".=20
> Can you please test the following two things:
>=20
>  - Can you reproduce with the kernel parameter:
>=20
> 	maxcpus=3D1

Aha! When booted this way, I can't reproduce the problem. Suspend works=
=2E

>    ?
>  - Does onlining/offlining of the 2nd cpu work reliably? That is:
>=20
>  	echo 0 > /sys/devices/system/cpu/cpu1/online
> 	echo 1 > /sys/devices/system/cpu/cpu1/online

I can successfully execute those commands without error, but as my lapt=
op has only one cpu, I'm not sure what that means.

> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe
> Kleine-K=C3=B6nig            | Industrial Linux Solutions
> | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
