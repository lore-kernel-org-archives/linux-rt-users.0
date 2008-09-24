From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][RT]: handle_IRQ_event() - fix thinko
Date: Wed, 24 Sep 2008 17:45:36 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0809241744110.4413@apollo.tec.linutronix.de>
References: <20080923101052.16574a0f@bull.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux-rt <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
To: Sebastien Dugue <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42781 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264AbYIXPqj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Sep 2008 11:46:39 -0400
In-Reply-To: <20080923101052.16574a0f@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 23 Sep 2008, Sebastien Dugue wrote:

> 
>   handle_IRQ_event() reenables interrupts for threaded IRQ handlers,
> provided said handler does not need to run with IRQF_DISABLED.
> 
>   Therefore, unless I'm missing something, in the following:
> 
> if (!hardirq_count() || !(action->flags & IRQF_DISABLED))
> 	local_irq_enable();
> 
>   the logical OR should be a logical AND:
> 
> if (!hardirq_count() && !(action->flags & IRQF_DISABLED))
> 	local_irq_enable();

No. We don't want to run the threaded handler with interrupts disabled.

!hardirq_count() tells us that we are in thread context.
 
>   Or maybe I've not yet reached my daily cafeine dose. (Damned addiction)

Looks like. :)

Thanks,

	tglx
