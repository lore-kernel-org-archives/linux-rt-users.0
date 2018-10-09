From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFD/RFC PATCH 7/8] sched: Ensure blocked_on is always guarded by blocked_lock
Date: Tue,  9 Oct 2018 11:24:33 +0200
Message-ID: <20181009092434.26221-8-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

blocked_on pointer might be concurrently modified by schedule() (when
proxy() is called) and by wakeup path, so we need to guard changes.

Ensure blocked_lock is always held before updating blocked_on pointer.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/locking/mutex-debug.c |  1 +
 kernel/locking/mutex.c       | 13 ++++++++++---
 kernel/sched/core.c          | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 6605e083a3e9..2e3fbdaa8474 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -62,6 +62,7 @@ void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 {
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
+	DEBUG_LOCKS_WARN_ON(task->blocked_on == NULL);
 	DEBUG_LOCKS_WARN_ON(task->blocked_on != lock);
 
 	list_del_init(&waiter->list);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index c16cb84420c3..8f6d4ceca2da 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -950,6 +950,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	raw_spin_lock(&current->blocked_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -1014,6 +1015,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 				goto err;
 		}
 
+		raw_spin_unlock(&current->blocked_lock);
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		schedule_preempt_disabled();
 
@@ -1027,6 +1029,8 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
 		}
 
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+		raw_spin_lock(&current->blocked_lock);
 		/*
 		 * Gets reset by ttwu_remote().
 		 */
@@ -1040,10 +1044,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		if (__mutex_trylock(lock) ||
 		    (first && mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx, &waiter)))
 			break;
-
-		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -1072,6 +1073,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	if (use_ww_ctx && ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
@@ -1081,6 +1083,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	__set_current_state(TASK_RUNNING);
 	mutex_remove_waiter(lock, &waiter, current);
 err_early_kill:
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, 1, ip);
@@ -1268,6 +1271,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	debug_mutex_unlock(lock);
 
 #ifdef CONFIG_PROXY_EXEC
+	raw_spin_lock(&current->blocked_lock);
 	/*
 	 * If we have a task boosting us, and that task was boosting us through
 	 * this lock, hand the lock that that task, as that is the highest
@@ -1305,6 +1309,9 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		__mutex_handoff(lock, next);
 
 	preempt_disable(); // XXX unlock->wakeup inversion like
+#ifdef CONFIG_PROXY_EXEC
+	raw_spin_unlock(&current->blocked_lock);
+#endif
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	wake_up_q(&wake_q); // XXX must force resched on proxy
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e3e3eea3f5b2..54003515fd29 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1761,7 +1761,15 @@ static int ttwu_remote(struct task_struct *p, int wake_flags)
 	 * trigger the on_rq_queued() clause for them.
 	 */
 	if (task_is_blocked(p)) {
-		p->blocked_on = NULL; /* let it run again */
+		raw_spin_lock(&p->blocked_lock);
+
+		if (task_is_blocked(p)) {
+			p->blocked_on = NULL; /* let it run again */
+		} else {
+			raw_spin_unlock(&p->blocked_lock);
+			goto out_wakeup;
+		}
+
 		if (!cpumask_test_cpu(cpu_of(rq), &p->cpus_allowed)) {
 			/*
 			 * proxy stuff moved us outside of the affinity mask
@@ -1771,6 +1779,7 @@ static int ttwu_remote(struct task_struct *p, int wake_flags)
 			p->on_rq = 0;
 			/* XXX [juril] SLEEP|NOCLOCK ? */
 			deactivate_task(rq, p, DEQUEUE_SLEEP);
+			raw_spin_unlock(&p->blocked_lock);
 			goto out_unlock;
 		}
 
@@ -1779,8 +1788,10 @@ static int ttwu_remote(struct task_struct *p, int wake_flags)
 		 * executing context might not be the most elegible anymore.
 		 */
 		resched_curr(rq);
+		raw_spin_unlock(&p->blocked_lock);
 	}
 
+out_wakeup:
 	ttwu_do_wakeup(rq, p, wake_flags, &rf);
 	ret = 1;
 
@@ -3464,12 +3475,26 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	 */
 	for (p = next; p->blocked_on; p = owner) {
 		mutex = p->blocked_on;
+		if (!mutex)
+			return NULL;
 
 		/*
 		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
 		 * and ensure @owner sticks around.
 		 */
 		raw_spin_lock(&mutex->wait_lock);
+		raw_spin_lock(&p->blocked_lock);
+
+		/* Check again that p is blocked with blocked_lock held */
+		if (task_is_blocked(p)) {
+			BUG_ON(mutex != p->blocked_on);
+		} else {
+			/* Something changed in the blocked_on chain */
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return NULL;
+		}
+
 		owner = __mutex_owner(mutex);
 		/*
 		 * XXX can't this be 0|FLAGS? See __mutex_unlock_slowpath for(;;)
@@ -3491,6 +3516,7 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		 * on this rq, therefore holding @rq->lock is sufficient to
 		 * guarantee its existence, as per ttwu_remote().
 		 */
+		raw_spin_unlock(&p->blocked_lock);
 		raw_spin_unlock(&mutex->wait_lock);
 
 		owner->blocked_task = p;
@@ -3537,6 +3563,7 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	 * @owner can disappear, simply migrate to @that_cpu and leave that CPU
 	 * to sort things out.
 	 */
+	raw_spin_unlock(&p->blocked_lock);
 	raw_spin_unlock(&mutex->wait_lock);
 
 	/*
@@ -3661,6 +3688,7 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	 * If @owner/@p is allowed to run on this CPU, make it go.
 	 */
 	if (cpumask_test_cpu(this_cpu, &owner->cpus_allowed)) {
+		raw_spin_unlock(&p->blocked_lock);
 		raw_spin_unlock(&mutex->wait_lock);
 		return owner;
 	}
@@ -3682,6 +3710,7 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	 * We use @owner->blocked_lock to serialize against ttwu_activate().
 	 * Either we see its new owner->on_rq or it will see our list_add().
 	 */
+	raw_spin_unlock(&p->blocked_lock);
 	raw_spin_lock(&owner->blocked_lock);
 
 	/*
-- 
2.17.1
