Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74263C433FE
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 18:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350298AbhKXSGn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:06:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350222AbhKXSGh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 13:06:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A2D360FE7;
        Wed, 24 Nov 2021 18:03:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mpwcA-0027qQ-7p;
        Wed, 24 Nov 2021 13:03:26 -0500
Message-ID: <20211124180303.574562279@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Nov 2021 13:03:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 00/13] Linux 5.10.78-rt56-rc3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 5.10.78-rt56-rc3.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 11/26/2021.

Enjoy,

-- Steve


To build 5.10.78-rt56-rc3 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.78.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.78-rt56-rc3.patch.xz

You can also build from 5.10.78-rt55 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.78-rt55-rt56-rc3.patch.xz


Changes from 5.10.78-rt55:

---


Mike Galbraith (1):
      mm, zsmalloc: Convert zsmalloc_handle.lock to spinlock_t

Sebastian Andrzej Siewior (11):
      sched: Fix get_push_task() vs migrate_disable()
      sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD
      preempt: Move preempt_enable_no_resched() to the RT block
      mm: Disable NUMA_BALANCING_DEFAULT_ENABLED and TRANSPARENT_HUGEPAGE on PREEMPT_RT
      fscache: Use only one fscache_object_cong_wait.
      fscache: Use only one fscache_object_cong_wait.
      locking: Drop might_resched() from might_sleep_no_state_check()
      drm/i915/gt: Queue and wait for the irq_work item.
      irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.
      irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT
      irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT

Steven Rostedt (VMware) (1):
      Linux 5.10.78-rt56-rc3

----
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c |   5 +-
 fs/fscache/internal.h                       |   1 -
 fs/fscache/main.c                           |   6 --
 fs/fscache/object.c                         |  13 +--
 include/linux/irq_work.h                    |  31 ++++--
 include/linux/kernel.h                      |   2 +-
 include/linux/preempt.h                     |   6 +-
 init/Kconfig                                |   2 +-
 kernel/irq_work.c                           | 143 +++++++++++++++++++++-------
 kernel/sched/core.c                         |   2 +-
 kernel/sched/sched.h                        |   3 +
 kernel/time/timer.c                         |   2 -
 localversion-rt                             |   2 +-
 mm/zsmalloc.c                               |  12 +--
 14 files changed, 155 insertions(+), 75 deletions(-)
