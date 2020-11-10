Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC2EC388F7
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 15:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3116121741
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 15:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbgKJPka (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730985AbgKJPk1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 10:40:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFFD2068D;
        Tue, 10 Nov 2020 15:40:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kcVku-008eCh-U3; Tue, 10 Nov 2020 10:40:24 -0500
Message-ID: <20201110153853.463368981@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 10 Nov 2020 10:38:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 0/5] Linux 5.4.74-rt42-rc2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 5.4.74-rt42-rc2.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 11/11/2020.

Changes since -rc1: removed patch:

    tcp: Remove superfluous BH-disable around listening_hash

Enjoy,

-- Steve


To build 5.4.74-rt42-rc2 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.74.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.74-rt42-rc2.patch.xz

You can also build from 5.4.74-rt41 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.74-rt41-rt42-rc2.patch.xz


Changes from 5.4.74-rt41:

---


Oleg Nesterov (1):
      ptrace: fix ptrace_unfreeze_traced() race with rt-lock

Sebastian Andrzej Siewior (3):
      net: Properly annotate the try-lock for the seqlock
      mm/memcontrol: Disable preemption in __mod_memcg_lruvec_state()
      timers: Don't block on ->expiry_lock for TIMER_IRQSAFE

Steven Rostedt (VMware) (1):
      Linux 5.4.74-rt42-rc2

----
 include/linux/seqlock.h   |  9 ---------
 include/net/sch_generic.h | 10 +++++++++-
 kernel/ptrace.c           | 23 +++++++++++++++--------
 kernel/time/timer.c       |  9 ++++++++-
 localversion-rt           |  2 +-
 mm/memcontrol.c           |  2 ++
 6 files changed, 35 insertions(+), 20 deletions(-)
