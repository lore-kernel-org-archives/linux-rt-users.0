Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8520C432BE
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 01:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90EB6101A
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 01:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhHZBrF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 25 Aug 2021 21:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhHZBrF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Aug 2021 21:47:05 -0400
Received: from rorschach.local.home (unknown [24.94.146.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D07660FDC;
        Thu, 26 Aug 2021 01:46:17 +0000 (UTC)
Date:   Wed, 25 Aug 2021 21:45:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [ANNOUNCE] 5.10.59-rt52
Message-ID: <20210825214556.00baf202@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.10.59-rt52 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: da75d2161ca1104184e4f903e2753cd41b90fbc3


Or to build 5.10.59-rt52 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.59.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.59-rt52.patch.xz



You can also build from 5.10.59-rt51 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.59-rt51-rt52.patch.xz



Enjoy,

-- Steve


Changes from v5.10.59-rt51:

---

Andrew Halaney (1):
      locking/rwsem-rt: Remove might_sleep() in __up_read()

Steven Rostedt (VMware) (1):
      Linux 5.10.59-rt52

----
 kernel/locking/rwsem-rt.c | 1 -
 localversion-rt           | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)
---------------------------
diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index 274172d5bb3a..b61edc4dcb73 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -198,7 +198,6 @@ void __up_read(struct rw_semaphore *sem)
 	if (!atomic_dec_and_test(&sem->readers))
 		return;
 
-	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
 	/*
 	 * Wake the writer, i.e. the rtmutex owner. It might release the
diff --git a/localversion-rt b/localversion-rt
index 75493460c41f..66a5ed8bf3d7 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt51
+-rt52
