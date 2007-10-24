From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: How to debug complete kernel lock-ups
Date: Wed, 24 Oct 2007 09:19:13 -0700
Message-ID: <2c0942db0710240919x26f0803arae3776cac7add8fa@mail.gmail.com>
References: <471E1D3A.8000705@free.fr> <471F0DB4.1080709@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz
To: "John Sigler" <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:12302 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbXJXQTQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2007 12:19:16 -0400
Received: by ug-out-1314.google.com with SMTP id z38so350903ugc
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Oct 2007 09:19:14 -0700 (PDT)
In-Reply-To: <471F0DB4.1080709@free.fr>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 10/24/07, John Sigler <linux.kernel@free.fr> wrote:
> > I have an x86 system with two PCI slots, in which I inserted two
> > specialized output cards (Dektec DTA-105).
> >
> > http://www.dektec.com/Products/DTA-105/
> > (They provide an open source driver.)
> >
> > My problem is: when I write to the 4 ports (each card has 2 ports) "at
> > the same time" (not really "at the same time" because I have a
> > uni-processor system, so "within a short time frame" is more accurate)
> > the system *completely* locks up.
> >
> > The manufacturer told me they had seen the problem in their lab. I'm
> > just trying to provide some helpful debug output to speed up the process
> > of fixing the problem :-)
[...]
> > Suppose the PCI bus "crashes" (whatever that means) or locks up.
> > Would that make the system completely unresponsive? The I/O does have to
> > get to/from the south bridge, through the PCI bus AFAIU. I can imagine
> > that a locked PCI bus would be slightly problematic.
> >
> > Does this mean I need some kind of PCI bus analyzer (i.e. hardware) at
> > this point? Is there anything more I can try?

You need visibility into the actual place where the issue is
happening, and by your description it's the two cards fighting each
other on the PCI bus. (I'm assuming that the problem doesn't occur
when there's only one card.)

I've worked on a platform where only a few things went through the PCI
bus, and via the firmware's debugger (completely outside the kernel),
I was able to do the setup of the PCI chip and mappings, and then
pound on the hardware directly to exhibit a lockup of the bus. That
provided pretty strong proof that it wasn't some other unrelated issue
in the kernel causing us grief.

At that point, it was pretty clear that was it, as there was no kernel
running, and the CPU was still responsive. Renting a logic analyzer
was the next step.

> How do driver writers deal with complete kernel hangs?

Lots of sleeps in between each and every write to the hardware, with
regular output. Of course, if it's a timing issue (which is what it
sounds like), you're screwed.

Other than that, I look at the hardware guys and say "Your turn," and
walk out of the room to get a cup of coffee.

Ray
