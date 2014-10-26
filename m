From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: semantics of reader/writer semaphores in rt patch
Date: Sun, 26 Oct 2014 08:42:57 +0100
Message-ID: <20141026074257.GC10501@worktop.programming.kicks-ass.net>
References: <544956B8.2000406@windriver.com>
 <alpine.DEB.2.11.1410252354030.5308@nanos>
 <alpine.DEB.2.11.1410260019280.5308@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Friesen <chris.friesen@windriver.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48004 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbaJZHnG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Oct 2014 03:43:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1410260019280.5308@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Oct 26, 2014 at 12:21:31AM +0200, Thomas Gleixner wrote:
> On Sun, 26 Oct 2014, Thomas Gleixner wrote:
> > On Thu, 23 Oct 2014, Chris Friesen wrote:
> > > Does the RT kernel just disallow this sort of algorithm?
> > 
> > Yes. For a good reason. Let's add thread C
> > 
> > A    	   	B		C
> > down_read(X)
> > 				down_write(X)
> > lock(Y)
> > modify data
> > unlock(Y)
> > wake(B)
> > 		down_read(X)
> > 
> > Due to the mainline rwsem fairness semantics:
> > 
> > A holds X, C is blocked on A and B is blocked on A.
> > 
> > Deadlock, without RT and the single reader restriction being involved.
> > 
> > So RT does not violate ANY of the existing mainline semantics, it just
> > imposes a performance impact of not allowing multiple readers.
> 
> @peterz: It might be worthwhile to have a CONFIG_LOCKDEP=y dependent
> mode which restricts concurrent readers to 1 in mainline to catch this
> kind of stuff. Hmm?

There were patches by ego that fix lockdep's read side tracking. I need
to find a few spare days to look at those :/
