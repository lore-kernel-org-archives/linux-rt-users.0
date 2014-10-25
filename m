From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: semantics of reader/writer semaphores in rt patch
Date: Sun, 26 Oct 2014 00:19:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1410252354030.5308@nanos>
References: <544956B8.2000406@windriver.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Chris Friesen <chris.friesen@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <544956B8.2000406@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 23 Oct 2014, Chris Friesen wrote:

> I recently noticed that when CONFIG_PREEMPT_RT_FULL is enabled we the
> semantics change.  From "include/linux/rwsem_rt.h":
> 
>  * Note that the semantics are different from the usual
>  * Linux rw-sems, in PREEMPT_RT mode we do not allow
>  * multiple readers to hold the lock at once, we only allow
>  * a read-lock owner to read-lock recursively. This is
>  * better for latency, makes the implementation inherently
>  * fair and makes it simpler as well.
> 
> How is this valid?  It seems to me that there are any number of code paths
> that could depend on having multiple threads of execution be able to hold the
> reader lock simultaneously.  Something as simple as:
> 
> thread A:
> take rw_semaphore X for reading
> take lock Y, modify data, release lock Y
> wake up thread B
> wait on conditional protected by lock Y
> free rw_semaphore X
> 
> thread B:
> take rw_semaphore X for reading
> wait on conditional protected by lock Y
> send message to wake up thread A
> free rw_semaphore X

I don't see why B should wake A without changing the conditional. A
won't make progress by being woken by B as the conditional does not
magically change just because B wakes A.

So what you wanted to say is:

  thread B:
  take rw_semaphore X for reading
  wait on conditional protected by lock Y
+ take lock Y, modify data, release lock Y
  send message to wake up thread A
  free rw_semaphore X

Otherwise your example does not make any sense at all. And that has
some serious non RT related implications.

> In the regular kernel this would work, in the RT kernel it would deadlock.

Works by some definition of 'works'
 
> Does the RT kernel just disallow this sort of algorithm?

Yes. For a good reason. Let's add thread C

A    	   	B		C
down_read(X)
				down_write(X)
lock(Y)
modify data
unlock(Y)
wake(B)
		down_read(X)

Due to the mainline rwsem fairness semantics:

A holds X, C is blocked on A and B is blocked on A.

Deadlock, without RT and the single reader restriction being involved.

So RT does not violate ANY of the existing mainline semantics, it just
imposes a performance impact of not allowing multiple readers.

Aside of that it provides as usual the free of charge service to
expose mainline bugs faster.

Yes, it's valid and not that simple as you might think.

Thanks,

	tglx
