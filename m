From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] ptrace: fix ptrace vs tasklist_lock race
Date: Sat, 30 Nov 2013 21:07:15 +0100
Message-ID: <20131130200715.GA24080@linutronix.de>
References: <102271374683007@web8f.yandex.ru>
 <20130812164145.GJ23040@linutronix.de>
 <393831376342036@web15d.yandex.ru>
 <20130821172431.GD16913@linutronix.de>
 <96171377181398@web13h.yandex.ru>
 <20130829163300.GC15360@linutronix.de>
 <143271377797197@web5m.yandex.ru>
 <521F92D9.5090701@linutronix.de>
 <18551377802042@web15m.yandex.ru>
 <521F97AC.8080505@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Alexander Fyodorov <halcy@yandex.ru>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37913 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab3K3UHS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 Nov 2013 15:07:18 -0500
Content-Disposition: inline
In-Reply-To: <521F97AC.8080505@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

As explained by Alexander Fyodorov <halcy@yandex.ru>:

|read_lock(&tasklist_lock) in ptrace_stop() is converted to mutex on RT=
 kernel,
|and it can remove __TASK_TRACED from task->state (by moving  it to
|task->saved_state). If parent does wait() on child followed by a sys_p=
trace
|call, the following race can happen:
|
|- child sets __TASK_TRACED in ptrace_stop()
|- parent does wait() which eventually calls wait_task_stopped() and re=
turns
|  child's pid
|- child blocks on read_lock(&tasklist_lock) in ptrace_stop() and moves
|  __TASK_TRACED flag to saved_state
|- parent calls sys_ptrace, which calls ptrace_check_attach() and wait_=
task_inactive()

The patch is based on his initial patch where an additional check is
added in case the __TASK_TRACED moved to ->saved_state. The pi_lock is
taken in case the caller is interrupted between looking into ->state an=
d
->saved_state.

Additionally I also extended the check in task_is_stopped_or_traced()
and consider the two possible states in ptrace_freeze_traced().
In wait_task_inactive() the state is now checked under the pi_lock as
well. I merged Steven's patch in this one
(rfc-sched-rt-fix-wait_task_interactive-to-test-rt_spin_lock-state.patc=
h)
which already checked both places but without the lock.
This seems to pass my tiny testcase=E2=80=A6

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h |   48 +++++++++++++++++++++++++++++++++++++++++=
++++---
 kernel/ptrace.c       |    7 ++++++-
 kernel/sched/core.c   |   24 +++++++++++++++++++++---
 3 files changed, 72 insertions(+), 7 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -165,11 +165,8 @@ extern char ___assert_task_state[1 - 2*!
 				 TASK_UNINTERRUPTIBLE | __TASK_STOPPED | \
 				 __TASK_TRACED)
=20
-#define task_is_traced(task)	((task->state & __TASK_TRACED) !=3D 0)
 #define task_is_stopped(task)	((task->state & __TASK_STOPPED) !=3D 0)
 #define task_is_dead(task)	((task)->exit_state !=3D 0)
-#define task_is_stopped_or_traced(task)	\
-			((task->state & (__TASK_STOPPED | __TASK_TRACED)) !=3D 0)
 #define task_contributes_to_load(task)	\
 				((task->state & TASK_UNINTERRUPTIBLE) !=3D 0 && \
 				 (task->flags & PF_FROZEN) =3D=3D 0)
@@ -2410,6 +2407,51 @@ static inline int need_resched(void)
 	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
 }
=20
+static inline bool __task_is_stopped_or_traced(struct task_struct *tas=
k)
+{
+	if (task->state & (__TASK_STOPPED | __TASK_TRACED))
+		return true;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	if (task->saved_state & (__TASK_STOPPED | __TASK_TRACED))
+		return true;
+#endif
+	return false;
+}
+
+static inline bool task_is_stopped_or_traced(struct task_struct *task)
+{
+	bool traced_stopped;
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	traced_stopped =3D __task_is_stopped_or_traced(task);
+	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+#else
+	traced_stopped =3D __task_is_stopped_or_traced(task);
+#endif
+	return traced_stopped;
+}
+
+static inline bool task_is_traced(struct task_struct *task)
+{
+	bool traced =3D false;
+
+	if (task->state & __TASK_TRACED)
+		return true;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	/* in case the task is sleeping on tasklist_lock */
+	raw_spin_lock_irq(&task->pi_lock);
+	if (task->state & __TASK_TRACED)
+		traced =3D true;
+	else if (task->saved_state & __TASK_TRACED)
+		traced =3D true;
+	raw_spin_unlock_irq(&task->pi_lock);
+#endif
+	return traced;
+}
+
 /*
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -135,7 +135,12 @@ static bool ptrace_freeze_traced(struct
=20
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !__fatal_signal_pending(task)) {
-		task->state =3D __TASK_TRACED;
+		raw_spin_lock_irq(&task->pi_lock);
+		if (task->state & __TASK_TRACED)
+			task->state =3D __TASK_TRACED;
+		else
+			task->saved_state =3D __TASK_TRACED;
+		raw_spin_unlock_irq(&task->pi_lock);
 		ret =3D true;
 	}
 	spin_unlock_irq(&task->sighand->siglock);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1024,6 +1024,20 @@ struct migration_arg {
=20
 static int migration_cpu_stop(void *data);
=20
+static bool check_task_state(struct task_struct *p, long match_state)
+{
+	bool match =3D false;
+
+	raw_spin_lock_irq(&p->pi_lock);
+	if (p->state =3D=3D match_state)
+		match =3D true;
+	else if (p->saved_state =3D=3D match_state)
+		match =3D true;
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	return match;
+}
+
 /*
  * wait_task_inactive - wait for a thread to unschedule.
  *
@@ -1068,8 +1082,11 @@ unsigned long wait_task_inactive(struct
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(p->state !=3D match_state))
+			if (match_state) {
+				if (!unlikely(check_task_state(p, match_state)))
+					return 0;
 				return 0;
+			}
 			cpu_relax();
 		}
=20
@@ -1083,7 +1100,8 @@ unsigned long wait_task_inactive(struct
 		running =3D task_running(rq, p);
 		on_rq =3D p->on_rq;
 		ncsw =3D 0;
-		if (!match_state || p->state =3D=3D match_state)
+		if (!match_state || p->state =3D=3D match_state
+		    || p->saved_state =3D=3D match_state)
 			ncsw =3D p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &flags);
=20
@@ -1579,7 +1597,7 @@ static void try_to_wake_up_local(struct
  */
 int wake_up_process(struct task_struct *p)
 {
-	WARN_ON(task_is_stopped_or_traced(p));
+	WARN_ON(__task_is_stopped_or_traced(p));
 	return try_to_wake_up(p, TASK_NORMAL, 0);
 }
 EXPORT_SYMBOL(wake_up_process);
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
