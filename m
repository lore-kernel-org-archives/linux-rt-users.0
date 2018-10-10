From: luca abeni <luca.abeni@santannapisa.it>
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Date: Wed, 10 Oct 2018 13:16:29 +0200
Message-ID: <20181010131629.6623ddb4@luca64>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
        <20181010123417.26c682ef@luca64>
        <20181010105710.GP5728@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010105710.GP5728@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 10 Oct 2018 12:57:10 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 10, 2018 at 12:34:17PM +0200, luca abeni wrote:
> > So, I would propose to make the proxy() function of patch more
> > generic, and not strictly bound to mutexes. Maybe a task structure
> > can contain a list of tasks for which the task can act as a proxy,
> > and we can have a function like "I want to act as a proxy for task
> > T" to be invoked when a task blocks?  
> 
> Certainly possible, but that's something I'd prefer to look at after
> it all 'works'.

Of course :)
I was mentioning this idea because maybe it can have some impact on the
design.

BTW, here is another "interesting" issue I had in the past with changes
like this one: how do we check if the patchset works as expected?

"No crashes" is surely a requirement, but I think we also need some
kind of testcase that fails if the inheritance mechanism is not working
properly, and is successful if the inheritance works.

Maybe we can develop some testcase based on rt-app (if noone has such a
testcase already)


			Thanks,
				Luca
> The mutex blocking thing doesn't require external
> interfaces etc..
