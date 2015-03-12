From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 32/36] timers: Track total number of timers in list
Date: Thu, 12 Mar 2015 15:22:11 -0400
Message-ID: <20150312192200.050690834@goodmis.org>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0032-timers-Track-total-number-of-timers-in-list.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.38-rt53-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

upstream commit: fff421580f512fc044cc7421fdff31a7a6997350

Currently, the tvec_base structure's ->active_timers field tracks only
the non-deferrable timers, which means that even if ->active_timers is
zero, there might well be deferrable timers in the list.  This commit
therefore adds an ->all_timers field to track all the timers, whether
deferrable or not.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Tested-by: Mike Galbraith <bitbucket@online.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/timer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/timer.c b/kernel/timer.c
index 3b79da2f9c67..1f1795734b70 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -84,6 +84,7 @@ struct tvec_base {
 	unsigned long timer_jiffies;
 	unsigned long next_timer;
 	unsigned long active_timers;
+	unsigned long all_timers;
 	struct tvec_root tv1;
 	struct tvec tv2;
 	struct tvec tv3;
@@ -395,6 +396,7 @@ static void internal_add_timer(struct tvec_base *base, struct timer_list *timer)
 			base->next_timer = timer->expires;
 		base->active_timers++;
 	}
+	base->all_timers++;
 }
 
 #ifdef CONFIG_TIMER_STATS
@@ -674,6 +676,7 @@ detach_expired_timer(struct timer_list *timer, struct tvec_base *base)
 	detach_timer(timer, true);
 	if (!tbase_get_deferrable(timer->base))
 		base->active_timers--;
+	base->all_timers--;
 }
 
 static int detach_if_pending(struct timer_list *timer, struct tvec_base *base,
@@ -688,6 +691,7 @@ static int detach_if_pending(struct timer_list *timer, struct tvec_base *base,
 		if (timer->expires == base->next_timer)
 			base->next_timer = base->timer_jiffies;
 	}
+	base->all_timers--;
 	return 1;
 }
 
@@ -1678,6 +1682,7 @@ static int init_timers_cpu(int cpu)
 	base->timer_jiffies = jiffies;
 	base->next_timer = base->timer_jiffies;
 	base->active_timers = 0;
+	base->all_timers = 0;
 	return 0;
 }
 
-- 
2.1.4
