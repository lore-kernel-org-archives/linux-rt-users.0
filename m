From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: catching interrupts
Date: Wed, 13 Jun 2007 10:43:54 +0200
Message-ID: <1181724234.8176.260.camel@chaos>
References: <1181679431.4904.2.camel@localhost.localdomain>
	 <466F3484.3000202@l1nuxh4ck3r.de>
	 <1181721505.5703.7.camel@localhost.localdomain>
	 <1181722808.8176.255.camel@chaos>
	 <1181723468.5703.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>, linux-rt-users@vger.kernel.org
To: Peter Feuerer <peter@piie.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:49315 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753459AbXFMIn4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jun 2007 04:43:56 -0400
In-Reply-To: <1181723468.5703.17.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-06-13 at 10:31 +0200, Peter Feuerer wrote:
> > > Great, seems like that's what I'm searching for. I will have a deeper
> > > look into this. Because if this is going to be in the mainline kernel, I
> > > don't have to touch the kernel at all.
> > 
> > You have to touch it. You still need to write a kernel module which
> > handles the interrupt in the first place.
> > 
> 
> But wouldn't it be a good idea to create a kernel driver which offers an
> abstract interface and add it to the mainline kernel or to the preempt
> patch? So that handling interrupts can really just happen by coding a
> userspace program?
> Or is there no way to accomplish that? Sorry if this questions may sound
> stupid, I'm not that deep in the code,.. yet.

No. This can not work. The kernel side must be able to mask the device
interrupt before invoking the user space handler. Otherwise it would not
work with shared interrupts. Also the kernel needs control to shut down
the device interrupt in case that the user space driver is broken, not
running or whatever. Please read the UIO documentation, it explains this
in detail.

	tglx


	
