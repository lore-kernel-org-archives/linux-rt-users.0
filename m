From: "Christian Volk" <linux.kernel@cvolk.de>
Subject: Re: Re: Questions About preempt-rt and arch:ppc
Date: Mon, 28 Jul 2008 16:43:08 +0200 (MEST)
Message-ID: <200807281443.m6SEh8xX014622@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org
To: "Thomas Gleixner" <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cg-p00-ob.rzone.de ([81.169.146.192]:63871 "EHLO
	cg-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbYG1OnL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Jul 2008 10:43:11 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

thanks for your answer Thomas.
So i think we will switch the board to arch/powerpc.

regards,

Christian

----- original Nachricht --------

Betreff: Re: Questions About preempt-rt and arch:ppc
Gesendet: So, 27. Jul 2008
Von: Thomas Gleixner<tglx@linutronix.de>

> On Fri, 18 Jul 2008, Christian Volk wrote:
> 
> > Hi all,
> > 
> > is it possible to get preempt-rt working with kernel 2.6.20 / 2.6.21 with
> arch ppc 
> > (processor is a Freescale MPC8343)?
> > Unfortunately it is not possible for me to change the arch to powerpc.
> > 
> > Kernel 2.6.20/21 compiles fine runs and boots without the patch.
> > After applying the patch and fixing some small issues i can configure it,
> but while building
> > it, i get a lot of warnings concerning about redefinition of functions.
> > 
> > My question is, is it possible to get the above combination working or
> not?
> 
> The answer is simple. Yes, it's possible to get it working, but you're
> on your own. IMNSHO is easier to move the board to a current
> arch/powerpc kernel than fixing the -rt issues of arch/ppc on 2.6.21.
> 
> Good luck.
> 
>      tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--- original Nachricht Ende ----

