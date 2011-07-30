From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] dma: ipu: convert back_lock to a raw spinlock
Date: Sat, 30 Jul 2011 21:15:49 +0200
Message-ID: <20110730191549.GA26262@pengutronix.de>
References: <1311949627-13260-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CABE8wwuJPSPmJ=fHacdPcPAX5Lrewknd=f4uKtwLP08=+qDnww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, kernel@pengutronix.de,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54395 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1G3TPy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 Jul 2011 15:15:54 -0400
Content-Disposition: inline
In-Reply-To: <CABE8wwuJPSPmJ=fHacdPcPAX5Lrewknd=f4uKtwLP08=+qDnww@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Jul 30, 2011 at 09:24:26AM -0700, Williams, Dan J wrote:
> 2011/7/29 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > It's used in irq handling, so needs to be hardirq safe.
> >
>=20
> This changelog does not make sense,  spin_lock_irqsave *is* hardirq
> safe.  Is this trying to workaround a lockdep report?
It's only hardirq save on !PREEMPT_RT. Without PREEMPT_RT there is no
real difference between raw spinlocks and the normal ones.

So maybe:

	It's used in irq handling, so needs to be hardirq safe even on
	PREEMPT_RT.

?

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
