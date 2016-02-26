From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/7] Linux 3.2.77-rt111-rc1
Date: Fri, 26 Feb 2016 16:44:08 -0500
Message-ID: <20160226214408.590103414@goodmis.org>
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

This is the RT stable review cycle of patch 3.2.77-rt111-rc1.

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


To build 3.2.77-rt111-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.77.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.77-rt111-rc1.patch.xz

You can also build from 3.2.77-rt110 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.77-rt110-rt111-rc1.patch.xz


Changes from 3.2.77-rt110:

---


Josh Cartwright (1):
      net: Make synchronize_rcu_expedited() conditional on !RT_FULL

Peter Zijlstra (1):
      sched: Introduce the trace_sched_waking tracepoint

Sebastian Andrzej Siewior (1):
      dump stack: don't disable preemption during trace

Steven Rostedt (Red Hat) (2):
      rtmutex: Have slowfn of rt_mutex_timed_fastlock() use enum
      Linux 3.2.77-rt111-rc1

Thomas Gleixner (1):
      rtmutex: Handle non enqueued waiters gracefully

bmouring@ni.com (1):
      rtmutex: Use chainwalking control enum

----
 arch/x86/kernel/dumpstack_64.c    |  8 ++++----
 include/trace/events/sched.h      | 30 +++++++++++++++++++++---------
 kernel/rtmutex.c                  |  6 +++---
 kernel/sched.c                    |  7 +++++--
 kernel/trace/trace_sched_switch.c |  2 +-
 kernel/trace/trace_sched_wakeup.c |  2 +-
 localversion-rt                   |  2 +-
 net/core/dev.c                    |  2 +-
 8 files changed, 37 insertions(+), 22 deletions(-)
