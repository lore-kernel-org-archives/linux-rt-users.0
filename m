From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 25 Mar 2016 09:52:49 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603250951100.3978@nanos>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>  <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>  <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>  <alpine.DEB.2.11.1603241140510.3978@nanos>
 <1458817594.3972.16.camel@gmail.com> <1458884330.3836.21.camel@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42456 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbcCYIyU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Mar 2016 04:54:20 -0400
In-Reply-To: <1458884330.3836.21.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 25 Mar 2016, Mike Galbraith wrote:
> On Thu, 2016-03-24 at 12:06 +0100, Mike Galbraith wrote:
> > On Thu, 2016-03-24 at 11:44 +0100, Thomas Gleixner wrote:
> > >  
> > > > On the bright side, with the busted migrate enable business reverted,
> > > > plus one dinky change from me [1], master-rt.today has completed 100
> > > > iterations of Steven's hotplug stress script along side endless
> > > > futexstress, and is happily doing another 900 as I write this, so the
> > > > next -rt should finally be hotplug deadlock free.
> > > > 
> > > > Thomas's state machinery seems to work wonders.  'course this being
> > > > hotplug, the other shoe will likely apply itself to my backside soon.
> > > 
> > > That's a given :)
> > 
> > blk-mq applied it shortly after I was satisfied enough to poke xmit.
> 
> The other shoe is that notifiers can depend upon RCU grace periods, so
> when pin_current_cpu() snags rcu_sched, the hotplug game is over.
> 
> blk_mq_queue_reinit_notify:
>         /*
>          * We need to freeze and reinit all existing queues.  Freezing
>          * involves synchronous wait for an RCU grace period and doing it
>          * one by one may take a long time.  Start freezing all queues in
>          * one swoop and then wait for the completions so that freezing can
>          * take place in parallel.
>          */
>         list_for_each_entry(q, &all_q_list, all_q_node)
>                 blk_mq_freeze_queue_start(q);
>         list_for_each_entry(q, &all_q_list, all_q_node) {
>                 blk_mq_freeze_queue_wait(q);

Yeah, I stumbled over that already when analysing all the hotplug notifier
sites. That's definitely a horrible one.
 
> Hohum (sharpens rock), next.

/me recommends frozen sharks

Thanks,

       tglx
