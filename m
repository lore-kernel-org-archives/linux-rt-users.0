From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH -rt] Add wakeup timing to expose /proc/preempt_max_latency
Date: Wed, 12 Dec 2007 09:22:56 -0800
Message-ID: <20071212172227.554694168__6223.29308321259$1197480941$gmane$org@mvista.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754706AbXLLRfG@vger.kernel.org>
Message-Id: <20071212172227.554694168@mvista.com>
Date: Wed, 12 Dec 2007 09:22:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Fix my original mistake of using CONFIG_CRITICAL_TIMING , which only
covers preempt and irqs-off timing.. Convert to CONFIG_LATENCY_TIMING,
so wakeup timing also has these.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 kernel/sysctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.23/kernel/sysctl.c
===================================================================
--- linux-2.6.23.orig/kernel/sysctl.c
+++ linux-2.6.23/kernel/sysctl.c
@@ -414,7 +414,7 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
-#if defined(CONFIG_CRITICAL_TIMING)
+#if defined(CONFIG_LATENCY_TIMING)
 	{
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "preempt_max_latency",
-- 

-- 
