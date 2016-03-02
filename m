From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/10] Linux 3.10.97-rt107-rc1
Date: Wed, 02 Mar 2016 10:51:00 -0500
Message-ID: <20160302155100.873557484@goodmis.org>
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

This is the RT stable review cycle of patch 3.10.97-rt107-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/7/2016.

Enjoy,

-- Steve


To build 3.10.97-rt107-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.97.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.97-rt107-rc1.patch.xz

You can also build from 3.10.97-rt106 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.97-rt106-rt107-rc1.patch.xz


Changes from 3.10.97-rt106:

---


Clark Williams (1):
      rcu/torture: Comment out rcu_bh ops on PREEMPT_RT_FULL

Sebastian Andrzej Siewior (7):
      softirq: split timer softirqs out of ksoftirqd
      net: provide a way to delegate processing a softirq to ksoftirqd
      latencyhist: disable jump-labels
      kernel: migrate_disable() do fastpath in atomic & irqs-off
      kernel: softirq: unlock with irqs on
      kernel/stop_machine: partly revert "stop_machine: Use raw spinlocks"
      kernel: sched: Fix preempt_disable_ip recodring for preempt_disable()

Steven Rostedt (Red Hat) (1):
      Linux 3.10.97-rt107-rc1

Yang Shi (1):
      trace: Use rcuidle version for preemptoff_hist trace point

----
 arch/Kconfig                 |   1 +
 include/linux/ftrace.h       |  12 +++++
 include/linux/interrupt.h    |   8 ++++
 include/linux/sched.h        |   2 -
 include/trace/events/hist.h  |   1 +
 kernel/rcutorture.c          |   7 +++
 kernel/sched/core.c          |  18 ++-----
 kernel/softirq.c             | 110 ++++++++++++++++++++++++++++++++++++++-----
 kernel/stop_machine.c        |  38 +++------------
 kernel/trace/trace_irqsoff.c |   8 ++--
 localversion-rt              |   2 +-
 net/core/dev.c               |   2 +-
 12 files changed, 143 insertions(+), 66 deletions(-)
