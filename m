From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [v4.1-rt PATCH resend] RM: lazy-preempt: add missed TIF_NEED_RESCHED_LAZY to _TIF_WORK_MASK
Date: Fri, 12 Aug 2016 20:21:28 +0300
Message-ID: <20160812172128.11543-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33615 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbcHLRVr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Aug 2016 13:21:47 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The flag TIF_NEED_RESCHED_LAZY is missed in _TIF_WORK_MASK [1], so add it.

[1] http://www.spinics.net/lists/linux-rt-users/msg14450.html

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/include/asm/thread_info.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index b5a6163..bc99bd3 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -178,7 +178,8 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
  * Change these and you break ASM code in entry-common.S
  */
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
-				 _TIF_NOTIFY_RESUME | _TIF_UPROBE)
+				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
+				 _TIF_NEED_RESCHED_LAZY)
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_ARM_THREAD_INFO_H */
-- 
2.9.2

