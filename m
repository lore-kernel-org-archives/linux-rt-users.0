From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFD/RFC PATCH 5/8] sched: Add proxy execution
Date: Thu, 11 Oct 2018 15:42:24 +0200
Message-ID: <20181011134224.GT9130@localhost.localdomain>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009092434.26221-6-juri.lelli@redhat.com>
 <20181010131048.54afd1b6@luca64>
 <20181011123448.GS9130@localhost.localdomain>
 <20181011125325.GA9867@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: luca abeni <luca.abeni@santannapisa.it>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011125325.GA9867@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 11/10/18 14:53, Peter Zijlstra wrote:

[...]

> I think it was the safe and simple choice; note that we're not migrating
> just a single @p, but a whole chain of @p. rq->curr must not be any of the
> possible @p's. rq->idle, is per definition not one of the @p's.
> 
> Does that make sense?

It does, and I guess is most probably the safest choice indeed. But,
just to put together a proper comment for next version..

The chain we are migrating is composed of blocked_task(s), so tasks that
blocked on a mutex owned by @p. Now, if such a chain has been built, it
means that proxy() has been called "for" @p previously, and @p might be
curr while one of its waiters might be proxy. So, none of the blocked_
task(s) should be rq->curr (even if one of their scheduling context
might be in use)?
