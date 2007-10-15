From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/7] RT: Add support for low-priority wake-up to push_rt
 feature
Date: Mon, 15 Oct 2007 14:57:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710151452330.27710@gandalf.stny.rr.com>
References: <20071013001052.7444.8363.stgit@novell1.haskins.net>
 <20071013001559.7444.4125.stgit@novell1.haskins.net> <1192268778.27435.46.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <ghaskins@novell.com>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:35906 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbXJOS5x (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2007 14:57:53 -0400
In-Reply-To: <1192268778.27435.46.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Sat, 13 Oct 2007, Peter Zijlstra wrote:

> On Fri, 2007-10-12 at 20:15 -0400, Gregory Haskins wrote:
>
> > +/* Push all tasks that we can to other CPUs */
> > +static void push_rt_tasks(struct rq *this_rq)
> > +{
> > +	while (push_rt_task(this_rq));
> > +}
>
> I'd like to see an additional termination condition to this loop (might
> just be paranoia though).


Well if this fails to terminate, then we have a major bug.

Perhaps we can add something like this:

{
	int count = NR_CPUS * 2;

	while (push_rt_tasks(this_rq) && count--)
		;

	BUG_ON(!count);
}

Since we should do it really at most CPU times, and I added a CPU * 2 just
to be safe that we don't have a unrealistic point of moving tasks onto
other CPUS and have them finish before we finish this loop.

But really, I don't think we need to worry too much about that while loop
going too long.  It terminates when there's no more RT tasks to migrate
off to other CPUs that have lower priority tasks.

Hmm, the thing we need to be careful with here is that we need to change
the prio of the CPU, otherwise we can a task to a CPU even though a higher
one was already queued.

/me plays to fix that!

-- Steve
