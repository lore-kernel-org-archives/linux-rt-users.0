From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Mon, 20 Apr 2015 18:22:58 -0700
Message-ID: <20150421012258.GZ5561@linux.vnet.ibm.com>
References: <20150416183812.GA5571@linux.vnet.ibm.com>
 <20150418130340.GA26931@gmail.com>
 <20150418133444.GD23685@linux.vnet.ibm.com>
 <20150418143238.GA2337@gmail.com>
 <20150419020541.GA5561@linux.vnet.ibm.com>
 <20150420113554.598e503f@sluggy>
 <20150420170902.GU5561@linux.vnet.ibm.com>
 <20150420204049.GF24936@home.goodmis.org>
 <20150420211504.GW5561@linux.vnet.ibm.com>
 <20150420165007.295f3fe0@sluggy>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
	akpm@linux-foundation.org, linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:37380 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbbDUBXF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Apr 2015 21:23:05 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 20 Apr 2015 19:23:05 -0600
Content-Disposition: inline
In-Reply-To: <20150420165007.295f3fe0@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Apr 20, 2015 at 04:50:07PM -0500, Clark Williams wrote:
> On Mon, 20 Apr 2015 14:15:04 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Mon, Apr 20, 2015 at 04:40:49PM -0400, Steven Rostedt wrote:
> > > On Mon, Apr 20, 2015 at 10:09:03AM -0700, Paul E. McKenney wrote:
> > > > 
> > > > The sysfs knob might be nice, but as far as I know nobody has been
> > > > complaining about it.
> > > > 
> > > > Besides, we already have the rcutree.kthread_prio= kernel-boot parameter.
> > > > So how about if the Kconfig parameter selects either SCHED_OTHER
> > > > (the default) or SCHED_FIFO:1, and then the boot parameter can be used
> > > > to select other values.
> > > 
> > > Hmm, what priority is this for anyway. To change the priority of the boost
> > > value at run time, do we only need to change the priority of the rcub threads?
> > > 
> > > And the priority of the other rcu threads can change as well with a simple
> > > chrt?
> > > 
> > > If that's the case, then we don't need a sysctl knob at all.
> > 
> > For the grace-period kthreads and the boost kthread, that is the case.
> > It is also the case for the per-CPU kthreads that invoke RCU callbacks
> > for the non-offloaded RCU_BOOST configuration (and that replace all
> > softirq RCU work in -rt).
> > 
> > So, should I just ditch all of the priority-setting within RCU and tell
> > users to just use chrt?
> 
> Looks to me like all we need to do is tell people if they need a boost
> higher than the compiled in default (RCU_KTHREAD_PRIO), then chrt the
> priority of the rcub thread to the desired priority. 

There's the rub.  They also need to chrt the RCU grace-period kthreads
as well as the per-CPU kthreads (rcuc).  Which is a pain and easy to
get wrong.

So at this point, I am leaning towards keeping RCU_KTHREAD_PRIO, but
hiding it behind RCU_EXPERT.  Someone in an emergency situation can use
chrt to get RCU going, at least assuming that they had the foresight to
leave a prio-99 shell running somewhere and assuming that they do the
chrt before the system hits OOM.  But they have to do all that anyway
if they were to use a sysfs or similar interface.  And it is easy to
tell when you have boosted all the necessary kthreads because RCU
grace periods start advancing once again.  You don't get that feedback
when you set things up at boot time.  ;-)

So again, at least for the moment, I believe that RCU need not provide
a run-time interface for changing RCU kthread priorities, that the
RCU_KTHREAD_PRIO Kconfig parameter should remain, except that it needs
to be hidden behind RCU_EXPERT, and that the rcutree.kthread_prio=
kernel-boot parameter should also remain.

Seem reasonable?

							Thanx, Paul

