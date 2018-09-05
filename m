From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 00/22] Linux 4.14.63-rt41-rc1
Date: Wed, 05 Sep 2018 08:27:54 -0400
Message-ID: <20180905122754.443196118@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.14.63-rt41-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 9/7/2018.

Enjoy,

-- Steve


To build 4.14.63-rt41-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.63.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.63-rt41-rc1.patch.xz

You can also build from 4.14.63-rt40 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.63-rt40-rt41-rc1.patch.xz


Changes from 4.14.63-rt40:

---


Anna-Maria Gleixner (1):
      Revert "timer: delay waking softirqs from the jiffy tick"

Daniel Bristot de Oliveira (1):
      sched/core: Avoid __schedule() being called twice in a row

Julia Cartwright (3):
      locallock: provide {get,put}_locked_ptr() variants
      squashfs: make use of local lock in multi_cpu decompressor
      seqlock: provide the same ordering semantics as mainline

Mike Galbraith (3):
      sched/fair: Fix CFS bandwidth control lockdep DEADLOCK report
      crypto: scompress - serialize RT percpu scratch buffer access with a local lock
      sched: Allow pinned user tasks to be awakened to the CPU they pinned

Sebastian Andrzej Siewior (12):
      PM / suspend: Prevent might sleep splats (updated)
      PM / wakeup: Make events_lock a RAW_SPINLOCK
      PM / s2idle: Make s2idle_wait_head swait based
      Revert "x86: UV: raw_spinlock conversion"
      irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t
      irqchip/gic-v3-its: Move ITS' ->pend_page allocation into an early CPU up hook
      sched/migrate_disable: fallback to preempt_disable() instead barrier()
      efi: Allow efi=runtime
      efi: Disable runtime services on RT
      crypto: cryptd - add a lock instead preempt_disable/local_bh_disable
      Revert "arm64/xen: Make XEN depend on !RT"
      Drivers: hv: vmbus: include header for get_irq_regs()

Steven Rostedt (VMware) (1):
      Linux 4.14.63-rt41-rc1

Thomas Gleixner (1):
      x86/ioapic: Don't let setaffinity unmask threaded EOI interrupt too early

----
 arch/arm64/Kconfig                      |  2 +-
 arch/x86/include/asm/uv/uv_bau.h        | 14 +++----
 arch/x86/kernel/apic/io_apic.c          | 26 ++++++------
 arch/x86/platform/uv/tlb_uv.c           | 26 ++++++------
 arch/x86/platform/uv/uv_time.c          | 20 ++++------
 crypto/cryptd.c                         | 19 +++++----
 crypto/scompress.c                      |  6 ++-
 drivers/base/power/wakeup.c             | 18 ++++-----
 drivers/firmware/efi/efi.c              |  5 ++-
 drivers/hv/hyperv_vmbus.h               |  1 +
 drivers/irqchip/irq-gic-v3-its.c        | 70 ++++++++++++++++++++++-----------
 fs/squashfs/decompressor_multi_percpu.c | 16 ++++++--
 include/linux/locallock.h               | 10 +++++
 include/linux/preempt.h                 |  6 +--
 include/linux/sched.h                   |  4 +-
 include/linux/seqlock.h                 |  1 +
 kernel/power/suspend.c                  |  9 +++--
 kernel/sched/core.c                     | 34 +++++++++-------
 kernel/sched/debug.c                    |  2 +-
 kernel/sched/fair.c                     |  4 +-
 kernel/time/tick-common.c               |  2 +
 kernel/time/timer.c                     |  2 +-
 localversion-rt                         |  2 +-
 23 files changed, 175 insertions(+), 124 deletions(-)
