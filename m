From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 4.4-rt2] fix
 arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch
Date: Tue, 19 Jan 2016 02:22:47 +0100
Message-ID: <20160119012247.GV3367@piout.net>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1452997394-8554-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118172522.GB12309@linutronix.de>
 <20160118184247.GQ3367@piout.net>
 <569D49FC.2050500@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35259 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756772AbcASBWt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jan 2016 20:22:49 -0500
Content-Disposition: inline
In-Reply-To: <569D49FC.2050500@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 18/01/2016 at 21:24:28 +0100, Sebastian Andrzej Siewior wrote :
> > 
> > My understanding is that clockevents_exchange_device() changes the state
> > from detached to shutdown and so at that point the IRQ has never been
> > requested.
> 
> I see. So we get shutdown called twice while set_periodic was only
> called once. In that case I would suggest to have internal bookkeeping
> instead of relying on current core's behavior when it is time free the
> irq.
> 

Ok, I can do that. What should I base my patch on?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
