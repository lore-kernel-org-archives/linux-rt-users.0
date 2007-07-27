From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [kvm-devel] Threaded IPIs?
Date: Fri, 27 Jul 2007 07:43:13 -0400
Message-ID: <46A9A2110200005A00028434@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <kvm-devel@lists.sourceforge.net>, <linux-rt-users@vger.kernel.org>
To: <avi@qumranet.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:8244 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934874AbXG0Ln0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Jul 2007 07:43:26 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-07-27 at 07:56 +0300, Avi Kivity wrote:
> Gregory Haskins wrote:
> > Hi guys,
> >   While working with the -rt kernel, I have noticed a problem in KVM.
> > Specifically, when you stop a VM you sometimes get a "sleep while
> > atomic" oopses.  It turns out that the issue is related to an
> > smp_function_call IPI that KVM does to remotely flush the VMX hardware
> > on shutdown.  The code tries to acquire the global kvm_lock (which is a
> > normal spinlock_t, of course converted to rt_mutex on -rt) from the
> > interrupt context of the IPI handler.  You know the rest of the
> > story....
> >
> > The obvious solution is to convert the kvm_lock to a raw_spinlock_t.
> > However, I really don't want to do this unless we absolutely have to
> > since it will just increase latencies for a good portion of the rest of
> > KVM.
> >   
> 
> Are you talking about decache_vcpus_from_cpu() that is called from
> hardware_disable()?  

Yeah, exactly.


> Would having the caller acquire the lock solve the
> problem?  

Possibly, though I would have to look at how/where the caller executes.
If its in_atomic, it will hit the same problem that the callee does.

That being said, I have no doubts that we can solve this particular KVM
issue much more simply then with what I am proposing.  What I am
wondering, however, is if this is an opportunity to further increase the
preemptibility of the RT kernel.  I figure, most drivers that use
hardirqs and spinlock_t continue to work transparently on PREEMPT_RT
because threaded IRQs can sleep (and be preempted)....why not FC-IPIs
too?

I'm partway done with a proof-of-concept patch.  Ill send it out later.
