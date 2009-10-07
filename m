From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Using set_irq_handler in set_irq_type callback?
Date: Wed, 7 Oct 2009 12:07:56 +0200
Message-ID: <20091007100756.GA5478@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russell King <rmk@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43040 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755186AbZJGKJR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Oct 2009 06:09:17 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hallo,

I'm seeing an imx31 (ARCH=3Darm) based system failing to boot .31.2-rt1=
3.

The reason is that the irq for the ethernet device is level triggered,
but the handler for that interrupt is handle_edge_irq.
As the handler is threaded with PREEMPT_RT=3Dy, the irq is only acked b=
ut
neither masked (as it is believed to be an edge irq) nor handled.  This
stucks the machine as the irq is still active.

I think the fix for that is adding something like:

	if (type & IRQ_TYPE_EDGE_BOTH)
		set_irq_handler(irq, handle_edge_irq);
	else
		set_irq_handler(irq, handle_level_irq);

to the chip's .set_type callback.  (Doing this directly fails, as
=2Eset_type holds desc->lock which set_irq_handler acquires, too.  So
maybe I need to code up a handler that checks how a given irq triggers
and then calls handle_edge_irq or handle_level_irq.)

The thing that let's me question that change is that I only found[1] a
single .set_type callback that does something like that (i.e.
arch/blackfin/mach-common/ints-priority.c).

Do I just miss something or are there more than one platforms that are
in the need of handling this issue, too?

Best regards
Uwe

[1] checking files found by=20

	git grep -c set_irq_handler | awk -F: '$2 >=3D 2'

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
