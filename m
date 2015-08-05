From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 1/3] KVM: use simple waitqueue for vcpu->wq
Date: Wed,  5 Aug 2015 15:30:46 +0200
Message-ID: <1438781448-10760-2-git-send-email-daniel.wagner@bmw-carit.de>
References: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paul.gortmaker@windriver.com, peterz@infradead.org,
	bigeasy@linutronix.de, tglx@linutronix.de,
	paulmck@linux.vnet.ibm.com, rostedt@goodmis.org
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

=46rom: Peter Zijlstra <peterz@infradead.org>

On Tue, Feb 17, 2015 at 06:44:19PM +0100, Sebastian Andrzej Siewior wro=
te:
> * Peter Zijlstra | 2015-01-21 16:07:16 [+0100]:
>
> >On Tue, Jan 20, 2015 at 01:16:13PM -0500, Steven Rostedt wrote:
> >> I'm actually wondering if we should just nuke the _interruptible()
> >> version of swait. As it should only be all interruptible or all no=
t
> >> interruptible, that the swait_wake() should just do the wake up
> >> regardless. In which case, swait_wake() is good enough. No need to=
 have
> >> different versions where people may think do something special.
> >>
> >> Peter?
> >
> >Yeah, I think the lastest thing I have sitting here on my disk only =
has
> >the swake_up() which does TASK_NORMAL, no choice there.
>
> what is the swait status in terms of mainline? This sounds like it
> beeing worked on.
> I could take the series but then I would drop it again if the mainlin=
e
> implementation changes=E2=80=A6

Well, 'worked' on might be putting too much on it, its one of the many
many 'spare' time things that never get attention unless people bug me
;-)

The below is my current patch, I've not actually tried it yet, I (think
I) had one patch doing some conversions but I'm having trouble locating
it.

Mostly-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[wagi: fixed compile issues]
---
 include/linux/swait.h | 172 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 kernel/sched/Makefile |   2 +-
 kernel/sched/swait.c  | 122 +++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/swait.h
 create mode 100644 kernel/sched/swait.c

diff --git a/include/linux/swait.h b/include/linux/swait.h
new file mode 100644
index 0000000..c1f9c62
--- /dev/null
+++ b/include/linux/swait.h
@@ -0,0 +1,172 @@
+#ifndef _LINUX_SWAIT_H
+#define _LINUX_SWAIT_H
+
+#include <linux/list.h>
+#include <linux/stddef.h>
+#include <linux/spinlock.h>
+#include <asm/current.h>
+
+/*
+ * Simple wait queues
+ *
+ * While these are very similar to the other/complex wait queues (wait=
=2Eh) the
+ * most important difference is that the simple waitqueue allows for
+ * deterministic behaviour -- IOW it has strictly bounded IRQ and lock=
 hold
+ * times.
+ *
+ * In order to make this so, we had to drop a fair number of features =
of the
+ * other waitqueue code; notably:
+ *
+ *  - mixing INTERRUPTIBLE and UNINTERRUPTIBLE sleeps on the same wait=
queue;
+ *    all wakeups are TASK_NORMAL in order to avoid O(n) lookups for t=
he right
+ *    sleeper state.
+ *
+ *  - the exclusive mode; because this requires preserving the list or=
der
+ *    and this is hard.
+ *
+ *  - custom wake functions; because you cannot give any guarantees ab=
out
+ *    random code.
+ *
+ * As a side effect of this; the data structures are slimmer.
+ *
+ * One would recommend using this wait queue where possible.
+ */
+
+struct task_struct;
+
+struct swait_queue_head {
+	raw_spinlock_t		lock;
+	struct list_head	task_list;
+};
+
+struct swait_queue {
+	struct task_struct	*task;
+	struct list_head	task_list;
+};
+
+#define __SWAITQUEUE_INITIALIZER(name) {				\
+	.task		=3D current,					\
+	.task_list	=3D LIST_HEAD_INIT((name).task_list),		\
+}
+
+#define DECLARE_SWAITQUEUE(name)					\
+	struct swait_queue name =3D __SWAITQUEUE_INITIALIZER(name)
+
+#define __SWAIT_QUEUE_HEAD_INITIALIZER(name) {				\
+	.lock		=3D __RAW_SPIN_LOCK_UNLOCKED(name.lock),		\
+	.task_list	=3D LIST_HEAD_INIT((name).task_list),		\
+}
+
+#define DECLARE_SWAIT_QUEUE_HEAD(name)					\
+	struct swait_queue_head name =3D __SWAIT_QUEUE_HEAD_INITIALIZER(name)
+
+extern void __init_swait_queue_head(struct swait_queue_head *q, const =
char *name,
+				    struct lock_class_key *key);
+
+#define init_swait_queue_head(q)				\
+	do {							\
+		static struct lock_class_key __key;		\
+		__init_swait_queue_head((q), #q, &__key);	\
+	} while (0)
+
+#ifdef CONFIG_LOCKDEP
+# define __SWAIT_QUEUE_HEAD_INIT_ONSTACK(name)			\
+	({ init_swait_queue_head(&name); name; })
+# define DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(name)			\
+	struct swait_queue_head name =3D __SWAIT_QUEUE_HEAD_INIT_ONSTACK(name=
)
+#else
+# define DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(name)			\
+	DECLARE_SWAIT_QUEUE_HEAD(name)
+#endif
+
+static inline int swait_active(struct swait_queue_head *q)
+{
+	return !list_empty(&q->task_list);
+}
+
+extern void swake_up(struct swait_queue_head *q);
+extern void swake_up_all(struct swait_queue_head *q);
+extern void swake_up_locked(struct swait_queue_head *q);
+
+extern void __prepare_to_swait(struct swait_queue_head *q, struct swai=
t_queue *wait);
+extern void prepare_to_swait(struct swait_queue_head *q, struct swait_=
queue *wait, int state);
+extern long prepare_to_swait_event(struct swait_queue_head *q, struct =
swait_queue *wait, int state);
+
+extern void __finish_swait(struct swait_queue_head *q, struct swait_qu=
eue *wait);
+extern void finish_swait(struct swait_queue_head *q, struct swait_queu=
e *wait);
+
+/* as per ___wait_event() but for swait, therefore "exclusive =3D=3D 0=
" */
+#define ___swait_event(wq, condition, state, ret, cmd)			\
+({									\
+	struct swait_queue __wait;					\
+	long __ret =3D ret;						\
+									\
+	INIT_LIST_HEAD(&__wait.task_list);				\
+	for (;;) {							\
+		long __int =3D prepare_to_swait_event(&wq, &__wait, state);\
+									\
+		if (condition)						\
+			break;						\
+									\
+		if (___wait_is_interruptible(state) && __int) {		\
+			__ret =3D __int;					\
+			break;						\
+		}							\
+									\
+		cmd;							\
+	}								\
+	finish_swait(&wq, &__wait);					\
+	__ret;								\
+})
+
+#define __swait_event(wq, condition)					\
+	(void)___swait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0,	\
+			    schedule())
+
+#define swait_event(wq, condition)					\
+do {									\
+	if (condition)							\
+		break;							\
+	__swait_event(wq, condition);					\
+} while (0)
+
+#define __swait_event_timeout(wq, condition, timeout)			\
+	___swait_event(wq, ___wait_cond_timeout(condition),		\
+		      TASK_UNINTERRUPTIBLE, timeout,			\
+		      __ret =3D schedule_timeout(__ret))
+
+#define swait_event_timeout(wq, condition, timeout)			\
+({									\
+	long __ret =3D timeout;						\
+	if (!___wait_cond_timeout(condition))				\
+		__ret =3D __swait_event_timeout(wq, condition, timeout);	\
+	__ret;								\
+})
+
+#define __swait_event_interruptible(wq, condition)			\
+	___swait_event(wq, condition, TASK_INTERRUPTIBLE, 0,		\
+		      schedule())
+
+#define swait_event_interruptible(wq, condition)			\
+({									\
+	int __ret =3D 0;							\
+	if (!(condition))						\
+		__ret =3D __swait_event_interruptible(wq, condition);	\
+	__ret;								\
+})
+
+#define __swait_event_interruptible_timeout(wq, condition, timeout)	\
+	___swait_event(wq, ___wait_cond_timeout(condition),		\
+		      TASK_INTERRUPTIBLE, timeout,			\
+		      __ret =3D schedule_timeout(__ret))
+
+#define swait_event_interruptible_timeout(wq, condition, timeout)	\
+({									\
+	long __ret =3D timeout;						\
+	if (!___wait_cond_timeout(condition))				\
+		__ret =3D __swait_event_interruptible_timeout(wq,		\
+						condition, timeout);	\
+	__ret;								\
+})
+
+#endif /* _LINUX_SWAIT_H */
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 6768797..7d4cba2 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -13,7 +13,7 @@ endif
=20
 obj-y +=3D core.o loadavg.o clock.o cputime.o
 obj-y +=3D idle_task.o fair.o rt.o deadline.o stop_task.o
-obj-y +=3D wait.o completion.o idle.o
+obj-y +=3D wait.o swait.o completion.o idle.o
 obj-$(CONFIG_SMP) +=3D cpupri.o cpudeadline.o
 obj-$(CONFIG_SCHED_AUTOGROUP) +=3D auto_group.o
 obj-$(CONFIG_SCHEDSTATS) +=3D stats.o
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
new file mode 100644
index 0000000..533710e
--- /dev/null
+++ b/kernel/sched/swait.c
@@ -0,0 +1,122 @@
+#include <linux/sched.h>
+#include <linux/swait.h>
+
+void __init_swait_queue_head(struct swait_queue_head *q, const char *n=
ame,
+			     struct lock_class_key *key)
+{
+	raw_spin_lock_init(&q->lock);
+	lockdep_set_class_and_name(&q->lock, key, name);
+	INIT_LIST_HEAD(&q->task_list);
+}
+EXPORT_SYMBOL(__init_swait_queue_head);
+
+/*
+ * The thing about the wake_up_state() return value; I think we can ig=
nore it.
+ *
+ * If for some reason it would return 0, that means the previously wai=
ting
+ * task is already running, so it will observe condition true (or has =
already).
+ */
+void swake_up_locked(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+
+	list_for_each_entry(curr, &q->task_list, task_list) {
+		wake_up_process(curr->task);
+		list_del_init(&curr->task_list);
+		break;
+	}
+}
+EXPORT_SYMBOL(swake_up_locked);
+
+void swake_up(struct swait_queue_head *q)
+{
+	unsigned long flags;
+
+	if (!swait_active(q))
+		return;
+
+	raw_spin_lock_irqsave(&q->lock, flags);
+	swake_up_locked(q);
+	raw_spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(swake_up);
+
+/*
+ * Does not allow usage from IRQ disabled, since we must be able to
+ * release IRQs to guarantee bounded hold time.
+ */
+void swake_up_all(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+	LIST_HEAD(tmp);
+
+	if (!swait_active(q))
+		return;
+
+	raw_spin_lock_irq(&q->lock);
+	list_splice_init(&q->task_list, &tmp);
+	while (!list_empty(&tmp)) {
+		curr =3D list_first_entry(&tmp, typeof(*curr), task_list);
+
+		wake_up_state(curr->task, TASK_NORMAL);
+		list_del_init(&curr->task_list);
+
+		if (list_empty(&tmp))
+			break;
+
+		raw_spin_unlock_irq(&q->lock);
+		raw_spin_lock_irq(&q->lock);
+	}
+	raw_spin_unlock_irq(&q->lock);
+}
+EXPORT_SYMBOL(swake_up_all);
+
+void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue=
 *wait)
+{
+	wait->task =3D current;
+	if (list_empty(&wait->task_list))
+		list_add(&wait->task_list, &q->task_list);
+}
+
+void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *=
wait, int state)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&q->lock, flags);
+	__prepare_to_swait(q, wait);
+	set_current_state(state);
+	raw_spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(prepare_to_swait);
+
+long prepare_to_swait_event(struct swait_queue_head *q, struct swait_q=
ueue *wait, int state)
+{
+	if (signal_pending_state(state, current))
+		return -ERESTARTSYS;
+
+	prepare_to_swait(q, wait, state);
+
+	return 0;
+}
+EXPORT_SYMBOL(prepare_to_swait_event);
+
+void __finish_swait(struct swait_queue_head *q, struct swait_queue *wa=
it)
+{
+	__set_current_state(TASK_RUNNING);
+	if (!list_empty(&wait->task_list))
+		list_del_init(&wait->task_list);
+}
+
+void finish_swait(struct swait_queue_head *q, struct swait_queue *wait=
)
+{
+	unsigned long flags;
+
+	__set_current_state(TASK_RUNNING);
+
+	if (!list_empty_careful(&wait->task_list)) {
+		raw_spin_lock_irqsave(&q->lock, flags);
+		list_del_init(&wait->task_list);
+		raw_spin_unlock_irqrestore(&q->lock, flags);
+	}
+}
+EXPORT_SYMBOL(finish_swait);
--=20
2.4.3
