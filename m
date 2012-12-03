From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: bugsplat 3.6.7-rt18
Date: Mon, 3 Dec 2012 05:50:23 -0800
Message-ID: <20121203135023.GD2605@linux.vnet.ibm.com>
References: <201212010050.59563.tim01@vlsi.informatik.tu-darmstadt.de>
 <50B94C0D.1010809@am.sony.com>
 <20121201015932.GP2474@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1212031051370.2701@ionos>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:41143 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010Ab2LCNub (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Dec 2012 08:50:31 -0500
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 3 Dec 2012 06:50:30 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 899FB3E40026
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Dec 2012 06:50:23 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id qB3DoOxe293850
	for <linux-rt-users@vger.kernel.org>; Mon, 3 Dec 2012 06:50:25 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id qB3DoOr5021622
	for <linux-rt-users@vger.kernel.org>; Mon, 3 Dec 2012 06:50:24 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1212031051370.2701@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Dec 03, 2012 at 10:54:02AM +0100, Thomas Gleixner wrote:
> On Fri, 30 Nov 2012, Paul E. McKenney wrote:
> > On Fri, Nov 30, 2012 at 04:15:09PM -0800, Frank Rowand wrote:
> > > >  Possible unsafe locking scenario:
> > > > 
> > > >        CPU0
> > > >        ----
> > > >   lock(rcu_kthread_wq.lock.lock.wait_lock);
> > > >   <Interrupt>
> > > >     lock(rcu_kthread_wq.lock.lock.wait_lock);
> > 
> > ???
> > 
> > These are all spin_lock_irqsave() calls, so how would the interrupt
> > happen?  Or do these need to be changed to raw_spinlock_t?
> > 
> > Hmmm...  In include/linux/wait.h, doesn't struct __wait_queue_head
> > need to have raw_spinlock_t rather than spinlock_t?  Please try that
> > change and let me know what happens.
> 
> No. We can't do that. The reason is that some wait queue wakeups have
> callbacks which can't be called with interrupts disabled on RT.
> 
> IIRC, I restructured the RCU code in 3.0-rt so it won't be affected by
> this. I'll have a look.

I guess I am once again getting out of touch with -rt...  Apologies for
the noise.

							Thanx, Paul

