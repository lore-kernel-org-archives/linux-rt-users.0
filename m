From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 2/6] kernel: migrate_disable() do fastpath in atomic & irqs-off
Date: Sat, 13 Feb 2016 00:02:44 +0100
Message-ID: <1455318168-7125-2-git-send-email-bigeasy@linutronix.de>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43526 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbcBLXC7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Feb 2016 18:02:59 -0500
In-Reply-To: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

With interrupts off it makes no sense to do the long path since we can't
leave the CPU anyway. Also we might end up in a recursion with lockdep.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1217926b500d..40c1e29416c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3157,7 +3157,7 @@ void migrate_disable(void)
 {
 	struct task_struct *p = current;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
 #endif
@@ -3188,7 +3188,7 @@ void migrate_enable(void)
 {
 	struct task_struct *p = current;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
 #endif
-- 
2.7.0

