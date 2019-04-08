Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23131C10F13
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E785E20879
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750950;
	bh=UHqMDDtQOqOxGKgfkJ41h5RR0HAzENzv75YV2K8MuNg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ye8gMYD5XMU1bo4wXxDhtH9976ssx6c4p/+lkh0OY79E6USYg1wee7taAaHO/FhQ1
	 843KGsLNjcgzhWeYCP6KZ5MmjAmNmAkgf1sFbK6CvPTaVFBXyX2FVToCsQtw8/ssAv
	 i9TMm/ZqsqdWjMzKmKPxHjxRSE0YlGwomyKfEjSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDHTOT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfDHTOT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:19 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32BF20879;
        Mon,  8 Apr 2019 19:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750858;
        bh=UHqMDDtQOqOxGKgfkJ41h5RR0HAzENzv75YV2K8MuNg=;
        h=From:To:Cc:Subject:Date:From;
        b=Bstkjv11vWjtox2y0NfHrsbg5j1WOC4aik5dED6OGFJcb2EIFBcocue51L2S5lKWl
         PwOvnnWHaYsL0+iSuwR2A6Wh8tm2uARNS2aB9VWC2tJIjJ6AboTFkf6oYz6oXAdL0L
         ey3QYfvwc1LfVIKw77TNZ8plVyim+vfZTHU80NIM=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 00/13] Linux 4.14.109-rt58-rc1
Date:   Mon,  8 Apr 2019 14:14:02 -0500
Message-Id: <cover.1554737688.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hello RT Folks!

This is the RT stable review cycle of patch 4.14.109-rt58-rc1.

Please scream at me if I messed something up. Please test the
patches too.

The -rc release will be uploaded to kernel.org and will be
deleted when the final release is out. This is just a review
release (or release candidate).

The pre-releases will not be pushed to the git repository,
only the final release is.

If all goes well, this patch will be converted to the next
main release on 4/12/2019.

To build 4.14.109-rt58-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.109.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.109-rt58-rc1.patch.xz

You can also build from 4.14.109-rt57 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.109-rt57-rt58-rc1.patch.xz

Enjoy!
   
   Tom

Changes from v4.14.109-rt57:

Julien Grall (1):
  tty/sysrq: Convert show_lock to raw_spinlock_t

Peter Zijlstra (1):
  sched/fair: Robustify CFS-bandwidth timer locking

Scott Wood (1):
  locking/rt-mutex: Flush block plug on __down_read()

Sebastian Andrzej Siewior (9):
  arm64: fpsimd: use preemp_disable in addition to local_bh_disable()
  sched/fair: Make the hrtimers non-hard again
  rtmutex/rwlock: preserve state like a sleeping lock
  softirq: Avoid "local_softirq_pending" messages if ksoftirqd is
    blocked
  softirq: Avoid "local_softirq_pending" messages if task is in
    cpu_chill()
  hrtimer: Don't lose state in cpu_chill()
  x86: lazy-preempt: properly check against preempt-mask
  hrtimer: cpu_chill(): save task state in ->saved_state()
  powerpc/pseries/iommu: Use a locallock instead local_irq_save()

Tom Zanussi (1):
  Linux 4.14.109-rt58

 arch/arm64/kernel/fpsimd.c             | 10 ++++++
 arch/powerpc/platforms/pseries/iommu.c | 16 +++++----
 arch/x86/include/asm/preempt.h         |  2 +-
 drivers/tty/sysrq.c                    |  6 ++--
 kernel/locking/rtmutex.c               |  2 +-
 kernel/locking/rwlock-rt.c             |  2 +-
 kernel/locking/rwsem-rt.c              |  9 +++++
 kernel/sched/fair.c                    | 34 ++++++++++---------
 kernel/softirq.c                       | 60 +++++++++++++++++++++++++---------
 kernel/time/hrtimer.c                  | 15 +++++++--
 localversion-rt                        |  2 +-
 11 files changed, 111 insertions(+), 47 deletions(-)

-- 
2.14.1

