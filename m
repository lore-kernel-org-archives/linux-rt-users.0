From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tty: serial: sc16is7xx: implemented our own oneshot-like
 handling
Date: Sun, 13 Mar 2016 11:25:05 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603131103020.3657@nanos>
References: <1457692476-19082-1-git-send-email-sean.nyekjaer@prevas.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-serial@vger.kernel.org, Josh Cartwright <joshc@ni.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rt-users@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42936 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbcCMK0e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Mar 2016 06:26:34 -0400
In-Reply-To: <1457692476-19082-1-git-send-email-sean.nyekjaer@prevas.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 11 Mar 2016, Sean Nyekjaer wrote:

>  static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
>  {
>  	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
> +	int i;
> +
> +	for (i = 0; i < s->devtype->nr_uart; ++i)
> +		disable_irq_nosync(s->p[i].port.irq);

Aside of the lack of a changelog. This is completely bogus. You disable the
same interrupt a gazillion of times. 

>  	queue_kthread_work(&s->kworker, &s->irq_work);

This driver should use a threaded interrupt instead of trying to emulate it
via dis/enable_irq and a worker thread.

Then you simply call c16is7xx_port_irq() right from the interrupt routine and
the core code deals with the interrupt mask/unmask automatically.

Thanks,

	tglx

