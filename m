From: Meenakshi Aggarwal <meenakshi.aggarwal@freescale.com>
Subject: [PATCH] Removed unnecessary use of local variable in v3.12.
Date: Thu, 15 May 2014 16:08:54 +0530
Message-ID: <1400150334-24814-1-git-send-email-meenakshi.aggarwal@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Meenakshi Aggarwal <meenakshi.aggarwal@freescale.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:28443
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751278AbaEOKjG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 May 2014 06:39:06 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patch remove use of temporary variable 'ip' which optimizes the code and results in
reduction of assembly instructions and hence improves latency.

Benefit of 18 lines of assembly instructions is observed on e6500 core.

Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@freescale.com>
---
 kernel/sched/core.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8749d20..cdf43f8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2296,13 +2296,16 @@ void __kprobes add_preempt_count(int val)
 	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
 				PREEMPT_MASK - 10);
 #endif
-	if (preempt_count() == val) {
-		unsigned long ip = get_parent_ip(CALLER_ADDR1);
+
+	if (preempt_count() == val)
 #ifdef CONFIG_DEBUG_PREEMPT
-		current->preempt_disable_ip = ip;
+		trace_preempt_off(CALLER_ADDR0,
+			current->preempt_disable_ip =
+			get_parent_ip(CALLER_ADDR1));
+#else
+		trace_preempt_off(CALLER_ADDR0, get_parent_ip(CALLER_ADDR1));
 #endif
-		trace_preempt_off(CALLER_ADDR0, ip);
-	}
+
 }
 EXPORT_SYMBOL(add_preempt_count);
 
-- 
1.7.10.4

