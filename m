From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: On migrate_disable() and latencies
Date: Thu, 28 Jul 2011 13:50:43 +0800
Message-ID: <20110728055043.GA570@windriver.com>
References: <1311329992.27400.23.camel@twins>
 <20110723003934.GP2382@linux.vnet.ibm.com>
 <1311582653.2617.49.camel@laptop>
 <20110725211706.GT2327@linux.vnet.ibm.com>
 <1311765198.24752.437.camel@twins>
 <20110727183008.GA2407@linux.vnet.ibm.com>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Kumar Gala <galak@gate.crashing.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	rostedt <rostedt@goodmis.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f52.google.com ([209.85.212.52]:56372 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab1G1F7E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 01:59:04 -0400
Content-Disposition: inline
In-Reply-To: <20110727183008.GA2407@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jul 27, 2011 at 11:30:08AM -0700, Paul E. McKenney wrote:
> o	Tasks awakening outside of migrate-disable regions will pick
> 	the CPU running the lowest-priority task, whether or not this
> 	task is in migrate-disable state.  (At least I don't see
> 	anything in 3.0-rt3 that looks like a scheduling decision
> 	based on ->migrate_disable, perhaps due to blindness.)

I'm also confused here, seems we just disable migration for RT task.
migrate_disable()
{
	...
		if (p->sched_class->set_cpus_allowed)
			p->sched_class->set_cpus_allowed(p, mask);
		p->rt.nr_cpus_allowed =	cpumask_weight(mask);
	...
}

Shouldn't we also forbid migration on !RT task?

Thanks,
Yong

-- 
Only stand for myself
