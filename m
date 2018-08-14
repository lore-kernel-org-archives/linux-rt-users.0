Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:51674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVnS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Aug 2018 17:43:18 -0400
From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 00/15] [ANNOUNCE] 3.18.117-rt105-rc2
Date: Tue, 14 Aug 2018 13:53:53 -0500
Message-Id: <cover.1534263273.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com, julia@ni.com

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hello RT Folks!

This is the RT stable review cycle of patch 3.18.117-rt105-rc2.

This is -rc2, containing the same set of patches as -rc1, but with the
'cherry-picked from xxx' lines removed and replaced with the more
standard [ Upstream commit xxx ] form.

In addition to the applicable stable-rt patches not yet in the 3.18-rt
kernel, this set includes some patches needed to fix cross-compilation
build failures.

Please scream at me if I messed something up. Please test the
patches too.

The -rc release will be uploaded to kernel.org and will be
deleted when the final release is out. This is just a review
release (or release candidate).

The pre-releases will not be pushed to the git repository,
only the final release is.

If all goes well, this patch will be converted to the next
main release on 8/16/2018.

To build 3.18.117-rt105-rc2 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.117.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.117-rt105-rc2.patch.xz


You can also build from 3.18.117-rt104 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.117-rt104-rt105-rc2.patch.xz

Enjoy!
   
   Tom


Changes from v3.18.117-rt104:

Anton Blanchard (1):
  powerpc/vdso64: Use double word compare on pointers

Julia Cartwright (2):
  seqlock: provide the same ordering semantics as mainline
  squashfs: make use of local lock in multi_cpu decompressor

Krzysztof Mazur (1):
  um: Use POSIX ucontext_t instead of struct ucontext

Paul Gortmaker (1):
  powerpc: ps3/device-init.c - adapt to completions using swait vs wait

Peter Zijlstra (1):
  sched: Remove TASK_ALL

Philipp Schrader (1):
  tracing: Fix rcu splat from idle CPU on boot

Sebastian Andrzej Siewior (5):
  arm*: disable NEON in kernel mode
  posix-timers: move the rcu head out of the union
  alarmtimer: Prevent live lock in alarm_cancel()
  locking: add types.h
  net: use task_struct instead of CPU number as the queue owner on -RT

Tom Zanussi (3):
  Revert "fs, jbd: pull your plug when waiting for space"
  s390/mm: Fix missed tsk->pagefault_disabled conversion to
    pagefault_disable()
  Linux 3.18.117-rt105-rc2

 arch/arm/Kconfig                          |  2 +-
 arch/arm64/crypto/Kconfig                 | 14 ++++----
 arch/powerpc/kernel/vdso64/datapage.S     |  2 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S |  2 +-
 arch/powerpc/platforms/ps3/device-init.c  |  2 +-
 arch/s390/mm/fault.c                      |  2 +-
 arch/um/os-Linux/signal.c                 |  2 +-
 arch/x86/um/stub_segv.c                   |  2 +-
 fs/jbd/checkpoint.c                       |  2 --
 fs/squashfs/decompressor_multi_percpu.c   | 16 ++++++---
 include/linux/netdevice.h                 | 54 +++++++++++++++++++++++++++----
 include/linux/posix-timers.h              |  2 +-
 include/linux/sched.h                     |  1 -
 include/linux/seqlock.h                   |  1 +
 include/linux/spinlock_types_raw.h        |  2 ++
 kernel/time/alarmtimer.c                  |  2 +-
 kernel/time/posix-timers.c                |  4 +--
 kernel/trace/trace_irqsoff.c              |  4 +--
 localversion-rt                           |  2 +-
 net/core/dev.c                            |  6 +++-
 20 files changed, 89 insertions(+), 35 deletions(-)

-- 
2.14.1
