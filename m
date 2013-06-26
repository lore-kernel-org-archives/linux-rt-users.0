From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT] rcu,rt: Allow rcu_read_lock_sched() to schedule
Date: Wed, 26 Jun 2013 13:40:09 -0400
Message-ID: <1372268409.18733.264.camel@gandalf.local.home>
References: <1372254133.18733.252.camel@gandalf.local.home>
	 <20130626144045.GO3828@linux.vnet.ibm.com>
	 <1372259000.18733.258.camel@gandalf.local.home>
	 <1372259103.18733.260.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:32277 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab3FZRkL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Jun 2013 13:40:11 -0400
In-Reply-To: <1372259103.18733.260.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2013-06-26 at 11:05 -0400, Steven Rostedt wrote:
> On Wed, 2013-06-26 at 11:03 -0400, Steven Rostedt wrote:
> 
> > > I tried this approach in early 2005, and testing did not go well:
> > > 
> > > https://lkml.org/lkml/2005/3/17/199
> > > 
> > > For one thing, a lock acquired both within and surrounding an
> > > RCU-sched read-side critical section would result in deadlock.
> > > 
> > > Or have things changed so that this now somehow works?
> > 
> > Well, so far lockdep hasn't splatted on this. But that's not saying much
> > because I'm currently fighting the lockdep splats from other workqueue
> > related stuff.
> > 
> > Seems that Tejun really doesn't like us RT folks ;-)
> 
> If there are issues, we could make a rcu_read_lock_sched_rt() which for
> mainline will be rcu_read_lock_sched(), but for -rt will grab the lock.
> That way we can pick and choose the locations that this is required.
> 

I finally fixed the other issues and ran a full compile on this kernel.
No problems appeared yet, so maybe things have changed.

-- Steve


