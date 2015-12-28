From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.4-rc6-rt1 PATCH 1/2] kernel/sched/core.c: UP: fix 'implicit declaration of function 'update_migrate_disable'
Date: Mon, 28 Dec 2015 20:00:10 +0200
Message-ID: <1451325611-21678-2-git-send-email-grygorii.strashko@ti.com>
References: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>
To: <bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43663 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbbL1SA0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Dec 2015 13:00:26 -0500
In-Reply-To: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patch fixes below build error for case SMP=n:

kernel/sched/core.c: In function '__schedule':
kernel/sched/core.c:3400:2: error: implicit declaration of function 'update_migrate_disable' [-Werror=implicit-function-declaration]
  update_migrate_disable(prev);
  ^

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 kernel/sched/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8d9f6a6..c10ac78 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1092,6 +1092,15 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 		rq_clock_skip_update(rq, true);
 }
 
+#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
+#define MIGRATE_DISABLE_SET_AFFIN	(1<<30) /* Can't make a negative */
+#define migrate_disabled_updated(p)	((p)->migrate_disable & MIGRATE_DISABLE_SET_AFFIN)
+#define migrate_disable_count(p)	((p)->migrate_disable & ~MIGRATE_DISABLE_SET_AFFIN)
+#else
+static inline void update_migrate_disable(struct task_struct *p) { }
+#define migrate_disabled_updated(p)		0
+#endif
+
 #ifdef CONFIG_SMP
 /*
  * This is how migration works:
@@ -1209,15 +1218,6 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
-#define MIGRATE_DISABLE_SET_AFFIN	(1<<30) /* Can't make a negative */
-#define migrate_disabled_updated(p)	((p)->migrate_disable & MIGRATE_DISABLE_SET_AFFIN)
-#define migrate_disable_count(p)	((p)->migrate_disable & ~MIGRATE_DISABLE_SET_AFFIN)
-#else
-static inline void update_migrate_disable(struct task_struct *p) { }
-#define migrate_disabled_updated(p)		0
-#endif
