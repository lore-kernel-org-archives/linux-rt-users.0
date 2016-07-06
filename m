From: minyard@acm.org
Subject: [PATCH v2] x86: Fix an RT MCE crash
Date: Wed,  6 Jul 2016 13:55:01 -0500
Message-ID: <1467831301-17233-1-git-send-email-minyard@acm.org>
Cc: Corey Minyard <cminyard@mvista.com>
To: minyard@acm.org, Borislav Petkov <bp@alien8.de>, Luck@minyard.net,
	Tony <tony.luck@intel.com>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34634 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbcGFSzI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Jul 2016 14:55:08 -0400
Received: by mail-pa0-f67.google.com with SMTP id us13so21677812pab.1
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Jul 2016 11:55:07 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Corey Minyard <cminyard@mvista.com>

On some x86 systems an MCE interrupt would come in before the kernel
was ready for it.  Looking at the latest RT code, it has similar
(but not quite the same) code, except it adds a bool that tells if
MCE handling is initialized.  That was required because they had
switched to use swork instead of a kernel thread.  Here, just
checking to see if the thread is NULL is good enough to see if
MCE handling is initialized.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index aaf4b9b..cc70d98 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1391,7 +1391,8 @@ static int mce_notify_work_init(void)
 
 static void mce_notify_work(void)
 {
-	wake_up_process(mce_notify_helper);
+	if (mce_notify_helper)
+		wake_up_process(mce_notify_helper);
 }
 #else
 static void mce_notify_work(void)
-- 
2.7.4

