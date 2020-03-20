Return-Path: <SRS0=7Euv=5F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C75C4332E
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Mar 2020 16:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456CA2076F
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Mar 2020 16:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCTQyr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:54:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36649 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgCTQyq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Mar 2020 12:54:46 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jFKuw-0000AS-8L; Fri, 20 Mar 2020 17:54:42 +0100
Date:   Fri, 20 Mar 2020 17:54:42 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Mathew <john.mathew@unikie.com>
Cc:     linux-rt-users@vger.kernel.org, lukas.bulwahn@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] swait: Remove the warning with more than two waiters
Message-ID: <20200320165442.fqmcmwxrk64d3csm@linutronix.de>
References: <20200213083121.vqbbbufja4uilblo@linutronix.de>
 <20200218071857.14805-1-john.mathew@unikie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200218071857.14805-1-john.mathew@unikie.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The warning was introduced to find callers of complete_all() having
multiple waiters enqueued. As completa_all() wakes all waiters with
disabled interrupts it may lead visibile latency spikes with a larger
amount of waiters.

Since the warning was introduced, most of the feedback was in the
"setup/configure" phase which is nothing that would disturb the RT
workload because it is not yet active.
There were reports regarding the crypto code which may wake multiple
waiters if all of them request an algorithm which requires a module to
be loaded first. If this really become a problem during runtime it
should be investigated then.

Remove the warning if more than two waiters are worken up via the
complete_all() interface.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/suspend.h  | 6 ------
 kernel/power/hibernate.c | 7 -------
 kernel/power/suspend.c   | 4 ----
 kernel/sched/swait.c     | 5 -----
 4 files changed, 22 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 5030ab13db060..cd97d2c8840cc 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -197,12 +197,6 @@ struct platform_s2idle_ops {
 	void (*end)(void);
 };
 
-#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
-extern bool pm_in_action;
-#else
-# define pm_in_action false
-#endif
-
 #ifdef CONFIG_SUSPEND
 extern suspend_state_t mem_sleep_current;
 extern suspend_state_t mem_sleep_default;
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index c8713bbc44810..3c0a5a8170b02 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -689,10 +689,6 @@ static int load_image_and_restore(void)
 	return error;
 }
 
-#ifndef CONFIG_SUSPEND
-bool pm_in_action;
-#endif
-
 /**
  * hibernate - Carry out system hibernation, including saving the image.
  */
@@ -706,8 +702,6 @@ int hibernate(void)
 		return -EPERM;
 	}
 
-	pm_in_action = true;
-
 	lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
@@ -784,7 +778,6 @@ int hibernate(void)
 	atomic_inc(&snapshot_device_available);
  Unlock:
 	unlock_system_sleep();
-	pm_in_action = false;
 	pr_info("hibernation exit\n");
 
 	return error;
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index a9a6ada0c8e47..27f149f5d4a9f 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -595,8 +595,6 @@ static int enter_state(suspend_state_t state)
 	return error;
 }
 
-bool pm_in_action;
-
 /**
  * pm_suspend - Externally visible function for suspending the system.
  * @state: System sleep state to enter.
@@ -611,7 +609,6 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
-	pm_in_action = true;
 	pr_info("suspend entry (%s)\n", mem_sleep_labels[state]);
 	error = enter_state(state);
 	if (error) {
@@ -621,7 +618,6 @@ int pm_suspend(suspend_state_t state)
 		suspend_stats.success++;
 	}
 	pr_info("suspend exit\n");
-	pm_in_action = false;
 	return error;
 }
 EXPORT_SYMBOL(pm_suspend);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index c58068d2ee06c..c56c315524ae6 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -35,7 +35,6 @@ EXPORT_SYMBOL(swake_up_locked);
 void swake_up_all_locked(struct swait_queue_head *q)
 {
 	struct swait_queue *curr;
-	int wakes = 0;
 
 	while (!list_empty(&q->task_list)) {
 
@@ -43,11 +42,7 @@ void swake_up_all_locked(struct swait_queue_head *q)
 					task_list);
 		wake_up_process(curr->task);
 		list_del_init(&curr->task_list);
-		wakes++;
 	}
-	if (pm_in_action)
-		return;
-	WARN(wakes > 2, "complete_all() with %d waiters\n", wakes);
 }
 EXPORT_SYMBOL(swake_up_all_locked);
 
-- 
2.26.0.rc2

