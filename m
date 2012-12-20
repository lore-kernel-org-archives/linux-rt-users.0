From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Move cpu rq properties from "struct rt_rq" to
 "struct rq"
Date: Thu, 20 Dec 2012 18:07:45 -0500
Message-ID: <1356044865.5896.78.camel@gandalf.local.home>
References: <4807701355857948@web19f.yandex.ru>
	 <alpine.LFD.2.02.1212201852060.3148@ionos>
	 <401821356041818@web4f.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <401821356041818@web4f.yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2012-12-21 at 02:16 +0400, Kirill Tkhai wrote:
> 20.12.2012, 21:53, "Thomas Gleixner" <tglx@linutronix.de>:
> > On Tue, 18 Dec 2012, Kirill Tkhai wrote:
> >
> >>  The members rt_nr_total, rt_nr_migratory, overloaded and pushable_tasks are
> >>  properties of cpu runqueue, not group rt_rq.
> >
> > Why?
> 
> Because, they depend on number and properties of all processes of rq, not of nested rt_rq.
> 

You're answer is still confusing.

	struct rq {
		[...]
		struct rt_rq rt;


rt_rq is just a part of rq. What's the point?

	rq = container_of(rt_rq, struct rt_rq, rt);

As the comment above struct rt_rq says:

/* Real-Time classes' related field in a runqueue: */

Those look like fields related to the Real-Time class. I don't see them
used outside of kernel/sched/rt.c

-- Steve

> >
> > Thanks,
> >
> >         tglx
