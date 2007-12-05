From: David Brownell <david-b@pacbell.net>
Subject: Re: Generic IRQs: proper edge/level via irq_chip->set_type hook
Date: Tue, 4 Dec 2007 16:46:35 -0800
Message-ID: <200712041646.36402.david-b@pacbell.net>
References: <87eje259r0.fsf@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-omap@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	"Remy Bohmer" <linux@bohmer.net>
To: Kevin Hilman <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:25708 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751539AbXLEAxS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Dec 2007 19:53:18 -0500
In-Reply-To: <87eje259r0.fsf@vence.hilman.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 04 December 2007, Kevin Hilman wrote:
> The hack below allows me to get the above idea working, but I'm
> looking for better suggestions on how to rework the locking here so
> that the handler might be changed from within the irq_chip's set_type
> handler.
> 
> Any ideas?

As I'm sure you know, this problem can show up on most platforms.
It's not limited to OMAP; more generic solutions are needed.

One solution would have the irq_chip.set_type() method just call

/* caller has locked the irq_desc and both params are valid */
static inline void __set_irq_handler_unlocked(int irq, irq_flow_handler_t handler)
{
	irq_desc[irq].handler = handler;
}

Another solution, limited to chained handlers, is to have the
chaining handler call the right handler (edge or level) directly
instead of calling generic_handle_irq():

	if (desc->status & IRQ_LEVEL)
		handle_level_irq(irq, desc);
	else
		handle_edge_irq(irq, desc);

Of course that requires set_type() to maintain that status flag,
which currently isn't handled by the genirq core.  Equivalently
it might mask against (IRQ_TYPE_LEVEL_HIGH|IRQ_TYPE_LEVEL_LOW),
which again isn't handled by the genirq core but is handled by
the GPIO logic in the OMAP tree.

- Dave
