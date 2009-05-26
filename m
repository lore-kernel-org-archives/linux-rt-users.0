From: Jan Blunck <jblunck@suse.de>
Subject: [PATCH] Missing hunk from rt-mutex-core.patch
Date: Tue, 26 May 2009 22:11:00 +0200
Message-ID: <20090526201100.GO23793@bolzano.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52328 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbZEZUK7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 May 2009 16:10:59 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Somehow the following hunk was lost during the port to 2.6.29. Without it
calling sysrq-t or similar gives you very strange results ;)

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 include/linux/sched.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/include/linux/sched.h
===================================================================
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2572,7 +2572,7 @@ static inline void mm_init_owner(struct
 }
 #endif /* CONFIG_MM_OWNER */
 
-#define TASK_STATE_TO_CHAR_STR "RSDTtZX"
+#define TASK_STATE_TO_CHAR_STR "RMSDTtZX"
 
 #ifdef CONFIG_SMP
 static inline int task_is_current(struct task_struct *task)
