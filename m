From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/10] Linux 3.10.97-rt106-rc1
Date: Fri, 26 Feb 2016 16:41:00 -0500
Message-ID: <20160226214100.390136141@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.10.97-rt106-rc1.

Please scream at me if I messed something up. Please test the patches too.

Note, I'm bringing this tree up to stable patches in 4.1.7-rt8.
Then I'll be pulling 4.1-rt into stable, as development is now on 4.4-rt.
After that, I'll be pulling the 4.1-rt stable changes into the stable trees.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 2/29/2016.

Enjoy,

-- Steve


To build 3.10.97-rt106-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.97.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.97-rt106-rc1.patch.xz

You can also build from 3.10.97-rt105 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.97-rt105-rt106-rc1.patch.xz


Changes from 3.10.97-rt105:

---


Grygorii Strashko (2):
      ARM: smp: Move clear_tasks_mm_cpumask() call to __cpu_die()
      net/core/cpuhotplug: Drain input_pkt_queue lockless

Josh Cartwright (1):
      net: Make synchronize_rcu_expedited() conditional on !RT_FULL

Peter Zijlstra (1):
      sched: Introduce the trace_sched_waking tracepoint

Sebastian Andrzej Siewior (1):
      dump stack: don't disable preemption during trace

Steven Rostedt (Red Hat) (2):
      rtmutex: Have slowfn of rt_mutex_timed_fastlock() use enum
      Linux 3.10.97-rt106-rc1

Thomas Gleixner (2):
      rtmutex: Handle non enqueued waiters gracefully
      irqwork: Move irq safe work to irq context

bmouring@ni.com (1):
      rtmutex: Use chainwalking control enum

----
 arch/arm/kernel/smp.c             |  5 +++--
 arch/x86/kernel/dumpstack_64.c    |  8 ++++----
 include/linux/irq_work.h          |  6 ++++++
 include/trace/events/sched.h      | 30 +++++++++++++++++++++---------
 kernel/irq_work.c                 |  9 +++++++++
 kernel/rtmutex.c                  |  6 +++---
 kernel/sched/core.c               |  8 +++++---
 kernel/timer.c                    |  6 ++----
 kernel/trace/trace_sched_switch.c |  2 +-
 kernel/trace/trace_sched_wakeup.c |  2 +-
 localversion-rt                   |  2 +-
 net/core/dev.c                    |  4 ++--
 12 files changed, 58 insertions(+), 30 deletions(-)
