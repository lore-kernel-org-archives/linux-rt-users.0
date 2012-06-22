From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Oops during Init IRQ
Date: Fri, 22 Jun 2012 07:30:15 -0400
Message-ID: <1340364615.27036.229.camel@gandalf.stny.rr.com>
References: <4FDF32DD.3010800@c-s.fr>
	 <alpine.LFD.2.02.1206181949160.3086@ionos> <4FE03CCE.8000603@c-s.fr>
	 <alpine.LFD.2.02.1206200839110.3068@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: leroy christophe <christophe.leroy@c-s.fr>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:12725 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442Ab2FVLaQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2012 07:30:16 -0400
In-Reply-To: <alpine.LFD.2.02.1206200839110.3068@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-06-20 at 08:40 +0200, Thomas Gleixner wrote:
> On Tue, 19 Jun 2012, leroy christophe wrote:
> > Hello,
> > 
> > Yes it does fix the issue.
> > Thanks a lot.
> > 
> > Shall I do anything to ask for this change to be included either in the kernel
> > or in the rt patch ?
> 
> We'll take care. Thanks.
> 
> Steven, can you please pick that up for stable-rt ? It's in my queue,
> but I won't be able to release before the weekend.
>  

Thomas, can you reply with your SOB tag please.

I'll also add a reported by and tested by from Leroy.

Thanks,

-- Steve

> > > 
> > > 
> > > Index: linux-3.4/arch/powerpc/platforms/8xx/m8xx_setup.c
> > > ===================================================================
> > > --- linux-3.4.orig/arch/powerpc/platforms/8xx/m8xx_setup.c
> > > +++ linux-3.4/arch/powerpc/platforms/8xx/m8xx_setup.c
> > > @@ -43,6 +43,7 @@ static irqreturn_t timebase_interrupt(in
> > >     static struct irqaction tbint_irqaction = {
> > >   	.handler = timebase_interrupt,
> > > +	.flags = IRQF_NO_THREAD,
> > >   	.name = "tbint",
> > >   };
> > >   Index: linux-3.4/arch/powerpc/sysdev/cpm1.c
> > > ===================================================================
> > > --- linux-3.4.orig/arch/powerpc/sysdev/cpm1.c
> > > +++ linux-3.4/arch/powerpc/sysdev/cpm1.c
> > > @@ -120,6 +120,7 @@ static irqreturn_t cpm_error_interrupt(i
> > >     static struct irqaction cpm_error_irqaction = {
> > >   	.handler = cpm_error_interrupt,
> > > +	.flags = IRQF_NO_THREAD,
> > >   	.name = "error",
> > >   };
> > >   
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


