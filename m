From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: How to talk to DAQ Hardware?
Date: Sun, 26 Aug 2007 03:33:12 -0700
Message-ID: <1188124392.29859.29.camel@sx.thebigcorporation.com>
References: <664539.31533.qm@web36101.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Walker <dwalker@mvista.com>, linux-rt-users@vger.kernel.org,
	Greg KH <gregkh@suse.de>
To: Calin Culianu <cculianu@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:40526 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbXHZKdY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Aug 2007 06:33:24 -0400
In-Reply-To: <664539.31533.qm@web36101.mail.mud.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2007-08-25 at 12:49 -0700, Calin Culianu wrote: 
> --- Daniel Walker <dwalker@mvista.com> wrote:
> 
> > On Sat, 2007-08-25 at 08:45 -0700, Calin Culianu wrote:
> > > Hi,
> > > 
> > > 
> > > I'm coming from the RTAI and RTLinux world and I just learned about the
> > great
> > > strides you guys have made in hard RT.  Anyway, I was wondering --
> > currently
> > > how would one go about talking to DAQ hardware using the RT_PREEMPT
> > patch(es)?
> > > Will this "just work" with COMEDI?  What happens when a userspace hard rt
> > app
> > > calls into a kernel device driver in the simple case of an inb() or outb()
> > > instruction?
> > 
> > PREEMPT_RT doesn't change the way that users call into drivers .. The
> > users perspective of things is just same as regular linux .. 
> > 
> > Daniel
> > 
> > 
> 
> Cool!  That's what I figured but I wanted to double-check.
> 
> Now, there is no way to raise the priority of particular driver's ISRs is
> there?  So that a specific ISR can preempt anything including a hard realtime
> process?
> 

there is chrt

(I had started to compose this earlier, so I defer to Greg H's comments
on the low level stuff.) - just a few add-ons below:

> I know in the shared IRQ situation it would introduce lots of jitter but having
> really high priority interrupts would be nice.  Is that possible?
> 

I looked at that problem with some folks before. 

The current RT IRQ model masks the IRQ until the thread corresponding to
the top-level handler (HARDIRQ) processes it.
For shared IRQs, that means there can be quite some jitter when one
thread is handling a shared IRQ on a certain priority level, and it gets
preempted by another thread at a higher prio - all before the shared IRQ
you are interested in runs.

Its possible to configure an IRQ handler to run in IRQ space, so it
vectores and runs in the "classical" IRQ paradigm. In a shared IRQ
model, however, where you have a shared IRQ in thread-space, and another
IRQ in IRQ context, things get messy...

Currently, internal priorities on shared irqs are not supported. 
To make this work, not only the shared-IRQ code must be modified to add
prio awareness, but also in many cases, the driver model falls short.

We were looking at a shared device similar to your DAQ's requirements,
but - the BIOS was stuffing a USB device in there (on the same SH_IRQ),
and on different revisions, there were other subsystems, ACPI, IIRC,
amongst others.

The workaround required adding a layer to the USB/ACPI layer, that would
allow you to clear the IRQ assert on the respective chip-set, so that it
would be possible to receive, and process a concurrently asserted high
prio interrupt on the same IRQ line (the DAQ), without constantly
re-entering the USB/ACPI vector while the IRQ was being asserted...

(because just masking the IRQ would block the DAQ from being processed
until some arbitrary IRQ handler runs - e.g. USB)

Essentially, the workaround required a 3-tiered driver model, where tier
1 ack-s the IRQ and triages the chipset to "shut up". 
Tier 2 handles the classic IRQ top-level, either in thread context, or
in IRQ context 
- and tier 3 is the "bottom half".

This doesn't translate well to a general IRQ model for all devices,
isn't supported in the general Linux driver model at this time, and
creates a lot of complexity to debug.

But it can be done, and if you can avoid the shared IRQ stuff, and can
get a dedicated IRQ in IRQ-space for your DAQ, you will see performance
similar to any sub-kernel. 

Happy hacking.


Sven

> Anyway thanks for answering my question -- this basically means I can
> throw
> away rtlinux and use the latest 2.6 kernels with the RT_PREEMPT
> patches!  :)
> 

Enjoy.

Sven


-- 
Sven-Thorsten Dietrich
+1 415 694-2930
( www.novell.com/linux )
