Return-Path: <SRS0=FXzI=4X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6933C10DCE
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 18:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD23E207FD
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 18:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFSkx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:40:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFSkx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Mar 2020 13:40:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A1F20637;
        Fri,  6 Mar 2020 18:40:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jAHtz-002dxX-R0; Fri, 06 Mar 2020 13:40:51 -0500
Message-Id: <20200306184035.948924528@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 13:40:35 -0500
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
Subject: [PATCH RT 0/8] Linux 4.19.106-rt45-rc1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 4.19.106-rt45-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 3/16/2020.

Enjoy,

-- Steve


To build 4.19.106-rt45-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.106.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.106-rt45-rc1.patch.xz

You can also build from 4.19.106-rt44 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.106-rt44-rt45-rc1.patch.xz


Changes from 4.19.106-rt44:

---


Matt Fleming (1):
      mm/memcontrol: Move misplaced local_unlock_irqrestore()

Scott Wood (2):
      sched: migrate_enable: Use per-cpu cpu_stop_work
      sched: migrate_enable: Remove __schedule() call

Sebastian Andrzej Siewior (4):
      userfaultfd: Use a seqlock instead of seqcount
      locallock: Include header for the `current' macro
      drm/vmwgfx: Drop preempt_disable() in vmw_fifo_ping_host()
      tracing: make preempt_lazy and migrate_disable counter smaller

Steven Rostedt (VMware) (1):
      Linux 4.19.106-rt45-rc1

----
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c |  2 --
 fs/userfaultfd.c                     | 12 ++++++------
 include/linux/locallock.h            |  1 +
 include/linux/trace_events.h         |  3 +--
 kernel/sched/core.c                  | 23 ++++++++++++++---------
 kernel/trace/trace_events.c          |  4 ++--
 localversion-rt                      |  2 +-
 mm/memcontrol.c                      |  2 +-
 8 files changed, 26 insertions(+), 23 deletions(-)
