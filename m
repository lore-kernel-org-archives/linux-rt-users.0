From: Qiang Huang <h.huangqiang@huawei.com>
Subject: [PATCH] sched: fix the wrong macro name of CONFIG_DEBUG_PREEMPT
Date: Mon, 8 Apr 2013 19:47:29 +0800
Message-ID: <5162AE51.8030804@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:58190 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935215Ab3DHLwg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Apr 2013 07:52:36 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Might be a typo, would cause some debug code never be run.

Signed-off-by: Qiang Huang <h.huangqiang@huawei.com>
---
 kernel/sched/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 30126e2..7b50412 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3405,7 +3405,7 @@ static noinline void __schedule_bug(struct task_struct *prev)
 	print_modules();
 	if (irqs_disabled())
 		print_irqtrace_events(prev);
-#ifdef DEBUG_PREEMPT
+#ifdef CONFIG_DEBUG_PREEMPT
 	if (in_atomic_preempt_off()) {
 		pr_err("Preemption disabled at:");
 		print_ip_sym(current->preempt_disable_ip);
@@ -7802,7 +7802,7 @@ void __might_sleep(const char *file, int line, int preempt_offset)
 	debug_show_held_locks(current);
 	if (irqs_disabled())
 		print_irqtrace_events(current);
-#ifdef DEBUG_PREEMPT
+#ifdef CONFIG_DEBUG_PREEMPT
 	if (!preempt_count_equals(preempt_offset)) {
 		pr_err("Preemption disabled at:");
 		print_ip_sym(current->preempt_disable_ip);
-- 
1.7.1

