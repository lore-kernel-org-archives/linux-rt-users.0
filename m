From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 1 Apr 2016 23:11:05 +0200
Message-ID: <20160401211105.GE29603@linutronix.de>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
 <1458463425.3908.5.camel@gmail.com>
 <1458814024.23732.35.camel@gmail.com>
 <alpine.DEB.2.11.1603241140510.3978@nanos>
 <1459405903.14336.64.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55769 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbcDAVLJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Apr 2016 17:11:09 -0400
Content-Disposition: inline
In-Reply-To: <1459405903.14336.64.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2016-03-31 08:31:43 [+0200]:

>3. nuke irksome grab_lock: make everybody always try to get the hell
>outta Dodge or hotplug can bloody well wait.
>
>I haven't yet flogged my 64 core box doing that, but my local boxen
>seem to be saying we don't really really need the grab_lock business.
>
>Are my boxen fibbing, is that very attractive looking door #3 a trap?

By the time I improved hotplug I played with this. I had a few ideas but
it didn't fly in the end. Today however I ended up with this:

-- 

Subject: [PATCH] kernel: hotplug: migrate to another CPU if the current is
 going away

If you X is going down then every task running on that CPU must go away.
This is achieved by setting hp->grab_lock to force the task to block
on hp->lock and schedule away in migrate_disable() before the task is
pinned to the CPU.
The task blocks on lock until the CPU is down. If the task holds any
ressources (locks) that are required by one of the CPU notifier then we
will dead lock here.
One petential deadlock is blk_mq CPU notifier (blk_mq_queue_reinit_notify())
which becuase it waits for the RCU grace period to advance/complete
which is stuck on the hp->lock and won't make any progress.
Mike identified another candidate "thermal_throttle_cpu_callback() ->
kernfs_find_and_get_ns()" which blocks on kernfs_mutex that is held
by udev via load_module() and is blocks on hp->lock.

So instead of getting tasks off the CPU by blocking on a lock I attempt
to get off the CPU by masking it out from the CPU mask. The ->mig_away
flag is used to primary avoid a blk_flush_plug_list() invacation via
schedule() and dead lock on cpumask_lock() (because the first spinlock
will invoke migrate_disable()).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h |  2 +-
 kernel/cpu.c          | 37 +++++++++++++++++++++++++++++++++++--
 kernel/sched/core.c   |  3 +++
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 58c5ec8c3742..d0ba00b9aff4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1492,7 +1492,7 @@ struct task_struct {
 #ifdef CONFIG_COMPAT_BRK
 	unsigned brk_randomized:1;
 #endif
-
+	unsigned mig_away :1;
 	unsigned long atomic_flags; /* Flags needing atomic access. */
 
 	struct restart_block restart_block;
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8edd3c716092..3a1ee02ba3ab 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -30,6 +30,10 @@
 /* Serializes the updates to cpu_online_mask, cpu_present_mask */
 static DEFINE_MUTEX(cpu_add_remove_lock);
 
+static DEFINE_SPINLOCK(cpumask_lock);
+static cpumask_var_t mig_cpumask;
+static cpumask_var_t mig_cpumask_org;
+
 /*
  * The following two APIs (cpu_maps_update_begin/done) must be used when
  * attempting to serialize the updates to cpu_online_mask & cpu_present_mask.
@@ -120,6 +124,8 @@ struct hotplug_pcp {
 	 * state.
 	 */
 	spinlock_t lock;
+	cpumask_var_t cpumask;
+	cpumask_var_t cpumask_org;
 #else
 	struct mutex mutex;
 #endif
@@ -158,9 +164,30 @@ void pin_current_cpu(void)
 		return;
 	}
 	if (hp->grab_lock) {
+		int cpu;
+
+		cpu = smp_processor_id();
 		preempt_enable();
-		hotplug_lock(hp);
-		hotplug_unlock(hp);
+		if (cpu != raw_smp_processor_id())
+			goto retry;
+
+		current->mig_away = 1;
+		rt_spin_lock__no_mg(&cpumask_lock);
+
+		/* DOWN */
+		cpumask_copy(mig_cpumask_org, tsk_cpus_allowed(current));
+		cpumask_andnot(mig_cpumask, cpu_online_mask, cpumask_of(cpu));
+		set_cpus_allowed_ptr(current, mig_cpumask);
+
+		if (cpu == raw_smp_processor_id()) {
+			/* BAD */
+			hotplug_lock(hp);
+			hotplug_unlock(hp);
+		}
+		set_cpus_allowed_ptr(current, mig_cpumask_org);
+		current->mig_away = 0;
+		rt_spin_unlock__no_mg(&cpumask_lock);
+
 	} else {
 		preempt_enable();
 		/*
@@ -800,7 +827,13 @@ static struct notifier_block smpboot_thread_notifier = {
 
 void smpboot_thread_init(void)
 {
+	bool ok;
+
 	register_cpu_notifier(&smpboot_thread_notifier);
+	ok = alloc_cpumask_var(&mig_cpumask, GFP_KERNEL);
+	BUG_ON(!ok);
+	ok = alloc_cpumask_var(&mig_cpumask_org, GFP_KERNEL);
+	BUG_ON(!ok);
 }
 
 /* Requires cpu_add_remove_lock to be held */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 94827a59301e..ab06be452eb7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3369,6 +3369,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
 {
 	if (!tsk->state)
 		return;
+
+	if (tsk->mig_away)
+		return;
 	/*
 	 * If a worker went to sleep, notify and ask workqueue whether
 	 * it wants to wake up a task to maintain concurrency.
-- 
2.8.0.rc3

Sebastian
