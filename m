From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH -rt 5/6] ARM: Fix save_stack_trace() prototype
Date: Fri, 13 Jul 2007 10:52:19 -0700
Message-ID: <20070713175229.063244111@mvista.com>
References: <20070713175214.336577416@mvista.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: tglx@linutronix.de, mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:38938 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759669AbXGMSNG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 14:13:06 -0400
Content-Disposition: inline; filename=arm-stacktrace.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/lib/stacktrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/arm/lib/stacktrace.c
===================================================================
--- linux-2.6.orig/arch/arm/lib/stacktrace.c
+++ linux-2.6/arch/arm/lib/stacktrace.c
@@ -1,7 +1,7 @@
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 
-void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
+void save_stack_trace(struct stack_trace *trace)
 {
 }
 

--
