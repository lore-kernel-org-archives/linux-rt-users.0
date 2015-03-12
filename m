From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 34/36] timers: Reduce future __run_timers() latency for newly emptied list
Date: Thu, 12 Mar 2015 15:22:13 -0400
Message-ID: <20150312192200.369597331@goodmis.org>
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
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:58636 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932491AbbCLTWJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 15:22:09 -0400
Content-Disposition: inline; filename=0034-timers-Reduce-future-__run_timers-latency-for-newly-.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.12.38-rt53-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

upstream commit: 16d937f880312e3f47157d4d6d6ebf7e61523378

The __run_timers() function currently steps through the list one jiffy at
a time in order to update the timer wheel.  However, if the timer wheel
is empty, no adjustment is needed other than updating ->timer_jiffies.
Therefore, if we just emptied the timer wheel, for example, by deleting
the last timer, we should mark the timer wheel as being up to date.
This marking will reduce (and perhaps eliminate) the jiffy-stepping that
a future __run_timers() call will need to do in response to some future
timer posting or migration.  This commit therefore catches ->timer_jiffies
for this case.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Tested-by: Mike Galbraith <bitbucket@online.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/timer.c b/kernel/timer.c
index 763ca9af64ae..c3017c06f212 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -691,6 +691,7 @@ detach_expired_timer(struct timer_list *timer, struct tvec_base *base)
 	if (!tbase_get_deferrable(timer->base))
 		base->active_timers--;
 	base->all_timers--;
+	(void)catchup_timer_jiffies(base);
 }
 
 static int detach_if_pending(struct timer_list *timer, struct tvec_base *base,
@@ -706,6 +707,7 @@ static int detach_if_pending(struct timer_list *timer, struct tvec_base *base,
 			base->next_timer = base->timer_jiffies;
 	}
 	base->all_timers--;
+	(void)catchup_timer_jiffies(base);
 	return 1;
 }
 
-- 
2.1.4


