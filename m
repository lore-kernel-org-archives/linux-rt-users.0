From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Using set_irq_handler in set_irq_type callback?
Date: Wed, 7 Oct 2009 12:22:27 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0910071221140.9428@localhost.localdomain>
References: <20091007100756.GA5478@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-26196288-1254910949=:9428"
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
	linux-rt-users@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:60220 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702AbZJGKXP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Oct 2009 06:23:15 -0400
In-Reply-To: <20091007100756.GA5478@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-26196288-1254910949=:9428
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 7 Oct 2009, Uwe Kleine-König wrote:
> I think the fix for that is adding something like:
> 
> 	if (type & IRQ_TYPE_EDGE_BOTH)
> 		set_irq_handler(irq, handle_edge_irq);
> 	else
> 		set_irq_handler(irq, handle_level_irq);
> 
> to the chip's .set_type callback.  (Doing this directly fails, as
> .set_type holds desc->lock which set_irq_handler acquires, too.  So
> maybe I need to code up a handler that checks how a given irq triggers
> and then calls handle_edge_irq or handle_level_irq.)

Nope. See __set_irq_handler_unlocked()

Thanks,

	tglx
--8323328-26196288-1254910949=:9428--
