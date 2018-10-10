From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Date: Wed, 10 Oct 2018 14:36:10 +0200
Message-ID: <20181010123610.GN9130@localhost.localdomain>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181010115639.GA25534@sisyphus.home.austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, linux-rt-users@vger.kernel.org
To: Henrik Austad <henrik@austad.us>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010115639.GA25534@sisyphus.home.austad.us>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 10/10/18 13:56, Henrik Austad wrote:
> On Tue, Oct 09, 2018 at 11:24:26AM +0200, Juri Lelli wrote:
> > Hi all,
> 
> Hi, nice series, I have a lot of details to grok, but I like the idea of PE
> 
> > Proxy Execution (also goes under several other names) isn't a new
> > concept, it has been mentioned already in the past to this community
> > (both in email discussions and at conferences [1, 2]), but no actual
> > implementation that applies to a fairly recent kernel exists as of today
> > (of which I'm aware of at least - happy to be proven wrong).
> > 
> > Very broadly speaking, more info below, proxy execution enables a task
> > to run using the context of some other task that is "willing" to
> > participate in the mechanism, as this helps both tasks to improve
> > performance (w.r.t. the latter task not participating to proxy
> > execution).
> 
> From what I remember, PEP was originally proposed for a global EDF, and as 
> far as my head has been able to read this series, this implementation is 
> planned for not only deadline, but eventuall also for sched_(rr|fifo|other) 
> - is that correct?

Correct, this is cross class.

> I have a bit of concern when it comes to affinities and and where the 
> lock owner will actually execute while in the context of the proxy, 
> especially when you run into the situation where you have disjoint CPU 
> affinities for _rr tasks to ensure the deadlines.

Well, it's the (scheduler context) of the proxy that is potentially
moved around. Lock owner stays inside its affinity.

> I believe there were some papers circulated last year that looked at 
> something similar to this when you had overlapping or completely disjoint 
> CPUsets I think it would be nice to drag into the discussion. Has this been 
> considered? (if so, sorry for adding line-noise!)

I think you refer to BBB work. Not sure if it applies here, though
(considering what above).

> Let me know if my attempt at translating brainlanguage into semi-coherent 
> english failed and I'll do another attempt

You succeeded! (that's assuming that I got your questions right of
course :)
> 
> > This RFD/proof of concept aims at starting a discussion about how we can
> > get proxy execution in mainline. But, first things first, why do we even
> > care about it?
> > 
> > I'm pretty confident with saying that the line of development that is
> > mainly interested in this at the moment is the one that might benefit
> > in allowing non privileged processes to use deadline scheduling [3].
> > The main missing bit before we can safely relax the root privileges
> > constraint is a proper priority inheritance mechanism, which translates
> > to bandwidth inheritance [4, 5] for deadline scheduling, or to some sort
> > of interpretation of the concept of running a task holding a (rt_)mutex
> > within the bandwidth allotment of some other task that is blocked on the
> > same (rt_)mutex.
> > 
> > The concept itself is pretty general however, and it is not hard to
> > foresee possible applications in other scenarios (say for example nice
> > values/shares across co-operating CFS tasks or clamping values [6]).
> > But I'm already digressing, so let's get back to the code that comes
> > with this cover letter.
> > 
> > One can define the scheduling context of a task as all the information
> > in task_struct that the scheduler needs to implement a policy and the
> > execution contex as all the state required to actually "run" the task.
> > An example of scheduling context might be the information contained in
> > task_struct se, rt and dl fields; affinity pertains instead to execution
> > context (and I guess decideing what pertains to what is actually up for
> > discussion as well ;-). Patch 04/08 implements such distinction.
> 
> I really like the idea of splitting scheduling ctx and execution context!
> 
> > As implemented in this set, a link between scheduling contexts of
> > different tasks might be established when a task blocks on a mutex held
> > by some other task (blocked_on relation). In this case the former task
> > starts to be considered a potential proxy for the latter (mutex owner).
> > One key change in how mutexes work made in here is that waiters don't
> > really sleep: they are not dequeued, so they can be picked up by the
> > scheduler when it runs.  If a waiter (potential proxy) task is selected
> > by the scheduler, the blocked_on relation is used to find the mutex
> > owner and put that to run on the CPU, using the proxy task scheduling
> > context.
> > 
> >    Follow the blocked-on relation:
> >   
> >                   ,-> task           <- proxy, picked by scheduler
> >                   |     | blocked-on
> >                   |     v
> >      blocked-task |   mutex
> >                   |     | owner
> >                   |     v
> >                   `-- task           <- gets to run using proxy info
> > 
> > Now, the situation is (of course) more tricky than depicted so far
> > because we have to deal with all sort of possible states the mutex
> > owner might be in while a potential proxy is selected by the scheduler,
> > e.g. owner might be sleeping, running on a different CPU, blocked on
> > another mutex itself... so, I'd kindly refer people to have a look at
> > 05/08 proxy() implementation and comments.
> 
> My head hurt already.. :)

Eh. I was wondering about putting even more details in the cover. But
then I thought that it might have been enough info already for this
first spin. Guess we'll have to create proper docs (after how to
properly implement this has been agreed upon?).

> > Peter kindly shared his WIP patches with us (me, Luca, Tommaso, Claudio,
> > Daniel, the Pisa gang) a while ago, but I could seriously have a decent
> > look at them only recently (thanks a lot to the other guys for giving a
> > first look at this way before me!). This set is thus composed of Peter's
> > original patches (which I rebased on tip/sched/core as of today,
> > commented and hopefully duly reported in changelogs what have I possibly
> > broke) plus a bunch of additional changes that seemed required to make
> > all this boot "successfully" on a virtual machine. So be advised! This
> > is good only for fun ATM (I actually really hope this is good enough for
> > discussion), pretty far from production I'm afraid. Share early, share
> > often, right?  :-)
> 
> I'll give it a spin and see if it boots, then I probably have a ton of 
> extra questions :)

Thanks! (I honestly expect sparks.. but it'll give us clues what needs
to be fixing)

Thanks a lot for looking at this.

Best,

- Juri
