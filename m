From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: workqueue code needing preemption disabled
Date: Mon, 18 Mar 2013 12:30:43 -0400
Message-ID: <1363624243.25967.178.camel@gandalf.local.home>
References: <1363617383.25967.152.camel@gandalf.local.home>
	 <20130318160652.GA20133@mtj.dyndns.org>
	 <1363623799.25967.172.camel@gandalf.local.home>
	 <1363624020.25967.175.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363624020.25967.175.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2013-03-18 at 12:27 -0400, Steven Rostedt wrote:

> IOW, what can happen in -rt here is:
> 
> 	spin_lock_irq(&gcwq->lock);
> 	[...]
> 	<interrupt>
> 		-> preempt_schedule();
> 		   schedule();
> 		   try_to_wake_up_local();
> 
> 	[...]
> 	spin_unlock_irq(&gcwq->lock);
> 
> Again, with -rt, spin_lock_irq() does not prevent interrupts nor
> preemption.

If you happen to know the critical areas that require preemption to be
disabled for real, we can encapsulate them with:

	preempt_disable_rt();

	preempt_enable_rt();

These are currently only in the -rt patch, but it annotates locations
that require preemption to be disabled even when -rt converts spin_locks
into mutexes. These obviously can not contain spin_locks() as
spin_locks() can block and schedule out.

-- Steve
