From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Tue, 8 Sep 2015 12:59:34 -0400
Message-ID: <20150908125934.7b60fca7@gandalf.local.home>
References: <20150904011900.730816481@goodmis.org>
	<alpine.DEB.2.11.1509051217330.15006@nanos>
	<20150905120457.GA21338@gmail.com>
	<alpine.DEB.2.11.1509070959440.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1509070959440.15006@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 7 Sep 2015 10:35:25 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> > i.e. I'm not sure the problem is properly specified.
> 
> Right. I omitted some essential information.
> 
>        lock(y->lock);
>        x = y->x;
>        if (!try_lock(x->lock))
> 		....
> 
> Once we drop x->lock, y->x can change. That's why the retry is there.

You mean once we drop y->lock, y->x can change.


> 
> Now on RT the trylock loop can obviously lead to a live lock if the
> try locker preempted the holder of x->lock.
> 
> What Steve is trying to do is to boost the holder of x->lock (task A)
> without actually queueing the task (task B) on the lock wait queue of
> x->lock. To get out of the try-lock loop he calls sched_yield() from
> task B.
> 
> While this works by some definition of works, I really do not like the
> semantical obscurity of this approach.
> 
> 1) The boosting is not related to anything.
> 
>    If the priority of taskB changes then nothing changes the boosting
>    of taskA.
> 
> 2) The boosting stops
> 
> 3) sched_yield() makes me shudder
> 
>    CPU0			CPU1	
> 
>    taskA
>      lock(x->lock)
> 
>    preemption
>    taskC
> 			taskB
> 			  lock(y->lock);
> 			  x = y->x;
> 			  if (!try_lock(x->lock)) {
> 			    unlock(y->lock);
> 			    boost(taskA);
> 			    sched_yield();  <- returns immediately
> 			    
>    So, if taskC has higher priority than taskB and therefor than
>    taskA, taskB will do the lock/trylock/unlock/boost dance in
>    circles.

Yeah, I was aware of this scenario, in which case, it just shows the
nastiness of a spinning trylock. Even with the current situation, the
task is going to constantly be spinning until TaskA can run. The
difference, is that it will let other tasks run during that 1 ms sleep.
The current code works, but as you said, by some definition of works ;-)


> 
>    We can make that worse. If taskB's code looks like this:
> 
> 			  lock(y->lock);
> 			  x = y->x;
> 			  if (!try_lock(x->lock)) {
> 			    unlock(y->lock);
> 			    boost(taskA);
> 			    sched_yield();
> 			    return -EAGAIN;
> 
>   and at the callsite it decides to do something completely different
>   than retrying then taskA stays boosted.

But only till it releases the lock (or any lock). That is, it's a
bounded boost, and not a leak. A leak would have no end.

> 
> So we have already two scenarios where this clearly violates the PI
> rules and I really do not have any interest to debug leaked RT
> priorites.

It's not a leak, it's only bounded by the time it holds that lock. As
the only locks that have this characteristic are spinlock converted to
rtmutex, those should be short.

> 
> I agree with Steve, that the main case where we have this horrible
> msleep() right now - dcache - is complex, but we rather sit down and
> analyze it proper and come up with semantically well defined
> solutions.

I'm happy to have this discussion! That's what RFC patches are for ;-)

I would also be happy if we can come up with a better solution than this
proposal.

-- Steve
