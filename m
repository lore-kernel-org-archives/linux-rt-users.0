From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Re: Setting the priority of an IRQ thread
Date: Tue, 16 Jun 2009 23:09:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0906162232100.21049@goblin.caltech.edu>
References: <loom.20090615T222836-377@post.gmane.org>
 <000001c9ee36$218cf3a0$a852c70a@dlh.st.com> <loom.20090616T074347-549@post.gmane.org>
 <20090616182734.GD13048@pengutronix.de> <loom.20090616T215133-122@post.gmane.org>
 <alpine.LFD.2.00.0906170706220.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from phobos.caltech.edu ([131.215.193.100]:54221 "EHLO
	phobos.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbZFQGKK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 02:10:10 -0400
In-Reply-To: <alpine.LFD.2.00.0906170706220.2800@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 17 Jun 2009, Thomas Gleixner wrote:
>> It seems much more friendly and efficient for my driver to provide
>> applications with an ioctl that tells it to set the priority of its
>> IRQ thread.
>
> Wrong. That information is already available in sysfs and there is no
> reason to use an ioctl for that.

Could you point out where please? Searching sysfs I see the following
two files that contain the IRQ numbers of two of the boards that my
driver handles:

  /bus/pci/drivers/accpcidio/0000:03:02.0/irq
  /bus/pci/drivers/accpcidio/0000:03:03.0/irq

However, I don't see how a user application could figure out which of
these corresponded to the board that it opened using a particular
device file. Only the device driver knows which device file is
associated with a given PCI device ID, and that isn't recorded in
sysfs.

>> Note that none of this would be necessary if the IRQ thread of a
>> device automatically inherited the priority of the highest priority
>> realtime thread that has requested (and not yet free'd) its IRQ. Not
>> doing so, leads to a form of priority inversion.
>
> Eek. That's even more wrong. Why should the priority of a user task
> influence the priority of a device driver irq thread ? That's a
> question of policy and policies are set from user space. The kernel
> merily provides the interfaces.

Agreed. I didn't think this through properly.

> Also why do you claim that the user task requests/frees the drivers
> irq ? That depends on the driver, i.e. if it is implemented to request
> the irq on open(), and can not be generalized.

I was just saying that it is common for device drivers not to request
IRQs until a user application calls their open methods, and that in
such cases only the application and the driver know when is the right
time to search for the newly created IRQ thread. An external script
whose job it was to start the realtime program, and set the priorities
of associated IRQs, would have a hard time doing this reliably.

Martin
