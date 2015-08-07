From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Fri, 7 Aug 2015 12:57:38 +0200
Message-ID: <20150807105738.GF16853@twins.programming.kicks-ass.net>
References: <20150114171251.882318257@redhat.com>
 <20150114171459.593877145@redhat.com>
 <20150116114846.4e7b718d@gandalf.local.home>
 <20150119144100.GA10794@amt.cnet>
 <20150120054653.GA6473@iris.ozlabs.ibm.com>
 <20150120131613.009903a0@gandalf.local.home>
 <20150121150716.GD11596@twins.programming.kicks-ass.net>
 <20150217174419.GY26177@linutronix.de>
 <20150218140320.GY5029@twins.programming.kicks-ass.net>
 <20150225210250.GA25858@linutronix.de>
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150225210250.GA25858@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Feb 25, 2015 at 10:02:50PM +0100, Sebastian Andrzej Siewior wro=
te:

> >+static inline int swait_active(struct swait_queue_head *q)
> >+{
> >+	return !list_empty(&q->task_list);
>=20
> In RT there was a smp_mb() which you dropped and I assume you had
> reasons for it.

Yeah, RT didn't have a reason for the smp_mb() -- any barrier without a
comment is a bug :-)

Also waitqueue_active(), its counterpart, does not have a barrier there
either.

Nor did I see any reason for that mb to be there.

> I assumed that one can perform list_empty_careful()
> without a lock if the items were removed with list_del_init(). But si=
nce
> nothing in -RT blow up so far I guess this here is legal, too :)

Nobody will come and arrest us for software bugs -- yet ;-)

> >+/*
> >+ * The thing about the wake_up_state() return value; I think we can=
 ignore it.
> >+ *
> >+ * If for some reason it would return 0, that means the previously =
waiting
> >+ * task is already running, so it will observe condition true (or h=
as already).
> >+ */
> >+void swake_up_locked(struct swait_queue_head *q)
> >+{
> >+	struct swait_queue *curr;
> >+
> >+	list_for_each_entry(curr, &q->task_list, task_list) {
> >+		wake_up_process(curr->task);
>=20
> okay. So since we limit everything to TASK_NORMAL which has to sleep
> while on the list there is no need to check if we actually woken up
> someone.

Partly that, also that I don't see how that return value is meaningful
in the first place.

If it were to return false, the task was/is already running and it will
observe whatever condition we just satisfied to allow waking things up.

So either way around, we'll get (at least) 1 task running.

> >+		list_del_init(&curr->task_list);
> >+		break;
> >+	}
> >+}
> >+EXPORT_SYMBOL(swake_up_locked);



> >+void swake_up(struct swait_queue_head *q)
> >+{
> >+	unsigned long flags;
> >+
> >+	if (!swait_active(q))
> >+		return;
> >+
> >+	raw_spin_lock_irqsave(&q->lock, flags);
> >+	__swake_up_locked(q);
>=20
> I thing this should have been swake_up_locked() instead since
> __swake_up_locked() isn't part of this patch.
>=20
> Just a nitpick: later there is __prepare_to_swait() and __finish_swai=
t()
> which have the __ prefix instead a _locked suffix. Not sure what is
> better for a better for a public API but maybe one way would be good.

Yeah, I suppose that's true ;-)

> >+	raw_spin_unlock_irqrestore(&q->lock, flags);
> >+}
> >+EXPORT_SYMBOL(swake_up);
> >+
> >+/*
> >+ * Does not allow usage from IRQ disabled, since we must be able to
> >+ * release IRQs to guarantee bounded hold time.
> >+ */
> >+void swake_up_all(struct swait_queue_head *q)
> >+{
> >+	struct swait_queue *curr, *next;
> >+	LIST_HEAD(tmp);
>=20
> WARN_ON(irqs_disabled()) ?

Lockdep should already catch that by virtue of using unconditional _irq
spinlock primitives.

> >+	if (!swait_active(q))
> >+		return;
> >+
> >+	raw_spin_lock_irq(&q->lock);
> >+	list_splice_init(&q->task_list, &tmp);
> >+	while (!list_empty(&tmp)) {
> >+		curr =3D list_first_entry(&tmp, typeof(curr), task_list);
> >+
> >+		wake_up_state(curr->task, state);
> >+		list_del_init(&curr->task_list);
>=20
> So because the task may timeout and remove itself from the list at
> anytime you need to hold the lock during wakeup and the removal from =
the
> list

Indeed.

> >+
> >+		if (list_empty(&tmp))
> >+			break;
> >+
> >+		raw_spin_unlock_irq(&q->lock);
>=20
> and you drop the lock after each iteration in case there is an IRQ=20
> pending or the task, that has been just woken up, has a higher priori=
ty
> than the current task and needs to get on the CPU.

> Not sure if this case matters:
> - _this_ task (wake_all) prio 120
> - first task in queue prio 10, RR
> - second task in queue prio 9, RR

Why complicate things? Better to not assume anything and just do the
simple correct thing.

> the *old* behavior would put the second task before the first task on
> CPU. The *new* behaviour puts the first task on the CPU after droppin=
g
> the lock. The second task (that has a higher priority but nobody know=
s)
> has to wait until the first one is done (and anything else that might
> been woken up in the meantime with a higher prio than 120).

Irrelevant, we _must_ drop the lock in order to maintain bounded
behaviour.

> >+		raw_spin_lock_irq(&q->lock);
> >+	}
> >+	raw_spin_unlock_irq(&q->lock);
> >+}
> >+EXPORT_SYMBOL(swake_up_all);

> >+void __finish_swait(struct swait_queue_head *q, struct swait_queue =
*wait)
> this one has no users the __ suggests that it is locked edition. Mayb=
e
> it is for the completions=E2=80=A6

Yeah, who knows, I certainly do not anymore ;-)
