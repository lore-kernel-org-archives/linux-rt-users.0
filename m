From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: workqueue code needing preemption disabled
Date: Mon, 18 Mar 2013 12:27:00 -0400
Message-ID: <1363624020.25967.175.camel@gandalf.local.home>
References: <1363617383.25967.152.camel@gandalf.local.home>
	 <20130318160652.GA20133@mtj.dyndns.org>
	 <1363623799.25967.172.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:7664 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab3CRQ1C (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Mar 2013 12:27:02 -0400
In-Reply-To: <1363623799.25967.172.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2013-03-18 at 12:23 -0400, Steven Rostedt wrote:

> > Maybe I'm confused but I can't really see how the above would be a
> > problem to workqueue in itself.  Both rq->lock and gcwq->lock are
> > irq-safe, so spin_lock() not disabling preemption shouldn't be a
> > problem.  Are CPU hotplug operations involved?
> 
> No CPU hotplug is involved here. But I will note that gcwq->lock in -rt
> is not irq -safe. That is, in rt the spin_lock_irq(&gcwq->lock) really
> becomes a special "mutex_lock(&gcwq->lock)".

IOW, what can happen in -rt here is:

	spin_lock_irq(&gcwq->lock);
	[...]
	<interrupt>
		-> preempt_schedule();
		   schedule();
		   try_to_wake_up_local();

	[...]
	spin_unlock_irq(&gcwq->lock);

Again, with -rt, spin_lock_irq() does not prevent interrupts nor
preemption.

-- Steve


