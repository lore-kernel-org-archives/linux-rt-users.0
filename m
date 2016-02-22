From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Mon, 22 Feb 2016 18:32:59 +0100
Message-ID: <20160222173259.GM6357@twins.programming.kicks-ass.net>
References: <cover.1456157869.git.bristot@redhat.com>
 <f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57269 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbcBVRdG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Feb 2016 12:33:06 -0500
Content-Disposition: inline
In-Reply-To: <f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 22, 2016 at 02:08:21PM -0300, Daniel Bristot de Oliveira wrote:
> Deadline tasks behave differently of other tasks because deadline
> task's also depend on their period, deadline and runtime.
> 
> Hence, the well known sched:sched_wakeup and sched:sched_switch
> tracepoints are not always enough to precisely explain the behavior of a
> deadline task with respect to the task's period, deadline, and runtime
> consumption and replenishment.
> 
> In order to provide more precise information about the scheduling of
> deadline tasks, this patch implements the following tracepoints:
> 
> - sched:sched_deadline_replenish: Informs the runtime replenishment of
> a deadline task. Trace example:
> 
>   <idle>-0     [010] d.h.   268.428878: sched_deadline_replenish: \
> 	comm=y pid=1608 now=268.428876113 deadline=268.458863627  \
> 	runtime=20000000
> 
> The task y-1608 was replenished with 20000000 ns at 268.428876113
> to be used until the deadline at 268.458863627.
> 
> - sched:sched_deadline_yield: Informs that a deadline task called
> sched_yield(), and will wait for the next period. Trace example:
> 
>   y-1608  [010] d...   268.428892: sched_deadline_yield: 	\
> 	now=268.428891932 deadline=268.458863627		\
> 	remaining_runtime=19995653
> 
> The task y-1608 yielded before its deadline, with 19995653 ns of
> remaining runtime.
> 
> - sched:sched_deadline_throttle: Informs that a task consumed all its
> available runtime and was throttled. Trace example:
> 
>   t-1613  [011] d.h.   280.419823: sched_deadline_throttle:	\
> 	now=280.419823282 deadline=280.430683206 		\
> 	remaining_runtime=-13280
> 
> The task t-1613 overrun its runtime by 13280 ns and was throttled.
> 
> - sched:sched_deadline_block: Informs that a deadline task went to sleep
> waiting to be awakened by another task. Trace example:
> 
>   b-1611  [011] d...   276.228298: sched_deadline_block: 	\
> 	now=276.228295889 deadline=276.258262555
> 	remaining_runtime=19966666
> 
> The task b-1611 blocked waiting for an external event. Its deadline is at
> 276.258262555, and it stills have 19966666 ns of remaining runtime on the
> current period.

So I'm a bit allergic to tracepoints and this is very flimsy on reasons
why I would want to do this.

As it stands, the existing tracepoint have already been an ABI
trainwreck, why would I want to add more?
