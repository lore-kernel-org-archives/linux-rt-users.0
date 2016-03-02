From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 09/20] kernel: migrate_disable() do fastpath in atomic & irqs-off
Date: Wed, 02 Mar 2016 10:37:07 -0500
Message-ID: <20160302153715.814953215@goodmis.org>
References: <20160302153658.995489487@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0009-kernel-migrate_disable-do-fastpath-in-atomic-irqs-of.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.27-rt27-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

With interrupts off it makes no sense to do the long path since we can't
leave the CPU anyway. Also we might end up in a recursion with lockdep.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8214206817f2..24c7ced53555 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2859,7 +2859,7 @@ void migrate_disable(void)
 {
 	struct task_struct *p = current;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
 #endif
@@ -2893,7 +2893,7 @@ void migrate_enable(void)
 	unsigned long flags;
 	struct rq *rq;
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
 #endif
-- 
2.7.0
