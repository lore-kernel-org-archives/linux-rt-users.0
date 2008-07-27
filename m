From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Questions About preempt-rt and arch:ppc
Date: Sun, 27 Jul 2008 22:13:34 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0807241814310.574@apollo.tec.linutronix.de>
References: <200807181920.m6IJKucY010585@post.webmailer.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Christian Volk <linux.kernel@cvolk.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:46783 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757615AbYG0UO0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 27 Jul 2008 16:14:26 -0400
In-Reply-To: <200807181920.m6IJKucY010585@post.webmailer.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 18 Jul 2008, Christian Volk wrote:

> Hi all,
> 
> is it possible to get preempt-rt working with kernel 2.6.20 / 2.6.21 with arch ppc 
> (processor is a Freescale MPC8343)?
> Unfortunately it is not possible for me to change the arch to powerpc.
> 
> Kernel 2.6.20/21 compiles fine runs and boots without the patch.
> After applying the patch and fixing some small issues i can configure it, but while building
> it, i get a lot of warnings concerning about redefinition of functions.
> 
> My question is, is it possible to get the above combination working or not?

The answer is simple. Yes, it's possible to get it working, but you're
on your own. IMNSHO is easier to move the board to a current
arch/powerpc kernel than fixing the -rt issues of arch/ppc on 2.6.21.

Good luck.

     tglx
