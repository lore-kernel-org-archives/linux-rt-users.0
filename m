From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Sun, 20 Mar 2016 09:43:45 +0100
Message-ID: <1458463425.3908.5.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2016-02-13 at 00:02 +0100, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> We currently disable migration across lock acquisition. That includes the part
> where we block on the lock and schedule out. We cannot disable migration after
> taking the lock as that would cause a possible lock inversion.
> 
> But we can be smart and enable migration when we block and schedule out. That
> allows the scheduler to place the task freely at least if this is the first
> migrate disable level. For nested locking this does not help at all.

I met a problem while testing shiny new hotplug machinery.

rt/locking: Fix rt_spin_lock_slowlock() vs hotplug migrate_disable() bug

migrate_disable() -> pin_current_cpu() -> hotplug_lock() leads to..
	BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on));
..so let's call migrate_disable() after we acquire the lock instead.

Fixes: e24b142cfb4a rt/locking: Reenable migration accross schedule
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmailo.com>
---
 kernel/locking/rtmutex.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1011,7 +1011,7 @@ static void  noinline __sched rt_spin_lo
 	struct task_struct *lock_owner, *self = current;
 	struct rt_mutex_waiter waiter, *top_waiter;
 	unsigned long flags;
-	int ret;
+	bool mg_disable = false;
 
 	rt_mutex_init_waiter(&waiter, true);
 
@@ -1035,8 +1035,7 @@ static void  noinline __sched rt_spin_lo
 	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
 	raw_spin_unlock(&self->pi_lock);
 
-	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
-	BUG_ON(ret);
+	BUG_ON(task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK));
 
 	for (;;) {
 		/* Try to acquire the lock again. */
@@ -1051,11 +1050,12 @@ static void  noinline __sched rt_spin_lo
 		debug_rt_mutex_print_deadlock(&waiter);
 
 		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner)) {
-			if (mg_off)
+			if (mg_off && self->migrate_disable == 1) {
+				mg_off = false;
+				mg_disable = true;
 				migrate_enable();
+			}
 			schedule();
-			if (mg_off)
-				migrate_disable();
 		}
 
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
@@ -1088,6 +1088,9 @@ static void  noinline __sched rt_spin_lo
 
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
+	if (mg_disable)
+		migrate_disable();
+
 	debug_rt_mutex_free_waiter(&waiter);
 }
 
