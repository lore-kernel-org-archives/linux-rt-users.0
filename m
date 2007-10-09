From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/5] RT: scheduler fixes and rt_overload enhancements
Date: Tue, 9 Oct 2007 11:00:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710091054430.21404@gandalf.stny.rr.com>
References: <20071009142044.4941.65189.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	kravetz@us.ibm.com, LKML <linux-kernel@vger.kernel.org>,
	pmorreale@novell.com, sdietrich@novell.com,
	Peter Zijlstra <peterz@infradead.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756313AbXJIPB2@vger.kernel.org>
In-Reply-To: <20071009142044.4941.65189.stgit@novell1.haskins.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



--
On Tue, 9 Oct 2007, Gregory Haskins wrote:
> Hi All,

Hi Gregory,

>
> The first two patches are from Mike and Steven on LKML, which the rest of my
> series is dependent on.  Patch #4 is a resend from earlier.
>
> Series Summary:
>
> 1) Send IPI on overload regardless of whether prev is an RT task

OK.

> 2) Set the NEEDS_RESCHED flag on reception of RESCHED_IPI

Peter Zijlstra and I have been discussing this IPI Resched change a bit.
It seems that it is too much overkill for what is needed. That is, the
send_reschedule is used elsewhere where we do not want to actually do a
schedule.

I'm thinking about trying out a method that each rq has the priority of
the current task that is running. On case where we get an rt overload
(like in the finish_task_switch) we do a scan of all CPUS (not taking any
locks) and find the CPU which the lowest priority. If that CPU has a lower
prioirty than a waiting task to run on the current CPU then we grab the
lock for that rq, check to see if the priority is still lower, and then
push the rt task over to that CPU.

If after taking the rq lock a schedule had taken place and a higher RT
task is running, then we would try again, two more times. If this
phenomenon happens two more times, we punt and wouldn't do anything else
(paranoid attempt to fall into trying over and over on a high context
switch RT system).


> 3) Fix a mistargeted IPI on overload
> 4) Track which CPUS are in overload for efficiency
> 5) Track which CPUs are eligible for rebalancing for efficiency

The above three may be obsoleted by this new algorithm.

-- Steve
