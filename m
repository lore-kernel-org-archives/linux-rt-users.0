From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 33/36] timers: Reduce __run_timers() latency for empty list
Date: Thu, 12 Mar 2015 15:22:12 -0400
Message-ID: <20150312192200.209937203@goodmis.org>
References: <20150312192139.799127123@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Mike Galbraith <bitbucket@online.de>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:11830 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932486AbbCLTWJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 15:22:09 -0400
Content-Disposition: inline; filename=0033-timers-Reduce-__run_timers-latency-for-empty-list.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.12.38-rt53-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

upstream commit: d550e81dc0ddc04f1b417c179c214103a28e0ee8

The __run_timers() function currently steps through the list one jiffy at
a time in order to update the timer wheel.  However, if the timer wheel
is empty, no adjustment is needed other than updating ->timer_jiffies.
In this case, which is likely to be common for NO_HZ_FULL kernels, the
kernel currently incurs a large latency for no good reason.  This commit
therefore short-circuits this case.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Tested-by: Mike Galbraith <bitbucket@online.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/timer.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/timer.c b/kernel/timer.c
index 1f1795734b70..763ca9af64ae 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -341,6 +341,20 @@ void set_timer_slack(struct timer_list *timer, int slack_hz)
 }
 EXPORT_SYMBOL_GPL(set_timer_slack);
 
+/*
+ * If the list is empty, catch up ->timer_jiffies to the current time.
+ * The caller must hold the tvec_base lock.  Returns true if the list
+ * was empty and therefore ->timer_jiffies was updated.
+ */
+static bool catchup_timer_jiffies(struct tvec_base *base)
+{
+	if (!base->all_timers) {
+		base->timer_jiffies = jiffies;
+		return true;
+	}
+	return false;
+}
+
 static void
 __internal_add_timer(struct tvec_base *base, struct timer_list *timer)
 {
@@ -1203,6 +1217,10 @@ static inline void __run_timers(struct tvec_base *base)
 	struct timer_list *timer;
 
 	spin_lock_irq(&base->lock);
+	if (catchup_timer_jiffies(base)) {
+		spin_unlock_irq(&base->lock);
+		return;
+	}
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
 		struct list_head work_list;
 		struct list_head *head = &work_list;
-- 
2.1.4


