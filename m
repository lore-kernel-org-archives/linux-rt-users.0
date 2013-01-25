From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Don't pull tasks of throttled rt_rq in
 pre_schedule_rt()
Date: Thu, 24 Jan 2013 21:47:46 -0500
Message-ID: <1359082066.21576.198.camel@gandalf.local.home>
References: <1286111356423652@web16f.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:4990 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269Ab3AYCrt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Jan 2013 21:47:49 -0500
In-Reply-To: <1286111356423652@web16f.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry for the late reply.

On Tue, 2012-12-25 at 12:20 +0400, Kirill Tkhai wrote:
> The patch aims not to pull tasks of throttled rt_rqs
> in pre_schedule_rt() because thay are not able to be
> picked in pick_next_task_rt().
> 
> There are three places where pull_rt_task() is used:
> 
> 1)pre_schedule_rt()
> If we pull a task of a throttled rt_rq it won't be picked
> by pick_next_task_rt(), because throttled tasks are dequeued
> by sched_rt_runtime_exceeded(). So this action is unnecessary.
> 
> 2)prio_changed_rt()
> A pulled task of higher priority leads to reschedule of current
> rq's task. The schedule() will occur with the first hw interrupt
> so there is possibility the throttled rt_rq will unthrottle and
> it will be queued during this time.
> (In case of preemptable kernel schedule() occurs during
> preempt_enable() in call of __task_rq_unlock(). But its lock is
> unlocked so there is no guarantee the rt_rq won't be queued).
> 
> 3)switched_from_rt()
> The same as prio_changed_rt().

These are pretty much hot paths. They are done rather commonly. My
concern is that we are adding overhead here that can be done in a much
less common path.

I'm wondering if we couldn't use the pushable_task list for finding the
next highest rt task. That may even speed up the fast path if we do so.

Then, when an rq gets throttled, which shouldn't be often, we can remove
all the tasks from the pushable_task list, and add them back when the rq
is comes back up.

Then, by just using the pushable_task list, we can achieve this goal.

We have to look to see what prevents us from using that list.

-- Steve


