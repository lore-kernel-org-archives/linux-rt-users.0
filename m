Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93F5C63777
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 18:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876A12242B
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 18:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wSCPaTVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbgKTSve (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:51:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbgKTSvc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Nov 2020 13:51:32 -0500
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637BD2242B;
        Fri, 20 Nov 2020 18:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605898292;
        bh=xpsW+j5Z95aEf14SEZ/cG4zHUfe+fcw4VxLFbmk0zE0=;
        h=Subject:From:To:Date:From;
        b=wSCPaTVT3oyvh6eYohEqaqZV0cPySdoZ/E485rh8O46grvmhq0ozrHLsr08dA0jP2
         Hu3Hmy04NV6HpR6bTTcl7NXgyv/4HR93bP3Q39AhBGGFZMNZDERFQ+GycSVVq4LKE/
         RA1X4lqyvEH1IQsRuzR0bYNkbZWjtCr22UT+PDQ0=
Message-ID: <0a643944215d02582d5c7acd1cedcd90388e3353.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.152-rt66
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 20 Nov 2020 12:51:30 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.152-rt66 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 3b515711216822e708490d1c686813c819e237b1

Or to build 4.19.152-rt66 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.152.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.152-rt66.patch.xz


You can also build from 4.19.152-rt65 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.152-rt65-rt66.patch.xz

Enjoy!

   Tom

Changes from v4.19.152-rt65:
---

Oleg Nesterov (1):
      ptrace: fix ptrace_unfreeze_traced() race with rt-lock

Sebastian Andrzej Siewior (1):
      mm/memcontrol: Disable preemption in __mod_memcg_lruvec_state()

Tom Zanussi (1):
      Linux 4.19.152-rt66
---
include/linux/memcontrol.h |  2 ++
 kernel/ptrace.c            | 23 +++++++++++++++--------
 localversion-rt            |  2 +-
 3 files changed, 18 insertions(+), 9 deletions(-)
---
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index cc6b6532eb56..dbb2c4e27277 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -665,6 +665,7 @@ static inline void __mod_lruvec_state(struct lruvec *lruvec,
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 
+	preempt_disable_rt();
 	/* Update memcg */
 	__mod_memcg_state(pn->memcg, idx, val);
 
@@ -675,6 +676,7 @@ static inline void __mod_lruvec_state(struct lruvec *lruvec,
 		x = 0;
 	}
 	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+	preempt_enable_rt();
 }
 
 static inline void mod_lruvec_state(struct lruvec *lruvec,
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index a38b304fb9fd..cbefb0234be3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -191,8 +191,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (task->state != __TASK_TRACED)
-		return;
+	unsigned long flags;
+	bool frozen = true;
 
 	WARN_ON(!task->ptrace || task->parent != current);
 
@@ -201,12 +201,19 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (task->state == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
-			wake_up_state(task, __TASK_TRACED);
-		else
-			task->state = TASK_TRACED;
-	}
+
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	if (task->state == __TASK_TRACED)
+		task->state = TASK_TRACED;
+	else if (task->saved_state == __TASK_TRACED)
+		task->saved_state = TASK_TRACED;
+	else
+		frozen = false;
+	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+
+	if (frozen && __fatal_signal_pending(task))
+		wake_up_state(task, __TASK_TRACED);
+
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
diff --git a/localversion-rt b/localversion-rt
index e2eb19782d4c..d42c0971b041 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt65
+-rt66

