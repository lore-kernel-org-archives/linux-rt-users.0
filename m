From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 35/36] timers: Reduce future __run_timers() latency for first add to empty
 list
Date: Thu, 12 Mar 2015 15:22:14 -0400
Message-ID: <20150312192200.529548051@goodmis.org>
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
Content-Disposition: inline; filename=0035-timers-Reduce-future-__run_timers-latency-for-first-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.38-rt53-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

upstream commit: 18d8cb64c9c074cbe2bd677ab10fff8283abdb62

The __run_timers() function currently steps through the list one jiffy at
a time in order to update the timer wheel.  However, if the timer wheel
is empty, no adjustment is needed other than updating ->timer_jiffies.
Therefore, just before we add a timer to an empty timer wheel, we should
mark the timer wheel as being up to date.  This marking will reduce (and
perhaps eliminate) the jiffy-stepping that a future __run_timers() call
will need to do in response to some future timer posting or migration.
This commit therefore updates ->timer_jiffies for this case.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Tested-by: Mike Galbraith <bitbucket@online.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/timer.c b/kernel/timer.c
index c3017c06f212..0ee72212b99c 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -401,6 +401,7 @@ __internal_add_timer(struct tvec_base *base, struct timer_list *timer)
 
 static void internal_add_timer(struct tvec_base *base, struct timer_list *timer)
 {
+	(void)catchup_timer_jiffies(base);
 	__internal_add_timer(base, timer);
 	/*
 	 * Update base->active_timers and base->next_timer
-- 
2.1.4
