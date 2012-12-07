From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT 0/4] sched/rt: Lower rq lock contention latencies on many CPU boxes
Date: Fri, 07 Dec 2012 18:56:15 -0500
Message-ID: <20121207235615.206108556@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I've been debugging large latencies on a 40 core box and found a major
cause due to the thundering herd like grab of the rq lock due to the
pull_rt_task() logic.

Basically, if a large number of CPUs were to lower its priority roughly
the same time, they would all trigger a pull. If there happens to be
only one CPU available to get a task, all CPUs doing the pull will try
to grab it. In doing so, they will all contend on the rq lock of
the overloaded CPU. Only one CPU will succeed in pulling the task
and unfortunately, there's no quick way to know which, as it's dependent
on the affinitiy of the task that needs to be pulled, and to look at that,
we need to grab its rq lock!

Instead of having the pull logic grab the rq locks and do the work to
switch the task over to the pulling CPU, this patch series (well patch
#3) has the pulling CPU send an IPI to the overloaded CPU and that
CPU will do the push instead. The push logic uses the cpupri.c code
to quickly find the best CPU to offload the overloaded RT task to, so
it makes it quite efficient to do this.

Retrieving multiple IPIs has a much lower overhead than all the CPUs
grabbing the rq lock.

The other three patches are fixes/enhancements to the push/pull code
that I found while doing the debugging of the latencies.

Note, although this patch series is made for the -rt patch, the issues
apply to mainline as well. But because -rt has the migrate_disable() code,
this patch series is tailored to that. But if we can vet this out in
-rt, all this code should make its way quickly to mainline.

I tested this code out, but it probably needs some clean up and definitely
more comments. I'm only posting this as an RFC for now to get feedback
on the idea.

Thanks!

-- Steve
