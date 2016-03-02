From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/17] Linux 3.14.61-rt64-rc1
Date: Wed, 02 Mar 2016 10:44:33 -0500
Message-ID: <20160302154433.638594715@goodmis.org>
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

This is the RT stable review cycle of patch 3.14.61-rt64-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/7/2016.

Enjoy,

-- Steve


To build 3.14.61-rt64-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.14.61.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.61-rt64-rc1.patch.xz

You can also build from 3.14.61-rt63 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/incr/patch-3.14.61-rt63-rt64-rc1.patch.xz


Changes from 3.14.61-rt63:

---


Clark Williams (1):
      rcu/torture: Comment out rcu_bh ops on PREEMPT_RT_FULL

Mike Galbraith (2):
      sched,rt: __always_inline preemptible_lazy()
      drm,radeon,i915: Use preempt_disable/enable_rt() where recommended

Sebastian Andrzej Siewior (10):
      ptrace: don't open IRQs in ptrace_freeze_traced() too early
      net: move xmit_recursion to per-task variable on -RT
      preempt-lazy: Add the lazy-preemption check to preempt_schedule()
      softirq: split timer softirqs out of ksoftirqd
      net: provide a way to delegate processing a softirq to ksoftirqd
      latencyhist: disable jump-labels
      kernel: migrate_disable() do fastpath in atomic & irqs-off
      kernel: softirq: unlock with irqs on
      kernel/stop_machine: partly revert "stop_machine: Use raw spinlocks"
      kernel: sched: Fix preempt_disable_ip recodring for preempt_disable()

Steven Rostedt (Red Hat) (1):
      Linux 3.14.61-rt64-rc1

Yang Shi (3):
      arm64: replace read_lock to rcu lock in call_step_hook
      trace: Use rcuidle version for preemptoff_hist trace point
      f2fs: Mutex can't be used by down_write_nest_lock()

----
 arch/Kconfig                            |   1 +
 arch/arm64/kernel/debug-monitors.c      |  21 +++---
 drivers/gpu/drm/i915/i915_irq.c         |   2 +
 drivers/gpu/drm/radeon/radeon_display.c |   2 +
 fs/f2fs/f2fs.h                          |   4 +-
 include/linux/ftrace.h                  |  12 ++++
 include/linux/interrupt.h               |   8 +++
 include/linux/netdevice.h               |   9 +++
 include/linux/sched.h                   |   3 +-
 include/trace/events/hist.h             |   1 +
 kernel/ptrace.c                         |   6 +-
 kernel/rcu/torture.c                    |   7 ++
 kernel/sched/core.c                     |  52 ++++++++-------
 kernel/softirq.c                        | 110 ++++++++++++++++++++++++++++----
 kernel/stop_machine.c                   |  40 +++---------
 kernel/trace/trace_irqsoff.c            |   8 +--
 localversion-rt                         |   2 +-
 net/core/dev.c                          |  43 +++++++++++--
 18 files changed, 240 insertions(+), 91 deletions(-)
