From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Date: Wed, 10 Oct 2018 13:23:00 +0200
Message-ID: <20181010112300.GQ5728@hirez.programming.kicks-ass.net>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181010123417.26c682ef@luca64>
 <20181010105710.GP5728@hirez.programming.kicks-ass.net>
 <20181010131629.6623ddb4@luca64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
To: luca abeni <luca.abeni@santannapisa.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010131629.6623ddb4@luca64>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 10, 2018 at 01:16:29PM +0200, luca abeni wrote:
> On Wed, 10 Oct 2018 12:57:10 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Oct 10, 2018 at 12:34:17PM +0200, luca abeni wrote:
> > > So, I would propose to make the proxy() function of patch more
> > > generic, and not strictly bound to mutexes. Maybe a task structure
> > > can contain a list of tasks for which the task can act as a proxy,
> > > and we can have a function like "I want to act as a proxy for task
> > > T" to be invoked when a task blocks?  
> > 
> > Certainly possible, but that's something I'd prefer to look at after
> > it all 'works'.
> 
> Of course :)
> I was mentioning this idea because maybe it can have some impact on the
> design.
> 
> BTW, here is another "interesting" issue I had in the past with changes
> like this one: how do we check if the patchset works as expected?
> 
> "No crashes" is surely a requirement, but I think we also need some
> kind of testcase that fails if the inheritance mechanism is not working
> properly, and is successful if the inheritance works.
> 
> Maybe we can develop some testcase based on rt-app (if noone has such a
> testcase already)

Indeed; IIRC there is a test suite that mostly covers the FIFO-PI stuff,
that should obviously still pass. Steve, do you know where that lives?

For the extended DL stuff, we'd need new tests.
