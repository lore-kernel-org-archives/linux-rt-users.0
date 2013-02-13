From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3.4.28-rt40 arm freescale imx35 pcm43 - patch
 86236252d2449313bdbac790023cbc957bf6e426 is cause
Date: Wed, 13 Feb 2013 18:40:49 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302131828050.22263@ionos>
References: <6003615.pRQnIgKCSn@dabox> <1525614.TvuV6qqnEF@dabox> <alpine.LFD.2.02.1302131301580.11905@ionos> <3970144.HqS49ZSYWh@dabox>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim@krieglstein.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60465 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759980Ab3BMRku (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Feb 2013 12:40:50 -0500
In-Reply-To: <3970144.HqS49ZSYWh@dabox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 13 Feb 2013, Tim Sander wrote:
> Hi Thomas
> > > Just another update on this stuff. I noticed that there has been a patch
> > > added* with spinlocks to the imx.c serial driver. I reverted this patch
> > > and now my serialfuz programm "only" kills the serial port with a not so
> > > nice oom condition. But at least it does not show the runaway interrupt
> > > problem.
> > That does not make any sense, really. The runnaway interrupt issue is
> > completely unrelated to this commit.
> One thing that puzzles me is the fact that it does! So removing the mentioned 
> spinlock patch creates the same result as using your fixed patch.
> 
> As the other problem with the driver i posted shows the same interrupt runaway 
> symptom as this i have a very bad gut feeling about this... 
> Or probably its not a runnaway interrupt problem but a double 
> spin_lock_irqsave.

Well, you claimed that it is a runnaway interrupt. So much for the
theory :)

The issue with the recursive locking is not an RT issue. You can
observe the problem on mainline, when you enable PROVE_LOCKING and
issue a sysrq or oopsing in a section which holds the port.lock
already.

The reason why you can't observe it with PREEMPT_RT_FULL=n and
PROVE_LOCKING=n is, that the spinlocks on UP machines are compiled
away, so recursive locking does not lead to an observable dead lock.

> Also the fact that my serialfuz program i posted is able to give the system an 
> Out Of Memory condition is strange. I mean throwing random chars at a getty 
> should'nt exhaust memory so fast.

That's true, but w/o seing the OOM output I can't tell what's
exhausting the memory.

Thanks,

	tglx
