From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [ANNOUNCE] 3.2.9-rt17
Date: Thu, 08 Mar 2012 22:20:27 +0100
Message-ID: <1331241627.11248.430.camel@twins>
References: <alpine.LFD.2.02.1203072225020.2742@ionos>
	 <1331230991.25686.452.camel@gandalf.stny.rr.com>
	 <1331231287.11248.396.camel@twins>
	 <1331232159.25686.456.camel@gandalf.stny.rr.com>
	 <1331235579.11248.402.camel@twins>
	 <1331237441.25686.469.camel@gandalf.stny.rr.com>
	 <1331238369.11248.426.camel@twins>
	 <1331240882.25686.499.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57538 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058Ab2CHVUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Mar 2012 16:20:35 -0500
In-Reply-To: <1331240882.25686.499.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-03-08 at 16:08 -0500, Steven Rostedt wrote:
> Hmm, perhaps we need a way to attach a priority to a lock. Maybe we just
> need a way to set a priority of a lock with.. "A task of priority X
> needs the lock, set the owner to at least X while it holds the lock",
> where it doesn't care about the high priority task, it just cares about
> the lock. That is, give locks a priority too (like priority ceiling). On
> doing spin_trylock_rt() (no need for deadlock detection) if it fails,
> gives a lock the priority of the task trying to take it. The lock will
> be given a temporary priority for the duration it is held. The owner of
> the lock will get that priority unless its already higher in priority.
> When the lock is released, both the owner and the lock lose the
> priority.
> 
> Note, spin_trylock_rt() continues to run even on failure.
> 
> Have cpu_chill() do a "sched_yield()" (the good kind, to put the current
> FIFO task behind another FIFO task of the same priority). Then the owner
> of the lock will get to run.
> 
> The sched_yield in cpu_chill() would be needed if the owner of the lock
> is blocked on the lock the high priority task has. After the high
> priority task releases its lock, and calls cpu_chill(), the
> sched_yield() allows the owner of the lock to run if it happens to be
> blocked on the lock the high prio task held. As the cpu_chill() will be
> called after that lock is released. 

Now put the thing on 2 cpus and both tasks can endlessly chase each
other's tail, no? The yield will be useless there.. 


