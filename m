From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC -rt] updated synchronize_all_irqs implementation
Date: Wed, 26 Sep 2007 13:44:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709261341170.18417@gandalf.stny.rr.com>
References: <20070921054656.GA11708@linux.vnet.ibm.com>
 <Pine.LNX.4.58.0709251317080.5676@gandalf.stny.rr.com>
 <20070925193454.GH8432@linux.vnet.ibm.com>  <Pine.LNX.4.58.0709251601240.14583@gandalf.stny.rr.com>
  <20070926012447.7ffdd45a@lappy>  <20070926011139.GW8432@linux.vnet.ibm.com>
  <20070926102833.17f7c025@twins>  <20070926130326.GC19496@linux.vnet.ibm.com>
  <d120d5000709260616s5e3548d8j7b24f2123bf2d02f@mail.gmail.com>
 <20070926155656.GA9101@linux.vnet.ibm.com> <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: paulmck@linux.vnet.ibm.com,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
	dvhltc@us.ibm.com, tytso@us.ibm.com, akpm@linux-foundation.org,
	nickpiggin@yahoo.com.au
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:57732 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbXIZRp2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 13:45:28 -0400
In-Reply-To: <d120d5000709261019v3c514fc7y49f5f0fe2c43a8a6@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



--

On Wed, 26 Sep 2007, Dmitry Torokhov wrote:

> >
> > The synchronize_all_irqs() will not return until:
> >
> > 1.      All pre-existing hardirqs have completed.
> >
> > 2.      All pre-existing threaded irqs have completed.
> >
> > 3.      All preempt_disable() regions of code have completed.
> >
> > 4.      All irq-disable regions of code have completed.
> >
> > It will not necessarily wait for all softirqs to complete, but
> > then again, synchronize_sched() in non-rt might not wait for all
> > softirqs either, for example, if ksoftirqd is handling softirqs.
> >
> > Does that do what you need, or am I missing a case that needs
> > to be covered?
>
> As long as the list includes code guarded by
> spin_lock_irqsave()/spin_unlock_irqrestore() I am happy. Does this
> count as an irq-disable region? Peter said earlier that in -rt such
> code still runs with IRQs enabled...

No it does not guarantee that in -rt.  Peter is correct that in the -rt
patch, spin_lock_irqsave and restore do not touch actual interrupts (when
PREEMPT_RT is configured).  And the above protections that Paul has shown
also does not guarantee that all spin-locks will be released.

spin_locks in -rt become mutexes, and if some low priority process grabs
some spin_lock somewhere that no other process cares about, and then this
process gets preempted by a bunch of RT hogs, that lock could be held for
an awfully long time.

Paul, has there been any work to guarantee such a thing?

-- Steve
