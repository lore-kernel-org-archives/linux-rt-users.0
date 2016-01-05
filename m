From: Henrik Austad <henrik@austad.us>
Subject: [PATCH] sched: migrate_disable() and del_timer_sync() issues with !CONFIG_SMP
Date: Tue,  5 Jan 2016 01:40:50 +0100
Message-ID: <1451954450-29298-1-git-send-email-henrik@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: uriahheep@gmail.com, Henrik Austad <henrik@austad.us>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35189 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbcAEAlB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Jan 2016 19:41:01 -0500
Received: by mail-lb0-f193.google.com with SMTP id tz10so17463064lbb.2
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Jan 2016 16:41:00 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Commit b09caeac92182 ("Intrduce migrate_disable() + cpu_light()") added
migrate_disable inside a CONFIG_SMP && CONFIG_PREEMPT_RT_FULL
guard. However, this was already inside a CONFIG_SMP guard, so the empt=
y
prototype was not defined when CONFIG_SMP was unset resulting in a

kernel/sched/core.c: In function =E2=80=98__schedule=E2=80=99:
kernel/sched/core.c:3400:2: error: implicit declaration of function =E2=
=80=98update_migrate_disable=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
  update_migrate_disable(prev);
  ^

This change simply moves the defines and prototypes out from the outer
CONFIG_SMP guard and places them closer to the relevant code.

Commit 34fcdf1673461 ("timers: Prepare for full preemption") wrapped
del_timer_sync in _either_ CONFIG_SMP -or- CONFIG_PREEMPT_RT_FULL, but
failed to do the same in timer.c where it is only wrapped in
CONFIG_PREEMPT_RT_FULL.

This leads to errors of the type:

/data/work/linux/kernel/workqueue.c:3212: undefined reference to `del_t=
imer_sync'
/data/work/linux/kernel/workqueue.c:3213: undefined reference to `del_t=
imer_sync'
kernel/built-in.o: In function `flush_delayed_work':
/data/work/linux/kernel/workqueue.c:2896: undefined reference to `del_t=
imer_sync'
kernel/built-in.o: In function `maybe_create_worker':
/data/work/linux/kernel/workqueue.c:1914: undefined reference to `del_t=
imer_sync'
kernel/built-in.o:/data/work/linux/kernel/relay.c:362: more undefined r=
eferences to `del_timer_sync' follow
Makefile:929: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

This change adds set the dependency to _both_, as the old guard was for
CONFIG_SMP, so we should not loose that.

The kernel compiles, I have -not- booted it.

Reported-by: uriahheep@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Henrik Austad <henrik@austad.us>
---
 include/linux/timer.h |  2 +-
 kernel/sched/core.c   | 16 +++++++---------
 kernel/time/timer.c   |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 299d2b78591f..79889be97b3b 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -225,7 +225,7 @@ extern void add_timer(struct timer_list *timer);
=20
 extern int try_to_del_timer_sync(struct timer_list *timer);
=20
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_FULL)
   extern int del_timer_sync(struct timer_list *timer);
 #else
 # define del_timer_sync(t)		del_timer(t)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8d9f6a657d4e..c5bb630868a4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1209,15 +1209,6 @@ void set_cpus_allowed_common(struct task_struct =
*p, const struct cpumask *new_ma
 	p->nr_cpus_allowed =3D cpumask_weight(new_mask);
 }
=20
-#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
-#define MIGRATE_DISABLE_SET_AFFIN	(1<<30) /* Can't make a negative */
-#define migrate_disabled_updated(p)	((p)->migrate_disable & MIGRATE_DI=
SABLE_SET_AFFIN)
-#define migrate_disable_count(p)	((p)->migrate_disable & ~MIGRATE_DISA=
BLE_SET_AFFIN)
-#else
-static inline void update_migrate_disable(struct task_struct *p) { }
-#define migrate_disabled_updated(p)		0
-#endif
-
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *=
new_mask)
 {
 	struct rq *rq =3D task_rq(p);
@@ -3161,6 +3152,9 @@ static inline void schedule_debug(struct task_str=
uct *prev)
 }
=20
 #if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
+#define MIGRATE_DISABLE_SET_AFFIN	(1<<30) /* Can't make a negative */
+#define migrate_disabled_updated(p)	((p)->migrate_disable & MIGRATE_DI=
SABLE_SET_AFFIN)
+#define migrate_disable_count(p)	((p)->migrate_disable & ~MIGRATE_DISA=
BLE_SET_AFFIN)
=20
 static inline void update_migrate_disable(struct task_struct *p)
 {
@@ -3280,6 +3274,10 @@ void migrate_enable(void)
 	preempt_lazy_enable();
 }
 EXPORT_SYMBOL(migrate_enable);
+
+#else /* #if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP) */
+static inline void update_migrate_disable(struct task_struct *p) { }
+#define migrate_disabled_updated(p)		0
 #endif
=20
 /*
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index c3314fc41316..be53b78fb0f1 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1034,7 +1034,7 @@ void add_timer_on(struct timer_list *timer, int c=
pu)
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
=20
-#ifdef CONFIG_PREEMPT_RT_FULL
+#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
 /*
  * Wait for a running timer
  */
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
