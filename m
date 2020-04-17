Return-Path: <SRS0=XNcY=6B=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BCAC38A2B
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Apr 2020 19:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4FBB2078E
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Apr 2020 19:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587153139;
	bh=Ue2uwERpjafVWLqvbOSGuHaQ1eH9g16yaTajylxhG+E=;
	h=Subject:From:To:Date:List-ID:From;
	b=vpYUp+W9+8y3lGK67zQ6qBSiIPjb2AOMmAzTcdFKu+DaPOF5cznQo9oeL1AOhAJ/J
	 /sFLr4KHyujQrcgbE+6I5/RWzLnIsScJT4UMtyK0zoDBOKycvhASY3AZeri9n2k5FT
	 UY+BlpwxOXEHBRGdvWG3iNmhq3Q8qZGor+Fbd0nI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgDQTwQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730590AbgDQTwQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Apr 2020 15:52:16 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 036EE20715;
        Fri, 17 Apr 2020 19:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587153135;
        bh=Ue2uwERpjafVWLqvbOSGuHaQ1eH9g16yaTajylxhG+E=;
        h=Subject:From:To:Date:From;
        b=TkXqeph0fHybO7PFSbwa6084OoA1KJwaZtv2SYRFz9q2b4OWpQmwxWAkRm5Tng/od
         pc29wZiTcS3fOXtL6N4K1ayRGQiOFJrh/jR/ZAeB1vMrsYAinfUZC0PnBcJeSY/ZT3
         3j/nVwCDun11q/8mxfRbJfHui2H1M8QFwfasRZS0=
Message-ID: <fcc3709169c47351b6e6fd9bf5fa0162db5b4bf1.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.175-rt81
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 17 Apr 2020 14:52:12 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.175-rt81 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: aad6ed737a078d30926be3205fa67b03018a6ded

Or to build 4.14.175-rt81 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.175.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.175-rt81.patch.xz


You can also build from 4.14.175-rt80 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.175-rt80-rt81.patch.xz

Enjoy!

   Tom

Changes from v4.14.175-rt80:
---

Steven Rostedt (VMware) (1):
      irq_work: Fix checking of IRQ_WORK_LAZY flag set on non PREEMPT_RT

Tom Zanussi (1):
      Linux 4.14.175-rt81
---
kernel/irq_work.c | 12 +++++++++---
 localversion-rt   |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)
---
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2899ba0d23d1..838b56cef5fe 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -57,6 +57,12 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
 
+static inline bool use_lazy_list(struct irq_work *work)
+{
+	return (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+		|| (work->flags & IRQ_WORK_LAZY);
+}
+
 #ifdef CONFIG_SMP
 /*
  * Enqueue the irq_work @work on @cpu unless it's already pending
@@ -78,7 +84,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+	if (use_lazy_list(work))
 		list = &per_cpu(lazy_list, cpu);
 	else
 		list = &per_cpu(raised_list, cpu);
@@ -95,7 +101,7 @@ EXPORT_SYMBOL_GPL(irq_work_queue_on);
 bool irq_work_queue(struct irq_work *work)
 {
 	struct llist_head *list;
-	bool lazy_work, realtime = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+	bool lazy_work;
 
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
@@ -106,7 +112,7 @@ bool irq_work_queue(struct irq_work *work)
 
 	lazy_work = work->flags & IRQ_WORK_LAZY;
 
-	if (lazy_work || (realtime && !(work->flags & IRQ_WORK_HARD_IRQ)))
+	if (use_lazy_list(work))
 		list = this_cpu_ptr(&lazy_list);
 	else
 		list = this_cpu_ptr(&raised_list);
diff --git a/localversion-rt b/localversion-rt
index 5ba2c2091cf9..8269ec129c0c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt80
+-rt81

