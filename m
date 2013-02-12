From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Unthrottle the highest RT task of the rq if
 there are no another available tasks to be picked
Date: Tue, 12 Feb 2013 09:46:18 -0500
Message-ID: <1360680378.21867.8.camel@gandalf.local.home>
References: <2260671360618316@web22h.yandex.ru>
	 <1360652809.4657.87.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Kirill Tkhai <tkhai@yandex.ru>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360652809.4657.87.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2013-02-12 at 08:06 +0100, Mike Galbraith wrote:
> On Tue, 2013-02-12 at 01:31 +0400, Kirill Tkhai wrote: 
> > It's possible a situation when rq->rt is throttled or
> > it has no child entities and there are RT tasks ready
> > for execution in the rq which are the only tasks
> > of TASK_RUNNING state. In this case pick_next_task
> > takes idle tasks and idle wastes cpu time.
> 
> That's not a waste of CPU time, that's utilization enforcement the thing
> it is designed to do.  I'd rather see borrowing go away, bodyguard being
> either a ruthless thug who may save your bacon, or unemployed.  AFAIKT,
> the throttle is useless in any other role, just having it standing
> around glaring across the room occasionally can turn sensitive realtime
> into a quaking heap of jello.

I guess what Mike is saying is, you can do a bunch of tests, and if it
happens to throttle, you wont notice because the system happened to be
idle.

Now if you are running in production, and hit the throttle, where
there's tasks to run, you're production system just went *THUNK*.

Now in argument for the "borrowing" of idle, I do believe that the
throttle does still occur, and you get a nasty output on the console.
But not everyone reads those.

-- Steve
