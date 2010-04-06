From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Kernel 2.6.33.1-rt11 on PPC405 UIC spinlock and serial input
 overruns
Date: Tue, 6 Apr 2010 09:59:56 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004060946000.32352@localhost.localdomain>
References: <1270145758.27946.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: "Darcy L. Watkins" <dwatkins@tranzeo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51346 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603Ab0DFIAM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Apr 2010 04:00:12 -0400
In-Reply-To: <1270145758.27946.48.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 1 Apr 2010, Darcy L. Watkins wrote:
> In arch/powerpc/sysdev/uic.c changing all the spinlock functions for
> &uic->lock to their raw_ equivalents appears to fix it.  Also since the

Yes, that lock needs to be raw.

> invoking code appears to already have an rtmutex locked already whenever
> any of these paths are executed, I also tried simply commenting out the
> whole UIC spinlock altogether and that works too.
>
> Perhaps someone more familiar with the powerpc kernel code can advise me
> as to whether or not the uic->lock spinlock in uic.c is redundant (i.e.
> correct to remove it) or the raw spinlock is still needed.

Looks redundant, but I need to have a closer look. Converted it to raw
for now.
 
> I have also observed the following type of errors in dmesg output...
> 
> [  145.583931] ttyS0: 1 input overrun(s)
> 
> I observe these whether I have the earlier BUG present or either of my
> changes to get rid of the BUG error messages.
> 
> All of these conditions also appear when I build kernel 2.6.31.12-rt21
> for the same hardware.
> 
> They do NOT appear when I build kernel 2.6.29.6-rt24 for the same
> hardware.  They also do NOT appear for kernel 2.6.30, 2.6.31 or 2.6.33

Hmm. Which UART driver is this ?

Thanks,

	tglx

