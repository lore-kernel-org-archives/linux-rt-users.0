From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 00:28:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
References: <loom.20090615T222836-377@post.gmane.org> <000001c9ee36$218cf3a0$a852c70a@dlh.st.com> <loom.20090616T074347-549@post.gmane.org> <20090616182734.GD13048@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-964813989-1245191325=:2800"
Cc: Martin Shepherd <mcs@astro.caltech.edu>,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:38607 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327AbZFPW3G (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 18:29:06 -0400
In-Reply-To: <20090616182734.GD13048@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-964813989-1245191325=:2800
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 16 Jun 2009, Uwe Kleine-König wrote:
> On Tue, Jun 16, 2009 at 07:59:28AM +0000, Martin Shepherd wrote:
> > Suresh Kumar SHUKLA <suresh.shukla <at> st.com> writes:
> > > 	// get IRQ descriptor from IRQ, it contains pid
> > > 	desc = &irq_desc[IRQ_BASIC_TIMER_3_1];
> > 
> > That's a very useful clue. I was thinking that I would have to walk the process
> > tree to find the thread by name. Following up on this clue, it appears as though
> > in kernel 2.6.29.4 I should be able to use desc=irq_to_desc(irq) to look up the
> > IRQ descriptor, then use pid=get_task_pid(desc->thread), to get the PID of the
> > IRQ thread, then use sys_sched_setscheduler(pid,...) to change its priority.
> > I'll try that out in the morning.
> I wouldn't recommend calling sys_sched_setscheduler from kernel space.
> That's the userspace API and you need to pass a __user pointer as third
> argument.
> 
> The right way is to do this change from userspace.

What a nonsense. Care to look at the code ?

The irq/softirq threads call sys_sched_setscheduler() already to
change their priorities.

The right way to do this is to have an interface
set_irq_thread_prio(irq, prio)

Thanks,

	tglx
--8323328-964813989-1245191325=:2800--
