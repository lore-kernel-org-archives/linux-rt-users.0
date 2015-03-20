From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Fri, 20 Mar 2015 11:31:20 +0100
Message-ID: <20150320103120.GZ23123@twins.programming.kicks-ass.net>
References: <20150318144946.2f3cc982@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150318144946.2f3cc982@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Mar 18, 2015 at 02:49:46PM -0400, Steven Rostedt wrote:
> 
> When debugging the latencies on a 40 core box, where we hit 300 to
> 500 microsecond latencies, I found there was a huge contention on the
> runqueue locks.
> 
> Investigating it further, running ftrace, I found that it was due to
> the pulling of RT tasks.
> 
> The test that was run was the following:
> 
>  cyclictest --numa -p95 -m -d0 -i100
> 
> This created a thread on each CPU, that would set its wakeup in iterations
> of 100 microseconds. The -d0 means that all the threads had the same
> interval (100us). Each thread sleeps for 100us and wakes up and measures
> its latencies.
> 
> cyclictest is maintained at:
>  git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
> 
> What happened was another RT task would be scheduled on one of the CPUs
> that was running our test, when the other CPU tests went to sleep and
> scheduled idle. This caused the "pull" operation to execute on all
> these CPUs. Each one of these saw the RT task that was overloaded on
> the CPU of the test that was still running, and each one tried
> to grab that task in a thundering herd way.
> 
> To grab the task, each thread would do a double rq lock grab, grabbing
> its own lock as well as the rq of the overloaded CPU. As the sched
> domains on this box was rather flat for its size, I saw up to 12 CPUs
> block on this lock at once. This caused a ripple affect with the
> rq locks especially since the taking was done via a double rq lock, which
> means that several of the CPUs had their own rq locks held while trying
> to take this rq lock. As these locks were blocked, any wakeups or load
> balanceing on these CPUs would also block on these locks, and the wait
> time escalated.
> 
> I've tried various methods to lessen the load, but things like an
> atomic counter to only let one CPU grab the task wont work, because
> the task may have a limited affinity, and we may pick the wrong
> CPU to take that lock and do the pull, to only find out that the
> CPU we picked isn't in the task's affinity.
> 
> Instead of doing the PULL, I now have the CPUs that want the pull to
> send over an IPI to the overloaded CPU, and let that CPU pick what
> CPU to push the task to. No more need to grab the rq lock, and the
> push/pull algorithm still works fine.
> 
> With this patch, the latency dropped to just 150us over a 20 hour run.
> Without the patch, the huge latencies would trigger in seconds.
> 
> I've created a new sched feature called RT_PUSH_IPI, which is enabled
> by default.
> 
> When RT_PUSH_IPI is not enabled, the old method of grabbing the rq locks
> and having the pulling CPU do the work is implemented. When RT_PUSH_IPI
> is enabled, the IPI is sent to the overloaded CPU to do a push.
> 
> To enabled or disable this at run time:
> 
>  # mount -t debugfs nodev /sys/kernel/debug
>  # echo RT_PUSH_IPI > /sys/kernel/debug/sched_features
> or
>  # echo NO_RT_PUSH_IPI > /sys/kernel/debug/sched_features
> 
> Update: This original patch would send an IPI to all CPUs in the RT overload
> list. But that could theoretically cause the reverse issue. That is, there
> could be lots of overloaded RT queues and one CPU lowers its priority. It would
> then send an IPI to all the overloaded RT queues and they could then all try
> to grab the rq lock of the CPU lowering its priority, and then we have the
> same problem.
> 
> The latest design sends out only one IPI to the first overloaded CPU. It tries to
> push any tasks that it can, and then looks for the next overloaded CPU that can
> push to the source CPU. The IPIs stop when all overloaded CPUs that have pushable
> tasks that have priorities greater than the source CPU are covered. In case the
> source CPU lowers its priority again, a flag is set to tell the IPI traversal to
> restart with the first RT overloaded CPU after the source CPU.
> 
> Parts-suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

OK, queued it. Do we want to look into making the same change for
deadline once this has settled?
