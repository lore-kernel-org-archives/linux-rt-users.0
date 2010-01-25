From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Problem with interrupt handler
Date: Mon, 25 Jan 2010 20:31:04 +0100
Message-ID: <20100125193104.GC14834@pengutronix.de>
References: <e97c14da1001250916u9b20444k2bdb550211aca1ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Julian Fuchs <julian@fuchs.cc>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59949 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab0AYTbF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jan 2010 14:31:05 -0500
Content-Disposition: inline
In-Reply-To: <e97c14da1001250916u9b20444k2bdb550211aca1ea@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jan 25, 2010 at 06:16:08PM +0100, Julian Fuchs wrote:
> being aware of the risk to bother some people here I would
> nevertheless really appreciate your help with the following issue:
>=20
> Is there any difference in the request_irq() function call in
> comparison to the one in the normal kernel?
>=20
> I'm trying to run
>=20
> request_irq(irq, interrupt_handler, IRQF_SHARED | IRQF_DISABLED |
> IRQF_NODELAY, MODULE_IDENT, &stage)
>=20
> on 2.6.31.6-rt19 but it doesn't call interrupt_handler() when an
> interrupt is received.
>=20
> In the plain kernel 2.6.31 it works with this call:
>=20
> request_irq(irq, interrupt_handler, IRQF_SHARED | IRQF_DISABLED,
> MODULE_IDENT, &stage)
Did you try with IRQF_NODELAY on vanilla and without it in rt?  Are you
sure the irq fires in rt?  Does your interrupt appear in
/proc/interrupts?  What platform are you working on?  Do you can send
the code of a minimal example?

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
