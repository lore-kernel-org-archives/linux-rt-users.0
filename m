From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch 2/2]  rt/locking/hotplug: Fix
 rt_spin_lock_slowlock() migrate_disable() bug
Date: Thu, 07 Apr 2016 06:37:11 +0200
Message-ID: <1460003831.3882.106.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1459405903.14336.64.camel@gmail.com>
	 <20160401211105.GE29603@linutronix.de> <1459566735.3779.36.camel@gmail.com>
	 <1459837988.26938.16.camel@gmail.com> <1459860597.7776.2.camel@gmail.com>
	 <1459944021.3990.14.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38223 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbcDGEhP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Apr 2016 00:37:15 -0400
In-Reply-To: <1459944021.3990.14.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2016-04-06 at 14:00 +0200, Mike Galbraith wrote:
> It'll take a hotplug beating seemingly as well as any non-rt kernel,
> but big box NAKed it due to jitter, which can mean 1.0 things.. duh.

FWIW, the below turned big box NAK into ACK.  Stressing hotplug over
night, iteration completion time went from about 2 1/2 hours with
bandaids on the two identified rt sore spots, to an hour and 10 minutes
as well for some reason, but whatever..

There are other things like doing the downing on the cpu being taken
down that would likely be a good idea, but I suppose I'll now wait to
see what future devel trees look like.  I suspect Thomas will aim his
axe at the annoying lock too (and his makes clean cuts).  Meanwhile,
just reverting e24b142cfb4a makes hotplug as safe as it ever was (not
at all), slaughtering the lock seems to put current rt on par with non
-rt (iow other changes left not much rt trouble remaining), and the
below is one way to make e24b142cfb4a non-toxic.

	-Mike

rt/locking/hotplug: Fix rt_spin_lock_slowlock() migrate_disable() bug

I met a problem while testing shiny new hotplug machinery.

migrate_disable() -> pin_current_cpu() -> hotplug_lock() leads to..
	BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on));

Unpin before we block, and repin while still in atomic context
after acquisition.

Fixes: e24b142cfb4a rt/locking: Reenable migration accross schedule
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 include/linux/cpu.h      |    2 ++
 include/linux/preempt.h  |    2 ++
 kernel/cpu.c             |   13 +++++++++++++
 kernel/locking/rtmutex.c |   18 +++++++++++-------
 kernel/sched/core.c      |    7 +++++++
 5 files changed, 35 insertions(+), 7 deletions(-)

--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -231,6 +231,7 @@ extern void put_online_cpus(void);
 extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 extern void pin_current_cpu(void);
+extern void pin_current_cpu_in_atomic(void);
 extern void unpin_current_cpu(void);
 #define hotcpu_notifier(fn, pri)	cpu_notifier(fn, pri)
 #define __hotcpu_notifier(fn, pri)	__cpu_notifier(fn, pri)
@@ -250,6 +251,7 @@ static inline void cpu_hotplug_done(void
 #define cpu_hotplug_disable()	do { } while (0)
 #define cpu_hotplug_enable()	do { } while (0)
 static inline void pin_current_cpu(void) { }
+static inline void pin_current_cpu_in_atomic(void) { }
 static inline void unpin_current_cpu(void) { }
 #define hotcpu_notifier(fn, pri)	do { (void)(fn); } while (0)
 #define __hotcpu_notifier(fn, pri)	do { (void)(fn); } while (0)
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -302,9 +302,11 @@ do { \
 # define preempt_enable_nort()		barrier()
 # ifdef CONFIG_SMP
    extern void migrate_disable(void);
+   extern void migrate_disable_in_atomic(void);
    extern void migrate_enable(void);
 # else /* CONFIG_SMP */
 #  define migrate_disable()		barrier()
+#  define migrate_disable_in_atomic()	barrier()
 #  define migrate_enable()		barrier()
 # endif /* CONFIG_SMP */
 #else
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -204,6 +204,19 @@ void pin_current_cpu(void)
 }
 
 /**
+ * pin_current_cpu_in_atomic - Prevent the current cpu from being unplugged
+ *
+ * The caller is acquiring a lock, and must have a reference before leaving
+ * the preemption disabled region therein.
+ *
+ * Must be called with preemption disabled (preempt_count = 1)!
+ */
+void pin_current_cpu_in_atomic(void)
+{
+	this_cpu_ptr(&hotplug_pcp)->refcount++;
+}
+
+/**
  * unpin_current_cpu - Allow unplug of current cpu
  *
  * Must be called with preemption or interrupts disabled!
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1002,11 +1002,17 @@ static void  noinline __sched rt_spin_lo
 	unsigned long flags;
 	int ret;
 
+	mg_off &= (self->migrate_disable == 1 && !self->state);
+	if (mg_off)
+		migrate_enable();
+
 	rt_mutex_init_waiter(&waiter, true);
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
 	if (__try_to_take_rt_mutex(lock, self, NULL, STEAL_LATERAL)) {
+		if (mg_off)
+			migrate_disable_in_atomic();
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		return;
 	}
@@ -1029,8 +1035,11 @@ static void  noinline __sched rt_spin_lo
 
 	for (;;) {
 		/* Try to acquire the lock again. */
-		if (__try_to_take_rt_mutex(lock, self, &waiter, STEAL_LATERAL))
+		if (__try_to_take_rt_mutex(lock, self, &waiter, STEAL_LATERAL)) {
+			if (mg_off)
+				migrate_disable_in_atomic();
 			break;
+		}
 
 		top_waiter = rt_mutex_top_waiter(lock);
 		lock_owner = rt_mutex_owner(lock);
@@ -1039,13 +1048,8 @@ static void  noinline __sched rt_spin_lo
 
 		debug_rt_mutex_print_deadlock(&waiter);
 
-		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner)) {
-			if (mg_off)
-				migrate_enable();
+		if (top_waiter != &waiter || adaptive_wait(lock, lock_owner))
 			schedule();
-			if (mg_off)
-				migrate_disable();
-		}
 
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3328,6 +3328,13 @@ void migrate_disable(void)
 }
 EXPORT_SYMBOL(migrate_disable);
 
+void migrate_disable_in_atomic(void)
+{
+	pin_current_cpu_in_atomic();
+	current->migrate_disable++;
+}
+EXPORT_SYMBOL(migrate_disable_in_atomic);
+
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
