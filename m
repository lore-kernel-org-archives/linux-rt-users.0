From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/4] x86: Fix an RT MCE crash
Date: Tue, 12 Jul 2016 15:08:31 -0400
Message-ID: <20160712190842.545233886@goodmis.org>
References: <20160712190828.355044001@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Borislav Petkov <bp@alien8.de>,
	Corey Minyard <cminyard@mvista.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60790 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbcGLTI4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jul 2016 15:08:56 -0400
Content-Disposition: inline; filename=0003-x86-Fix-an-RT-MCE-crash.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.4.112-rt143-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Corey Minyard <cminyard@mvista.com>

On some x86 systems an MCE interrupt would come in before the kernel
was ready for it.  Looking at the latest RT code, it has similar
(but not quite the same) code, except it adds a bool that tells if
MCE handling is initialized.  That was required because they had
switched to use swork instead of a kernel thread.  Here, just
checking to see if the thread is NULL is good enough to see if
MCE handling is initialized.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 27068f690ede..674872b08ea4 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1344,7 +1344,8 @@ static int mce_notify_work_init(void)
 
 static void mce_notify_work(void)
 {
-	wake_up_process(mce_notify_helper);
+	if (mce_notify_helper)
+		wake_up_process(mce_notify_helper);
 }
 #else
 static void mce_notify_work(void)
-- 
2.8.1


