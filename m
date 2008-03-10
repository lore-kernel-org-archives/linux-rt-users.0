From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: try_module_get and friends
Date: Mon, 10 Mar 2008 01:53:48 -0400
Message-ID: <1205128428.5484.222.camel@perihelion>
References: <1204608058.11912.3.camel@perihelion>
	 <1204608506.11912.9.camel@perihelion> <1204661228.8244.15.camel@jcmlaptop>
	 <1204745455.17630.8.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0803051442330.15217@gandalf.stny.rr.com>
	 <y0mr6eo99vg.fsf@ton.toronto.redhat.com>
	 <Pine.LNX.4.58.0803051611390.15882@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Frank Ch. Eigler" <fche@redhat.com>,
	Daniel Walker <dwalker@mvista.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dallas.jonmasters.org ([72.29.103.172]:58595 "EHLO
	dallas.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbYCJFz0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Mar 2008 01:55:26 -0400
In-Reply-To: <Pine.LNX.4.58.0803051611390.15882@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 2008-03-05 at 16:14 -0500, Steven Rostedt wrote:
> On Wed, 5 Mar 2008, Frank Ch. Eigler wrote:
> > > There's a theoretical potential for the system to crash in -rt when
> > > unloading a module. Simply because interrupts are threads.
> > >
> > > Some device has an interrupt handler that is called and preempted.
> > > At that moment the module for that device is unloaded. [...]
> > > Since the code for the interrupt handler no longer exists... KABOOM!
> >
> > Perhaps you can identify those modules that have asked for interrupts,
> > and block only them from unloading.  Or, would it be outrageously
> > expensive to increment the module refcount while one of its interrupt
> > handlers is running?
> 
> Actually this whole thing is theoretical. Since the device would have to
> free the irq before unloading and interrupt desc->lock protects races like
> this. Then there is the question of softirqs and tasklets. And random
> passing of pointers. But this can also happen in mainline since tasklets
> and softirqs can run in a thread.
> 
> We need to look deeper. I'm not sure there is an issue here.

I can poke some more and look at what actually happens on module unload
(for now I think a quick test script loading/unloading modules in a loop
should show us whether this is enough of a problem in reality), but I do
want to point out that I was never concerned with interrupt handlers
themselves - only the assumptions mainline makes about "interrupt
context" use of pointers without an explicit try_module_get.

Rusty didn't have a simple answer either, so I'll poke.

Jon.


