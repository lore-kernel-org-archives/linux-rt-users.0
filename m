From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Wed, 25 Feb 2015 22:02:50 +0100
Message-ID: <20150225210250.GA25858@linutronix.de>
References: <20150114171251.882318257@redhat.com>
 <20150114171459.593877145@redhat.com>
 <20150116114846.4e7b718d@gandalf.local.home>
 <20150119144100.GA10794@amt.cnet>
 <20150120054653.GA6473@iris.ozlabs.ibm.com>
 <20150120131613.009903a0@gandalf.local.home>
 <20150121150716.GD11596@twins.programming.kicks-ass.net>
 <20150217174419.GY26177@linutronix.de>
 <20150218140320.GY5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Paul Mackerras <paulus@samba.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150218140320.GY5029@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Peter Zijlstra | 2015-02-18 15:03:20 [+0100]:

>On Tue, Feb 17, 2015 at 06:44:19PM +0100, Sebastian Andrzej Siewior wr=
ote:
>> * Peter Zijlstra | 2015-01-21 16:07:16 [+0100]:
>>=20
>> >On Tue, Jan 20, 2015 at 01:16:13PM -0500, Steven Rostedt wrote:
>> >> I'm actually wondering if we should just nuke the _interruptible(=
)
>> >> version of swait. As it should only be all interruptible or all n=
ot
>> >> interruptible, that the swait_wake() should just do the wake up
>> >> regardless. In which case, swait_wake() is good enough. No need t=
o have
>> >> different versions where people may think do something special.
>> >>=20
>> >> Peter?
>> >
>> >Yeah, I think the lastest thing I have sitting here on my disk only=
 has
>> >the swake_up() which does TASK_NORMAL, no choice there.
>>=20
>> what is the swait status in terms of mainline? This sounds like it
>> beeing worked on.
>> I could take the series but then I would drop it again if the mainli=
ne
>> implementation changes=E2=80=A6
>
>Well, 'worked' on might be putting too much on it, its one of the many
>many 'spare' time things that never get attention unless people bug me
>;-)
>
>The below is my current patch, I've not actually tried it yet, I (thin=
k
>I) had one patch doing some conversions but I'm having trouble locatin=
g
>it.
>
>Mostly-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>---
> include/linux/swait.h |  172 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
> kernel/sched/swait.c  |  122 +++++++++++++++++++++++++++++++++++
> 2 files changed, 294 insertions(+)
>
>--- /dev/null
>+++ b/include/linux/swait.h
>@@ -0,0 +1,172 @@
>+#ifndef _LINUX_SWAIT_H
>+#define _LINUX_SWAIT_H
>+
>+#include <linux/list.h>
>+#include <linux/stddef.h>
>+#include <linux/spinlock.h>
>+#include <asm/current.h>
>+
>+/*
>+ * Simple wait queues
>+ *
>+ * While these are very similar to the other/complex wait queues (wai=
t.h) the
>+ * most important difference is that the simple waitqueue allows for
>+ * deterministic behaviour -- IOW it has strictly bounded IRQ and loc=
k hold
>+ * times.
>+ *
>+ * In order to make this so, we had to drop a fair number of features=
 of the
>+ * other waitqueue code; notably:
>+ *
>+ *  - mixing INTERRUPTIBLE and UNINTERRUPTIBLE sleeps on the same wai=
tqueue;
>+ *    all wakeups are TASK_NORMAL in order to avoid O(n) lookups for =
the right
>+ *    sleeper state.
>+ *
>+ *  - the exclusive mode; because this requires preserving the list o=
rder
>+ *    and this is hard.
>+ *
>+ *  - custom wake functions; because you cannot give any guarantees a=
bout
>+ *    random code.
>+ *
>+ * As a side effect of this; the data structures are slimmer.
>+ *
>+ * One would recommend using this wait queue where possible.
>+ */
>+
>+struct task_struct;
>+
>+struct swait_queue_head {
>+	raw_spinlock_t		lock;
>+	struct list_head	task_list;
>+};
>+
>+struct swait_queue {
>+	struct task_struct	*task;
>+	struct list_head	task_list;

I would prefer something different than task_list here since this is an
item. Scrolling down you tried to use node once so maybe that would be
good here :)

>+};
>+
>+#define __SWAITQUEUE_INITIALIZER(name) {				\
>+	.task		=3D current,					\
>+	.task_list	=3D LIST_HEAD_INIT((name).task_list),		\
>+}
>+
>+#define DECLARE_SWAITQUEUE(name)					\
>+	struct swait_queue name =3D __SWAITQUEUE_INITIALIZER(name)
>+
>+#define __SWAIT_QUEUE_HEAD_INITIALIZER(name) {				\
>+	.lock		=3D __RAW_SPIN_LOCK_UNLOCKED(name.lock),		\
>+	.task_list	=3D LIST_HEAD_INIT((name).task_list),		\
>+}
>+
>+#define DECLARE_SWAIT_QUEUE_HEAD(name)					\
>+	struct swait_queue_head name =3D __SWAIT_QUEUE_HEAD_INITIALIZER(name=
)
>+
>+extern void __init_swait_queue_head(struct swait_queue_head *q, const=
 char *name,
>+				    struct lock_class_key *key);
>+
>+#define init_swait_queue_head(q)				\
>+	do {							\
>+		static struct lock_class_key __key;		\
>+		__init_swait_queue_head((q), #q, &__key);	\
>+	} while (0)
>+
>+#ifdef CONFIG_LOCKDEP
>+# define __SWAIT_QUEUE_HEAD_INIT_ONSTACK(name)			\
>+	({ init_swait_queue_head(&name); name; })
>+# define DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(name)			\
>+	struct swait_queue_head name =3D __SWAIT_QUEUE_HEAD_INIT_ONSTACK(nam=
e)
>+#else
>+# define DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(name)			\
>+	DECLARE_SWAIT_QUEUE_HEAD(name)
>+#endif
>+
>+static inline int swait_active(struct swait_queue_head *q)
>+{
>+	return !list_empty(&q->task_list);

In RT there was a smp_mb() which you dropped and I assume you had
reasons for it. I assumed that one can perform list_empty_careful()
without a lock if the items were removed with list_del_init(). But sinc=
e
nothing in -RT blow up so far I guess this here is legal, too :)

>+}
>+
>+extern void swake_up(struct swait_queue_head *q);
>+extern void swake_up_all(struct swait_queue_head *q);
>+extern void swake_up_locked(struct swait_queue_head *q);
>+
>+extern void __prepare_to_swait(struct swait_queue_head *q, struct swa=
it_queue *wait);
>+extern void prepare_to_swait(struct swait_queue_head *q, struct swait=
_queue *wait, int state);
>+extern long prepare_to_swait_event(struct swait_queue_head *q, struct=
 swait_queue *wait, int state);
>+
>+extern void __finish_swait(struct swait_queue_head *q, struct swait_q=
ueue *wait);
>+extern void finish_swait(struct swait_queue_head *q, struct swait_que=
ue *wait);
>+
>+/* as per ___wait_event() but for swait, therefore "exclusive =3D=3D =
0" */
>+#define ___swait_event(wq, condition, state, ret, cmd)			\
>+({									\
>+	struct swait_queue __wait;					\
>+	long __ret =3D ret;						\
>+									\
>+	INIT_LIST_HEAD(&__wait.task_list);				\
>+	for (;;) {							\
>+		long __int =3D prepare_to_swait_event(&wq, &__wait, state);\
>+									\
>+		if (condition)						\
>+			break;						\
>+									\
>+		if (___wait_is_interruptible(state) && __int) {		\
>+			__ret =3D __int;					\
>+			break;						\
>+		}							\
>+									\
>+		cmd;							\
>+	}								\
>+	finish_swait(&wq, &__wait);					\
>+	__ret;								\
>+})
>+
>+#define __swait_event(wq, condition)					\
>+	(void)___swait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0,	\
>+			    schedule())
>+
>+#define swait_event(wq, condition)					\
>+do {									\
>+	if (condition)							\
>+		break;							\
>+	__swait_event(wq, condition);					\
>+} while (0)
>+
>+#define __swait_event_timeout(wq, condition, timeout)			\
>+	___swait_event(wq, ___wait_cond_timeout(condition),		\
>+		      TASK_UNINTERRUPTIBLE, timeout,			\
>+		      __ret =3D schedule_timeout(__ret))
>+
>+#define swait_event_timeout(wq, condition, timeout)			\
>+({									\
>+	long __ret =3D timeout;						\
>+	if (!___wait_cond_timeout(condition))				\
>+		__ret =3D __swait_event_timeout(wq, condition, timeout);	\
>+	__ret;								\
>+})
>+
>+#define __swait_event_interruptible(wq, condition)			\
>+	___swait_event(wq, condition, TASK_INTERRUPTIBLE, 0,		\
>+		      schedule())
>+
>+#define swait_event_interruptible(wq, condition)			\
>+({									\
>+	int __ret =3D 0;							\
>+	if (!(condition))						\
>+		__ret =3D __swait_event_interruptible(wq, condition);	\
>+	__ret;								\
>+})
>+
>+#define __swait_event_interruptible_timeout(wq, condition, timeout)	\
>+	___swait_event(wq, ___wait_cond_timeout(condition),		\
>+		      TASK_INTERRUPTIBLE, timeout,			\
>+		      __ret =3D schedule_timeout(__ret))
>+
>+#define swait_event_interruptible_timeout(wq, condition, timeout)	\
>+({									\
>+	long __ret =3D timeout;						\
>+	if (!___wait_cond_timeout(condition))				\
>+		__ret =3D __swait_event_interruptible_timeout(wq,		\
>+						condition, timeout);	\
>+	__ret;								\
>+})
>+
>+#endif /* _LINUX_SWAIT_H */
>--- /dev/null
>+++ b/kernel/sched/swait.c
>@@ -0,0 +1,122 @@
>+
>+#include <linux/swait.h>
>+
>+void __init_swait_queue_head(struct swait_queue_head *q, const char *=
name,
>+			     struct lock_class_key *key)
>+{
>+	raw_spin_lock_init(&q->lock);
>+	lockdep_set_class_and_name(&q->lock, key, name);
>+	INIT_LIST_HEAD(&q->task_list);
>+}
>+EXPORT_SYMBOL(__init_swait_queue_head);
>+
>+/*
>+ * The thing about the wake_up_state() return value; I think we can i=
gnore it.
>+ *
>+ * If for some reason it would return 0, that means the previously wa=
iting
>+ * task is already running, so it will observe condition true (or has=
 already).
>+ */
>+void swake_up_locked(struct swait_queue_head *q)
>+{
>+	struct swait_queue *curr;
>+
>+	list_for_each_entry(curr, &q->task_list, task_list) {
>+		wake_up_process(curr->task);

okay. So since we limit everything to TASK_NORMAL which has to sleep
while on the list there is no need to check if we actually woken up
someone.

>+		list_del_init(&curr->task_list);
>+		break;
>+	}
>+}
>+EXPORT_SYMBOL(swake_up_locked);
>+
>+void swake_up(struct swait_queue_head *q)
>+{
>+	unsigned long flags;
>+
>+	if (!swait_active(q))
>+		return;
>+
>+	raw_spin_lock_irqsave(&q->lock, flags);
>+	__swake_up_locked(q);

I thing this should have been swake_up_locked() instead since
__swake_up_locked() isn't part of this patch.

Just a nitpick: later there is __prepare_to_swait() and __finish_swait(=
)
which have the __ prefix instead a _locked suffix. Not sure what is
better for a better for a public API but maybe one way would be good.

>+	raw_spin_unlock_irqrestore(&q->lock, flags);
>+}
>+EXPORT_SYMBOL(swake_up);
>+
>+/*
>+ * Does not allow usage from IRQ disabled, since we must be able to
>+ * release IRQs to guarantee bounded hold time.
>+ */
>+void swake_up_all(struct swait_queue_head *q)
>+{
>+	struct swait_queue *curr, *next;
>+	LIST_HEAD(tmp);

WARN_ON(irqs_disabled()) ?

>+	if (!swait_active(q))
>+		return;
>+
>+	raw_spin_lock_irq(&q->lock);
>+	list_splice_init(&q->task_list, &tmp);
>+	while (!list_empty(&tmp)) {
>+		curr =3D list_first_entry(&tmp, typeof(curr), task_list);
>+
>+		wake_up_state(curr->task, state);
>+		list_del_init(&curr->task_list);

So because the task may timeout and remove itself from the list at
anytime you need to hold the lock during wakeup and the removal from th=
e
list

>+
>+		if (list_empty(&tmp))
>+			break;
>+
>+		raw_spin_unlock_irq(&q->lock);

and you drop the lock after each iteration in case there is an IRQ=20
pending or the task, that has been just woken up, has a higher priority
than the current task and needs to get on the CPU.
Not sure if this case matters:
- _this_ task (wake_all) prio 120
- first task in queue prio 10, RR
- second task in queue prio 9, RR

the *old* behavior would put the second task before the first task on
CPU. The *new* behaviour puts the first task on the CPU after dropping
the lock. The second task (that has a higher priority but nobody knows)
has to wait until the first one is done (and anything else that might
been woken up in the meantime with a higher prio than 120).

>+		raw_spin_lock_irq(&q->lock);
>+	}
>+	raw_spin_unlock_irq(&q->lock);
>+}
>+EXPORT_SYMBOL(swake_up_all);
>+
>+void __prepare_to_swait(struct swait_queue_head *q, struct swait_queu=
e *wait)
>+{
>+	wait->task =3D current;
>+	if (list_empty(&wait->node))
>+		list_add(&wait->task_list, &q->task_list);
>+}
>+
>+void prepare_to_swait(struct swait_queue_head *q, struct swait_queue =
*wait, int state)
>+{
>+	unsigned long flags;
>+
>+	raw_spin_lock_irqsave(&q->lock, flags);
>+	__prepare_to_swait(q, wait);
>+	set_current_state(state);
>+	raw_spin_unlock_irqrestore(&q->lock, flags);
>+}
>+EXPORT_SYMBOL(prepare_to_swait);
>+
>+long prepare_to_swait_event(struct swait_queue_head *q, struct swait_=
queue *wait, int state)
>+{
>+	if (signal_pending_state(state, current))
>+		return -ERESTARTSYS;
>+
>+	prepare_to_swait(q, wait, state);
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL(prepare_to_swait_event);
>+
>+void __finish_swait(struct swait_queue_head *q, struct swait_queue *w=
ait)
this one has no users the __ suggests that it is locked edition. Maybe
it is for the completions=E2=80=A6

>+{
>+	__set_current_state(TASK_RUNNING);
>+	if (!list_empty(&wait->task_list))
>+		list_del_init(&wait->task_list);
>+}
>+
>+void finish_swait(struct swait_queue_head *q, struct swait_queue *wai=
t)
>+{
>+	unsigned long flags;
>+
>+	__set_current_state(TASK_RUNNING);
>+
>+	if (!list_empty_careful(&wait->task_list)) {
>+		raw_spin_lock_irqsave(&q->lock, flags);
>+		list_del_init(&wait->task_list);
>+		raw_spin_unlock_irqrestore(&q->lock, flags);
>+	}
>+}
>+EXPORT_SYMBOL(finish_swait);

Sebastian
