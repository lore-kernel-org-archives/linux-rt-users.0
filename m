From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] e1000e: Add delays after writing to registers
Date: Fri, 6 Nov 2015 12:08:10 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511060929430.4032@nanos>
References: <1445465268-10347-1-git-send-email-jonathan.david@ni.com> <20151022055909.GA7263@icarus.home.austad.us> <5638F239.1030804@ni.com> <20151103194246.GA19824@sisyphus.home.austad.us> <563930CF.9090800@ni.com>
 <20151106055349.GA10665@icarus.home.austad.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan David <jonathan.david@ni.com>,
	linux-rt-users@vger.kernel.org, josh.cartwright@ni.com
To: Henrik Austad <henrik@austad.us>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59327 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031997AbbKFLIy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Nov 2015 06:08:54 -0500
In-Reply-To: <20151106055349.GA10665@icarus.home.austad.us>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 6 Nov 2015, Henrik Austad wrote:
> On Tue, Nov 03, 2015 at 04:10:23PM -0600, Jonathan David wrote:
> > On 11/03/2015 01:42 PM, Henrik Austad wrote:
> > >On Tue, Nov 03, 2015 at 11:43:21AM -0600, Jonathan David wrote:
> > >>On 10/22/2015 12:59 AM, Henrik Austad wrote:
> > 
> > >>>>Adding a delay after long series of writes gives them time to
> > >>>>complete, and for higher priority tasks to run unimpeded.
> > >>>
> > >>>Aren't we running with threaded interrupts?
> > >>>
> > >>>What happens to the thread(s) pushing data to the network?
> > >>>What about xmit-buffer once it is full? Which thread will block on send or
> > >>>have its sk_buff dropped?
> > >>
> > >>All of this is totally irrelevant to the problem we are seeing.
> > >
> > >If this is irrelevant, why hack at the network-driver, hmm?
> > 
> > It is relevant to the network driver, as this is where the symptoms were
> > discovered; however, it has no relation to the packet delivery path. This is
> > related purely to link configuration.
> 
> I was under the impression that a PCI link configuration/training was down 
> to speed etc, not how many MMIO read/writes it could do. Then again, a lot 
> of this stuff is pure (black) magic.

This is not about PCI link training. Jonathan is talking about the
network link configuration.

> > >>The issue is with PCI where issuing a large number of MMIO writes
> > >>followed by a read (to force said writes to execute) will stall the CPU.
> > >>When the CPU is stalled, no interrupts are serviced, including the local
> > >>apic timer interrupt, which was responsible for waking up cyclictest.
> > >>This behavior was observed within traces gathered from cyclictest with
> > >>ftrace enabled.
> > >
> > >So you get bogged down with interrupts disabled;
> > 
> > No, interrupts are entirely enabled while the PCI MMIO writes/read are
> > issued; but the local apic timer still arrives late, presumably because the
> > CPU is waiting to complete whatever writes remain in the buffer.
> 
> Heh, strange, is the interrupt signal itself delivered late as well, or 
> just the handling of it?

The CPU stalls on the IO read, so the interrupt cannot be handled by
the CPU until that stall is resolved. The timer fires correctly.

The problem here is that even if the I/O memory of the network device
is mapped uncached, the PCI bus itself is allowed to buffer and do
write combining. That's done to overcome the bottleneck of waiting for
each single write transaction to complete.

The PCI bus guarantees that the writes are not reordered versus a
read. That's why drivers use a read after a series of writes to make
sure that the writes have reached the device and are not longer in the
PCI buffer queue.

Now that read after a sequence of writes has the effect that the CPU
has to wait for the writes to be finished before the read can take
place. During that time the CPU just sits there and twiddles
thumbs. It's a full stall.

Now my question is how big is the induced latency.

Thanks,

	tglx
