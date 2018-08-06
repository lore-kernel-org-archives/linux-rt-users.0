From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 00/22] Linux 4.9.115-rt94-rc1
Date: Mon,  6 Aug 2018 04:17:16 -0500
Message-ID: <cover.1533540554.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Alex Shi <alex.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello RT folks!

This patchset brings back many RT-specific fixes that have gone into
subsequent 4.14-rt and 4.16-rt releases.

One of my x86 boxes very intermittently triggers a WARN_ON() on bootup
in migrate_enable(), which I'm still trying to triage.  If you can more
reliably reproduce this, please let me know.

This release candidate will not be pushed to the git tree.

To build 4.9.115-rt94-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.115.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.115-rt94-rc1.patch.xz

If all goes well with testing, this rc will be promoted to an official
release on 8/16/2018.

Please go forth and test!

Thanks,
   Julia

---
Boqun Feng (1):
  rtmutex: Make rt_mutex_futex_unlock() safe for irq-off callsites

Julia Cartwright (4):
  locallock: provide {get,put}_locked_ptr() variants
  squashfs: make use of local lock in multi_cpu decompressor
  seqlock: provide the same ordering semantics as mainline
  Linux 4.9.115-rt94-rc1

Paul E. McKenney (1):
  rcu: Suppress lockdep false-positive ->boost_mtx complaints

Peter Zijlstra (4):
  futex: Fix pi_state->owner serialization
  futex: Fix more put_pi_state() vs. exit_pi_state_list() races
  futex: Avoid violating the 10th rule of futex
  futex: Fix OWNER_DEAD fixup

Sebastian Andrzej Siewior (12):
  rcu: Do not include rtmutex_common.h unconditionally
  sched, tracing: Fix trace_sched_pi_setprio() for deboosting
  crypto: limit more FPU-enabled sections
  arm*: disable NEON in kernel mode
  mm/slub: close possible memory-leak in kmem_cache_alloc_bulk()
  locking: add types.h
  net: use task_struct instead of CPU number as the queue owner on -RT
  Revert "rt,ntp: Move call to schedule_delayed_work() to helper thread"
  Revert "block: blk-mq: Use swait"
  block: blk-mq: move blk_queue_usage_counter_release() into process
    context
  alarmtimer: Prevent live lock in alarm_cancel()
  posix-timers: move the rcu head out of the union

 arch/arm/Kconfig                           |   2 +-
 arch/arm64/crypto/Kconfig                  |  14 +-
 arch/x86/crypto/camellia_aesni_avx2_glue.c |  20 +++
 arch/x86/crypto/camellia_aesni_avx_glue.c  |  19 +++
 arch/x86/crypto/cast6_avx_glue.c           |  24 +++-
 arch/x86/crypto/chacha20_glue.c            |   9 +-
 arch/x86/crypto/serpent_avx2_glue.c        |  19 +++
 arch/x86/crypto/serpent_avx_glue.c         |  23 +++-
 arch/x86/crypto/serpent_sse2_glue.c        |  23 +++-
 arch/x86/crypto/twofish_avx_glue.c         |  27 +++-
 arch/x86/include/asm/fpu/api.h             |   1 +
 arch/x86/kernel/fpu/core.c                 |  12 ++
 block/blk-core.c                           |  22 +++-
 block/blk-mq.c                             |   6 +-
 fs/squashfs/decompressor_multi_percpu.c    |  16 ++-
 include/linux/blkdev.h                     |   4 +-
 include/linux/locallock.h                  |  10 ++
 include/linux/netdevice.h                  |  54 +++++++-
 include/linux/posix-timers.h               |   2 +-
 include/linux/seqlock.h                    |   1 +
 include/linux/spinlock_types_raw.h         |   2 +
 include/trace/events/sched.h               |   4 +-
 kernel/futex.c                             | 144 ++++++++++++++++-----
 kernel/locking/rtmutex.c                   |  31 +++--
 kernel/locking/rtmutex_common.h            |   1 +
 kernel/rcu/tree_plugin.h                   |   5 +-
 kernel/time/alarmtimer.c                   |   2 +-
 kernel/time/ntp.c                          |  26 ----
 kernel/time/posix-timers.c                 |   4 +-
 localversion-rt                            |   2 +-
 mm/slub.c                                  |   1 +
 net/core/dev.c                             |   6 +-
 32 files changed, 412 insertions(+), 124 deletions(-)

-- 
2.18.0
