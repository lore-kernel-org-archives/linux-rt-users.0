From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Quick review of -rt RCU-related patches
Date: Tue, 4 Oct 2011 16:56:07 -0700
Message-ID: <20111004235607.GM2223@linux.vnet.ibm.com>
References: <20111004174755.GA4762@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1110042322450.18778@ionos>
 <20111004231504.GG2223@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1110050120250.18778@ionos>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38144 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933916Ab1JDX4N (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Oct 2011 19:56:13 -0400
Received: from /spool/local
	by us.ibm.com with XMail ESMTP
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 4 Oct 2011 19:56:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110050120250.18778@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 05, 2011 at 01:27:15AM +0200, Thomas Gleixner wrote:
> On Tue, 4 Oct 2011, Paul E. McKenney wrote:
> > On Wed, Oct 05, 2011 at 12:05:47AM +0200, Thomas Gleixner wrote:
> > > > 	This means that might_sleep() will never complain about
> > > > 	blocking in an RCU read-side critical section.  I guess that
> > > > 	this is necessary, though it would be better to have some
> > > > 	way to complain for general sleeping (e.g., waiting on
> > > > 	network receive) as opposed to blocking on a lock that is
> > > > 	subject to priority inheritance.
> > > 
> > > Well, there's always a remaining problem. We need that stuff fully
> > > preemptible on rt. Any ideas ?
> > 
> > Not yet.  We would have to classify context switches into two groups:
> > 
> > 1.	Preemptions or blocking waiting for sleeping spinlocks.
> > 
> > 2.	Everything else.
> > 
> > Given that classification, it would be straightforward: prohibit
> > group #2 context switches while in RCU-preempt read-side critical
> > sections.  I know, easy for me to say!  ;-)
> 
> Well, you know the preemtible regions of RT, it basically boils down
> to #1 - except that it differs a bit from vanilla that locks and bh
> stuff does not prevent preemption.
> 
> If RCU can deal with that, then #2 is a non issue :)

Ah!  I thought you were asking for something that checked for people
violating -rt's rules for context switches within RCU-preempt read-side
critical sections.

> > > > rcu-disable-the-rcu-bh-stuff-for-rt.patch
> > > > 
> > > > 	This implements RCU-bh in terms of RCU-preempt, but disables
> > > > 	BH around the resulting RCU-preempt read-side critical section.
> > > > 	May be vulnerable to network-based denial-of-service attacks,
> > > > 	which could OOM a system with this patch.
> > > > 
> > > > 	The implementation of rcu_read_lock_bh_held() is weak, but OK.	In
> > > > 	an ideal world, it would also complain if not local_bh_disable().
> > > 
> > > Well, I dropped that after our IRC conversation, but we still need to
> > > have some extra debugging for RT to diagnose situations where we break
> > > those rcu_bh assumptions. That _bh rcu stuff should have never been
> > > there, we'd rather should drop the softirq processing back to
> > > ksoftirqd in such an overload case (in mainline) and voluntary
> > > schedule away from ksoftirqd until the situation is resolved.
> > > 
> > > I consider rcu_bh a bandaid for the nasty implict semantics of BH
> > > processing and I'm looking really forward to Peters analysis of the
> > > modern cpu local BKL constructs at RTLWS.
> > > 
> > > The patch stemmed from an earlier discussion about getting rid of
> > > those special rcu_bh semantics even in mainline for the sake of not
> > > making a special case for a completely over(ab)used construct which
> > > originates from the historically grown softirq behaviour. I think that
> > > keeping the special cased rcu_bh stuff around is just taking any
> > > incentive away from moving that whole softirq processing into a
> > > scheduler controllable environment (i.e. threaded interrupts). 
> > 
> > Between -rt and the guys pushing packets, I can tell that this is going
> > to be a fun one.  ;-)
> 
> We'll see. At some point they'll find out that a thread context will
> make their life easier simply because the locking maze can be
> distangled. That's why I'm ranting at the special "foster _bh" rcu
> abominations, which keep them thinking that going down that road is
> actually a good thing.
> 
> > I will see if I can come up with a way to make that patch safe to
> > apply.  Might not be all that hard.
> 
> :)

Easier now that "git clone" works for me once more.  Re-installed my
system, but my notes from doing it last time were incomplete.  They
are better now.  ;-)

							Thanx, Paul

