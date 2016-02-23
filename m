From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 23 Feb 2016 08:10:46 -0500
Message-ID: <20160223081046.529d615c@gandalf.local.home>
References: <cover.1456157869.git.bristot@redhat.com>
	<f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
	<20160222173259.GM6357@twins.programming.kicks-ass.net>
	<20160222124854.3816fec4@gandalf.local.home>
	<20160222213017.GN6357@twins.programming.kicks-ass.net>
	<20160222173043.24873ae8@gandalf.local.home>
	<20160223104408.GO6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160223104408.GO6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 23 Feb 2016 11:44:08 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> No it very much illustrates the problem and is a very clear indication
> that tracepoints are an ABI.

Yes they are. But note, they can change if nobody notices ;-)


> > 
> > Heh, it's not really changing state. The code directly after this is:
> > 
> > 	p->dl.runtime = 0;  
> 
> Yes, it more or less 'works', but its still atrocious shite. Its the
> worst kind of anti pattern possible.
> 
> Suppose someone comes and removes that line, and ignores the tracepoint
> stuff, because, hell its a tracepoint, those don't modify stuff.
> 
> Its just really, utterly bad practice.
> 
> You've done this tracing code long enough, you really should _KNOW_
> this.

You're right. I got too caught up in the cleverness of the hack to
acknowledge it is a hack.

But Daniel has a patch to clean up the yield code which would also help
in making this hack unnecessary for this tracepoint.

> 
> > > So tell me why these specific tracepoints and why the existing ones
> > > could not be extended to include this information. For example, why a
> > > trace_sched_dealine_yield, and not a generic trace_sched_yield() that
> > > works for all classes.  
> > 
> > But what about reporting actual runtime, and when the next period will
> > come. That only matters for deadline.  
> 
> How is that an answer to the question? Are you implying a generic
> trace_sched_yield() call could not do this?
> 
> > > But do not present me with a bunch of random arse, hacked together
> > > tracepoints and tell me they might be useful, maybe.  
> > 
> > 
> > They ARE useful. These are the tracepoints I'm currently using to
> > debug the deadline scheduler with. They have been indispensable for my
> > current work.  
> 
> They are, most obviously, a hacked together debug session for sure. This
> is _NOT_ what you commit.
> 
> Now ideally we'd do something like the below, but because trainwreck, we
> cannot actually do this I think :-(
> 
> It gets you about half of what your patch does, but shows how to also
> do a generic sched_yield(). The replenish might have to remain special,
> although both CFS and RT also have replenishes, albeit significantly
> different.

OK, I admit. I was very single focused on deadline scheduler. I wasn't
looking at how this could work with the rest of the scheduler. I'll
take a look at the patches you posted.

Thanks!

-- Steve
