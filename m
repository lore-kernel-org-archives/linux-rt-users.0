From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: I/O operations priority in RTOS
Date: Mon, 6 Jun 2011 00:29:55 +0200
Message-ID: <20110605222954.GA13340@opentech.at>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at> <4DEB427F.9020104@steinhoff.de> <20110605092854.GA7576@opentech.at> <4DEB5015.7070601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Armin Steinhoff <armin@steinhoff.de>,
	Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:35167 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756333Ab1FEW34 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Jun 2011 18:29:56 -0400
Content-Disposition: inline
In-Reply-To: <4DEB5015.7070601@web.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 05 Jun 2011, Jan Kiszka wrote:

> On 2011-06-05 11:28, Nicholas Mc Guire wrote:
> > On Sun, 05 Jun 2011, Armin Steinhoff wrote:
> > 
> >> Nicholas Mc Guire wrote:
> >>> On Sat, 04 Jun 2011, Monica Puig-Pey wrote:
> >>>
> >>>> Hello,
> >>>> I'm studying how to develop drivers in a real time OS and how do they
> >>>> work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installed.
> >>>> I would like to know the priority when executing open(), read(), write()
> >>>> and close() operations.
> >>>> In my example the thread which is using the driver runs with 10 RTPRIO,
> >>>> but I don't know what happens in kernel context with the priority when
> >>>> running the I/O operations.
> >>>> Thank you for your help, I don't know where to learn about this.
> >>>>
> >>> []
> >>> Also when using bottom half mechanisms you need to take into account the
> >>> priority of the kernel thread that manages the defered work items, so
> >>> rt-drivers may have a different structure than normal drivers.
> >>
> >> That's the reason why I prefer UIO based user space drivers !
> >>
> > ...and how to resolve DMA ? if DMA were resolved cleanly I would agree.
> 
> Regarding that limitation, there is some hope: "next-generation" UIO is
> called VFIO. Useful for exclusively assigning virtual PCI functions of
> network adapters etc. to user space stacks or hypervisors like QEMU/KVM
> (for device pass-through). But it's not mainline yet. And it obviously
> requires an IOMMU.
> 
> But the key point remains: "exclusively". Anything else cannot be
> modeled efficiently via UIO or VFIO.
> 
for many RT apps that is an acceptable limit - in fact sometimes a requirement - having dynamic access and handling this at runtime is not necessarily an advantage for rt. Giving guarantees on timing for non-exclusive access in the general case would probably need to be based on a priority access model any way (i.e. running non-RT network traffic on a RT-link as "rt-idle" bandwidth usage - but full shared access at runtime would be very hard, if not impossible, to model at the device interface level without breaking RT properties. So I think its legitimate to keep it out of the device all together and let the user apps have a non-rt fight about access...

Any pointers to VFIO ?

hofrat

