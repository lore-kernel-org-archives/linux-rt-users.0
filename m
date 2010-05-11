From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Real-time projects that could use userspace RCU
Date: Tue, 11 May 2010 10:43:37 -0400
Message-ID: <20100511144337.GB17656@Krystal>
References: <20100511122140.GA11000@Krystal> <AANLkTikLHsvs1LKAnFInWLkZUjHAVlM0evDT18jkb-NU@mail.gmail.com> <20100511131404.GC25418@Krystal> <20100511143852.GA2336@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Kacur <jkacur@redhat.com>, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:36916 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755066Ab0EKOnj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 May 2010 10:43:39 -0400
Content-Disposition: inline
In-Reply-To: <20100511143852.GA2336@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> On Tue, May 11, 2010 at 09:14:04AM -0400, Mathieu Desnoyers wrote:
> > * John Kacur (jkacur@redhat.com) wrote:
> > > On Tue, May 11, 2010 at 2:21 PM, Mathieu Desnoyers
> > > <mathieu.desnoyers@efficios.com> wrote:
> > > > Hi Thomas,
> > > >
> > > > Paul told me you were quite interested in the userspace RCU library when he told
> > > > you about it (http://lttng.org/urcu). Do you have some userspace applications or
> > > > libraries with real-time needs in mind that could use it ? We could help moving
> > > > them to liburcu. The wait-free read-side is, as you certainly know, a
> > > > characteristic of RCU that can be very useful to RT applications.
> > > >
> > > > [CCing linux-rt-users, as it seems appropriate to ask them too.]
> > > >
> > > > Thanks,
> > > 
> > > Do you have any kind of benchmarks? If you had something appropriate
> > > we could add it to the rt-tests suite (which includes cyclictest). Not
> > > only would this provide an objective measure, but it could also act as
> > > a reference implementation for userspace programmers.
> > 
> > Yes, the library already has its set of benchmark test programs. The results can
> > be found in http://lttng.org/pub/thesis/desnoyers-dissertation-2009-12.pdf
> > section 6.5. It shows that RCU read-side is a few orders of magnitude faster
> > than lock-based approaches and scales linearly with the number of cores.
> > 
> > The same PDF, sections 7.6.2 and 7.6.3, presents the architecture-level modeling
> > of the RCU mb algorithm in Promela, along with the formal proof by model
> > checking for both correctness and progress (the read-side is proven wait-free).
> > 
> > > 
> > > See here.
> > > git clone git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
> > > 
> > > cyclictest is the original program written by Thomas, maintained by
> > > Clark Williams now. Most - but not all, of the additional tests are
> > > modelled after this program, so you might want to have a look at that
> > > if you're not already familiar with it.
> > 
> > Thanks for the pointer, I did know about cyclictest, but not the others. Since
> > the read-side does not involve the OS nor blocking, I wonder which of these
> > tests would be even a near-match though.
> 
> Why not add mutual-exclusion tests, including locking, per-thread locking,
> reader-writer locking, and RCU?  The figure of merit would be maximum
> latency rather than throughput, but the existing userspace-rcu tests should
> be pretty close.
> 

Do you mean adding our RCU tests to the rt-tests.git tree or adding more
information in our own tests ? Also, the maximum latency is quite dependent on
the rest of the workload running on the system, so we might have to generate
such a workload while the test runs to give an interesting and accurate view of
the maximum latency.

Maybe running one (or many) of the already existing rt-tests in parallel would
do.

Thoughts ?

Mathieu


> 							Thanx, Paul

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
