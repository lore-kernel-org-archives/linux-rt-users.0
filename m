Return-Path: <SRS0=OCQz=VQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F53AC76195
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3BB2187F
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388715AbfGSVt6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Jul 2019 17:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbfGSVt5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Jul 2019 17:49:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E98A2184E;
        Fri, 19 Jul 2019 21:49:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hoalI-0007yk-3x; Fri, 19 Jul 2019 17:49:56 -0400
Message-Id: <20190719214931.700049248@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Jul 2019 17:49:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [PATCH RT 00/16] Linux 4.19.59-rt24-rc1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.19.59-rt24-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/23/2019.

Enjoy,

-- Steve


To build 4.19.59-rt24-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.59.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.59-rt24-rc1.patch.xz

You can also build from 4.19.59-rt23 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.59-rt23-rt24-rc1.patch.xz


Changes from 4.19.59-rt23:

---


Luis Claudio R. Goncalves (1):
      mm/zswap: Do not disable preemption in zswap_frontswap_store()

Sebastian Andrzej Siewior (12):
      kthread: add a global worker thread.
      genirq: Do not invoke the affinity callback via a workqueue on RT
      genirq: Handle missing work_struct in irq_set_affinity_notifier()
      arm: imx6: cpuidle: Use raw_spinlock_t
      rcu: Don't allow to change rcu_normal_after_boot on RT
      sched/core: Drop a preempt_disable_rt() statement
      timers: Redo the notification of canceling timers on -RT
      Revert "futex: Ensure lock/unlock symetry versus pi_lock and hash bucket lock"
      Revert "futex: Fix bug on when a requeued RT task times out"
      Revert "rtmutex: Handle the various new futex race conditions"
      Revert "futex: workaround migrate_disable/enable in different context"
      futex: Make the futex_hash_bucket lock raw

Steven Rostedt (VMware) (1):
      Linux 4.19.59-rt24-rc1

Thomas Gleixner (1):
      futex: Delay deallocation of pi_state

kbuild test robot (1):
      pci/switchtec: fix stream_open.cocci warnings

----
 arch/arm/mach-imx/cpuidle-imx6q.c |  10 +-
 drivers/block/loop.c              |   2 +-
 drivers/pci/switch/switchtec.c    |   2 +-
 drivers/spi/spi-rockchip.c        |   1 +
 fs/timerfd.c                      |   5 +-
 include/linux/hrtimer.h           |  17 +--
 include/linux/interrupt.h         |   5 +-
 include/linux/kthread-cgroup.h    |  17 +++
 include/linux/kthread.h           |  17 ++-
 include/linux/posix-timers.h      |   1 +
 init/main.c                       |   1 +
 kernel/futex.c                    | 231 ++++++++++++++++----------------------
 kernel/irq/manage.c               |  24 ++--
 kernel/kthread.c                  |  14 +++
 kernel/locking/rtmutex.c          |  65 +----------
 kernel/locking/rtmutex_common.h   |   3 -
 kernel/rcu/update.c               |   2 +
 kernel/sched/core.c               |   9 +-
 kernel/time/alarmtimer.c          |   2 +-
 kernel/time/hrtimer.c             |  36 ++----
 kernel/time/itimer.c              |   2 +-
 kernel/time/posix-cpu-timers.c    |  23 ++++
 kernel/time/posix-timers.c        |  69 +++++-------
 kernel/time/posix-timers.h        |   2 +
 kernel/time/timer.c               |  96 ++++++++--------
 localversion-rt                   |   2 +-
 mm/zswap.c                        |  12 +-
 27 files changed, 290 insertions(+), 380 deletions(-)
 create mode 100644 include/linux/kthread-cgroup.h
