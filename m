Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C45C41514
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D046721874
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294088;
	bh=S3QTZYjx6BDOf305mGjlzKbXfSHzEKqRofEbPjjrb/Q=;
	h=From:To:Subject:Date:List-ID:From;
	b=fQa5L9ztfq/MP4VvB+mh7ns2IjMr1caMrwNtIomIybsCuHhW/1zpSHtVefZKksIln
	 yoozgJwl5gdoRVAiEnFkaeWb7U7EWU8wFohWJ8dg/ZdCkXxk+IeTDi1qTuks5qA9M8
	 eNz9qPBY4CIaHm8quQsoQeRjQgqPJIpk3HKuL7/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404252AbfHHTxK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404228AbfHHTxK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:10 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8987221883;
        Thu,  8 Aug 2019 19:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293989;
        bh=S3QTZYjx6BDOf305mGjlzKbXfSHzEKqRofEbPjjrb/Q=;
        h=From:To:Subject:Date:From;
        b=ow4RoGCvPSaihud+cEfwSn2N0W89F64BxVI6fj7shR3ODMl2mZjy3MWijOiWJ5SUd
         C1fP15c4SFUnubKKRv92GSMI3Db0Z2EUanzJNSnqTvyt1CHTMAHVMB0lK5vSTWuKFu
         EFX5N0JmT162MXKxHYtQARBuj8W7cflQTc8lOcmg=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 00/19] Linux v4.14.137-rt65-rc1
Date:   Thu,  8 Aug 2019 14:52:28 -0500
Message-Id: <cover.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 4.14.137-rt65-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2019-08-15.

To build 4.14.137-rt65-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.137.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.137-rt65-rc1.patch.xz

You can also build from 4.14.137-rt64 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.137-rt64-rt65-rc1.patch.xz


Enjoy,

-- Tom


Corey Minyard (1):
  sched/completion: Fix a lockup in wait_for_completion()

Luis Claudio R. Goncalves (1):
  mm/zswap: Do not disable preemption in zswap_frontswap_store()

Sebastian Andrzej Siewior (13):
  kthread: add a global worker thread.
  genirq: Do not invoke the affinity callback via a workqueue on RT
  genirq: Handle missing work_struct in irq_set_affinity_notifier()
  locking/rwsem: Rename rwsem_rt.h to rwsem-rt.h
  locking/lockdep: Don't complain about incorrect name for no validate
    class
  arm: imx6: cpuidle: Use raw_spinlock_t
  rcu: Don't allow to change rcu_normal_after_boot on RT
  sched/core: Drop a preempt_disable_rt() statement
  Revert "futex: Ensure lock/unlock symetry versus pi_lock and hash
    bucket lock"
  Revert "futex: Fix bug on when a requeued RT task times out"
  Revert "rtmutex: Handle the various new futex race conditions"
  Revert "futex: workaround migrate_disable/enable in different context"
  futex: Make the futex_hash_bucket lock raw

Thomas Gleixner (1):
  futex: Delay deallocation of pi_state

Tom Zanussi (2):
  kthread: Use __RAW_SPIN_LOCK_UNLOCK to initialize kthread_worker lock
  Linux 4.14.137-rt65-rc1

kbuild test robot (1):
  pci/switchtec: fix stream_open.cocci warnings

 arch/arm/mach-imx/cpuidle-imx6q.c        |  10 +-
 drivers/block/loop.c                     |   2 +-
 drivers/pci/switch/switchtec.c           |   2 +-
 drivers/spi/spi-rockchip.c               |   1 +
 include/linux/blk-cgroup.h               |   1 +
 include/linux/interrupt.h                |   5 +-
 include/linux/kthread-cgroup.h           |  17 +++
 include/linux/kthread.h                  |  10 +-
 include/linux/{rwsem_rt.h => rwsem-rt.h} |   0
 include/linux/rwsem.h                    |   2 +-
 init/main.c                              |   1 +
 kernel/futex.c                           | 232 +++++++++++++------------------
 kernel/irq/manage.c                      |  23 +--
 kernel/kthread.c                         |  13 ++
 kernel/locking/lockdep.c                 |   3 +-
 kernel/locking/rtmutex.c                 |  65 +--------
 kernel/locking/rtmutex_common.h          |   3 -
 kernel/rcu/update.c                      |   2 +
 kernel/sched/completion.c                |   2 +-
 kernel/sched/core.c                      |   9 +-
 localversion-rt                          |   2 +-
 mm/zswap.c                               |  12 +-
 22 files changed, 179 insertions(+), 238 deletions(-)
 create mode 100644 include/linux/kthread-cgroup.h
 rename include/linux/{rwsem_rt.h => rwsem-rt.h} (100%)

-- 
2.14.1

