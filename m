From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: [PATCH [RT] 08/14] add a loop counter based timeout mechanism
Date: Fri, 22 Feb 2008 23:36:30 -0800
Message-ID: <1203752190.4772.192.camel@sven.thebigcorporation.com>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
	 <20080221152707.4804.59177.stgit@novell1.haskins.net>
	 <200802211741.10299.ak@suse.de> <20080222190814.GD11213@linux.vnet.ibm.com>
	 <9810cff90802221119j23818e74g2721512a693a0a01@mail.gmail.com>
	 <9810cff90802221121s216f69f4k4a5f39eaaf11dd7f@mail.gmail.com>
	 <20080222194341.GE11213@linux.vnet.ibm.com>
	 <1203710145.4772.107.camel@sven.thebigcorporation.com>
	 <1203712566.4147.56.camel@hermosa.morrealenet>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: paulmck@linux.vnet.ibm.com,
	"Bill Huey (hui)" <bill.huey@gmail.com>, Andi Kleen <ak@suse.de>,
	Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	a.p.zijlstra@chello.nl, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	gregkh@suse.de, mkohari@novell.com
To: "Peter W. Morreale" <pmorreale@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:49107 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754168AbYBWHhK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Feb 2008 02:37:10 -0500
In-Reply-To: <1203712566.4147.56.camel@hermosa.morrealenet>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Fri, 2008-02-22 at 13:36 -0700, Peter W. Morreale wrote:
> On Fri, 2008-02-22 at 11:55 -0800, Sven-Thorsten Dietrich wrote:
> > 
> > In high-contention, short-hold time situations, it may even make sense
> > to have multiple CPUs with multiple waiters spinning, depending on
> > hold-time vs. time to put a waiter to sleep and wake them up.
> > 
> > The wake-up side could also walk ahead on the queue, and bring up
> > spinners from sleeping, so that they are all ready to go when the lock
> > flips green for them.
> > 
> 
> I did try an attempt at this one time.  The logic was merely if the
> pending owner was running, wakeup the next waiter.  The results were
> terrible for the benchmarks used, as compared to the current
> implementation. 

Yup, but you cut the CONTEXT where I said:

"for very large SMP systems"

Specifically, what I mean, is an SMP system, where I have enough CPUs to
do this:

let (t_Tcs) be the time to lock, transition and unlock an un-contended
critical section (i.e. the one that I am the pending waiter for).

let (t_W) be the time to wake up a sleeping task.

and let (t_W > t_Tcs)

Then, "for very large SMP systems"

if 

S = (t_W / t_Tcs), 

then S designates the number of tasks to transition a critical section
before the first sleeper would wake up.

and the number of CPUs > S.

The time for an arbitrary number of tasks N > S which are all competing
for lock L, to transition a critical section (T_N_cs), approaches:

T_N_cs = (N * t_W) 

if you have only 1 task spinning.

but if you can have 

N tasks spinning, (T_N_cs) approaches:

T_N_cs = (N * t_Tcs)

and with the premise, that t_W > t_Tcs, you should see a dramatic
throughput improvement when running PREEMPT_RT on VERY LARGE SMP
systems.

I want to disclaim, that the math above is very much simplified, but I
hope its sufficient to demonstrate the concept.

I have to acknowledge Ingo's comments, that this is all suspect until
proven to make a positive difference in "non-marketing" workloads.

I personally *think* we are past that already, and the adaptive concept
can and will be extended and scaled as M-socket and N-core based SMP
proliferates into to larger grid-based systems. But there is plenty more
to do to prove it.

(someone send me a 1024 CPU box and a wind-powered-generator)

Sven



> 
> What this meant was that virtually every unlock performed a wakeup, if
> not for the new pending owner, than the next-in-line waiter. 
> 
> My impression at the time was that the contention for the rq lock is
> significant, regardless of even if the task being woken up was already
> running.  
> 
> I can generate numbers if that helps.
> 
> -PWM
> 
> 
> 
