From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: kernel-rt rcuc lock contention problem
Date: Mon, 2 Feb 2015 15:35:53 -0500
Message-ID: <20150202153553.70dd1a5a@gandalf.local.home>
References: <20150126141403.469dc92f@redhat.com>
	<20150127203752.GD19109@linux.vnet.ibm.com>
	<20150128015508.GA12233@amt.cnet>
	<20150128180335.GR19109@linux.vnet.ibm.com>
	<20150128182512.GB1259@amt.cnet>
	<20150128185552.GT19109@linux.vnet.ibm.com>
	<20150202182450.GA9526@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Luiz Capitulino <lcapitulino@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:35823 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964919AbbBBUf5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Feb 2015 15:35:57 -0500
In-Reply-To: <20150202182450.GA9526@amt.cnet>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2 Feb 2015 16:24:50 -0200
Marcelo Tosatti <mtosatti@redhat.com> wrote:

> > > > In any case, if you want the best real-time response for a CPU-bound
> > > > workload on a given CPU, careful use of NO_HZ_FULL would prevent
> > > > that CPU from ever invoking __rcu_process_callbacks() in the first
> > > > place, which would have the beneficial side effect of preventing
> > > > __rcu_process_callbacks() from ever invoking rcu_start_gp().
> > > > 
> > > > Of course, NO_HZ_FULL does have the drawback of increasing the cost
> > > > of user-kernel transitions.
> > > 
> > > We need periodic processing of __run_timers to keep timer wheel
> > > processing from falling behind too much.
> > > 
> > > See http://www.gossamer-threads.com/lists/linux/kernel/2094151.
> > 
> > Hmmm...  Do you have the following commits in your build?
> > 
> > fff421580f51 timers: Track total number of timers in list
> > d550e81dc0dd timers: Reduce __run_timers() latency for empty list
> > 16d937f88031 timers: Reduce future __run_timers() latency for newly emptied list
> > 18d8cb64c9c0 timers: Reduce future __run_timers() latency for first add to empty list
> > aea369b959be timers: Make internal_add_timer() update ->next_timer if ->active_timers == 0
> > 
> > Keeping extraneous processing off of the CPUs running the real-time
> > guest will minimize the number of timers, allowing these commits to
> > do their jobs.
> 
> Steven,
> 
> The second commit, d550e81dc0dd should be part of -RT, and currently is
> not, because:
> 
> -> Any IRQ work item will raise timer softirq.
> -> __run_timers will do a full round of processing,
> ruining latency.

Was this discussed?

> 
> Even without any timer pending on the timer wheel.
> 
> And about NO_HZ_FULL and -RT, is it correct that NO_HZ_FULL
> renders
> 
> commit 1a2de830b90e364c3bf95e0000173bffcb65ddb7
> Author: Steven Rostedt <rostedt@goodmis.org>
> Date:   Fri Jan 31 12:07:57 2014 -0500
> 
>     timer/rt: Always raise the softirq if there's irq_work to be done
> 
> Inactive? Should raise softirq from irq_work_queue directly?

What do you mean raise from irq_work_queue directly? When irq work
needs to be done, that usually is because something happened in a
context that you can not wake up a process (like raise_softirq might
do). The irq_work itself could raise the softirq, but as it takes the
softirq to trigger the irq_work you are stuck in a catch 22 there.

-- Steve
