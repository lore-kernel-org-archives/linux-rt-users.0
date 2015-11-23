From: <jianchuan.wang@windriver.com>
Subject: [PATCH] locking_selftest: Save/restore migrate_disable_atomic in locking selftest
Date: Mon, 23 Nov 2015 15:19:38 +0800
Message-ID: <1448263178-28397-1-git-send-email-jianchuan.wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: <rostedt@goodmis.org>, <bigeasy@linutronix.de>,
	<tglx@linutronix.de>, <yang.shi@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63011 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbbKWHV3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Nov 2015 02:21:29 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Jianchuan Wang <jianchuan.wang@windriver.com>

System will hang when enabling the kernel option
CONFIG_DEBUG_LOCKING_API_SELFTESTS and CONFIG_SCHED_CONFIG
in the preempt-rt kernel.

In the preempt-rt kernel, migrate_enable()/migrage_disable() are called
in the spinlock and read/write lock; The lock()/unlock() aren't used
in pairs in the selftest processing changes the migrate_disable_atomic
so that the system will hang in the dotest(), the calltrace is :
printk() ..-> vprintk_emit() -> migrage_disable()
-> WARN_ON_ONCE() ..-> warn_slowpath_common() ..-> printk()

For fixing it, we need save the migrate_disable_atomic before self-testing
and restore migrate_disable_atomic after self-testing.

Signed-off-by: Jianchuan Wang <jianchuan.wang@windriver.com>
---
 lib/locking-selftest.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index b93a610..61798da 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -997,10 +997,23 @@ static int unexpected_testcase_failures;
 static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 {
 	unsigned long saved_preempt_count = preempt_count();
+#ifdef CONFIG_SCHED_DEBUG
+	struct task_struct *p = current;
+	int save_migrate_atomic;
+#endif
 
 	WARN_ON(irqs_disabled());
 
+#ifdef CONFIG_SCHED_DEBUG
+	save_migrate_atomic = p->migrate_disable_atomic;
+#endif
+
 	testcase_fn();
+
+#ifdef CONFIG_SCHED_DEBUG
+	p->migrate_disable_atomic = save_migrate_atomic;
+#endif
+
 	/*
 	 * Filter out expected failures:
 	 */
-- 
1.9.1

