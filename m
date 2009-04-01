From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.29-rt1+ irqbalance = OOPS
Date: Wed, 1 Apr 2009 08:43:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904010840500.12916@localhost.localdomain>
References: <49CCFBCA.6050702@gareus.org> <49CD03AA.4030000@novell.com> <49CD0BC1.6090305@gareus.org> <alpine.LFD.2.00.0903281536420.3397@localhost.localdomain> <49CE48FD.5040506@gareus.org> <49D0CC64.5010605@gareus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org
To: Robin Gareus <robin@gareus.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:33761 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbZDAGnT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Apr 2009 02:43:19 -0400
In-Reply-To: <49D0CC64.5010605@gareus.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 30 Mar 2009, Robin Gareus wrote:

> Robin Gareus wrote:
> 
> > The corresponding .config is available at
> > http://rg42.org/_media/wiki/kernel/config-2.6.29-rt1.txt
> 
> BTW. This is a vanilla 2.6.29 with only the 2.6.29-rt1 patch applied.
> 
> > I just tested Fernando's CCRMA 2.6.29-rt1 kernel which is x686 plus
> > generic x86-compat (mine is MCORE2) and irqbalance does not produce an
> > OOPS there.

Ah, so there is some delta in the .configs which exposes this
problem. I got your .config and try to reproduce.

> > I'll see if can get a dump of the OOPS on Monday using netconsole.
> 
> If the netconsole module is loaded, the OOPS is produced without the
> Call and Stack Trace (both on local terminal and remote) and the cause
> is no longer the keyboard-interrupt but ethernet (IRQ 28)
> 
> Starting `irqbalance` still reliably hangs this system (Thinkpad X60s).
>
>
> ------------[ cut here ]------------
> kernel BUG at kernel/sched_rt.c:1602!
> invalid opcode: 0000 [#1] PREEMPT SMP kernel BUG at kernel/sched_rt.c:1602!

Unfortunately this does not tell us much. It tells us that something
went wrong, but not where and when :)

Thanks,

	tglx
