From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Mon, 20 Apr 2015 10:09:03 -0700
Message-ID: <20150420170902.GU5561@linux.vnet.ibm.com>
References: <20150416183812.GA5571@linux.vnet.ibm.com>
 <20150418130340.GA26931@gmail.com>
 <20150418133444.GD23685@linux.vnet.ibm.com>
 <20150418143238.GA2337@gmail.com>
 <20150419020541.GA5561@linux.vnet.ibm.com>
 <20150420113554.598e503f@sluggy>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
	akpm@linux-foundation.org, linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:33017 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbbDTRJI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Apr 2015 13:09:08 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 20 Apr 2015 11:09:07 -0600
Content-Disposition: inline
In-Reply-To: <20150420113554.598e503f@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Apr 20, 2015 at 11:35:54AM -0500, Clark Williams wrote:
> On Sat, 18 Apr 2015 19:05:42 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > 	Real-time priority to use for RCU worker threads (RCU_KTHREAD_PRIO) [0] (NEW) 
> > > > 
> > > > Indeed, Linus complained about this one.  ;-)
> > > 
> > > :-) Yes, it's an essentially unanswerable question.
> > > 
> > > > This Kconfig parameter is a stopgap, and needs a real solution.  
> > > > People with crazy-heavy workloads involving realtime cannot live 
> > > > without it, but that means that most people don't have to care.  I 
> > > > have had solving this on my list, and this clearly increases its 
> > > > priority.
> > > 
> > > So what value do they use, prio 99? 98? It might be better to offer 
> > > this option as a binary choice, and set a given priority. If -rt 
> > > people complain then they might help us in solving it properly.
> > 
> > I honestly do not remember what priority they were using, it is
> > not in email, and I don't keep IRC logs that far back.  Adding
> > linux-rt-users@vger.kernel.org on CC.
> 
> As I recall, we started out using fifo:1, but when you get heavy
> workloads running at higher fifo priorities, we wanted to boost the rcu
> worker threads over those workloads. 
> 
> Currently the irq threads default to fifo:50, so maybe a good
> default choice for the rcu threads on RT is fifo:49. That of course
> presumes rational behavior on the part of application developers. 
> 
> I seem to recall that you and I had a discussion about making this
> value a runtime knob in /sys but that didn't go anywhere. Do we need to
> crank that up again and just use the config as a default/starting
> value? If so then we could just default to fifo:1 and let sysadmins
> tweak the value to match up with the workload. 

The sysfs knob might be nice, but as far as I know nobody has been
complaining about it.

Besides, we already have the rcutree.kthread_prio= kernel-boot parameter.
So how about if the Kconfig parameter selects either SCHED_OTHER
(the default) or SCHED_FIFO:1, and then the boot parameter can be used
to select other values.

That said, if the lack of a sysfs knob has been causing real problems,
let's make that happen.

							Thanx, Paul

