From: Kuba Kicinski <kubakici@wp.pl>
Subject: Re: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead of homegrow
Date: Fri, 26 Feb 2016 09:34:57 -0500
Message-ID: <C32FB8B0-21F8-4C84-9F77-20F3CD43E3D4@wp.pl>
References: <56CDCCE6.5020801@prevas.dk> <56CDEAE2.9050102@prevas.dk> <20160224223547.GF9598@jcartwri.amer.corp.natinst.com> <20160226114340.GC8318@linutronix.de> <20160226114809.GD8318@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sean Nyekj?r <sean.nyekjaer@prevas.dk>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Josh Cartwright <joshc@ni.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.wp.pl ([212.77.101.10]:9352 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754502AbcBZOl7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 09:41:59 -0500
In-Reply-To: <20160226114809.GD8318@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 26 February 2016 06:48:09 GMT-05:00, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>This ONESHOT + workqueue combo is something that is not required
>because
>we have infrastrucure for this kind of things: threaded interrupts.
>
>This is compile tested only due to -ENODEV.
>Now that we that sc16is7xx_irq() is an actual interrupt handler
>sc16is7xx_port_irq() could be improved so the former can return
>IRQ_NONE
>if nothing has been done.
>
>Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The reason why this driver is not using threaded irqs is that it already has a kthread to handle other things. Having two threads per port seems like a big waste plus we may need some additional locking between them. Can we just return IRQ_WAKE_THREAD from the handler?

IMHO drivers should be perfectly fine to have their own threaded irq setups and core needs to support it.

