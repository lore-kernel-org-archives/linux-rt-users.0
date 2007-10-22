From: "Dmitry Adamushko" <dmitry.adamushko@gmail.com>
Subject: Re: [patch 6/8] pull RT tasks
Date: Tue, 23 Oct 2007 00:34:21 +0200
Message-ID: <b647ffbd0710221534h7c3e7da8g3311c39c10cb341c@mail.gmail.com>
References: <20071019184254.456160632@goodmis.org>
	 <20071019184336.983272715@goodmis.org>
	 <b647ffbd0710210459y6116e85ek3d6feba6ec98231@mail.gmail.com>
	 <1193061928.1912.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Gregory Haskins" <ghaskins@novell.com>,
	"Peter Zijlstra" <a.p.zijlstra@chello.nl>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:29219 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbXJVWeW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Oct 2007 18:34:22 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1514229wah
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Oct 2007 15:34:22 -0700 (PDT)
In-Reply-To: <1193061928.1912.26.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steven,

agreed with your comments in the previous message. Indeed, I missed some points.

> On wakeup, we can wake up several RT tasks (as my test case does) and if
> we only push one task, then the other tasks may not migrate over to the
> other run queues. I logged this happening in my tests.

I guess, what may happen is that while we are running push_rt_tasks()
on CPU-k (say, as a result on try_to_wake_up(task_1))
and as this_rq->lock may get released (in double_lock_balance()) , we
may get in a 'race'
with try_to_wake_up(task_2) from (another) CPU-m.
It places a woken up task on the same run-queue (for which
push_rt_task() is already running on CPU-k) and, actually, run
push_rt_task() for the same rq again!

So it may happen that both task_1 and task_2 will be pushed from the same CPU...

Do you see an error in my description? (it's a late hour so I can miss
something again ... sure, otherwise I'm almost perfect :-/ ) Can it
correlate with what you have observed in your tests?

Otherwise, there is 1:1 relation : push_rt_task() is called for every
new (single) task activated by try_to_wake_up() and for a preempted
task... so it's not like a few tasks are placed on the run-queue and
then push_rt_tasks() is called once.

btw., if this scenario may take place... maybe it would make sense to
have something like RTLB_INPROGRESS/PENDING and to avoid competing
push_rt_tasks() calls for the same 'rq' from different CPUs?
(although, there can be some disadvantages here as well. e.g. we would
likely need to remove 'max 3 tasks at once' limit and get,
theoretically, unbounded time spent in push_rt_tasks() on a single
CPU).


>
> -- Steve
>

-- 
Best regards,
Dmitry Adamushko
