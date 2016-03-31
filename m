From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline scheduler
Date: Thu, 31 Mar 2016 06:19:40 +0100
Message-ID: <20160331051940.GC7049@pablo>
References: <cover.1459182044.git.bristot@redhat.com>
 <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
 <20160329151649.GA12845@twins.programming.kicks-ass.net>
 <56FAA8FA.5060407@redhat.com>
 <20160329131343.3b2bcf76@gandalf.local.home>
 <56FAD3A6.20205@redhat.com>
 <20160329152510.3e0f0010@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160329152510.3e0f0010@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On 29/03/16 15:25, Steven Rostedt wrote:
> On Tue, 29 Mar 2016 16:12:38 -0300
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
> > On 03/29/2016 02:13 PM, Steven Rostedt wrote:
> > >>           <idle>-0     [007] d..3 78377.688969: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=b next_pid=18973 next_prio=-1  
> > >> >                b-18973 [007] d..3 78377.688979: sched_deadline_block: now=78377.688976271 deadline=78377.718945137 remaining_runtime=9968866
> > >> >                b-18973 [007] d..3 78377.688981: sched_switch: prev_comm=b prev_pid=18973 prev_prio=-1 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120  
> > > Why did it go to sleep? The above is still not very useful. What do you
> > > mean "blocking on a system call"?  
> > 
> > A task can go can to sleep in a blocking system call, like waiting
> > a network packet, or any other external event.
> 
> Note, waiting for a network packet or some other external event is a
> userspace call. A schedule out in 'S' state means exactly that. But
> I hate the term "blocked" because that is more like waiting for
> something else to finish (like blocked on a lock). In which case, if
> that did happen, the state would be "D" not "S".
> 
> "S" is basically "sleeping" and it gets woken up by some other event. A
> slight difference to the term "blocked".
> 
> > 
> > The "block state" is a possible state of a task running in the deadline
> > scheduler. It means that a task voluntarily left the processor, not
> > by calling sched_yield(), but by blocking (or sleeping) waiting another
> > event.
> > 
> > This state is described in the Figure 2 of the article "Deadline
> > scheduling in the Linux kernel", available at:
> > http://onlinelibrary.wiley.com/doi/10.1002/spe.2335/abstract
> 
> Bah, confusing terminology.
> 

Mmm, a bit of overloading yes. Should be consistent with RT literature
terminology, though (I hope :-/).

> > 
> > The block state affects the replenishment of the task, and that is why
> > it is different of both yeild and throttle. If the task blocks and is
> > awakened prior to the deadline, the task's runtime will not be
> > replenished. On the other hand it will. For example:
> > 

Not entirely true. We can have a replenishment even if the task wakes up
before the deadline, if it happens to wake up after the 0-lag point
(after which its runtime can't be recycled if we don't want to affect
others' guarantees). Anyway, this doesn't affect the discussion, I only
wanted to point out that the fact that a replenishment happened might be
useful information to get.

> > Blocking, and then waking up after the deadline:
> >                b-5152  [007] d..3  3983.376428: sched_deadline_replenish: comm=b pid=5152 now=3983.376425148 deadline=3983.406425148 runtime=10000000
> >                b-5152  [007] d..3  3983.376515: sched_deadline_block: now=3983.376511101 deadline=3983.406425148 remaining_runtime=9909566
> >                b-5152  [007] d..3  3983.376529: sched_switch: prev_comm=b prev_pid=5152 prev_prio=-1 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120
> > 
> >           <idle>-0     [007] d.h4  3983.476592: sched_deadline_replenish: comm=b pid=5152 now=3983.476589573 deadline=3983.506589573 runtime=10000000
> >           <idle>-0     [007] dNh4  3983.476596: sched_wakeup: comm=b pid=5152 prio=-1 target_cpu=007
> >           <idle>-0     [007] d..3  3983.476648: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=b next_pid=5152 next_prio=-1
> >                b-5152  [007] d..3  3983.476660: sched_deadline_block: now=3983.476656613 deadline=3983.506589573 remaining_runtime=9932960
> >                b-5152  [007] d..3  3983.476663: sched_switch: prev_comm=b prev_pid=5152 prev_prio=-1 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120
> > 
> > 
> > Blocking, and then waking up before the deadline:
> >                b-5139  [007] d..3  3964.148290: sched_deadline_replenish: comm=b pid=5139 now=3964.148285227 deadline=3964.178285227 runtime=10000000
> >                b-5139  [007] d..3  3964.148396: sched_deadline_block: now=3964.148385308 deadline=3964.178285227 remaining_runtime=9895243
> >                b-5139  [007] d..3  3964.148400: sched_switch: prev_comm=b prev_pid=5139 prev_prio=-1 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120
> > 
> >           <idle>-0     [007] dNh5  3964.148411: sched_wakeup: comm=b pid=5139 prio=-1 target_cpu=007
> >           <idle>-0     [007] d..3  3964.148419: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=b next_pid=5139 next_prio=-1
> >                b-5139  [007] d..3  3964.148427: sched_deadline_block: now=3964.148426022 deadline=3964.178285227 remaining_runtime=9878164
> >                b-5139  [007] d..3  3964.148429: sched_switch: prev_comm=b prev_pid=5139 prev_prio=-1 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120
> > 
> 
> I still fail to see the usefulness of the block tracepoint. I could
> imagine that if we add the dynamic part of the sched_switch tracepoint
> to include deadline and runtime, we would get the same information.
> 

Right. It seems to me that knowing when a task switched-off should be
enough information (given that we have the dynamic part), complemented
by having or not having a replenishment at wakeup.

Thanks,

- Juri
