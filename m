From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH RFC -rt] mm: perform lru_add_drain_all() remotely
Date: Fri, 29 Apr 2016 08:19:50 -0400
Message-ID: <20160429081950.0d8c5afd@redhat.com>
References: <20160428163155.350b54ab@redhat.com>
	<1461883636.13397.58.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
	tglx@linutronix.de, srostedt@redhat.com, williams@redhat.com
To: Rik van Riel <riel@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50343 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbcD2MTy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Apr 2016 08:19:54 -0400
In-Reply-To: <1461883636.13397.58.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 28 Apr 2016 18:47:16 -0400
Rik van Riel <riel@redhat.com> wrote:

> On Thu, 2016-04-28 at 16:31 -0400, Luiz Capitulino wrote:
> > lru_add_drain_all() works by scheduling lru_add_drain_cpu() to run
> > on all CPUs that have non-empty LRU pagevecs and then waiting for
> > the scheduled work to complete. However, workqueue threads may neve=
r
> > have the chance to run on a CPU that's running a SCHED_FIFO task.
> > This causes lru_add_drain_all() to block forever.
> >=20
> > This commit solves this problem by changing lru_add_drain_all()
> > to drain the LRU pagevecs of remote CPUs. This is done by grabbing
> > swapvec_lock and calling lru_add_drain_cpu().
> >=20
> > PS: This is based on an idea and initial implementation by
> > =C2=A0=C2=A0=C2=A0=C2=A0Rik van Riel. =20
>=20
> I wrote maybe half the code in this patch.

And it was the hard part, sorry for not adding your signed-off-by.

> It should
> probably have my signed-off-by line too :)
>=20
> Anyway, the patch looks fine to me and seems to work.
>=20
> =C2=A0 Signed-off-by: Rik van Riel <riel@redhat.com>
> > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> > ---
> > =C2=A0include/linux/locallock.h | 27 +++++++++++++++++++++++++++
> > =C2=A0mm/swap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 35 ++++++++++++++++++=
+++++++----------
> > =C2=A02 files changed, 52 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/include/linux/locallock.h b/include/linux/locallock.h
> > index 6fe5928..2de478b 100644
> > --- a/include/linux/locallock.h
> > +++ b/include/linux/locallock.h
> > @@ -104,6 +104,17 @@ static inline void __local_unlock(struct
> > local_irq_lock *lv)
> > =C2=A0		put_local_var(lvar);			=09
> > \
> > =C2=A0	} while (0)
> > =C2=A0
> > +#define local_lock_other_cpu(lvar, cpu)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > +	do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > +		__local_lock(&per_cpu(lvar, cpu));=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > +	} while (0)
> > +
> > +#define local_unlock_other_cpu(lvar, cpu)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > +	do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > +		__local_unlock(&per_cpu(lvar, cpu));=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > +	} while (0)
> > +
> > +
> > =C2=A0static inline void __local_lock_irq(struct local_irq_lock *lv=
)
> > =C2=A0{
> > =C2=A0	spin_lock_irqsave(&lv->lock, lv->flags);
> > @@ -163,6 +174,22 @@ static inline int __local_lock_irqsave(struct
> > local_irq_lock *lv)
> > =C2=A0		_flags =3D per_cpu(lvar, cpu).flags;		=09
> > \
> > =C2=A0	} while (0)
> > =C2=A0
> > +#define local_lock_irqsave_other_cpu(lvar, _flags, cpu)	=09
> > 	\
> > +	do {							=09
> > \
> > +		if (cpu =3D=3D smp_processor_id())		=09
> > 	\
> > +			local_lock_irqsave(lvar, _flags);	=09
> > \
> > +		else						=09
> > \
> > +			local_lock_other_cpu(lvar, cpu);	=09
> > \
> > +	} while (0)
> > +
> > +#define local_unlock_irqrestore_other_cpu(lvar, _flags, cpu)=09
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > +	do {							=09
> > \
> > +		if (cpu =3D=3D smp_processor_id())		=09
> > 	\
> > +			local_unlock_irqrestore(lvar, _flags);=09
> > 	\
> > +		else						=09
> > \
> > +			local_unlock_other_cpu(lvar, cpu);	=09
> > \
> > +	} while (0)
> > +
> > =C2=A0static inline int __local_unlock_irqrestore(struct local_irq_=
lock
> > *lv,
> > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0unsigned long flags)
> > =C2=A0{
> > diff --git a/mm/swap.c b/mm/swap.c
> > index ca194ae..9dc6956 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -821,9 +821,9 @@ void lru_add_drain_cpu(int cpu)
> > =C2=A0		unsigned long flags;
> > =C2=A0
> > =C2=A0		/* No harm done if a racing interrupt already did
> > this */
> > -		local_lock_irqsave(rotate_lock, flags);
> > +		local_lock_irqsave_other_cpu(rotate_lock, flags,
> > cpu);
> > =C2=A0		pagevec_move_tail(pvec);
> > -		local_unlock_irqrestore(rotate_lock, flags);
> > +		local_unlock_irqrestore_other_cpu(rotate_lock,
> > flags, cpu);
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	pvec =3D &per_cpu(lru_deactivate_file_pvecs, cpu);
> > @@ -866,12 +866,32 @@ void lru_add_drain(void)
> > =C2=A0	local_unlock_cpu(swapvec_lock);
> > =C2=A0}
> > =C2=A0
> > +static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
> > +
> > +#ifdef CONFIG_PREEMPT_RT_BASE
> > +static inline void remote_lru_add_drain(int cpu, struct cpumask
> > *has_work)
> > +{
> > +	local_lock_other_cpu(swapvec_lock, cpu);
> > +	lru_add_drain_cpu(cpu);
> > +	local_unlock_other_cpu(swapvec_lock, cpu);
> > +}
> > +#else
> > =C2=A0static void lru_add_drain_per_cpu(struct work_struct *dummy)
> > =C2=A0{
> > =C2=A0	lru_add_drain();
> > =C2=A0}
> > =C2=A0
> > -static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
> > +static inline void remote_lru_add_drain(int cpu, struct cpumask
> > *has_work)
> > +{
> > +		struct work_struct *work =3D
> > &per_cpu(lru_add_drain_work, cpu);
> > +
> > +		INIT_WORK(work, lru_add_drain_per_cpu);
> > +		schedule_work_on(cpu, work);
> > +		cpumask_set_cpu(cpu, &has_work);
> > +
> > +}
> > +#endif
> > +
> > =C2=A0
> > =C2=A0void lru_add_drain_all(void)
> > =C2=A0{
> > @@ -884,16 +904,11 @@ void lru_add_drain_all(void)
> > =C2=A0	cpumask_clear(&has_work);
> > =C2=A0
> > =C2=A0	for_each_online_cpu(cpu) {
> > -		struct work_struct *work =3D
> > &per_cpu(lru_add_drain_work, cpu);
> > -
> > =C2=A0		if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0pagevec_count(&per_cpu(lru_rotate_p=
vecs, cpu))
> > ||
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0pagevec_count(&per_cpu(lru_deactiva=
te_file_pvecs
> > , cpu)) ||
> > -		=C2=A0=C2=A0=C2=A0=C2=A0need_activate_page_drain(cpu)) {
> > -			INIT_WORK(work, lru_add_drain_per_cpu);
> > -			schedule_work_on(cpu, work);
> > -			cpumask_set_cpu(cpu, &has_work);
> > -		}
> > +		=C2=A0=C2=A0=C2=A0=C2=A0need_activate_page_drain(cpu))
> > +				remote_lru_add_drain(cpu,
> > &has_work);
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	for_each_cpu(cpu, &has_work) =20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
