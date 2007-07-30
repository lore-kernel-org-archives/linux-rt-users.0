From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH -rt 4/9] ifdef raise_softirq_irqoff wakeup
Date: Mon, 30 Jul 2007 08:48:57 -0700
Message-ID: <1185810537.2636.19.camel@imap.mvista.com>
References: <20070730024534.369897977@mvista.com>
	 <20070730024719.782847315@mvista.com>  <20070730092751.GD25640@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:13460 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761023AbXG3QAs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 12:00:48 -0400
In-Reply-To: <20070730092751.GD25640@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-07-30 at 11:27 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > @@ -508,7 +508,9 @@ inline fastcall void raise_softirq_irqof
> >  {
> >  	__do_raise_softirq_irqoff(nr);
> >  
> > +#ifdef CONFIG_PREEMPT_SOFTIRQS
> >  	wakeup_softirqd(nr);
> > +#endif
> 
> thanks, applied. People rarely run the -rt kernel just to turn off 
> PREEMPT_RT, that's why this bug was there ;-)

Ultimately, all modes should function correctly right?

Daniel
