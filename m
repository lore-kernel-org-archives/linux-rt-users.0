Return-Path: <SRS0=dorw=TZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F9AC282E1
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 May 2019 03:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2928B2075C
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 May 2019 03:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEYDdR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 May 2019 23:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfEYDdQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 May 2019 23:33:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2708D2075C;
        Sat, 25 May 2019 03:33:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUNQp-0002Ep-9j; Fri, 24 May 2019 23:33:15 -0400
Message-Id: <20190525033232.795741612@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 May 2019 23:32:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 0/6] Linux 4.19.37-rt20-rc1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.19.37-rt20-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 5/28/2019.

Enjoy,

-- Steve


To build 4.19.37-rt20-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.37.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.37-rt20-rc1.patch.xz

You can also build from 4.19.37-rt19 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.37-rt19-rt20-rc1.patch.xz


Changes from 4.19.37-rt19:

---


Corey Minyard (1):
      sched/completion: Fix a lockup in wait_for_completion()

Julien Grall (1):
      tty/sysrq: Convert show_lock to raw_spinlock_t

Sebastian Andrzej Siewior (3):
      powerpc/pseries/iommu: Use a locallock instead local_irq_save()
      powerpc: reshuffle TIF bits
      drm/i915: Don't disable interrupts independently of the lock

Steven Rostedt (VMware) (1):
      Linux 4.19.37-rt20-rc1

----
 arch/powerpc/include/asm/thread_info.h | 11 +++++++----
 arch/powerpc/kernel/entry_32.S         | 12 +++++++-----
 arch/powerpc/kernel/entry_64.S         | 12 +++++++-----
 arch/powerpc/platforms/pseries/iommu.c | 16 ++++++++++------
 drivers/gpu/drm/i915/i915_request.c    |  8 ++------
 drivers/tty/sysrq.c                    |  6 +++---
 kernel/sched/completion.c              |  2 +-
 localversion-rt                        |  2 +-
 8 files changed, 38 insertions(+), 31 deletions(-)
