Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B07C76569
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8E8246A9
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814038;
	bh=VcOF4R4aZL9840G5UM/Sd0oFwcPEt8T2Y3lsp5JJoBg=;
	h=From:To:Subject:Date:List-ID:From;
	b=nw9pfSOwzMWza02EdnvtNg6+F+w6q8U/Y90unfbDtmmt7wgUzsD8YDf2qW2FotEB3
	 DGolVeCM0BJlqdEShVVZ5EOVJBXITwguwbK9T+yl+DCkJKAZSRaagEeMkLQytTspzy
	 81TCC7GtDh8fHiAiMd6uYXIT2TpU6OCK082iimu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbgB0Od5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732342AbgB0Od4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 09:33:56 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3210724656;
        Thu, 27 Feb 2020 14:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814035;
        bh=VcOF4R4aZL9840G5UM/Sd0oFwcPEt8T2Y3lsp5JJoBg=;
        h=From:To:Subject:Date:From;
        b=RS27MqVp/rkxbsbuHD8/nWHm60qB2jmrZc13+FZsghuiRNJspMWMEUD3/3FEX7Byc
         jRAnHt5VVxcoB4rSmWrXovDZkPxu4ce1XV9zN2sVF11wMgrpHRaV422YW/RjiKTDj+
         ZTldBFalv5XDHuGs925Y5s0y76+aMDdpuxZ/A1ak=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 00/23] Linux v4.14.170-rt75-rc2
Date:   Thu, 27 Feb 2020 08:33:11 -0600
Message-Id: <cover.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 4.14.170-rt75-rc2.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2020-03-05.

To build 4.14.170-rt75-rc2 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.170.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.170-rt75-rc2.patch.xz

You can also build from 4.14.170-rt74 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.170-rt74-rt75-rc2.patch.xz


Enjoy,

-- Tom


Daniel Wagner (1):
  lib/smp_processor_id: Adjust check_preemption_disabled()

Joe Korty (1):
  Fix wrong-variable use in irq_set_affinity_notifier

Julien Grall (1):
  lib/ubsan: Don't seralize UBSAN report

Juri Lelli (1):
  sched/deadline: Ensure inactive_timer runs in hardirq context

Liu Haitao (1):
  kmemleak: Change the lock of kmemleak_object to raw_spinlock_t

Peter Zijlstra (1):
  locking/rtmutex: Clean ->pi_blocked_on in the error case

Scott Wood (7):
  sched: migrate_dis/enable: Use sleeping_lock…() to annotate sleeping
    points
  sched: __set_cpus_allowed_ptr: Check cpus_mask, not cpus_ptr
  sched: Remove dead __migrate_disabled() check
  sched: migrate disable: Protect cpus_ptr with lock
  sched: migrate_enable: Use select_fallback_rq()
  sched: Lazy migrate_disable processing
  sched: migrate_enable: Use stop_one_cpu_nowait()

Sebastian Andrzej Siewior (8):
  i2c: exynos5: Remove IRQF_ONESHOT
  i2c: hix5hd2: Remove IRQF_ONESHOT
  x86: preempt: Check preemption level before looking at lazy-preempt
  futex: Make the futex_hash_bucket spinlock_t again and bring back its
    old state
  Revert "ARM: Initialize split page table locks for vector page"
  locking: Make spinlock_t and rwlock_t a RCU section on RT
  sched/core: migrate_enable() must access takedown_cpu_task on
    !HOTPLUG_CPU
  sched: migrate_enable: Busy loop until the migration request is
    completed

Tom Zanussi (1):
  Linux 4.14.170-rt75-rc2

Waiman Long (1):
  lib/smp_processor_id: Don't use cpumask_equal()

 arch/arm/kernel/process.c        |  24 ----
 arch/x86/include/asm/preempt.h   |   2 +
 drivers/i2c/busses/i2c-exynos5.c |   4 +-
 drivers/i2c/busses/i2c-hix5hd2.c |   3 +-
 include/linux/cpu.h              |   4 -
 include/linux/init_task.h        |   9 ++
 include/linux/sched.h            |  11 +-
 include/linux/stop_machine.h     |   2 +
 kernel/cpu.c                     | 103 +++++++----------
 kernel/futex.c                   | 231 ++++++++++++++++++++++-----------------
 kernel/irq/manage.c              |   2 +-
 kernel/locking/rtmutex.c         | 114 +++++++++++++++----
 kernel/locking/rtmutex_common.h  |   3 +
 kernel/locking/rwlock-rt.c       |   6 +
 kernel/sched/core.c              | 211 +++++++++++++++--------------------
 kernel/sched/deadline.c          |   4 +-
 kernel/sched/sched.h             |   4 +
 kernel/stop_machine.c            |   7 +-
 lib/smp_processor_id.c           |   7 +-
 lib/ubsan.c                      |  76 +++++--------
 localversion-rt                  |   2 +-
 mm/kmemleak.c                    |  72 ++++++------
 22 files changed, 461 insertions(+), 440 deletions(-)

-- 
2.14.1

