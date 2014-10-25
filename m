From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: semantics of reader/writer semaphores in rt patch
Date: Sun, 26 Oct 2014 00:21:31 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1410260019280.5308@nanos>
References: <544956B8.2000406@windriver.com> <alpine.DEB.2.11.1410252354030.5308@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Chris Friesen <chris.friesen@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1410252354030.5308@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 26 Oct 2014, Thomas Gleixner wrote:
> On Thu, 23 Oct 2014, Chris Friesen wrote:
> > Does the RT kernel just disallow this sort of algorithm?
> 
> Yes. For a good reason. Let's add thread C
> 
> A    	   	B		C
> down_read(X)
> 				down_write(X)
> lock(Y)
> modify data
> unlock(Y)
> wake(B)
> 		down_read(X)
> 
> Due to the mainline rwsem fairness semantics:
> 
> A holds X, C is blocked on A and B is blocked on A.
> 
> Deadlock, without RT and the single reader restriction being involved.
> 
> So RT does not violate ANY of the existing mainline semantics, it just
> imposes a performance impact of not allowing multiple readers.

@peterz: It might be worthwhile to have a CONFIG_LOCKDEP=y dependent
mode which restricts concurrent readers to 1 in mainline to catch this
kind of stuff. Hmm?

Thanks,

	tglx
