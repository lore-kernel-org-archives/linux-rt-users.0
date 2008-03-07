From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: try_module_get and friends
Date: Fri, 7 Mar 2008 08:16:55 -0800
Message-ID: <20080307161655.GB9033@linux.vnet.ibm.com>
References: <1204608058.11912.3.camel@perihelion> <1204608506.11912.9.camel@perihelion> <1204661228.8244.15.camel@jcmlaptop> <1204745455.17630.8.camel@localhost.localdomain> <Pine.LNX.4.58.0803051442330.15217@gandalf.stny.rr.com> <y0mr6eo99vg.fsf@ton.toronto.redhat.com> <Pine.LNX.4.58.0803051551370.15882@gandalf.stny.rr.com> <1204751702.17630.27.camel@localhost.localdomain>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Frank Ch. Eigler" <fche@redhat.com>,
	Jon Masters <jonathan@jonmasters.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:57269 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbYCGQRF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Mar 2008 11:17:05 -0500
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m27GH3Do031343
	for <linux-rt-users@vger.kernel.org>; Fri, 7 Mar 2008 11:17:03 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m27GH0Si190028
	for <linux-rt-users@vger.kernel.org>; Fri, 7 Mar 2008 09:17:01 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m27GGuZk009321
	for <linux-rt-users@vger.kernel.org>; Fri, 7 Mar 2008 09:16:57 -0700
Content-Disposition: inline
In-Reply-To: <1204751702.17630.27.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 05, 2008 at 01:15:02PM -0800, Daniel Walker wrote:
> 
> On Wed, 2008-03-05 at 15:54 -0500, Steven Rostedt wrote:
> 
> > Actually, we were simply thinking of calling an rcu_lock before checking
> > the handlers, and releasing the lock when all are done. Then before doing
> > the module unload, we do a rcu_sync. Note, no interrupt handler should
> > ever do a rcu_sync.
> 
> There's already some smp synchronize inside free_irq, are you sure
> that's not already handling this for smp? For -rt we could just enable
> it for UP ..

If (desc->status & IRQ_INPROGRESS) remains true throughout the
execution of the threaded (and thus preemptible) interrupt handler,
then the synchronize_irq() should do the trick.

							Thanx, Paul
