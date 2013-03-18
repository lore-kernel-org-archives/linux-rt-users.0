From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: workqueue code needing preemption disabled
Date: Mon, 18 Mar 2013 13:08:07 -0400
Message-ID: <1363626487.25967.186.camel@gandalf.local.home>
References: <1363617383.25967.152.camel@gandalf.local.home>
	 <20130318160652.GA20133@mtj.dyndns.org>
	 <1363623799.25967.172.camel@gandalf.local.home>
	 <1363624020.25967.175.camel@gandalf.local.home>
	 <1363624243.25967.178.camel@gandalf.local.home>
	 <20130318164351.GA21516@mtj.dyndns.org>
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
In-Reply-To: <20130318164351.GA21516@mtj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2013-03-18 at 09:43 -0700, Tejun Heo wrote:

> Making gcwq locks disable preemption would be much safer / easier, but
> if that's not desirable, anything touching gcwq->idle_list would be a
> good place to start - worker_enter_idle() and worker_leave_idle().
> Hmmm... ignoring CPU hotplug, I think those two might just do it.
> Give it a try?  How reproducible is the problem?

Not very :-( I triggered it twice on a 40 CPU box. It can go
approximately 1 month before it triggers. And the box we are testing on
is currently a loaner, and we have it on extension right now. Which
means we wont have it much longer.

But perhaps that's the place to fix things.

Thanks,

-- Steve
