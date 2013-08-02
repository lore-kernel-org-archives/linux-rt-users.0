From: minyard@acm.org
Subject: [PATCH 3.10-rt1] rt: Fix NO_HZ config use
Date: Fri, 02 Aug 2013 15:24:34 -0500
Message-ID: <1375475074-30704-1-git-send-email-minyard@acm.org>
Cc: linux-rt-users@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
To: Sebastian Sewior <bigeasy@linutronix.de>,
	Thomas Gleixnet <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:20486 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab3HBVYr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Aug 2013 17:24:47 -0400
Received: from wf-rch.minyard.home ([unknown] [173.74.121.95])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MQX00BFB7D3AV90@vms173017.mailsrvcs.net> for
 linux-rt-users@vger.kernel.org; Fri, 02 Aug 2013 15:24:44 -0500 (CDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Corey Minyard <cminyard@mvista.com>

NO_HZ is old, it has become NO_HZ_COMMON. NO_HZ generally still works
because a leftover NO_HZ in a config file will still work, but it needs
to be fixed.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 kernel/softirq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index db2fe2b..d0f189d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -64,7 +64,7 @@ char *softirq_to_name[NR_SOFTIRQS] = {
 	"TASKLET", "SCHED", "HRTIMER", "RCU"
 };
 
-#ifdef CONFIG_NO_HZ
+#ifdef CONFIG_NO_HZ_COMMON
 # ifdef CONFIG_PREEMPT_RT_FULL
 
 struct softirq_runner {
@@ -151,7 +151,7 @@ void softirq_check_pending_idle(void)
 }
 # endif
 
-#else /* !NO_HZ */
+#else /* !NO_HZ_COMMON */
 static inline void softirq_set_runner(unsigned int sirq) { }
 static inline void softirq_clr_runner(unsigned int sirq) { }
 #endif
-- 
1.7.9.5

