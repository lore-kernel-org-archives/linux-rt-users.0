From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Mon, 18 Apr 2016 19:15:51 +0200
Message-ID: <20160418171550.GA21734@linutronix.de>
References: <alpine.DEB.2.11.1603241140510.3978@nanos>
 <1459405903.14336.64.camel@gmail.com>
 <20160401211105.GE29603@linutronix.de>
 <1459566735.3779.36.camel@gmail.com>
 <57068F28.8010409@linutronix.de>
 <1460123044.16946.11.camel@gmail.com>
 <5707B911.6090404@linutronix.de>
 <1460125010.16946.27.camel@gmail.com>
 <5707C563.2050801@linutronix.de>
 <1460134168.3860.6.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35756 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbcDRRPx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Apr 2016 13:15:53 -0400
Content-Disposition: inline
In-Reply-To: <1460134168.3860.6.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2016-04-08 18:49:28 [+0200]:

>On Fri, 2016-04-08 at 16:51 +0200, Sebastian Andrzej Siewior wrote:
>
>> Is there anything you can hand me over?
>
>Sure, I'll send it offline (yup, that proud of my scripting;)
>
>	-Mike

take 2. There is this else case in pin_current_cpu() where I take
hp_lock. I didn't manage to get in there. So I *think* we can get rid of
the lock now. Since there is no lock (or will be) we can drop the whole
`do_mig_dis' checking and do the migrate_disable() _after_ we obtained
the lock. We were not able to do so due to the lock hp_lock.

And with this, I didn't manage to triger the lockup you had with
futextest.

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f9a0f2b540f1..b0f786274025 100644
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
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 66971005cc12..b5e5e6a15278 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -930,13 +930,13 @@ static inline void rt_spin_lock_fastlock(struct rt_mutex *lock,
 {
 	might_sleep_no_state_check();
 
-	if (do_mig_dis)
+	if (do_mig_dis && 0)
 		migrate_disable();
 
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		rt_mutex_deadlock_account_lock(lock, current);
 	else
-		slowfn(lock, do_mig_dis);
+		slowfn(lock, false);
 }
 
 static inline void rt_spin_lock_fastunlock(struct rt_mutex *lock,
@@ -1125,12 +1125,14 @@ void __lockfunc rt_spin_lock(spinlock_t *lock)
 {
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock, true);
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	migrate_disable();
 }
 EXPORT_SYMBOL(rt_spin_lock);
 
 void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
 {
 	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock, true);
+	migrate_disable();
 }
 EXPORT_SYMBOL(__rt_spin_lock);
 
@@ -1145,6 +1147,7 @@ void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock, true);
+	migrate_disable();
 }
 EXPORT_SYMBOL(rt_spin_lock_nested);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da96d97f3d79..0eb7496870bd 100644
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
