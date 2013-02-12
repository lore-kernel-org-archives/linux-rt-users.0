From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH] sched/rt: Unthrottle the highest RT task of the rq if
 there are no another available tasks to be picked
Date: Tue, 12 Feb 2013 08:06:49 +0100
Message-ID: <1360652809.4657.87.camel@marge.simpson.net>
References: <2260671360618316@web22h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2260671360618316@web22h.yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2013-02-12 at 01:31 +0400, Kirill Tkhai wrote: 
> It's possible a situation when rq->rt is throttled or
> it has no child entities and there are RT tasks ready
> for execution in the rq which are the only tasks
> of TASK_RUNNING state. In this case pick_next_task
> takes idle tasks and idle wastes cpu time.

That's not a waste of CPU time, that's utilization enforcement the thing
it is designed to do.  I'd rather see borrowing go away, bodyguard being
either a ruthless thug who may save your bacon, or unemployed.  AFAIKT,
the throttle is useless in any other role, just having it standing
around glaring across the room occasionally can turn sensitive realtime
into a quaking heap of jello.

-Mike
