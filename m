From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/15] Linux 3.18.36-rt38-rc1
Date: Tue, 12 Jul 2016 10:29:07 -0400
Message-ID: <20160712142907.636678217@goodmis.org>
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

This is the RT stable review cycle of patch 3.18.36-rt38-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/14/2016.

Enjoy,

-- Steve


To build 3.18.36-rt38-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.36.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.36-rt38-rc1.patch.xz

You can also build from 3.18.36-rt37 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.36-rt37-rt38-rc1.patch.xz


Changes from 3.18.36-rt37:

---


Josh Cartwright (1):
      list_bl: fixup bogus lockdep warning

Luiz Capitulino (1):
      mm: perform lru_add_drain_all() remotely

Mike Galbraith (2):
      mm/zsmalloc: Use get/put_cpu_light in zs_map_object()/zs_unmap_object()
      drivers/block/zram: Replace bit spinlocks with rtmutex for -rt

Peter Zijlstra (1):
      sched,preempt: Fix preempt_count manipulations

Rik van Riel (1):
      kvm, rt: change async pagefault code locking for PREEMPT_RT

Sebastian Andrzej Siewior (7):
      net: dev: always take qdisc's busylock in __dev_xmit_skb()
      ARM: imx: always use TWD on IMX6Q
      drivers/block/zram: fixup compile for !RT
      kernel/printk: Don't try to print from IRQ/NMI region
      arm: lazy preempt: correct resched condition
      locallock: add local_lock_on()
      trace: correct off by one while recording the trace-event

Steven Rostedt (Red Hat) (1):
      Linux 3.18.36-rt38-rc1

Thomas Gleixner (1):
      perf/x86/intel/rapl: Make PMU lock raw

----
 arch/arm/kernel/entry-armv.S                |  6 ++++-
 arch/arm/mach-imx/Kconfig                   |  2 +-
 arch/x86/kernel/cpu/perf_event_intel_rapl.c | 20 +++++++-------
 arch/x86/kernel/kvm.c                       | 37 +++++++++++++-------------
 drivers/block/zram/zram_drv.c               | 30 +++++++++++----------
 drivers/block/zram/zram_drv.h               | 41 +++++++++++++++++++++++++++++
 include/asm-generic/preempt.h               |  4 +--
 include/linux/list_bl.h                     | 12 +++++----
 include/linux/locallock.h                   |  6 +++++
 kernel/printk/printk.c                      | 10 +++++++
 kernel/trace/trace_events.c                 |  8 ++++++
 localversion-rt                             |  2 +-
 mm/swap.c                                   | 37 +++++++++++++++++++++-----
 mm/zsmalloc.c                               |  4 +--
 net/core/dev.c                              |  4 +++
 15 files changed, 162 insertions(+), 61 deletions(-)
