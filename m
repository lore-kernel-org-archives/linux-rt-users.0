From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Tue, 23 Oct 2012 08:52:39 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210230850450.2756@ionos>
References: <alpine.LFD.2.02.1210202133470.2719@ionos> <op.wmk8f6m96426ze@localhost.localdomain> <alpine.LFD.2.02.1210222029480.2756@ionos> <op.wmll6ue46426ze@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41500 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab2JWGwl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2012 02:52:41 -0400
In-Reply-To: <op.wmll6ue46426ze@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 22 Oct 2012, Uwaysi Bin Kareem wrote:

> On Mon, 22 Oct 2012 20:33:25 +0200, Thomas Gleixner <tglx@linutronix.de>
> wrote:
> 
> > On Mon, 22 Oct 2012, Uwaysi Bin Kareem wrote:
> > 
> > > I tried it. Just low-latency desktop, seems slighty of less jitter, than
> > > mainline.
> > > Unfortunately the problem of threadedirqs continue, they never worked on
> > > my
> > > machine.
> > 
> > What does not work?
> > 
> 
> When enabling threaded irqs in mainline kernel, booting does not proceed, but
> stops quite soon after a few messages, and drops to shell.

If it drops to a shell, then it's way up in user space already. Can
you provide the full dmesg output or the bootlog captured via serial
console for such a case? It looks like one of your devices is not too
happy with the forced irq threading.

Thanks,

	tglx


