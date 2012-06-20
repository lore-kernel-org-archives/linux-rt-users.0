From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Oops during Init IRQ
Date: Wed, 20 Jun 2012 08:40:34 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1206200839110.3068@ionos>
References: <4FDF32DD.3010800@c-s.fr> <alpine.LFD.2.02.1206181949160.3086@ionos> <4FE03CCE.8000603@c-s.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: leroy christophe <christophe.leroy@c-s.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51625 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab2FTGkg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jun 2012 02:40:36 -0400
In-Reply-To: <4FE03CCE.8000603@c-s.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 19 Jun 2012, leroy christophe wrote:
> Hello,
> 
> Yes it does fix the issue.
> Thanks a lot.
> 
> Shall I do anything to ask for this change to be included either in the kernel
> or in the rt patch ?

We'll take care. Thanks.

Steven, can you please pick that up for stable-rt ? It's in my queue,
but I won't be able to release before the weekend.
 
Thanks,

	tglx

> > 
> > 
> > Index: linux-3.4/arch/powerpc/platforms/8xx/m8xx_setup.c
> > ===================================================================
> > --- linux-3.4.orig/arch/powerpc/platforms/8xx/m8xx_setup.c
> > +++ linux-3.4/arch/powerpc/platforms/8xx/m8xx_setup.c
> > @@ -43,6 +43,7 @@ static irqreturn_t timebase_interrupt(in
> >     static struct irqaction tbint_irqaction = {
> >   	.handler = timebase_interrupt,
> > +	.flags = IRQF_NO_THREAD,
> >   	.name = "tbint",
> >   };
> >   Index: linux-3.4/arch/powerpc/sysdev/cpm1.c
> > ===================================================================
> > --- linux-3.4.orig/arch/powerpc/sysdev/cpm1.c
> > +++ linux-3.4/arch/powerpc/sysdev/cpm1.c
> > @@ -120,6 +120,7 @@ static irqreturn_t cpm_error_interrupt(i
> >     static struct irqaction cpm_error_irqaction = {
> >   	.handler = cpm_error_interrupt,
> > +	.flags = IRQF_NO_THREAD,
> >   	.name = "error",
> >   };
> >   
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
