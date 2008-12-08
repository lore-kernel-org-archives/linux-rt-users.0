From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] [RT] avoid preemption in memory controller code
Date: Mon, 8 Dec 2008 12:23:17 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0812081218471.26257@gandalf.stny.rr.com>
References: <1228746854-23875-1-git-send-email-tim@klingt.org>  <alpine.DEB.1.10.0812081138470.26257@gandalf.stny.rr.com> <1228756056.7862.8.camel@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Tim Blechmann <tim@klingt.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:63261 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbYLHRXT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Dec 2008 12:23:19 -0500
In-Reply-To: <1228756056.7862.8.camel@thinkpad>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 8 Dec 2008, Tim Blechmann wrote:

> > > the lru_lock of struct mem_group_per_zone is used to avoid preemption
> > > during the __mem_cgroup_stat_add_safe function.
> > > therefore, a raw_spinlock_t should be used.
> > 
> > What is the reason that this must avoid preemption? 
> 
> it guards a call to smp_processor_id() in __mem_cgroup_stat_add_safe().
> see http://article.gmane.org/gmane.linux.rt.user/3690

We could simply create a 
	preempt_disable_rt();
that will only disable preemption when CONFIG_PREEMPT_RT is set.
and then we could add

	int cpu;

	preempt_disable_rt();
	cpu = smp_processor_id();
	stat->cpustat[cpu].count[idx] += val;
	preempt_enable_rt();

Or something similar.

-- Steve

> 
> > Is there another
> > way to solve this? I rather not just add a raw spinlock if we can
> > help it.
> 
> not sure, maybe one can disable preemption for that specific function?
> 
> tim
> 
> --
> tim@klingt.org
> http://tim.klingt.org
> 
> Art is either a complaint or do something else
>   John Cage quoting Jasper Johns
> 
