Return-Path: <SRS0=jf0u=5Q=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4BDC43331
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Mar 2020 16:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B282212CC
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Mar 2020 16:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgCaQfP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730548AbgCaQfP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Mar 2020 12:35:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1B220BED;
        Tue, 31 Mar 2020 16:35:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jJJr7-002Veb-GC; Tue, 31 Mar 2020 12:35:13 -0400
Message-Id: <20200331163453.805082089@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 31 Mar 2020 12:34:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 0/3] Linux 4.19.106-rt46-rc1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.19.106-rt46-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 4/3/2020.

Enjoy,

-- Steve


To build 4.19.106-rt46-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.106.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.106-rt46-rc1.patch.xz

You can also build from 4.19.106-rt45 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.106-rt45-rt46-rc1.patch.xz


Changes from 4.19.106-rt45:

---


Steven Rostedt (VMware) (2):
      irq_work: Fix checking of IRQ_WORK_LAZY flag set on non PREEMPT_RT
      Linux 4.19.106-rt46-rc1

Tiejun Chen (1):
      lib/ubsan: Remove flags parameter from calls to ubsan_prologue() and ubsan_epilogue()

----
 kernel/irq_work.c | 15 ++++++++-------
 lib/ubsan.c       |  5 ++---
 localversion-rt   |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)
