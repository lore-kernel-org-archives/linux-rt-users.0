From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2] Linux 3.4.106-rt132-rc2
Date: Tue, 17 Mar 2015 12:48:47 -0400
Message-ID: <20150317164847.304560387@goodmis.org>
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

This is the RT stable review cycle of patch 3.4.106-rt132-rc2.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/20/2015.

I'm only including the patches that were added since rc1.

Enjoy,

-- Steve


To build 3.4.106-rt132-rc2 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.106.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.106-rt132-rc2.patch.xz

You can also build from 3.4.106-rt131 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.106-rt131-rt132-rc2.patch.xz


Changes from 3.4.106-rt131:

---


Daniel Wagner (1):
      work-simple: Simple work queue implemenation

Josh Cartwright (1):
      lockdep: selftest: fix warnings due to missing PREEMPT_RT conditionals

Mike Galbraith (4):
      x86: UV: raw_spinlock conversion
      scheduling while atomic in cgroup code
      sunrpc: make svc_xprt_do_enqueue() use get_cpu_light()
      fs,btrfs: fix rt deadlock on extent_buffer->lock

Paul Gortmaker (1):
      sas-ata/isci: dont't disable interrupts in qc_issue handler

Sebastian Andrzej Siewior (3):
      gpio: omap: use raw locks for locking
      rt-mutex: avoid a NULL pointer dereference on deadlock
      arm/futex: disable preemption during futex_atomic_cmpxchg_inatomic()

Steven Rostedt (1):
      create-rt-enqueue

Steven Rostedt (Red Hat) (1):
      Linux 3.4.106-rt132-rc2

Thomas Gleixner (14):
      rtmutex: Simplify rtmutex_slowtrylock()
      rtmutex: Simplify and document try_to_take_rtmutex()
      rtmutex: No need to keep task ref for lock owner check
      rtmutex: Clarify the boost/deboost part
      rtmutex: Document pi chain walk
      rtmutex: Simplify remove_waiter()
      rtmutex: Confine deadlock logic to futex
      rtmutex: Cleanup deadlock detector debug logic
      rtmutex: Avoid pointless requeueing in the deadlock detection chain walk
      futex: Make unlock_pi more robust
      futex: Use futex_top_waiter() in lookup_pi_state()
      futex: Split out the waiter check from lookup_pi_state()
      futex: Split out the first waiter attachment from lookup_pi_state()
      futex: Simplify futex_lock_pi_atomic() and make it more robust

Yadi.hu (1):
      ARM: enable irq in translation/section permission fault handlers

Yong Zhang (1):
      ARM: cmpxchg: define __HAVE_ARCH_CMPXCHG for armv6 and later

----
 arch/arm/include/asm/cmpxchg.h     |   2 +
 arch/arm/include/asm/futex.h       |   4 +
 arch/arm/mm/fault.c                |   6 +
 arch/x86/include/asm/uv/uv_bau.h   |  12 +-
 arch/x86/include/asm/uv/uv_hub.h   |   2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c |  12 +-
 arch/x86/platform/uv/tlb_uv.c      |  30 +-
 arch/x86/platform/uv/uv_time.c     |  21 +-
 drivers/gpio/gpio-omap.c           |  76 ++---
 drivers/scsi/libsas/sas_ata.c      |   4 +-
 fs/btrfs/ctree.c                   |   4 +-
 include/linux/rtmutex.h            |   8 +-
 include/linux/work-simple.h        |  24 ++
 kernel/futex.c                     | 407 +++++++++++--------------
 kernel/rt.c                        |   8 +-
 kernel/rtmutex-debug.c             |   5 +-
 kernel/rtmutex-debug.h             |   7 +-
 kernel/rtmutex-tester.c            |   4 +-
 kernel/rtmutex.c                   | 603 +++++++++++++++++++++++++++----------
 kernel/rtmutex.h                   |   7 +-
 kernel/rtmutex_common.h            |  22 +-
 kernel/sched/Makefile              |   1 +
 kernel/sched/work-simple.c         | 172 +++++++++++
 lib/locking-selftest.c             |  27 ++
 localversion-rt                    |   2 +-
 mm/memcontrol.c                    |   7 +-
 net/sunrpc/svc_xprt.c              |   4 +-
 27 files changed, 998 insertions(+), 483 deletions(-)
