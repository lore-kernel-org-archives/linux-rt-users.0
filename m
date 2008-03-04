From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: try_module_get and friends
Date: Tue, 04 Mar 2008 15:07:08 -0500
Message-ID: <1204661228.8244.15.camel@jcmlaptop>
References: <1204608058.11912.3.camel@perihelion>
	 <1204608506.11912.9.camel@perihelion>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from panic.printk.net ([217.147.83.20]:59699 "EHLO panic.printk.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761675AbYCDUjD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Mar 2008 15:39:03 -0500
In-Reply-To: <1204608506.11912.9.camel@perihelion>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2008-03-04 at 00:28 -0500, Jon Masters wrote:
> On Tue, 2008-03-04 at 00:20 -0500, Jon Masters wrote:
> 
> > So, what's protecting the RT kernel from falling over if a CPU frequency
> > governor module is removed at the wrong moment?
> 
> That's a contrived example, it does the right thing in the ones I've
> looked it, but it just occurred to me that this might not be general for
> kernel code where random pointers to modules are getting thrown around.

I recommend not setting CONFIG_MODULE_UNLOAD on RT kernels for now. I
looked at programmatically implementing this in Kconfig, but it seems
that CONFIG_MODULE_UNLOAD is never explicitly set anywhere, it's simply
in the deconfig for each architecture - anyone know Kconfig well enough
to tell us how to fix up Kconfig.preempt to do the right thing?

Jon.


