Return-Path: <SRS0=3PEr=66=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BFFC433E0
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 May 2020 18:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0722065C
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 May 2020 18:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEPSxh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 16 May 2020 14:53:37 -0400
Received: from mail.monom.org ([188.138.9.77]:59972 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbgEPSxh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 16 May 2020 14:53:37 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id A8D49500402;
        Sat, 16 May 2020 20:53:34 +0200 (CEST)
Received: from localhost (b9168f17.cgn.dg-w.de [185.22.143.23])
        by mail.monom.org (Postfix) with ESMTPSA id 24730500190;
        Sat, 16 May 2020 20:53:34 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.220-rt197
Date:   Sat, 16 May 2020 18:52:44 -0000
Message-ID: <158965516435.9929.783847792525662706@beryllium>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.220-rt197 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 375a1effc06c4f59c65c6fa8657e44539d997680

Or to build 4.4.220-rt197 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.220.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.220-rt197.patch.xz


Enjoy!
Daniel

Changes from v4.4.220-rt196:
---

Daniel Wagner (1):
      Linux 4.4.220-rt197

Steven Rostedt (VMware) (1):
      irq_work: Fix checking of IRQ_WORK_LAZY flag set on non PREEMPT_RT
---
kernel/irq_work.c | 12 +++++++++---
 localversion-rt   |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)
---
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2899ba0d23d1..abc65de5d793 100644
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
+	int lazy_work;
 
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
index 9bc39cfc747c..7cbd4fa29217 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt196
+-rt197
