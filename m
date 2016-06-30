From: minyard@acm.org
Subject: [PATCH][RT] x86: Fix an RT MCE crash
Date: Thu, 30 Jun 2016 08:24:49 -0500
Message-ID: <1467293089-27656-1-git-send-email-minyard@acm.org>
Cc: Corey Minyard <cminyard@mvista.com>
To: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33837 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbcF3NYz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jun 2016 09:24:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id 66so7415158pfy.1
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2016 06:24:55 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Corey Minyard <cminyard@mvista.com>

On some x86 systems an MCE interrupt would come in before the kernel
was ready for it.  Looking at the latest RT code, it has similar
(but not quite the same) code, except it adds a bool that tells if
MCE handling is initialized.  Add the same bool for older versions.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

We noticed this issue on a new Broadwell system when we booted RT
on it.  This patch is for 3.10, I'm not sure if it applies to
other kernel versions.

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index aaf4b9b..7125584 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1365,6 +1365,7 @@ static void __mce_notify_work(void)
 }
 
 #ifdef CONFIG_PREEMPT_RT_FULL
+static bool notify_work_ready __read_mostly;
 struct task_struct *mce_notify_helper;
 
 static int mce_notify_helper_thread(void *unused)
@@ -1386,12 +1387,14 @@ static int mce_notify_work_init(void)
 	if (!mce_notify_helper)
 		return -ENOMEM;
 
+	notify_work_ready = true;
 	return 0;
 }
 
 static void mce_notify_work(void)
 {
-	wake_up_process(mce_notify_helper);
+	if (notify_work_ready)
+		wake_up_process(mce_notify_helper);
 }
 #else
 static void mce_notify_work(void)
-- 
2.7.4

