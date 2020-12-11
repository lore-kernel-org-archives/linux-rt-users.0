Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748ACC4361B
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Dec 2020 22:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D09123ED2
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Dec 2020 22:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392934AbgLKVm4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Dec 2020 16:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390559AbgLKVmM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Dec 2020 16:42:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766CB23372;
        Fri, 11 Dec 2020 21:41:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1knqAM-000JYq-5K; Fri, 11 Dec 2020 16:41:30 -0500
Message-ID: <20201211214103.954245915@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 11 Dec 2020 16:41:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 0/4] Linux  5.4.82-rt46-rc1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 5.4.82-rt46-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 12/15/2020.

Enjoy,

-- Steve


To build 5.4.82-rt46-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.82.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.82-rt46-rc1.patch.xz

You can also build from 5.4.82-rt45 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.82-rt45-rt46-rc1.patch.xz


Changes from 5.4.82-rt45:

---


Sebastian Andrzej Siewior (1):
      Revert "hrtimer: Allow raw wakeups during boot"

Steven Rostedt (VMware) (2):
      Revert "net: Properly annotate the try-lock for the seqlock"
      Linux 5.4.82-rt46-rc1

Thomas Gleixner (1):
      timers: Move clearing of base::timer_running under base::lock

----
 include/linux/seqlock.h   |  9 +++++++++
 include/net/sch_generic.h | 10 +---------
 kernel/time/hrtimer.c     |  2 +-
 kernel/time/timer.c       |  6 ++++--
 localversion-rt           |  2 +-
 5 files changed, 16 insertions(+), 13 deletions(-)
