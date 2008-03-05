From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: try_module_get and friends
Date: Wed, 5 Mar 2008 15:54:32 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0803051551370.15882@gandalf.stny.rr.com>
References: <1204608058.11912.3.camel@perihelion> <1204608506.11912.9.camel@perihelion>
 <1204661228.8244.15.camel@jcmlaptop> <1204745455.17630.8.camel@localhost.localdomain>
 <Pine.LNX.4.58.0803051442330.15217@gandalf.stny.rr.com>
 <y0mr6eo99vg.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Walker <dwalker@mvista.com>,
	Jon Masters <jonathan@jonmasters.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: "Frank Ch. Eigler" <fche@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:61824 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508AbYCEUyf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Mar 2008 15:54:35 -0500
In-Reply-To: <y0mr6eo99vg.fsf@ton.toronto.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 5 Mar 2008, Frank Ch. Eigler wrote:
> > There's a theoretical potential for the system to crash in -rt when
> > unloading a module. Simply because interrupts are threads.
> >
> > Some device has an interrupt handler that is called and preempted.
> > At that moment the module for that device is unloaded. [...]
> > Since the code for the interrupt handler no longer exists... KABOOM!
>
> Perhaps you can identify those modules that have asked for interrupts,
> and block only them from unloading.  Or, would it be outrageously
> expensive to increment the module refcount while one of its interrupt
> handlers is running?

Actually, we were simply thinking of calling an rcu_lock before checking
the handlers, and releasing the lock when all are done. Then before doing
the module unload, we do a rcu_sync. Note, no interrupt handler should
ever do a rcu_sync.

-- Steve

