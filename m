From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [PATCH PREEMPT_RT]: On AT91 ARM: GPIO Interrupt handling can/will stall forever
Date: Wed, 28 Nov 2007 15:43:49 +0100
Message-ID: <3efb10970711280643q50a91aeeoee2a28455e80cb8e@mail.gmail.com>
References: <3efb10970711260531x5e9f05acgfabdfa885a220192@mail.gmail.com>
	 <87bq9fqpoi.fsf@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Walker" <dwalker@mvista.com>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"ARM Linux Mailing List" <linux-arm-kernel@lists.arm.linux.org.uk>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Kevin Hilman" <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:65134 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbXK1Onv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 09:43:51 -0500
Received: by py-out-1112.google.com with SMTP id u77so2973342pyb
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Nov 2007 06:43:50 -0800 (PST)
In-Reply-To: <87bq9fqpoi.fsf@vence.hilman.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Kevin,

Just copied your mail to the list, maybe your solution is also worth looking at.

Remy

> I had a similar issue when using the chained GPIO interrupts on OMAP
> under PREEMPT_RT.
>
> I believe the chained handler itself is supposed to be doing the
> ack/unmask instead of the simple_handler.
>
> However, currently there is no way for the chained handler to know
> when the threaded handler has acutally run.  So the way I fixed this
> was to have the simple handler call the chip->end hook so that the
> chained handler could do the ack/unmask after the threaded handler has
> actually run.
>
> I've been using this against the -rt patch since 2.6.21, and submitted
> and RFC a while back, but got no comments.
>
> This patch is against 2.6.24-rc2-rt1.
>
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index b35d209..2f9e09e 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -661,6 +661,8 @@ static void thread_simple_irq(irq_desc_t *desc)
>                         note_interrupt(irq, desc, action_ret);
>         }
>         desc->status &= ~IRQ_INPROGRESS;
> +       if (desc->chip->end)
> +               desc->chip->end(irq);
>  }
>
>  /*
>
>
>
>
