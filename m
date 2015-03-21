From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Sat, 21 Mar 2015 19:02:23 +0100
Message-ID: <1426960943.4677.34.camel@gmail.com>
References: <20150317163541.080310081@goodmis.org>
	 <20150317163617.218582800@goodmis.org>
	 <20150317163551.3093b6c2@gandalf.local.home>
	 <1426753029.4168.80.camel@gmail.com>
	 <20150319122611.0d002d48@gandalf.local.home> <550AFC6A.4050901@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33662 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbbCUSCZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 21 Mar 2015 14:02:25 -0400
In-Reply-To: <550AFC6A.4050901@hp.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2015-03-19 at 10:42 -0600, Thavatchai Makphaibulchoke wrote:
> On 03/19/2015 10:26 AM, Steven Rostedt wrote:
> > On Thu, 19 Mar 2015 09:17:09 +0100
> > Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
> > 
> > 
> >> (aw crap, let's go shopping)... so why is the one in timer.c ok?
> > 
> > It's not. Sebastian, you said there were no other cases of rt_mutexes
> > being taken in hard irq context. Looks like timer.c has one.
> > 
> > So perhaps the real fix is to get that special case of ownership in
> > hard interrupt context?
> > 
> > -- Steve
> > 
> 
> Steve, I'm still working on the fix we discussed using dummy irq_task.
> I should be able to submit some time next week, if still interested.
> 
> Either that, or I think we should remove the function
> spin_do_trylock_in_interrupt() to prevent any possibility of running
> into similar problems in the future.

Why can't we just Let swapper be the owner when in irq with no dummy?

I have "don't raise timer unconditionally" re-applied, the check for a
running callback bits of my nohz_full fixlet, and the below on top of
that, and all _seems_ well.

---
 include/linux/spinlock_rt.h |    1 
 kernel/locking/rtmutex.c    |   58 ++++++++++++++++++--------------------------
 kernel/time/timer.c         |    4 +--
 3 files changed, 27 insertions(+), 36 deletions(-)

--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -22,7 +22,6 @@ extern void __lockfunc rt_spin_lock(spin
 extern unsigned long __lockfunc rt_spin_lock_trace_flags(spinlock_t *lock);
 extern void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass);
 extern void __lockfunc rt_spin_unlock(spinlock_t *lock);
-extern void __lockfunc rt_spin_unlock_after_trylock_in_irq(spinlock_t *lock);
 extern void __lockfunc rt_spin_unlock_wait(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags);
 extern int __lockfunc rt_spin_trylock_bh(spinlock_t *lock);
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -934,8 +934,10 @@ static inline void rt_spin_lock_fastlock
 static inline void rt_spin_lock_fastunlock(struct rt_mutex *lock,
 					   void  (*slowfn)(struct rt_mutex *lock))
 {
-	if (likely(rt_mutex_cmpxchg(lock, current, NULL)))
-		rt_mutex_deadlock_account_unlock(current);
+	struct task_struct *owner = rt_mutex_owner(lock);
+
+	if (likely(rt_mutex_cmpxchg(lock, owner, NULL)))
+		rt_mutex_deadlock_account_unlock(owner);
 	else
 		slowfn(lock);
 }
@@ -1072,11 +1074,16 @@ static void wakeup_next_waiter(struct rt
 /*
  * Slow path to release a rt_mutex spin_lock style
  */
-static void __sched __rt_spin_lock_slowunlock(struct rt_mutex *lock)
+static void noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 {
+	struct task_struct *owner;
+
+	raw_spin_lock(&lock->wait_lock);
+
 	debug_rt_mutex_unlock(lock);
 
-	rt_mutex_deadlock_account_unlock(current);
+	owner = rt_mutex_owner(lock);
+	rt_mutex_deadlock_account_unlock(owner);
 
 	if (!rt_mutex_has_waiters(lock)) {
 		lock->owner = NULL;
@@ -1089,24 +1096,8 @@ static void __sched __rt_spin_lock_slowu
 	raw_spin_unlock(&lock->wait_lock);
 
 	/* Undo pi boosting.when necessary */
-	rt_mutex_adjust_prio(current);
-}
-
-static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
-{
-	raw_spin_lock(&lock->wait_lock);
-	__rt_spin_lock_slowunlock(lock);
-}
-
-static void  noinline __sched rt_spin_lock_slowunlock_hirq(struct rt_mutex *lock)
-{
-	int ret;
-
-	do {
-		ret = raw_spin_trylock(&lock->wait_lock);
-	} while (!ret);
-
-	__rt_spin_lock_slowunlock(lock);
+	if (likely(!is_idle_task(owner)))
+		rt_mutex_adjust_prio(owner);
 }
 
 void __lockfunc rt_spin_lock(spinlock_t *lock)
@@ -1139,13 +1130,6 @@ void __lockfunc rt_spin_unlock(spinlock_
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
-void __lockfunc rt_spin_unlock_after_trylock_in_irq(spinlock_t *lock)
-{
-	/* NOTE: we always pass in '1' for nested, for simplicity */
-	spin_release(&lock->dep_map, 1, _RET_IP_);
-	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock_hirq);
-}
-
 void __lockfunc __rt_spin_unlock(struct rt_mutex *lock)
 {
 	rt_spin_lock_fastunlock(lock, rt_spin_lock_slowunlock);
@@ -1341,7 +1325,7 @@ static int task_blocks_on_rt_mutex(struc
 
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 
-	if (!owner)
+	if (!owner || is_idle_task(owner))
 		return 0;
 
 	raw_spin_lock_irqsave(&owner->pi_lock, flags);
@@ -1746,6 +1730,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
  */
 static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 {
+	struct task_struct *owner;
 	int ret;
 
 	/*
@@ -1763,7 +1748,9 @@ static inline int rt_mutex_slowtrylock(s
 	if (!raw_spin_trylock(&lock->wait_lock))
 		return 0;
 
-	ret = try_to_take_rt_mutex(lock, current, NULL);
+	owner = in_irq() ? idle_task(raw_smp_processor_id()) : current;
+
+	ret = try_to_take_rt_mutex(lock, owner, NULL);
 
 	/*
 	 * try_to_take_rt_mutex() sets the lock waiters bit
@@ -1886,8 +1873,13 @@ static inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
 		     int (*slowfn)(struct rt_mutex *lock))
 {
-	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
-		rt_mutex_deadlock_account_lock(lock, current);
+	struct task_struct *owner = current;
+
+	if (unlikely(in_irq()))
+		owner = idle_task(raw_smp_processor_id());
+
+	if (likely(rt_mutex_cmpxchg(lock, NULL, owner))) {
+		rt_mutex_deadlock_account_lock(lock, owner);
 		return 1;
 	}
 	return slowfn(lock);
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1425,7 +1425,7 @@ unsigned long get_next_timer_interrupt(u
 		expires = base->next_timer;
 	}
 #ifdef CONFIG_PREEMPT_RT_FULL
-	rt_spin_unlock_after_trylock_in_irq(&base->lock);
+	rt_spin_unlock(&base->lock);
 #else
 	spin_unlock(&base->lock);
 #endif
@@ -1518,7 +1518,7 @@ void run_local_timers(void)
 		raise_softirq(TIMER_SOFTIRQ);
 out:
 #ifdef CONFIG_PREEMPT_RT_FULL
-	rt_spin_unlock_after_trylock_in_irq(&base->lock);
+	rt_spin_unlock(&base->lock);
 #endif
 	/* The ; ensures that gcc won't complain in the !RT case */
 	;


