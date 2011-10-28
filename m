From: Michael Thalmeier <michael.thalmeier@hale.at>
Subject: Re: [PATCH] USB: g_serial: fix deadlock with PREEMPT_RT enabled
Date: Fri, 28 Oct 2011 14:28:05 +0200
Message-ID: <4EAA9FD5.4070202@hale.at>
References: <1319804185-18559-1-git-send-email-michael.thalmeier@hale.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rt <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Michael Thalmeier <michael@thalmeier.at>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx11.lb01.inode.at ([62.99.145.13]:24351 "EHLO mx.inode.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753397Ab1J1M1I (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Oct 2011 08:27:08 -0400
In-Reply-To: <1319804185-18559-1-git-send-email-michael.thalmeier@hale.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2011-10-28 14:16, Michael Thalmeier wrote:

> In commit 44a0c0190b500ee6bcfc0976fe540f65dee2cd67 unlocking of spin_locks has
> been removed. This patch party restores this functionality.
> 
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> ---
>  drivers/usb/gadget/u_serial.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/gadget/u_serial.c b/drivers/usb/gadget/u_serial.c
> index 40f7716..a925b9e 100644
> --- a/drivers/usb/gadget/u_serial.c
> +++ b/drivers/usb/gadget/u_serial.c
> @@ -553,7 +553,16 @@ recycle:
>  	 * a workqueue, so we won't get callbacks and can hold port_lock
>  	 */
>  	if (tty && do_push) {
> +		/*
> +		 * Drop the lock here since it might end up calling
> +		 * gs_flush_chars, which takes the lock.
> +		 */
> +		spin_unlock_irq(&port->port_lock);
>  		tty_flip_buffer_push(tty);
> +		spin_lock_irq(&port->port_lock);
> +
> +		/* tty may have been closed */
> +		tty = port->port_tty;
>  	}
>  
>  

In the function tty_flip_buffer_push the PRREMPT_RT patch changes the
behaviour. Most serial drivers (those that don't set low_latency) assume
that work is only scheduled and not executed immediately in current context.
This patch only fixes this driver but other serial drivers likely have
similar problems.

Michael



--
Scanned by MailScanner.

