From: Daniel Walker <dwalker@mvista.com>
Subject: Re: try_module_get and friends
Date: Wed, 05 Mar 2008 11:30:55 -0800
Message-ID: <1204745455.17630.8.camel@localhost.localdomain>
References: <1204608058.11912.3.camel@perihelion>
	 <1204608506.11912.9.camel@perihelion>  <1204661228.8244.15.camel@jcmlaptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Jon Masters <jonathan@jonmasters.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:9406 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762051AbYCETa5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Mar 2008 14:30:57 -0500
In-Reply-To: <1204661228.8244.15.camel@jcmlaptop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 2008-03-04 at 15:07 -0500, Jon Masters wrote:
> On Tue, 2008-03-04 at 00:28 -0500, Jon Masters wrote:
> > On Tue, 2008-03-04 at 00:20 -0500, Jon Masters wrote:
> > 
> > > So, what's protecting the RT kernel from falling over if a CPU frequency
> > > governor module is removed at the wrong moment?
> > 
> > That's a contrived example, it does the right thing in the ones I've
> > looked it, but it just occurred to me that this might not be general for
> > kernel code where random pointers to modules are getting thrown around.
> 
> I recommend not setting CONFIG_MODULE_UNLOAD on RT kernels for now. I
> looked at programmatically implementing this in Kconfig, but it seems
> that CONFIG_MODULE_UNLOAD is never explicitly set anywhere, it's simply
> in the deconfig for each architecture - anyone know Kconfig well enough
> to tell us how to fix up Kconfig.preempt to do the right thing?

Could you give a different of better example of the problem with
modules? This thread has been fairly scant on details ..

Daniel

