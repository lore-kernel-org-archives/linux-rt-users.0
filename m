From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 25 Mar 2016 06:38:50 +0100
Message-ID: <1458884330.3836.21.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1458817594.3972.16.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458817594.3972.16.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2016-03-24 at 12:06 +0100, Mike Galbraith wrote:
> On Thu, 2016-03-24 at 11:44 +0100, Thomas Gleixner wrote:
> >  
> > > On the bright side, with the busted migrate enable business reverted,
> > > plus one dinky change from me [1], master-rt.today has completed 100
> > > iterations of Steven's hotplug stress script along side endless
> > > futexstress, and is happily doing another 900 as I write this, so the
> > > next -rt should finally be hotplug deadlock free.
> > > 
> > > Thomas's state machinery seems to work wonders.  'course this being
> > > hotplug, the other shoe will likely apply itself to my backside soon.
> > 
> > That's a given :)
> 
> blk-mq applied it shortly after I was satisfied enough to poke xmit.

The other shoe is that notifiers can depend upon RCU grace periods, so
when pin_current_cpu() snags rcu_sched, the hotplug game is over.

blk_mq_queue_reinit_notify:
        /*
         * We need to freeze and reinit all existing queues.  Freezing
         * involves synchronous wait for an RCU grace period and doing it
         * one by one may take a long time.  Start freezing all queues in
         * one swoop and then wait for the completions so that freezing can
         * take place in parallel.
         */
        list_for_each_entry(q, &all_q_list, all_q_node)
                blk_mq_freeze_queue_start(q);
        list_for_each_entry(q, &all_q_list, all_q_node) {
                blk_mq_freeze_queue_wait(q);

Hohum (sharpens rock), next.

	-Mike
