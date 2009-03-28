From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.29-rt1+ irqbalance = OOPS
Date: Sat, 28 Mar 2009 15:37:24 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903281536420.3397@localhost.localdomain>
References: <49CCFBCA.6050702@gareus.org> <49CD03AA.4030000@novell.com> <49CD0BC1.6090305@gareus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org
To: Robin Gareus <robin@gareus.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:39767 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791AbZC1Ohe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 28 Mar 2009 10:37:34 -0400
In-Reply-To: <49CD0BC1.6090305@gareus.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 27 Mar 2009, Robin Gareus wrote:
> Gregory Haskins wrote:
> > Robin Gareus wrote:
> >> Hello,
> >>
> >> Starting the irqbalance daemon ( http://www.irqbalance.org/ ) on
> >> 2.6.29-rt1 causes the system to OOPS and freeze. irqbalance works fine
> >> with previous realtime kernels (2.6.24.7-rt27).
> >>
> >> The OOPS seems to be caused by the PID of the [timer] IRQ-1
> > This in of itself might be part of the problem.  I didn't think the
> > timer was supposed to be threaded.  Thomas?
> 
> OOPS ;) my bad. IRQ-0 is the timer and it's indeed not threaded.
> 
> IRQ-1 is i8042
> 
> The OOPS can be triggered by launching irqbalance. pressing any key.
> For whatever reason the OOPS also takes place after a random amount of
> time without pressing any key..

Hmm. Works fine here. Can you please provide the output of

# cat /proc/interrupts

Thanks,

	tglx
