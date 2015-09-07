From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Mon, 7 Sep 2015 10:35:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509070959440.15006@nanos>
References: <20150904011900.730816481@goodmis.org> <alpine.DEB.2.11.1509051217330.15006@nanos> <20150905120457.GA21338@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34842 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbbIGIgJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Sep 2015 04:36:09 -0400
In-Reply-To: <20150905120457.GA21338@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 5 Sep 2015, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > So the problem we need to solve is:
> > 
> > retry:
> > 	lock(B);
> > 	if (!try_lock(A)) {
> > 		unlock(B);
> > 		cpu_relax();
> > 		goto retry;
> > 	}
> > 
> > So instead of doing that proposed magic boost, we can do something
> > more straight forward:
> > 
> > retry:
> > 	lock(B);
> > 	if (!try_lock(A)) {
> > 		lock_and_drop(A, B);
> > 		unlock(A);
> > 		goto retry;
> > 	}
> > 
> > lock_and_drop() queues the task as a waiter on A, drops B and then
> > does the PI adjustment on A. 
> > 
> > Thoughts?
> 
> So why not do:
> 
> 	lock(B);
> 	if (!trylock(A)) {
> 		unlock(B);
> 		lock(A);
> 		lock(B);
> 	}
> 
> ?
> 
> Or, if this can be done, why didn't we do:
> 
> 	lock(A);
> 	lock(B);
> 
> to begin with?
> 
> i.e. I'm not sure the problem is properly specified.

Right. I omitted some essential information.

       lock(y->lock);
       x = y->x;
       if (!try_lock(x->lock))
		....

Once we drop x->lock, y->x can change. That's why the retry is there.

Now on RT the trylock loop can obviously lead to a live lock if the
try locker preempted the holder of x->lock.

What Steve is trying to do is to boost the holder of x->lock (task A)
without actually queueing the task (task B) on the lock wait queue of
x->lock. To get out of the try-lock loop he calls sched_yield() from
task B.

While this works by some definition of works, I really do not like the
semantical obscurity of this approach.

1) The boosting is not related to anything.

   If the priority of taskB changes then nothing changes the boosting
   of taskA.

2) The boosting stops

3) sched_yield() makes me shudder

   CPU0			CPU1	

   taskA
     lock(x->lock)

   preemption
   taskC
			taskB
			  lock(y->lock);
			  x = y->x;
			  if (!try_lock(x->lock)) {
			    unlock(y->lock);
			    boost(taskA);
			    sched_yield();  <- returns immediately
			    
   So, if taskC has higher priority than taskB and therefor than
   taskA, taskB will do the lock/trylock/unlock/boost dance in
   circles.

   We can make that worse. If taskB's code looks like this:

			  lock(y->lock);
			  x = y->x;
			  if (!try_lock(x->lock)) {
			    unlock(y->lock);
			    boost(taskA);
			    sched_yield();
			    return -EAGAIN;

  and at the callsite it decides to do something completely different
  than retrying then taskA stays boosted.

So we have already two scenarios where this clearly violates the PI
rules and I really do not have any interest to debug leaked RT
priorites.

I agree with Steve, that the main case where we have this horrible
msleep() right now - dcache - is complex, but we rather sit down and
analyze it proper and come up with semantically well defined
solutions.

Thanks,

	tglx






