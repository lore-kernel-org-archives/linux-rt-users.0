From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] genirq: don't sync irq thread if current happen to
 be the very irq thread
Date: Tue, 22 May 2012 15:50:38 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1205221548010.3231@ionos>
References: <CAEOomG9NEoQKqp=pMx0NpzGaFpHBimALwhemnZL4F-8g7XURkA@mail.gmail.com> <20120509174931.GB31844@pengutronix.de> <CAEOomG9FZD9TEQZZKhCrNrq8SNXi3otWB2mDX69i3tWh5YQenw@mail.gmail.com> <20120520052731.GA3864@zhy> <20120520121926.GA24585@zhy>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christophe Huriaux <c.huriaux@gmail.com>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Mohr <andi@lisas.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37894 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab2EVNul (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 May 2012 09:50:41 -0400
In-Reply-To: <20120520121926.GA24585@zhy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 20 May 2012, Yong Zhang wrote:
> On Sun, May 20, 2012 at 01:27:31PM +0800, Yong Zhang wrote:
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -41,6 +41,7 @@ early_param("threadirqs", setup_forced_irqthreads);
> >  void synchronize_irq(unsigned int irq)
> >  {
> >  	struct irq_desc *desc = irq_to_desc(irq);
> > +	struct irqaction *action = desc->action;
> 
> Bad time for dereferencing *action.

You meant dereferencing *desc :)
 
>  	/*
>  	 * We made sure that no hardirq handler is running. Now verify
>  	 * that no threaded handlers are active.
> +	 * But for theaded irq, we don't sync if current happens to be
> +	 * the irq thread; otherwise we could deadlock.
>  	 */
> +	action = desc->action;

And dereferencing action w/o being protected by desc->lock is buggy.

+	while (action) {
> +		if (action->thread && action->thread == current)
> +			return;
> +		action = action->next;
> +	}
> +

Aside of that I really do not like that change. It'll hide real
deadlocks when disable_irq() is called from the interrupt handler.

Also this will not cure all problems of that MMC driver on RT or with
forced threaded interrupts.

Assume that tasklet code runs from the softirq thread so it will
schedule when desc->threads_active > 0. This will trigger a
"scheduling while atomic" warning.

The irq_enable/disable dance in that driver is amazing. I have no time
at the moment to grok the logic behind this, but it bet this can be
done way simpler and less horrible.

Thanks,

	tglx

