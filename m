From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: bugsplat 3.6.7-rt18
Date: Mon, 3 Dec 2012 10:54:02 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1212031051370.2701@ionos>
References: <201212010050.59563.tim01@vlsi.informatik.tu-darmstadt.de> <50B94C0D.1010809@am.sony.com> <20121201015932.GP2474@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37434 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab2LCJyJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Dec 2012 04:54:09 -0500
In-Reply-To: <20121201015932.GP2474@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 30 Nov 2012, Paul E. McKenney wrote:
> On Fri, Nov 30, 2012 at 04:15:09PM -0800, Frank Rowand wrote:
> > >  Possible unsafe locking scenario:
> > > 
> > >        CPU0
> > >        ----
> > >   lock(rcu_kthread_wq.lock.lock.wait_lock);
> > >   <Interrupt>
> > >     lock(rcu_kthread_wq.lock.lock.wait_lock);
> 
> ???
> 
> These are all spin_lock_irqsave() calls, so how would the interrupt
> happen?  Or do these need to be changed to raw_spinlock_t?
> 
> Hmmm...  In include/linux/wait.h, doesn't struct __wait_queue_head
> need to have raw_spinlock_t rather than spinlock_t?  Please try that
> change and let me know what happens.

No. We can't do that. The reason is that some wait queue wakeups have
callbacks which can't be called with interrupts disabled on RT.

IIRC, I restructured the RCU code in 3.0-rt so it won't be affected by
this. I'll have a look.

Thanks,

	Thomas


