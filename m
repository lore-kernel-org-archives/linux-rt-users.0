From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V2 Resend 4/4] timer: Migrate running timer
Date: Tue,  6 Nov 2012 16:08:46 +0530
Message-ID: <d12b25130db5a8b645929eb93d1cf4ddc2d68826.1352196505.git.viresh.kumar@linaro.org>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdsw-power-team-5wv7dgnIgG8@public.gmane.org
To: pjt-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, paul.mckenney-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, venki-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
	mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <cover.1352196505.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1352196505.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1352196505.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Till now, we weren't migrating a running timer because with migration
del_timer_sync() can't detect that the timer's handler yet has not finished.

Now, when can we actually to reach to the code (inside __mod_timer()) where

base->running_timer == timer ? i.e. We are trying to migrate current timer

I can see only following case:
- Timer re-armed itself. i.e. Currently we are running interrupt handler of a
  timer and it rearmed itself from there. At this time user might have called
  del_timer_sync() or not. If not, then there is no harm in re-arming the timer?

Now, when somebody tries to delete a timer, obviously he doesn't want to run it
any more for now. So, why should we ever re-arm a timer, which is scheduled for
deletion?

This patch tries to fix "migration of running timer", assuming above theory is
correct :)

So, now when we get a call to del_timer_sync(), we will mark it scheduled for
deletion in an additional variable. This would be checked whenever we try to
modify/arm it again. If it was currently scheduled for deletion, we must not
modify/arm it.

And so, whenever we reach to the situation where:
base->running_timer == timer

We are sure, nobody is waiting in del_timer_sync().

We will clear this flag as soon as the timer is deleted, so that it can be
started again after deleting it successfully.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 include/linux/timer.h |  2 ++
 kernel/timer.c        | 42 +++++++++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 8c5a197..6aa720f 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -22,6 +22,7 @@ struct timer_list {
 	unsigned long data;
 
 	int slack;
+	int sched_del;
 
 #ifdef CONFIG_TIMER_STATS
 	int start_pid;
@@ -77,6 +78,7 @@ extern struct tvec_base boot_tvec_bases;
 		.data = (_data),				\
 		.base = (void *)((unsigned long)&boot_tvec_bases + (_flags)), \
 		.slack = -1,					\
+		.sched_del = 0,					\
 		__TIMER_LOCKDEP_MAP_INITIALIZER(		\
 			__FILE__ ":" __stringify(__LINE__))	\
 	}
diff --git a/kernel/timer.c b/kernel/timer.c
index 1170ece..14e1f76 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -622,6 +622,7 @@ static void do_init_timer(struct timer_list *timer, unsigned int flags,
 	timer->entry.next = NULL;
 	timer->base = (void *)((unsigned long)base | flags);
 	timer->slack = -1;
+	timer->sched_del = 0;
 #ifdef CONFIG_TIMER_STATS
 	timer->start_site = NULL;
 	timer->start_pid = -1;
@@ -729,6 +730,12 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 
 	base = lock_timer_base(timer, &flags);
 
+	if (timer->sched_del) {
+		/* Don't schedule it again, as it is getting deleted */
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	ret = detach_if_pending(timer, base, false);
 	if (!ret && pending_only)
 		goto out_unlock;
@@ -746,21 +753,12 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 	new_base = per_cpu(tvec_bases, cpu);
 
 	if (base != new_base) {
-		/*
-		 * We are trying to schedule the timer on the local CPU.
-		 * However we can't change timer's base while it is running,
-		 * otherwise del_timer_sync() can't detect that the timer's
-		 * handler yet has not finished. This also guarantees that
-		 * the timer is serialized wrt itself.
-		 */
-		if (likely(base->running_timer != timer)) {
-			/* See the comment in lock_timer_base() */
-			timer_set_base(timer, NULL);
-			spin_unlock(&base->lock);
-			base = new_base;
-			spin_lock(&base->lock);
-			timer_set_base(timer, base);
-		}
+		/* See the comment in lock_timer_base() */
+		timer_set_base(timer, NULL);
+		spin_unlock(&base->lock);
+		base = new_base;
+		spin_lock(&base->lock);
+		timer_set_base(timer, base);
 	}
 
 	timer->expires = expires;
@@ -1039,9 +1037,11 @@ EXPORT_SYMBOL(try_to_del_timer_sync);
  */
 int del_timer_sync(struct timer_list *timer)
 {
-#ifdef CONFIG_LOCKDEP
+	struct tvec_base *base;
 	unsigned long flags;
 
+#ifdef CONFIG_LOCKDEP
+
 	/*
 	 * If lockdep gives a backtrace here, please reference
 	 * the synchronization rules above.
@@ -1051,6 +1051,12 @@ int del_timer_sync(struct timer_list *timer)
 	lock_map_release(&timer->lockdep_map);
 	local_irq_restore(flags);
 #endif
+
+	/* Timer is scheduled for deletion, don't let it re-arm itself */
+	base = lock_timer_base(timer, &flags);
+	timer->sched_del = 1;
+	spin_unlock_irqrestore(&base->lock, flags);
+
 	/*
 	 * don't use it in hardirq context, because it
 	 * could lead to deadlock.
@@ -1058,8 +1064,10 @@ int del_timer_sync(struct timer_list *timer)
 	WARN_ON(in_irq() && !tbase_get_irqsafe(timer->base));
 	for (;;) {
 		int ret = try_to_del_timer_sync(timer);
-		if (ret >= 0)
+		if (ret >= 0) {
+			timer->sched_del = 0;
 			return ret;
+		}
 		cpu_relax();
 	}
 }
-- 
1.7.12.rc2.18.g61b472e
