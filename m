From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Tue, 29 Mar 2016 06:05:00 +0200
Message-ID: <1459224300.3883.61.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1458817594.3972.16.camel@gmail.com> <1458884330.3836.21.camel@gmail.com>
	 <alpine.DEB.2.11.1603250951100.3978@nanos>
	 <1458897196.3870.8.camel@gmail.com> <1458923073.3849.26.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33983 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbcC2EFE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 00:05:04 -0400
In-Reply-To: <1458923073.3849.26.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2016-03-25 at 17:24 +0100, Mike Galbraith wrote:
> On Fri, 2016-03-25 at 10:13 +0100, Mike Galbraith wrote:
> > On Fri, 2016-03-25 at 09:52 +0100, Thomas Gleixner wrote:
> > > On Fri, 25 Mar 2016, Mike Galbraith wrote:
> > > > On Thu, 2016-03-24 at 12:06 +0100, Mike Galbraith wrote:
> > > > > On Thu, 2016-03-24 at 11:44 +0100, Thomas Gleixner wrote:
> > > > > >  
> > > > > > > On the bright side, with the busted migrate enable business reverted,
> > > > > > > plus one dinky change from me [1], master-rt.today has completed 100
> > > > > > > iterations of Steven's hotplug stress script along side endless
> > > > > > > futexstress, and is happily doing another 900 as I write this, so the
> > > > > > > next -rt should finally be hotplug deadlock free.
> > > > > > > 
> > > > > > > Thomas's state machinery seems to work wonders.  'course this being
> > > > > > > hotplug, the other shoe will likely apply itself to my backside soon.
> > > > > > 
> > > > > > That's a given :)
> > > > > 
> > > > > blk-mq applied it shortly after I was satisfied enough to poke xmit.
> > > > 
> > > > The other shoe is that notifiers can depend upon RCU grace periods, so
> > > > when pin_current_cpu() snags rcu_sched, the hotplug game is over.
> > > > 
> > > > blk_mq_queue_reinit_notify:
> > > >         /*
> > > >          * We need to freeze and reinit all existing queues.  Freezing
> > > >          * involves synchronous wait for an RCU grace period and doing it
> > > >          * one by one may take a long time.  Start freezing all queues in
> > > >          * one swoop and then wait for the completions so that freezing can
> > > >          * take place in parallel.
> > > >          */
> > > >         list_for_each_entry(q, &all_q_list, all_q_node)
> > > >                 blk_mq_freeze_queue_start(q);
> > > >         list_for_each_entry(q, &all_q_list, all_q_node) {
> > > >                 blk_mq_freeze_queue_wait(q);
> > > 
> > > Yeah, I stumbled over that already when analysing all the hotplug notifier
> > > sites. That's definitely a horrible one.
> > >  
> > > > Hohum (sharpens rock), next.
> > > 
> > > /me recommends frozen sharks
> > 
> > With the sharp rock below and the one I'll follow up with, master-rt on
> > my DL980 just passed 3 hours of endless hotplug stress concurrent with
> > endless tbench 8, stockfish and futextest.  It has never survived this
> > long with this load by a long shot.
> 
> I knew it was unlikely to surrender that quickly.  Oh well, on the
> bright side it seems to be running low on deadlocks.

The immunize rcu_sched rock did that btw.  Having accidentally whacked
the dump, I got to reproduce (took 30.03 hours) so I could analyze it.

Hohum, notifier woes definitely require somewhat sharper rocks.

I could make rcu_sched dodge the migration thread, but think I'll apply
frozen shark to blk-mq instead.

	-Mike

(a clever person would wait for Sir Thomas, remaining blissfully
ignorant of the gory dragon slaying details, but whatever, premature
testing and rt mole whacking may turn up something interesting, ya
never know)
