From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Using set_irq_handler in set_irq_type callback?
Date: Wed, 7 Oct 2009 11:28:36 +0100
Message-ID: <20091007102836.GA27860@flint.arm.linux.org.uk>
References: <20091007100756.GA5478@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41177 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757902AbZJGKaR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Oct 2009 06:30:17 -0400
Content-Disposition: inline
In-Reply-To: <20091007100756.GA5478@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 07, 2009 at 12:07:56PM +0200, Uwe Kleine-K=F6nig wrote:
> Hallo,
>=20
> I'm seeing an imx31 (ARCH=3Darm) based system failing to boot .31.2-r=
t13.
>=20
> The reason is that the irq for the ethernet device is level triggered=
,
> but the handler for that interrupt is handle_edge_irq.

There's nothing wrong with that with the conventional interrupt handlin=
g
scheme.

> As the handler is threaded with PREEMPT_RT=3Dy, the irq is only acked=
 but
> neither masked (as it is believed to be an edge irq) nor handled.  Th=
is
> stucks the machine as the irq is still active.

Actually, the problem is that I misnamed the edge/level handlers.
What follows here is the non-RT case.

Really, what the two are about is that the level handler is there for
interrupt controllers which behave in a good way - in other words, for
level-based inputs and for edge-based inputs which "remember" new
transitions while the input is masked.

The edge handler is for edge-based inputs where the controller does not
remember transitions with the input masked.

=46orcing people to use the edge handler all the time for edge based in=
puts
is highly sub-optimal - it means greater interrupt load since the input
is left unmasked.

So really, the choice of the handler should be determined by how the
hardware behaves, and not by the input type requested.


When it comes to RT and its thread-based interrupt model, the assumptio=
ns
which these handlers were designed around are no longer true.  What is
now required is a different handling philosophy - rather than leaving
the interrupt-time decision about what to do with a signalled interrupt
to the flow handler, it should be immediately ack'ed and disabled, and
the interrupt thread scheduled.

It is then up to the interrupt thread to determine how to handle the
interrupt - if it's really a level interrupt, then the interrupt thread
has to call the handlers before re-enabling the input.  If it's edge
based, the input has to be re-enabled before running the handlers (so
that new edges received during the running of those handlers are
recognised.)


So, the technical aspects of handling of interrupts between the RT and
non-RT cases are quite different, and I feel that we shouldn't be
re-using the same flow handlers between the two cases.

--=20
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
