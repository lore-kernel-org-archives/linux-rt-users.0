From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: On migrate_disable() and latencies
Date: Mon, 25 Jul 2011 10:30:53 +0200
Message-ID: <1311582653.2617.49.camel@laptop>
References: <1311329992.27400.23.camel@twins>
	 <20110723003934.GP2382@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Kumar Gala <galak@gate.crashing.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	rostedt <rostedt@goodmis.org>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41764 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab1GYI0V (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jul 2011 04:26:21 -0400
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QlGUX-0005c4-6v
	for linux-rt-users@vger.kernel.org; Mon, 25 Jul 2011 08:26:21 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1QlGUW-0002Vl-P1
	for linux-rt-users@vger.kernel.org; Mon, 25 Jul 2011 08:26:20 +0000
In-Reply-To: <20110723003934.GP2382@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2011-07-22 at 17:39 -0700, Paul E. McKenney wrote:
> > Therefore the worst case latency is in the order of
> > max-migrate-disable-period * nr-cpus.
> 
> OK, but wouldn't that be the latency as seen be the lowest-priority
> task?  

It would indeed, the utility loss is added to the preemption cost of the
lower priority tasks.

> Or are migrate-disable tasks given preferential treatment?
> If not, a prio-99 task would get the same latency either way, right?

Right.

> Migration-disable can magnify the latency seen by low-priority tasks, if
> I understand correctly.  If you disabled preemption, when a low-priority
> task became runnable, it would find an idle CPU.  But with migration
> disable, the lowest-priority task might enter a migration-disable region,
> then be preempted by a marginally higher-priority task that also enters
> a migration-diable region, and is also preempted, and so on.  The
> lowest-priority task cannot run on the current CPU because of all
> the higher-priority tasks, and cannot migrate due to being in a
> migration-disable section.

Exactly so.

> In other words, as is often the case, better worst-case service to
> the high-priority tasks can multiply the latency seen by the
> low-priority tasks.
> 
> So is the topic to quantify this?  

I suppose it is indeed. Even for the SoftRT case we need to make sure
the total utilization loss is indeed acceptable.

> If so, my take is that the latency
> to the highest-priority task decreases by an amount roughly equal to
> the duration of the longest preempt_disable() region that turned into a
> migration-disable region, while that to the lowest-priority task increases
> by N-1 times the CPU overhead of the longest migration-disable region,
> plus context switches.  (Yes, this is a very crude rule-of-thumb model.
> A real model would have much higher mathematics and might use a more
> detailed understanding of the workload.)
> 
> Or am I misunderstanding how all this works? 

No, I think you're gettin' it.

My main worry with all this is that we have these insane long !preempt
regions in mainline that are now !migrate regions, and thus per all the
above we could be looking at a substantial utilization loss.

Alternatively we could all be missing something far more horrid, but
that might just be my paranoia talking.

