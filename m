From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt 4/9] ifdef raise_softirq_irqoff wakeup
Date: Mon, 6 Aug 2007 09:20:52 +0200
Message-ID: <20070806072052.GG5359@elte.hu>
References: <20070730024534.369897977@mvista.com> <20070730024719.782847315@mvista.com> <20070730092751.GD25640@elte.hu> <1185810537.2636.19.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:55864 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753610AbXHFHU6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Aug 2007 03:20:58 -0400
Content-Disposition: inline
In-Reply-To: <1185810537.2636.19.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> On Mon, 2007-07-30 at 11:27 +0200, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > @@ -508,7 +508,9 @@ inline fastcall void raise_softirq_irqof
> > >  {
> > >  	__do_raise_softirq_irqoff(nr);
> > >  
> > > +#ifdef CONFIG_PREEMPT_SOFTIRQS
> > >  	wakeup_softirqd(nr);
> > > +#endif
> > 
> > thanks, applied. People rarely run the -rt kernel just to turn off 
> > PREEMPT_RT, that's why this bug was there ;-)
> 
> Ultimately, all modes should function correctly right?

yes, of course - especially once any of the components nears upstream 
integration ;-)

	Ingo
