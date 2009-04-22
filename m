From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Triggering UserCode from KernelModule (IRQ)
Date: Wed, 22 Apr 2009 21:59:56 +0200
Message-ID: <20090422195956.GM5367@pengutronix.de>
References: <6669682.1240409688443.JavaMail.ngmail@webmail19.ha2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50382 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608AbZDVT75 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Apr 2009 15:59:57 -0400
Content-Disposition: inline
In-Reply-To: <6669682.1240409688443.JavaMail.ngmail@webmail19.ha2.local>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Apr 22, 2009 at 04:14:48PM +0200, M. Koehrer wrote:
> However, there is one operation mode that uses interrupts to signal
> incoming data.  The interrupt handler is realized as a tiny kernel
> module (that one that provides also the mmap for the user mode
> application).  Now I am not sure how the signalling of the IRQ from
> kernel to user mode could be realized best (in terms of low latency).
>
> The "classical" approach for this task is to provide a character
> driver with a .poll file operation. In Xenomai I could use a semaphore
> that was accessible from kernel and user space for this. What is the
> best way in the RT_PREEMPT "world"?

UIO might be a good choice here, the rest is giving the interrupt
handler and the processes the right priorities.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
