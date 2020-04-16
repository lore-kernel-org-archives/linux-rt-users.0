Return-Path: <SRS0=egP0=6A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A659DC2BB55
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Apr 2020 16:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891D4206B9
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Apr 2020 16:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbgDPQpO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727800AbgDPQpM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Apr 2020 12:45:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B94C061A0C;
        Thu, 16 Apr 2020 09:45:12 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jP7dW-00028A-7f; Thu, 16 Apr 2020 18:45:10 +0200
Date:   Thu, 16 Apr 2020 18:45:10 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.6.4-rt3
Message-ID: <20200416164510.kbrklqahdng5uhij@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.6.4-rt3 patch set. 

Changes since v5.6.4-rt2:

  - The printk thread could schedule where it is not appropriate.
    Affects only PREEMPT_VOLUNTARY. Reported by kernel test robot,
    patched by John Ogness.

  - The initialization of nohz_full_kick_work triggered a warning.
    Reported by kbuild test robot.

  - Patch by patch compilation could fail to compile in the fs/proc due
    to a missing header file. Reported by kbuild test robot.

  - The cached signal struct could lead to a double free of another data
    structure. Reported by Daniel Wagner, patch by Matt Fleming.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.6.4-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/incr/patch-5.6.4-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.6.4-rt3

The RT patch against v5.6.4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patch-5.6.4-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patches-5.6.4-rt3.tar.xz

Sebastian

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8c2a84fc4986d..eb8285ca344f3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -96,6 +96,7 @@
 #include <linux/posix-timers.h>
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
+#include <linux/swait.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8821a8c2263ff..8bc683be08574 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2715,6 +2715,7 @@ static int printk_kthread_func(void *data)
 			    &len, printk_time);
 
 		console_lock();
+		console_may_schedule = 0;
 		call_console_drivers(master_seq, ext_text, ext_len, text, len,
 				     msg->level, msg->facility);
 		if (len > 0 || ext_len > 0)
diff --git a/kernel/signal.c b/kernel/signal.c
index bfa9bcf27d3d7..75c82ecefdbb6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -494,8 +494,8 @@ static void sigqueue_free_current(struct sigqueue *q)
 
 	up = q->user;
 	if (rt_prio(current->normal_prio) && !put_task_cache(current, q)) {
-		atomic_dec(&up->sigpending);
-		free_uid(up);
+		if (atomic_dec_and_test(&up->sigpending))
+			free_uid(up);
 	} else
 		  __sigqueue_free(q);
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b568947dc90e5..fc62dcbed7429 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -245,7 +245,7 @@ static void nohz_full_kick_func(struct irq_work *work)
 
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
 	.func = nohz_full_kick_func,
-	.flags = IRQ_WORK_HARD_IRQ,
+	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
 };
 
 /*
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
