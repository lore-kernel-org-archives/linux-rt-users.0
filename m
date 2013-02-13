From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3.4.28-rt40 arm freescale imx35 pcm43
Date: Wed, 13 Feb 2013 12:59:31 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302131247260.11905@ionos>
References: <6003615.pRQnIgKCSn@dabox> <5977343.5KpmQXLB4x@dabox>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim@krieglstein.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58362 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658Ab3BML7c (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Feb 2013 06:59:32 -0500
In-Reply-To: <5977343.5KpmQXLB4x@dabox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 6 Feb 2013, Tim Sander wrote:
> I just noticed that the thread irq/45-IMX-uart is the current thread. 
> Nevertheless the interrupt for this thread is enabled which seems wrong to me?

That's wrong indeed. The forced threading masks the interrupt line in
the hard interrupt handling code and keeps it masked. It's unmasked
after the handler thread returns from the interrupt handler function.

> So the interrupt handler imx_rxint does not get call as it is always 
> interrupted by the level triggered interrupt of the same hw source?

Right. You have to find the reason, why the interrupt is not disabled
at the interrupt controller level.

Thanks,

	tglx



