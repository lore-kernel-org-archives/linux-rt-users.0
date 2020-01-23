Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E49C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECE4246B1
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgAWUjp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:39:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgAWUjp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:39:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B31821734;
        Thu, 23 Jan 2020 20:39:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iujGQ-000mTz-Dw; Thu, 23 Jan 2020 15:39:42 -0500
Message-Id: <20200123203930.646725253@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Jan 2020 15:39:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 00/30] Linux 4.19.94-rt39-rc2
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.19.94-rt39-rc2.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 1/24/2020.

Enjoy,

-- Steve


To build 4.19.94-rt39-rc2 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.94.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.94-rt39-rc2.patch.xz

You can also build from 4.19.94-rt38 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.94-rt38-rt39-rc2.patch.xz


Changes from 4.19.94-rt38:

---


Clark Williams (1):
      thermal/x86_pkg_temp: make pkg_temp_lock a raw spinlock

Daniel Wagner (1):
      lib/smp_processor_id: Adjust check_preemption_disabled()

Julien Grall (4):
      hrtimer: Use READ_ONCE to access timer->base in hrimer_grab_expiry_lock()
      hrtimer: Don't grab the expiry lock for non-soft hrtimer
      hrtimer: Prevent using hrtimer_grab_expiry_lock() on migration_base
      lib/ubsan: Don't seralize UBSAN report

Juri Lelli (1):
      sched/deadline: Ensure inactive_timer runs in hardirq context

Liu Haitao (1):
      kmemleak: Change the lock of kmemleak_object to raw_spinlock_t

Peter Zijlstra (1):
      locking/rtmutex: Clean ->pi_blocked_on in the error case

Scott Wood (7):
      sched: migrate_dis/enable: Use sleeping_lock…() to annotate sleeping points
      sched: __set_cpus_allowed_ptr: Check cpus_mask, not cpus_ptr
      sched: Remove dead __migrate_disabled() check
      sched: migrate disable: Protect cpus_ptr with lock
      sched: migrate_enable: Use select_fallback_rq()
      sched: Lazy migrate_disable processing
      sched: migrate_enable: Use stop_one_cpu_nowait()

Sebastian Andrzej Siewior (11):
      i2c: exynos5: Remove IRQF_ONESHOT
      i2c: hix5hd2: Remove IRQF_ONESHOT
      dma-buf: Use seqlock_t instread disabling preemption
      x86: preempt: Check preemption level before looking at lazy-preempt
      hrtimer: Add a missing bracket and hide `migration_base' on !SMP
      posix-timers: Unlock expiry lock in the early return
      futex: Make the futex_hash_bucket spinlock_t again and bring back its old state
      Revert "ARM: Initialize split page table locks for vector page"
      locking: Make spinlock_t and rwlock_t a RCU section on RT
      sched/core: migrate_enable() must access takedown_cpu_task on !HOTPLUG_CPU
      sched: migrate_enable: Busy loop until the migration request is completed

Steven Rostedt (VMware) (1):
      Linux 4.19.94-rt39-rc2

Thomas Gleixner (1):
      KVM: arm/arm64: Let the timer expire in hardirq context on RT

Waiman Long (1):
      lib/smp_processor_id: Don't use cpumask_equal()

----
 arch/arm/kernel/process.c                        |  24 ---
 arch/x86/include/asm/preempt.h                   |   2 +
 drivers/dma-buf/dma-buf.c                        |   8 +-
 drivers/dma-buf/reservation.c                    |  43 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |   6 +-
 drivers/gpu/drm/i915/i915_gem.c                  |  10 +-
 drivers/i2c/busses/i2c-exynos5.c                 |   4 +-
 drivers/i2c/busses/i2c-hix5hd2.c                 |   3 +-
 drivers/thermal/x86_pkg_temp_thermal.c           |  24 +--
 include/linux/cpu.h                              |   4 -
 include/linux/reservation.h                      |   4 +-
 include/linux/sched.h                            |  11 +-
 include/linux/stop_machine.h                     |   2 +
 init/init_task.c                                 |   4 +
 kernel/cpu.c                                     | 103 ++++------
 kernel/futex.c                                   | 230 +++++++++++++----------
 kernel/locking/rtmutex.c                         | 114 ++++++++---
 kernel/locking/rtmutex_common.h                  |   3 +
 kernel/locking/rwlock-rt.c                       |   6 +
 kernel/sched/core.c                              | 211 +++++++++------------
 kernel/sched/deadline.c                          |   4 +-
 kernel/sched/sched.h                             |   4 +
 kernel/stop_machine.c                            |   7 +-
 kernel/time/hrtimer.c                            |  14 +-
 kernel/time/posix-cpu-timers.c                   |   4 +-
 lib/smp_processor_id.c                           |   7 +-
 lib/ubsan.c                                      |  64 +++----
 localversion-rt                                  |   2 +-
 mm/kmemleak.c                                    |  72 +++----
 virt/kvm/arm/arch_timer.c                        |   6 +-
 30 files changed, 510 insertions(+), 490 deletions(-)
