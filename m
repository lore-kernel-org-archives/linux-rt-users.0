Return-Path: <SRS0=+P7g=VA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C416CC0650E
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 11:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F9D21882
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 11:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGCLRc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:17:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51773 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCLRc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Jul 2019 07:17:32 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hidGS-0003Fo-LE; Wed, 03 Jul 2019 13:17:28 +0200
Date:   Wed, 3 Jul 2019 13:17:28 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.0.21-rt15
Message-ID: <20190703111728.cnvki7zcqbiteveh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.0.21-rt15 patch set. 

Changes since v5.0.21-rt14:

  - Revert the replacement patch for wait_for_completion() and use the
    old patch again. The alternative version caused a regression as
    reported by Arve Barsnes, Corey Minyard, Kurt Kanzenbach and Steven
    Rostedt.

Known issues
     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.0.21-rt14 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/incr/patch-5.0.21-rt14-rt15.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.0.21-rt15

The RT patch against v5.0.21 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.21-rt15.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.21-rt15.tar.xz

Sebastian

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 2ac63a13d26d3..21ae66cd41d30 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -61,13 +61,11 @@ struct swait_queue_head {
 struct swait_queue {
 	struct task_struct	*task;
 	struct list_head	task_list;
-	unsigned int		remove;
 };
 
 #define __SWAITQUEUE_INITIALIZER(name) {				\
 	.task		= current,					\
 	.task_list	= LIST_HEAD_INIT((name).task_list),		\
-	.remove		= 1,						\
 }
 
 #define DECLARE_SWAITQUEUE(name)					\
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 755a580849781..49c14137988ea 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -72,12 +72,12 @@ do_wait_for_common(struct completion *x,
 	if (!x->done) {
 		DECLARE_SWAITQUEUE(wait);
 
-		__prepare_to_swait(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
+			__prepare_to_swait(&x->wait, &wait);
 			__set_current_state(state);
 			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index e2c3d2691edf1..c58068d2ee06c 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -28,8 +28,7 @@ void swake_up_locked(struct swait_queue_head *q)
 
 	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
 	wake_up_process(curr->task);
-	if (curr->remove)
-		list_del_init(&curr->task_list);
+	list_del_init(&curr->task_list);
 }
 EXPORT_SYMBOL(swake_up_locked);
 
@@ -78,8 +77,7 @@ void swake_up_all(struct swait_queue_head *q)
 		curr = list_first_entry(&tmp, typeof(*curr), task_list);
 
 		wake_up_state(curr->task, TASK_NORMAL);
-		if (curr->remove)
-			list_del_init(&curr->task_list);
+		list_del_init(&curr->task_list);
 
 		if (list_empty(&tmp))
 			break;
diff --git a/localversion-rt b/localversion-rt
index 08b3e75841adc..18777ec0c27d4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt14
+-rt15
