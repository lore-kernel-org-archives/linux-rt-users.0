Return-Path: <SRS0=GZ+T=5T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16A2C2BA12
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Apr 2020 19:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FE7207FF
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Apr 2020 19:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgDCTWJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbgDCTWJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Apr 2020 15:22:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041902063A;
        Fri,  3 Apr 2020 19:22:07 +0000 (UTC)
Date:   Fri, 3 Apr 2020 15:22:06 -0400
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
Subject: [ANNOUNCE] 4.19.106-rt46
Message-ID: <20200403152206.037cc665@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.19.106-rt46 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: e56eb1424b06c72cd304190c34c2541949dfe41d


Or to build 4.19.106-rt46 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.106.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.106-rt46.patch.xz



You can also build from 4.19.106-rt45 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.106-rt45-rt46.patch.xz



Enjoy,

-- Steve


Changes from v4.19.106-rt45:

---

Steven Rostedt (VMware) (2):
      irq_work: Fix checking of IRQ_WORK_LAZY flag set on non PREEMPT_RT
      Linux 4.19.106-rt46

Tiejun Chen (1):
      lib/ubsan: Remove flags parameter from calls to ubsan_prologue() and ubsan_epilogue()

----
 kernel/irq_work.c | 15 ++++++++-------
 lib/ubsan.c       |  5 ++---
 localversion-rt   |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)
---------------------------
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2940622da5b3..b6d9d35941ac 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -70,6 +70,12 @@ static void __irq_work_queue_local(struct irq_work *work, struct llist_head *lis
 		arch_irq_work_raise();
 }
 
+static inline bool use_lazy_list(struct irq_work *work)
+{
+	return (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+		|| (work->flags & IRQ_WORK_LAZY);
+}
+
 /* Enqueue the irq work @work on the current CPU */
 bool irq_work_queue(struct irq_work *work)
 {
@@ -81,11 +87,10 @@ bool irq_work_queue(struct irq_work *work)
 
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
-	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+	if (use_lazy_list(work))
 		list = this_cpu_ptr(&lazy_list);
 	else
 		list = this_cpu_ptr(&raised_list);
-
 	__irq_work_queue_local(work, list);
 	preempt_enable();
 
@@ -106,7 +111,6 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 
 #else /* CONFIG_SMP: */
 	struct llist_head *list;
-	bool lazy_work, realtime = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
 
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(cpu));
@@ -116,10 +120,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 		return false;
 
 	preempt_disable();
-
-	lazy_work = work->flags & IRQ_WORK_LAZY;
-
-	if (lazy_work || (realtime && !(work->flags & IRQ_WORK_HARD_IRQ)))
+	if (use_lazy_list(work))
 		list = &per_cpu(lazy_list, cpu);
 	else
 		list = &per_cpu(raised_list, cpu);
diff --git a/lib/ubsan.c b/lib/ubsan.c
index 5830cc9a2164..199c75e03469 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -339,18 +339,17 @@ EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
 void __ubsan_handle_vla_bound_not_positive(struct vla_bound_data *data,
 					void *bound)
 {
-	unsigned long flags;
 	char bound_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(bound_str, sizeof(bound_str), data->type, bound);
 	pr_err("variable length array bound value %s <= 0\n", bound_str);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_vla_bound_not_positive);
 
diff --git a/localversion-rt b/localversion-rt
index 38c40b21a885..272158183778 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt45
+-rt46
