Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A49C07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 22:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E02613E6
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 22:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhGIWDC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 18:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhGIWDC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 18:03:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60E76613C5;
        Fri,  9 Jul 2021 22:00:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m1yXh-000CI8-7h; Fri, 09 Jul 2021 18:00:17 -0400
Message-ID: <20210709215953.122804544@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 17:59:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 0/8] Linux 5.10.47-rt46-rc1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 5.10.47-rt46-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 7/13/2021.

Enjoy,

-- Steve


To build 5.10.47-rt46-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.47.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.47-rt46-rc1.patch.xz

You can also build from 5.10.47-rt45 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.47-rt45-rt46-rc1.patch.xz


Changes from 5.10.47-rt45:

---


Peter Zijlstra (6):
      sched: Fix migration_cpu_stop() requeueing
      sched: Simplify migration_cpu_stop()
      sched: Collate affine_move_task() stoppers
      sched: Optimize migration_cpu_stop()
      sched: Fix affine_move_task() self-concurrency
      sched: Simplify set_affinity_pending refcounts

Steven Rostedt (VMware) (1):
      Linux 5.10.47-rt46-rc1

Valentin Schneider (1):
      sched: Don't defer CPU pick to migration_cpu_stop()

----
 kernel/sched/core.c | 144 ++++++++++++++++++++++++++--------------------------
 localversion-rt     |   2 +-
 2 files changed, 74 insertions(+), 72 deletions(-)
