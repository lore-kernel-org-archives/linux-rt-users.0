From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 11:00:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906171058330.2800@localhost.localdomain>
References: <loom.20090615T222836-377@post.gmane.org> <000001c9ee36$218cf3a0$a852c70a@dlh.st.com> <loom.20090616T074347-549@post.gmane.org> <20090616182734.GD13048@pengutronix.de> <loom.20090616T215133-122@post.gmane.org> <alpine.LFD.2.00.0906170706220.2800@localhost.localdomain>
 <Pine.LNX.4.64.0906162232100.21049@goblin.caltech.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Martin Shepherd <mcs@astro.caltech.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:50033 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293AbZFQJBD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 05:01:03 -0400
In-Reply-To: <Pine.LNX.4.64.0906162232100.21049@goblin.caltech.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 16 Jun 2009, Martin Shepherd wrote:
> On Wed, 17 Jun 2009, Thomas Gleixner wrote:
> > > It seems much more friendly and efficient for my driver to provide
> > > applications with an ioctl that tells it to set the priority of its
> > > IRQ thread.
> > 
> > Wrong. That information is already available in sysfs and there is no
> > reason to use an ioctl for that.
> 
> Could you point out where please? Searching sysfs I see the following
> two files that contain the IRQ numbers of two of the boards that my
> driver handles:
> 
>  /bus/pci/drivers/accpcidio/0000:03:02.0/irq
>  /bus/pci/drivers/accpcidio/0000:03:03.0/irq
> 
> However, I don't see how a user application could figure out which of
> these corresponded to the board that it opened using a particular
> device file. Only the device driver knows which device file is
> associated with a given PCI device ID, and that isn't recorded in
> sysfs.

Errm, and how does udev figure out which device node to create for
which device ?

/sys/devices/pci0000:00/0000:00:1d.7/usb1/dev

Thanks,

	tglx
