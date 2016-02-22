From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Mon, 22 Feb 2016 17:11:42 -0300
Message-ID: <56CB6B7E.9020304@redhat.com>
References: <cover.1456157869.git.bristot@redhat.com>
 <f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
 <20160222173259.GM6357@twins.programming.kicks-ass.net>
 <20160222124854.3816fec4@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47717 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbcBVULp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Feb 2016 15:11:45 -0500
In-Reply-To: <20160222124854.3816fec4@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 02/22/2016 02:48 PM, Steven Rostedt wrote:
> On Mon, 22 Feb 2016 18:32:59 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> 
>> > So I'm a bit allergic to tracepoints and this is very flimsy on reasons
>> > why I would want to do this.
> Because there's no way to know if SCHED_DEADLINE tasks are doing what
> they suppose to without hacking the kernel and adding your own
> tracepoints.

That is the point. A potential deadline user would have to become a
sched deadline developer to be able to debug its deadline tasks.

Given that many deadline scheduler users are expected from application
field, e.g. automation, and that these users generally do not even know
how to compile a kernel, having a "ready to use" way to observe sched
deadline specific points of interest is essential for deadline
scheduler adoption.

For example, the runtime is an estimated value because there is no
deterministic way define it, so be able to observe the remaining runtime
at the end of an activation is very useful to define a tighter runtime.
On the other hand, it is possible to defined that runtime was under
estimated just by observing that a task was throttled.

Another example: be able to see that a task is blocking in the middle of
an activation is useful on the identification of an unexpected behavior
of a deadline task.

Although it is possible to guess many things by doing user-space
measurements, by using a set of other tracepoints, or even by using both
together. The debug process will not be as easy and precise as using
these four tracepoints.

-- Daniel
