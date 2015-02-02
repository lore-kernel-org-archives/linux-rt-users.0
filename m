From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: kernel-rt rcuc lock contention problem
Date: Mon, 2 Feb 2015 15:55:28 -0500
Message-ID: <20150202155528.31bcb406@gandalf.local.home>
References: <20150126141403.469dc92f@redhat.com>
	<20150127203752.GD19109@linux.vnet.ibm.com>
	<20150128015508.GA12233@amt.cnet>
	<20150128180335.GR19109@linux.vnet.ibm.com>
	<20150128182512.GB1259@amt.cnet>
	<20150128185552.GT19109@linux.vnet.ibm.com>
	<20150202182450.GA9526@amt.cnet>
	<20150202153553.70dd1a5a@gandalf.local.home>
	<20150202204659.GA13864@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Luiz Capitulino <lcapitulino@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:43122 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933506AbbBBUzb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Feb 2015 15:55:31 -0500
In-Reply-To: <20150202204659.GA13864@amt.cnet>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2 Feb 2015 18:46:59 -0200
Marcelo Tosatti <mtosatti@redhat.com> wrote:

 
> > > The second commit, d550e81dc0dd should be part of -RT, and currently is
> > > not, because:
> > > 
> > > -> Any IRQ work item will raise timer softirq.
> > > -> __run_timers will do a full round of processing,
> > > ruining latency.
> > 
> > Was this discussed?
> 
> Discussed where?

It sounded like that commit was not added because of the above. That's
why I asked, was it discussed. Sounded like you were saying that commit
d550e81dc0dd should be part of -RT but it is not because ..., which
sounds like there were some decisions made.

> 
> The point is this: __run_timers has horrible latency.
> How to avoid it: configure the system in such a way that no timers 
> (old interface, add_timers) expire on the local CPU.
> 
> The patches Paul listed above limit the issue allowing
> you to call raise_softirq(TIMER_SOFTIRQ) without having to go
> through __run_timers, in the case of no pending timers.

OK, so you are asking for me to add those patches?


> Then you rely on the sched timer interrupt to notice there is a pending 
> irq_work item? 

On, x86, there shouldn't be. irq_work can usually trigger its own
interrupt. In the case that it can not, it requires the softirq to
trigger when there's irq work to be done.

> 
> If you have no sched timer interrupts, then what happens with that
> irq_work item?
> 

That's what that patch does. It should trigger some. Hmm, I have to see
if no_hz_full checks irq work too.

But again, of there's no irq_work to do then this should not matter. If
there's irq_work to do, then something on that CPU asked to do irq
work. If you are worried about run_timers, make sure nothing is on that
CPU that can trigger a timer.

Isolation is the *only* way to make that work.

-- Steve
