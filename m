From: "Maarten Brock" <m.brock@vanmierlo.com>
Subject: Re: [PATCH] tty: serial: sc16is7xx: implemented our own oneshot-like
 handling
Date: Sun, 13 Mar 2016 20:05:58 +0100
Message-ID: <20160313200558.06543fce@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
	"Sean Nyekjaer" <sean.nyekjaer@prevas.dk>,
	"Josh Cartwright" <joshc@ni.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-rt-users@vger.kernel.org,
	"Jon Ringle" <jringle@gridpoint.com>
To: linux-serial@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from web1.dommelhosting.nl ([88.159.17.71]:41947 "EHLO
	web1.dommelhosting.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbcCMTGH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Mar 2016 15:06:07 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I also wonder why this driver doesn't use threaded interrupts, just like the
MAX310x driver it is based upon.

Maarten


> This driver should use a threaded interrupt instead of trying to emulate it
> via dis/enable_irq and a worker thread.
> 
> Then you simply call c16is7xx_port_irq() right from the interrupt routine
> and the core code deals with the interrupt mask/unmask automatically.
> 
> Thanks,
> 
> 	tglx
