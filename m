From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH] rcu: Eliminate softirq processing from rcutree
Date: Thu, 26 Dec 2013 11:03:32 +0100
Message-ID: <1388052212.5420.4.camel@marge.simpson.net>
References: <20131221193900.GA8427@linutronix.de>
	 <1387681647.5412.25.camel@marge.simpson.net>
	 <1387702631.5412.101.camel@marge.simpson.net>
	 <1387773533.5369.16.camel@marge.simpson.net>
	 <20131224193636.GD19211@linux.vnet.ibm.com>
	 <1387940854.5373.8.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387940854.5373.8.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2013-12-25 at 04:07 +0100, Mike Galbraith wrote:
> On Tue, 2013-12-24 at 11:36 -0800, Paul E. McKenney wrote: 

> > So which code do you think deserves the big lump of coal?  ;-)
> 
> Sebastian's NO_HZ_FULL locking fixes.

Whack-a-mole hasn't yet dug up any new moles.

---
 kernel/timer.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6/kernel/timer.c
===================================================================
--- linux-2.6.orig/kernel/timer.c
+++ linux-2.6/kernel/timer.c
@@ -764,7 +764,9 @@ __mod_timer(struct timer_list *timer, un
 	timer_stats_timer_set_start_info(timer);
 	BUG_ON(!timer->function);
 
+	local_irq_disable_rt();
 	base = lock_timer_base(timer, &flags);
+	local_irq_enable_rt();
 
 	ret = detach_if_pending(timer, base, false);
 	if (!ret && pending_only)
@@ -1198,7 +1200,9 @@ static inline void __run_timers(struct t
 {
 	struct timer_list *timer;
 
+	local_irq_disable_rt();
 	spin_lock_irq(&base->lock);
+	local_irq_enable_rt();
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
 		struct list_head work_list;
 		struct list_head *head = &work_list;
---
 kernel/time/tick-sched.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -216,7 +216,9 @@ void __tick_nohz_full_check(void)
 
 static void nohz_full_kick_work_func(struct irq_work *work)
 {
+	local_irq_disable_rt();
 	__tick_nohz_full_check();
+	local_irq_enable_rt();
 }
 
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
