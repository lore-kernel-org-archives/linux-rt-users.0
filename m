From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Generic IRQs: proper edge/level via irq_chip->set_type hook
Date: Tue, 04 Dec 2007 21:49:56 -0800
Message-ID: <87ir3d4rnf.fsf@vence.hilman.org>
References: <87eje259r0.fsf@vence.hilman.org>
	<200712041646.36402.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-omap@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	"Remy Bohmer" <linux@bohmer.net>
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:28100 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbXLEFt3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 00:49:29 -0500
In-Reply-To: <200712041646.36402.david-b@pacbell.net> (David Brownell's message of "Tue\, 4 Dec 2007 16\:46\:35 -0800")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

David Brownell <david-b@pacbell.net> writes:

> On Tuesday 04 December 2007, Kevin Hilman wrote:
>> The hack below allows me to get the above idea working, but I'm
>> looking for better suggestions on how to rework the locking here so
>> that the handler might be changed from within the irq_chip's set_type
>> handler.
>> 
>> Any ideas?
>
> As I'm sure you know, this problem can show up on most platforms.
> It's not limited to OMAP; more generic solutions are needed.

Agreed.

> One solution would have the irq_chip.set_type() method just call
>
> /* caller has locked the irq_desc and both params are valid */
> static inline void __set_irq_handler_unlocked(int irq, irq_flow_handler_t handler)
> {
> 	irq_desc[irq].handler = handler;
> }

I like this.  For starters, I'll submit an RFC patcheset to the OMAP
list which adds this and then fixes up the OMAP GPIO handlers to use
it, as well as a couple other fixes/cleanups for OMAP.

> Another solution, limited to chained handlers, is to have the
>chaining handler call the right handler (edge or level) directly
>instead of calling generic_handle_irq():
>
> 	if (desc->status & IRQ_LEVEL)
> 		handle_level_irq(irq, desc);
> 	else
> 		handle_edge_irq(irq, desc);
>
> Of course that requires set_type() to maintain that status flag,
> which currently isn't handled by the genirq core.  

This is what I'm currently doing, but I was hoping for something a bit
more generic that other platforms could use too.

> Equivalently it might mask against
> (IRQ_TYPE_LEVEL_HIGH|IRQ_TYPE_LEVEL_LOW), which again isn't handled
> by the genirq core but is handled by the GPIO logic in the OMAP
> tree.
>
> - Dave
