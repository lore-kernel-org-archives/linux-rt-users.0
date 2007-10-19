From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 6/8] pull RT tasks
Date: Fri, 19 Oct 2007 15:43:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710191542130.4478@gandalf.stny.rr.com>
References: <20071019184254.456160632@goodmis.org>  <20071019184336.983272715@goodmis.org>
  <1192821893.9471.17.camel@lappy> <1192822530.9471.22.camel@lappy>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>,
	Paul Jackson <pj@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:44001 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764810AbXJSToZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2007 15:44:25 -0400
In-Reply-To: <1192822530.9471.22.camel@lappy>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Fri, 19 Oct 2007, Peter Zijlstra wrote:

> > > +
> > > +	if (likely(!atomic_read(&rt_overload)))
> > > +		return 0;
> >
> > This seems to be the only usage of rt_overload. I'm not sure its worth
> > keeping it around for this.
>
> Ingo just brought up a good point. With large smp (where large is >64)
> this will all suck chunks.
>
> rt_overload will bounce around the system, and the rto_cpumask updates
> might already hurt.
>
> The idea would be to do this per cpuset, these naturally limit the
> migraiton posibilities of tasks and would thus be the natural locality
> to break this data structure.
>

That sounds like a good idea. RT balancing on >64 CPUs should be limited.
Having a bounding cpuset would help.

I'll try to come up with something.

Thanks!

-- Steve
