From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH RT 3/4] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Tue, 11 Dec 2012 13:43:32 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1212111326310.3028@ionos>
References: <20121207235615.206108556@goodmis.org>  <20121208000900.613917378@goodmis.org> <50C682F6.5030709@am.sony.com>  <50C68922.5030203@am.sony.com> <1355190830.17101.280.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: frank.rowand@am.sony.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355190830.17101.280.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 10 Dec 2012, Steven Rostedt wrote:
> On Mon, 2012-12-10 at 17:15 -0800, Frank Rowand wrote:
> 
> > I should have also mentioned some previous experience using IPIs to
> > avoid runq lock contention on wake up.  Someone encountered IPI
> > storms when using the TTWU_QUEUE feature, thus it defaults to off
> > for CONFIG_PREEMPT_RT_FULL:
> > 
> >   #ifndef CONFIG_PREEMPT_RT_FULL
> >   /*
> >    * Queue remote wakeups on the target CPU and process them
> >    * using the scheduler IPI. Reduces rq->lock contention/bounces.
> >    */
> >   SCHED_FEAT(TTWU_QUEUE, true)
> >   #else
> >   SCHED_FEAT(TTWU_QUEUE, false)
> > 
> 
> Interesting, but I'm wondering if this also does it for every wakeup? If
> you have 1000 tasks waking up on another CPU, this could potentially
> send out 1000 IPIs. The number of IPIs here looks to be # of tasks
> waking up, and perhaps more than that, as there could be multiple
> instances that try to wake up the same task.

Not using the TTWU_QUEUE feature limits the IPIs to a single one,
which is only sent if the newly woken task preempts the current task
on the remote cpu and the NEED_RESCHED flag was not yet set.
 
With TTWU_QUEUE you can induce massive latencies just by starting
hackbench. You get a herd wakeup on CPU0 which then enqueues hundreds
of tasks to the remote pull list and sends IPIs. The remote CPUs pulls
the tasks and activate them on their runqueue in hard interrupt
context. That easiliy can accumulate to hundreds of microseconds when
you do a mass push of newly woken tasks.

Of course it avoids fiddling with the remote rq lock, but it becomes
massivly non deterministic.

> Now this patch set, the # of IPIs is limited to the # of CPUs. If you
> have 4 CPUs, you'll get a storm of 3 IPIs. That's a big difference.

Yeah, the big difference is that you offload the double lock to the
IPI. So in the worst case you interrupt the most latency sensitive
task running on the remote CPU. Not sure if I really like that
"feature".
 
Thanks,

	tglx
