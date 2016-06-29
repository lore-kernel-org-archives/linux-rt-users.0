From: minyard@acm.org
Subject: [PATCH] sched: Fix compile warning when using CONFIG_PREEMPT_NONE
Date: Wed, 29 Jun 2016 11:55:11 -0500
Message-ID: <1467219311-19424-1-git-send-email-minyard@acm.org>
Cc: Corey Minyard <cminyard@mvista.com>
To: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f193.google.com ([209.85.214.193]:34049 "EHLO
	mail-ob0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbcF2Q4p (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Jun 2016 12:56:45 -0400
Received: by mail-ob0-f193.google.com with SMTP id s7so4032438obo.1
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2016 09:55:20 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Corey Minyard <cminyard@mvista.com>

preemptible_lazy() is only used under CONFIG_PREEMPT, but it was
always defined.  Move it into a CONFIG_PREEMPT ifdef.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3130a8..57af106 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3454,6 +3454,7 @@ static void __sched notrace preempt_schedule_common(void)
 	} while (need_resched());
 }
 
+#ifdef CONFIG_PREEMPT
 #ifdef CONFIG_PREEMPT_LAZY
 /*
  * If TIF_NEED_RESCHED is then we allow to be scheduled away since this is
@@ -3478,7 +3479,6 @@ static int preemptible_lazy(void)
 
 #endif
 
-#ifdef CONFIG_PREEMPT
 /*
  * this is the entry point to schedule() from in-kernel preemption
  * off of preempt_enable. Kernel preemptions off return from interrupt
-- 
2.7.4

