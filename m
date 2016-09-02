From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Force processes to non-realtime before mm_exit
Date: Fri, 2 Sep 2016 17:02:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609021700530.5647@nanos>
References: <1464995924-16367-1-git-send-email-brian@peloton-tech.com> <20160714172429.GH30935@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Brian Silverman <brian@peloton-tech.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        bigeasy@linutronix.de, Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54373 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753563AbcIBPEv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Sep 2016 11:04:51 -0400
In-Reply-To: <20160714172429.GH30935@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 14 Jul 2016, Peter Zijlstra wrote:
> On Fri, Jun 03, 2016 at 04:18:44PM -0700, Brian Silverman wrote:
> > Without this, a realtime process which has called mlockall exiting
> > causes large latencies for other realtime processes at the same or
> > lower priorities. This seems like a fairly common use case too, because
> > realtime processes generally want their memory locked into RAM.
> 
> So I'm not too sure..  SCHED_FIFO/RR are a complete trainwreck and
> provide absolutely no isolation from badly behaving tasks what so ever,
> so I'm not too inclined to protect them from exit either, its just one
> more way in which they can cause pain.
> 
> But aside from the, the patch has issues..
> 
> > +++ b/kernel/exit.c
> > @@ -730,6 +730,12 @@ void do_exit(long code)
> >  	tsk->exit_code = code;
> >  	taskstats_exit(tsk, group_dead);
> >  
> > +	if (tsk->policy == SCHED_FIFO || tsk->policy == SCHED_RR) {
> > +		struct sched_param param = { .sched_priority = 0 };
> > +
> > +		sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> > +	}
> > +
> >  	exit_mm(tsk);
> 
> That only does half a job. You forget about SCHED_DEADLINE and negative
> nice tasks.
> 
> Something like the below perhaps... But yeah, unconvinced.

I agree that FIFO/RR can cause pain, but running exit_mm() with RT priority
or consuming DL time is silly.
 
FWIW: Acked-by-me
