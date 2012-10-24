From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Wed, 24 Oct 2012 11:59:38 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210241156380.2756@ionos>
References: <alpine.LFD.2.02.1210202133470.2719@ionos> <op.wmk8f6m96426ze@localhost.localdomain> <alpine.LFD.2.02.1210222029480.2756@ionos> <op.wmnlvqm76426ze@localhost.localdomain> <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
 <op.wmobxtv66426ze@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	linux-rt-users@vger.kernel.org
To: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49893 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756847Ab2JXJ7o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2012 05:59:44 -0400
In-Reply-To: <op.wmobxtv66426ze@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Oct 2012, Uwaysi Bin Kareem wrote:
> On Wed, 24 Oct 2012 07:01:54 +0200, Sven-Thorsten Dietrich
> <sven@thebigcorporation.com> wrote:
> 
> > 
> > On Oct 23, 2012, at 3:53 PM, Uwaysi Bin Kareem
> > <uwaysi.bin.kareem@paradoxuncreated.com> wrote:
> > 
> > > I think it complains about not finding rootdevice. Anyway, I am getting a
> > > new machine, so it might not be much of an issue. If you still want to try
> > > and find the bug let me know. Also how do I compile without threadirqs, if
> > > I enable basic-rt, threadirqs are enabled in .config also.
> > 
> > rootdevice issues are most likely drivers/initrd related. Does your .config
> > match a working Kernel's .config?
> 
> Yes, it works fine without basic-rt, or full-rt. Do you know if basic-rt can
> be compiled without threadirqs?

No. And that's not interesting at all. We really want to know what's
going wrong when you have irq threading enabled.

You can also try the following. Compile the kernel without RT and add
"threadirqs" on the kernel command line. So that's just mainline + irq
threading. Does that work?

In any case it would be helpful if you provide the full dmesg output
of a failing boot.

Thanks,

	tglx

