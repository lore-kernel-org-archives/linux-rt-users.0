From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Date: Wed, 10 Oct 2018 14:24:54 +0200
Message-ID: <20181010122454.GR5663@hirez.programming.kicks-ass.net>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181010115639.GA25534@sisyphus.home.austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Cc: Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, linux-rt-users@vger.kernel.org
To: Henrik Austad <henrik@austad.us>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010115639.GA25534@sisyphus.home.austad.us>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 10, 2018 at 01:56:39PM +0200, Henrik Austad wrote:
> On Tue, Oct 09, 2018 at 11:24:26AM +0200, Juri Lelli wrote:
> > Hi all,
>=20
> Hi, nice series, I have a lot of details to grok, but I like the idea of =
PE
>=20
> > Proxy Execution (also goes under several other names) isn't a new
> > concept, it has been mentioned already in the past to this community
> > (both in email discussions and at conferences [1, 2]), but no actual
> > implementation that applies to a fairly recent kernel exists as of today
> > (of which I'm aware of at least - happy to be proven wrong).
> >=20
> > Very broadly speaking, more info below, proxy execution enables a task
> > to run using the context of some other task that is "willing" to
> > participate in the mechanism, as this helps both tasks to improve
> > performance (w.r.t. the latter task not participating to proxy
> > execution).
>=20
> From what I remember, PEP was originally proposed for a global EDF, and a=
s=20
> far as my head has been able to read this series, this implementation is=
=20
> planned for not only deadline, but eventuall also for sched_(rr|fifo|othe=
r)=20
> - is that correct?

This implementation covers every scheduling class unconditionally. It
directly uses the scheduling function to order things; where PI
re-implements the FIFO scheduling function to order the blocked lists.

> I have a bit of concern when it comes to affinities and and where the=20
> lock owner will actually execute while in the context of the proxy,=20
> especially when you run into the situation where you have disjoint CPU=20
> affinities for _rr tasks to ensure the deadlines.

The affinities of execution contexts are respected.

> I believe there were some papers circulated last year that looked at=20
> something similar to this when you had overlapping or completely disjoint=
=20
> CPUsets I think it would be nice to drag into the discussion. Has this be=
en=20
> considered? (if so, sorry for adding line-noise!)

Hurm, was that one of Bjorn's papers? Didn't that deal with AC of
disjoint/overlapping sets?

> > One can define the scheduling context of a task as all the information
> > in task_struct that the scheduler needs to implement a policy and the
> > execution contex as all the state required to actually "run" the task.
> > An example of scheduling context might be the information contained in
> > task_struct se, rt and dl fields; affinity pertains instead to execution
> > context (and I guess decideing what pertains to what is actually up for
> > discussion as well ;-). Patch 04/08 implements such distinction.
>=20
> I really like the idea of splitting scheduling ctx and execution context!

Right; so this whole thing relies on 'violating' affinities for
scheduling contexts, but respects affinities for execution contexts.

The basic observation is that affinities only matter when you execute
code.

This then also gives a fairly clear definition of what an execution
context is.
