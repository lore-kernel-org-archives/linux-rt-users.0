From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFD/RFC PATCH 3/8] locking/mutex: Rework task_struct::blocked_on
Date: Wed, 10 Oct 2018 13:06:11 +0200
Message-ID: <20181010110611.GK9130@localhost.localdomain>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009092434.26221-4-juri.lelli@redhat.com>
 <20181010124328.16052fd3@luca64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
To: luca abeni <luca.abeni@santannapisa.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010124328.16052fd3@luca64>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 10/10/18 12:43, luca abeni wrote:
> Hi,
> 
> On Tue,  9 Oct 2018 11:24:29 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Track the blocked-on relation for mutexes, this allows following this
> > relation at schedule time. Add blocked_task to track the inverse
> > relation.
> > 
> >                 ,-> task
> >                 |     | blocked-on
> >                 |     v
> >    blocked-task |   mutex
> >                 |     | owner
> >                 |     v
> >                 `-- task
> 
> I was a little bit confused by this description, because (if I
> understand the code well) blocked_task does not actually track the
> inverse of the "blocked_on" relationship, but just points to the task
> that is _currently_ acting as a proxy for a given task.
> 
> In theory, we could have multiple tasks blocked on "mutex" (which is
> owned by "task"), so if "blocked_task" tracked the inverse of
> "blocked_on" it should have been a list (or a data structure containing
> pointers to multiple task structures), no?
> 
> I would propose to change "blocked_task" into something like
> "current_proxy", or similar, which should be more clear (unless I
> completely misunderstood this stuff... In that case, sorry about the
> noise)

Makes sense to me. It looks also closer to what comment says.

> Also, I suspect that this "blocked_task" (or "current_proxy") field
> should be introcuced in patch 5 (same for the "task_is_blocked()"
> function from patch 4... Should it go in patch 5?)

Sure. I believe I might have wrongly split things while rebasing.
Will fix.

Thanks,

- Juri
