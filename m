From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Kernel panic with PREEMPT_RT_FULL and UIO driver
Date: Thu, 22 Dec 2011 11:31:14 +0100
Message-ID: <20111222103114.GE24496@pengutronix.de>
References: <4EF1B984.4010102@x2e.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Lukas Erlinghagen <lukas.erlinghagen@x2e.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48572 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab1LVKbQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Dec 2011 05:31:16 -0500
Content-Disposition: inline
In-Reply-To: <4EF1B984.4010102@x2e.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Dec 21, 2011 at 11:48:36AM +0100, Lukas Erlinghagen wrote:
> Dear list,
>=20
> we're getting the kernel panic postet below on our system (Kernel
> version is 3.0.3-rt11, the platform is an embedded PowerPC 440 in a
Are you aware that there are newer versions available? 3.0.14-rt31 is
the most recent 3.0 release. Don't know if it has any uio fixes though.

> Virtex 5 FPGA, the device controlled by the UIO driver is a
> Freescale MFR4310 controller, and the interrupt is triggered by a
> high-active interrupt pin). This panic only occurs when using
> CONFIG_PREEMPT_RT_FULL, and only under high interrupt load on the
> MFR.
>=20
> I've also included our IRQ handler (registered with IRQF_ONESHOT)
> and IRQ control function.
>=20
> Is there something fundamentally wrong we're doing, and if so, where
> can I find information on The Right Way to write UIO drivers for the
> RT kernel?
>=20
> Thanks in advance for any insight you can provide.
>=20
> Kernel panic:
>=20
> ------------[ cut here ]------------
> kernel BUG at kernel/rtmutex.c:724!
That's a recursive spinlock. Try enabling CONFIG_PROVE_LOCKING.

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
