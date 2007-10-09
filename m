From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH RT] push waiting rt tasks to cpus with lower prios.
Date: Tue, 9 Oct 2007 16:50:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710091645110.25406@gandalf.stny.rr.com>
References: <20071009142044.4941.65189.stgit@novell1.haskins.net>
 <Pine.LNX.4.58.0710091054430.21404@gandalf.stny.rr.com>
 <1191944024.4281.72.camel@ghaskins-t60p.haskins.net>
 <1191952777.23198.8.camel@localhost.localdomain> <20071009203936.GB23388@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <ghaskins@novell.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, pmorreale@novell.com,
	sdietrich@novell.com
To: mike kravetz <kravetz@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:55093 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbXJIUvq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 16:51:46 -0400
In-Reply-To: <20071009203936.GB23388@monkey.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Tue, 9 Oct 2007, mike kravetz wrote:

>
> I did something like this a while ago for another scheduling project.
> A couple 'possible' optimizations to think about are:
> 1) Only scan the remote runqueues once and keep a local copy of the
>    remote priorities for subsequent 'scans'.  Accessing the remote
>    runqueus (CPU specific cache lines) can be expensive.

You mean to keep the copy for the next two tries?

> 2) When verifying priorities, just perform spin_trylock() on the remote
>    runqueue.  If you can immediately get it great.  If not, it implies
>    someone else is messing with the runqueue and there is a good chance
>    the data you pre-fetched (curr->Priority) is invalid.  In this case
>    it might be faster to just 'move on' to the next candidate runqueue/CPU.
>    i.e. The next highest priority that the new task can preempt.

I was a bit scared of grabing the lock anyway, because that's another
cache hit (write side). So only grabbing the lock when needed would save
us from dirting the runqueue lock for each CPU.

>
> Of course, these 'optimizations' would change the algorithm.  Trying to
> make any decision based on data that is changing is always a crap shoot. :)

Yes indeed. The aim for now is to solve the latencies that you've been
seeing. But really, there is still holes (small ones) that can cause a
latency if a schedule happened "just right". Hopefully the final result of
this work will close them too.

-- Steve
