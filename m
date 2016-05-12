From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH RESEND -rt] mm: perform lru_add_drain_all() remotely
Date: Thu, 12 May 2016 09:51:49 -0400
Message-ID: <20160512095149.2a6f7357@redhat.com>
References: <20160509105037.1555d0e0@redhat.com>
	<20160512084230.GA19035@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, riel@redhat.com,
	tglx@linutronix.de, srostedt@redhat.com, williams@redhat.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59252 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbcELNvv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 May 2016 09:51:51 -0400
In-Reply-To: <20160512084230.GA19035@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 12 May 2016 10:42:30 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Luiz Capitulino | 2016-05-09 10:50:37 [-0400]:
>=20
> >diff --git a/include/linux/locallock.h b/include/linux/locallock.h
> >index 6fe5928..f4cd691 100644
> >--- a/include/linux/locallock.h
> >+++ b/include/linux/locallock.h
> >@@ -104,6 +104,17 @@ static inline void __local_unlock(struct local_=
irq_lock *lv)
> > 		put_local_var(lvar);				\
> > 	} while (0)
> >=20
> >+#define local_lock_other_cpu(lvar, cpu)                         \ =20
>=20
> I would prefer to have local_lock_on() to be in sync with
> local_lock_irq_on()
>=20
> >+	do {                                                    \
> >+		__local_lock(&per_cpu(lvar, cpu));              \
> >+	} while (0)
> >+
> >+#define local_unlock_other_cpu(lvar, cpu)                       \
> >+	do {                                                    \
> >+		__local_unlock(&per_cpu(lvar, cpu));            \
> >+	} while (0)
> >+
> >+
> > static inline void __local_lock_irq(struct local_irq_lock *lv)
> > {
> > 	spin_lock_irqsave(&lv->lock, lv->flags);
> >@@ -163,6 +174,22 @@ static inline int __local_lock_irqsave(struct l=
ocal_irq_lock *lv)
> > 		_flags =3D per_cpu(lvar, cpu).flags;			\
> > 	} while (0)
> >=20
> >+#define local_lock_irqsave_other_cpu(lvar, _flags, cpu)			\ =20
>=20
> why not local_lock_irq_on()?=20

I can change both.

> >+	do {								\
> >+		if (cpu =3D=3D smp_processor_id())				\
> >+			local_lock_irqsave(lvar, _flags);		\
> >+		else							\
> >+			local_lock_other_cpu(lvar, cpu);		\
> >+	} while (0)
> >+ =20
> =E2=80=A6
>=20
> >diff --git a/mm/swap.c b/mm/swap.c
> >index ca194ae..84c3c21 100644
> >--- a/mm/swap.c
> >+++ b/mm/swap.c
> >@@ -821,9 +821,9 @@ void lru_add_drain_cpu(int cpu)
> > 		unsigned long flags;
> >=20
> > 		/* No harm done if a racing interrupt already did this */
> >-		local_lock_irqsave(rotate_lock, flags);
> >+		local_lock_irqsave_other_cpu(rotate_lock, flags, cpu);
> > 		pagevec_move_tail(pvec);
> >-		local_unlock_irqrestore(rotate_lock, flags);
> >+		local_unlock_irqrestore_other_cpu(rotate_lock, flags, cpu); =20
>=20
> This piece might be required independently of this patch. It would be
> nice to have it in page_alloc_cpu_notify() :) I take care of this=E2=80=
=A6
>=20
> > 	}
> >=20
> > 	pvec =3D &per_cpu(lru_deactivate_file_pvecs, cpu);
> >@@ -866,12 +866,32 @@ void lru_add_drain(void)
> > 	local_unlock_cpu(swapvec_lock);
> > }
> >=20
> >+static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
> >+
> >+#ifdef CONFIG_PREEMPT_RT_BASE
> >+static inline void remote_lru_add_drain(int cpu, struct cpumask *ha=
s_work)
> >+{
> >+	local_lock_other_cpu(swapvec_lock, cpu);
> >+	lru_add_drain_cpu(cpu);
> >+	local_unlock_other_cpu(swapvec_lock, cpu);
> >+}
> >+#else
> > static void lru_add_drain_per_cpu(struct work_struct *dummy)
> > {
> > 	lru_add_drain();
> > }
> >=20
> >-static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
> >+static inline void remote_lru_add_drain(int cpu, struct cpumask *ha=
s_work)
> >+{
> >+		struct work_struct *work =3D &per_cpu(lru_add_drain_work, cpu);
> >+
> >+		INIT_WORK(work, lru_add_drain_per_cpu);
> >+		schedule_work_on(cpu, work);
> >+		cpumask_set_cpu(cpu, has_work);
> >+
> >+}
> >+#endif
> >+ =20
>=20
> So on RT you use the local locks to perform $work which should be don=
e
> on the remote CPU locally. RT's local locks help here. You can't do t=
his
> in the !RT case because we optimize the local locks away so you have =
to
> stick with the schedule_work_on() way of dealing with it.

Exactly.

> In your description you write
> >lru_add_drain_all() works by scheduling lru_add_drain_cpu() to run
> >on all CPUs that have non-empty LRU pagevecs and then waiting for
> >the scheduled work to complete. However, workqueue threads may never
> >have the chance to run on a CPU that's running a SCHED_FIFO task.
> >This causes lru_add_drain_all() to block forever. =20
>=20
> It might block forever but not necessarily. By default the scheduler
> would push RT tasks off the CPU if they run for too long. So you have
> disabled this (and I don't complain about it). And once this does not
> happen, there is nothing to force the workqueue to run.
> But this is not a RT-only problem, is it? You could run high prio RT
> task on a CPU and the workqueue would never get on the CPU as well.

That's correct. This is an -RT patch for two reasons:

 1. This solution builds on top of the per-cpu locks API implemented
    by -RT and already in place in the pagevecs drain code

 2. As SCHED_FIFO is the norm in -RT, the problem is more common there
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
