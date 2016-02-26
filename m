From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 02/12] genirq: Handle force threading of interrupts
 with primary and thread handler
Date: Fri, 26 Feb 2016 16:48:11 -0500
Message-ID: <20160226164811.1d3eb192@gandalf.local.home>
References: <20160226213235.253312067@goodmis.org>
	<20160226213340.259403556@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Kohji Okuno <okuno.kohji@jp.panasonic.com>,
	Michal =?UTF-8?B?w4U=?= mucr <msmucr@gmail.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:48051 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752176AbcBZVsQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 16:48:16 -0500
In-Reply-To: <20160226213340.259403556@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Quilt mail doesn't seem to handle =C3=85 well, and vger.kernel.org bloc=
ked
it.

-- Steve


On Fri, 26 Feb 2016 16:32:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 3.18.27-rt26-rc1 stable review patch.
> If anyone has any objections, please let me know.
>=20
> ------------------
>=20
> From: Thomas Gleixner <tglx@linutronix.de>
>=20
> Force threading of interrupts does not deal with interrupts which are
> requested with a primary and a threaded handler. The current policy i=
s
> to leave them alone and let the primary handler run in interrupt
> context, but we set the ONESHOT flag for those interrupts as well.
>=20
> Kohji Okuno debugged a problem with the SDHCI driver where the
> interrupt thread waits for a hardware interrupt to trigger, which can=
t
> work well because the hardware interrupt is masked due to the ONESHOT
> flag being set. He proposed to set the ONESHOT flag only if the
> interrupt does not provide a thread handler.
>=20
> Though that does not work either because these interrupts can be
> shared. So the other interrupt would rightfully get the ONESHOT flag
> set and therefor the same situation would happen again.
>=20
> To deal with this proper, we need to force thread the primary handler
> of such interrupts as well. That means that the primary interrupt
> handler is treated as any other primary interrupt handler which is no=
t
> marked IRQF_NO_THREAD. The threaded handler becomes a separate thread
> so the SDHCI flow logic can be handled gracefully.
>=20
> The same issue was reported against 4.1-rt.
>=20
> Reported-by: Kohji Okuno <okuno.kohji@jp.panasonic.com>
> Reported-By: Michal =C3=85=C2=A0mucr <msmucr@gmail.com>
> Reported-and-tested-by: Nathan Sullivan <nathan.sullivan@ni.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  include/linux/interrupt.h |   2 +
>  kernel/irq/manage.c       | 158 ++++++++++++++++++++++++++++++++++--=
----------
>  2 files changed, 119 insertions(+), 41 deletions(-)
>=20
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 33cfbc085a94..86628c733be7 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -100,6 +100,7 @@ typedef irqreturn_t (*irq_handler_t)(int, void *)=
;
>   * @flags:	flags (see IRQF_* above)
>   * @thread_fn:	interrupt handler function for threaded interrupts
>   * @thread:	thread pointer for threaded interrupts
> + * @secondary:	pointer to secondary irqaction (force threading)
>   * @thread_flags:	flags related to @thread
>   * @thread_mask:	bitmask for keeping track of @thread activity
>   * @dir:	pointer to the proc/irq/NN/name entry
> @@ -111,6 +112,7 @@ struct irqaction {
>  	struct irqaction	*next;
>  	irq_handler_t		thread_fn;
>  	struct task_struct	*thread;
> +	struct irqaction	*secondary;
>  	unsigned int		irq;
>  	unsigned int		flags;
>  	unsigned long		thread_flags;
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 382cbe57abf3..70f59992c201 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -735,6 +735,12 @@ static irqreturn_t irq_nested_primary_handler(in=
t irq, void *dev_id)
>  	return IRQ_NONE;
>  }
> =20
> +static irqreturn_t irq_forced_secondary_handler(int irq, void *dev_i=
d)
> +{
> +	WARN(1, "Secondary action handler called for irq %d\n", irq);
> +	return IRQ_NONE;
> +}
> +
>  static int irq_wait_for_interrupt(struct irqaction *action)
>  {
>  	set_current_state(TASK_INTERRUPTIBLE);
> @@ -761,7 +767,8 @@ static int irq_wait_for_interrupt(struct irqactio=
n *action)
>  static void irq_finalize_oneshot(struct irq_desc *desc,
>  				 struct irqaction *action)
>  {
> -	if (!(desc->istate & IRQS_ONESHOT))
> +	if (!(desc->istate & IRQS_ONESHOT) ||
> +	    action->handler =3D=3D irq_forced_secondary_handler)
>  		return;
>  again:
>  	chip_bus_lock(desc);
> @@ -923,6 +930,18 @@ static void irq_thread_dtor(struct callback_head=
 *unused)
>  	irq_finalize_oneshot(desc, action);
>  }
> =20
> +static void irq_wake_secondary(struct irq_desc *desc, struct irqacti=
on *action)
> +{
> +	struct irqaction *secondary =3D action->secondary;
> +
> +	if (WARN_ON_ONCE(!secondary))
> +		return;
> +
> +	raw_spin_lock_irq(&desc->lock);
> +	__irq_wake_thread(desc, secondary);
> +	raw_spin_unlock_irq(&desc->lock);
> +}
> +
>  /*
>   * Interrupt handler thread
>   */
> @@ -953,6 +972,8 @@ static int irq_thread(void *data)
>  		action_ret =3D handler_fn(desc, action);
>  		if (action_ret =3D=3D IRQ_HANDLED)
>  			atomic_inc(&desc->threads_handled);
> +		if (action_ret =3D=3D IRQ_WAKE_THREAD)
> +			irq_wake_secondary(desc, action);
> =20
>  #ifdef CONFIG_PREEMPT_RT_FULL
>  		migrate_disable();
> @@ -1003,20 +1024,36 @@ void irq_wake_thread(unsigned int irq, void *=
dev_id)
>  }
>  EXPORT_SYMBOL_GPL(irq_wake_thread);
> =20
> -static void irq_setup_forced_threading(struct irqaction *new)
> +static int irq_setup_forced_threading(struct irqaction *new)
>  {
>  	if (!force_irqthreads)
> -		return;
> +		return 0;
>  	if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
> -		return;
> +		return 0;
> =20
>  	new->flags |=3D IRQF_ONESHOT;
> =20
> -	if (!new->thread_fn) {
> -		set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
> -		new->thread_fn =3D new->handler;
> -		new->handler =3D irq_default_primary_handler;
> +	/*
> +	 * Handle the case where we have a real primary handler and a
> +	 * thread handler. We force thread them as well by creating a
> +	 * secondary action.
> +	 */
> +	if (new->handler !=3D irq_default_primary_handler && new->thread_fn=
) {
> +		/* Allocate the secondary action */
> +		new->secondary =3D kzalloc(sizeof(struct irqaction), GFP_KERNEL);
> +		if (!new->secondary)
> +			return -ENOMEM;
> +		new->secondary->handler =3D irq_forced_secondary_handler;
> +		new->secondary->thread_fn =3D new->thread_fn;
> +		new->secondary->dev_id =3D new->dev_id;
> +		new->secondary->irq =3D new->irq;
> +		new->secondary->name =3D new->name;
>  	}
> +	/* Deal with the primary handler */
> +	set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
> +	new->thread_fn =3D new->handler;
> +	new->handler =3D irq_default_primary_handler;
> +	return 0;
>  }
> =20
>  static int irq_request_resources(struct irq_desc *desc)
> @@ -1036,6 +1073,48 @@ static void irq_release_resources(struct irq_d=
esc *desc)
>  		c->irq_release_resources(d);
>  }
> =20
> +static int
> +setup_irq_thread(struct irqaction *new, unsigned int irq, bool secon=
dary)
> +{
> +	struct task_struct *t;
> +	struct sched_param param =3D {
> +		.sched_priority =3D MAX_USER_RT_PRIO/2,
> +	};
> +
> +	if (!secondary) {
> +		t =3D kthread_create(irq_thread, new, "irq/%d-%s", irq,
> +				   new->name);
> +	} else {
> +		t =3D kthread_create(irq_thread, new, "irq/%d-s-%s", irq,
> +				   new->name);
> +		param.sched_priority +=3D 1;
> +	}
> +
> +	if (IS_ERR(t))
> +		return PTR_ERR(t);
> +
> +	sched_setscheduler_nocheck(t, SCHED_FIFO, &param);
> +
> +	/*
> +	 * We keep the reference to the task struct even if
> +	 * the thread dies to avoid that the interrupt code
> +	 * references an already freed task_struct.
> +	 */
> +	get_task_struct(t);
> +	new->thread =3D t;
> +	/*
> +	 * Tell the thread to set its affinity. This is
> +	 * important for shared interrupt handlers as we do
> +	 * not invoke setup_affinity() for the secondary
> +	 * handlers as everything is already set up. Even for
> +	 * interrupts marked with IRQF_NO_BALANCE this is
> +	 * correct as we want the thread to move to the cpu(s)
> +	 * on which the requesting code placed the interrupt.
> +	 */
> +	set_bit(IRQTF_AFFINITY, &new->thread_flags);
> +	return 0;
> +}
> +
>  /*
>   * Internal function to register an irqaction - typically used to
>   * allocate special interrupts that are part of the architecture.
> @@ -1056,6 +1135,8 @@ __setup_irq(unsigned int irq, struct irq_desc *=
desc, struct irqaction *new)
>  	if (!try_module_get(desc->owner))
>  		return -ENODEV;
> =20
> +	new->irq =3D irq;
> +
>  	/*
>  	 * Check whether the interrupt nests into another interrupt
>  	 * thread.
> @@ -1073,8 +1154,11 @@ __setup_irq(unsigned int irq, struct irq_desc =
*desc, struct irqaction *new)
>  		 */
>  		new->handler =3D irq_nested_primary_handler;
>  	} else {
> -		if (irq_settings_can_thread(desc))
> -			irq_setup_forced_threading(new);
> +		if (irq_settings_can_thread(desc)) {
> +			ret =3D irq_setup_forced_threading(new);
> +			if (ret)
> +				goto out_mput;
> +		}
>  	}
> =20
>  	/*
> @@ -1083,37 +1167,14 @@ __setup_irq(unsigned int irq, struct irq_desc=
 *desc, struct irqaction *new)
>  	 * thread.
>  	 */
>  	if (new->thread_fn && !nested) {
> -		struct task_struct *t;
> -		static const struct sched_param param =3D {
> -			.sched_priority =3D MAX_USER_RT_PRIO/2,
> -		};
> -
> -		t =3D kthread_create(irq_thread, new, "irq/%d-%s", irq,
> -				   new->name);
> -		if (IS_ERR(t)) {
> -			ret =3D PTR_ERR(t);
> +		ret =3D setup_irq_thread(new, irq, false);
> +		if (ret)
>  			goto out_mput;
> +		if (new->secondary) {
> +			ret =3D setup_irq_thread(new->secondary, irq, true);
> +			if (ret)
> +				goto out_thread;
>  		}
> -
> -		sched_setscheduler_nocheck(t, SCHED_FIFO, &param);
> -
> -		/*
> -		 * We keep the reference to the task struct even if
> -		 * the thread dies to avoid that the interrupt code
> -		 * references an already freed task_struct.
> -		 */
> -		get_task_struct(t);
> -		new->thread =3D t;
> -		/*
> -		 * Tell the thread to set its affinity. This is
> -		 * important for shared interrupt handlers as we do
> -		 * not invoke setup_affinity() for the secondary
> -		 * handlers as everything is already set up. Even for
> -		 * interrupts marked with IRQF_NO_BALANCE this is
> -		 * correct as we want the thread to move to the cpu(s)
> -		 * on which the requesting code placed the interrupt.
> -		 */
> -		set_bit(IRQTF_AFFINITY, &new->thread_flags);
>  	}
> =20
>  	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
> @@ -1289,7 +1350,6 @@ __setup_irq(unsigned int irq, struct irq_desc *=
desc, struct irqaction *new)
>  				   irq, nmsk, omsk);
>  	}
> =20
> -	new->irq =3D irq;
>  	*old_ptr =3D new;
> =20
>  	irq_pm_install_action(desc, new);
> @@ -1315,6 +1375,8 @@ __setup_irq(unsigned int irq, struct irq_desc *=
desc, struct irqaction *new)
>  	 */
>  	if (new->thread)
>  		wake_up_process(new->thread);
> +	if (new->secondary)
> +		wake_up_process(new->secondary->thread);
> =20
>  	register_irq_proc(irq, desc);
>  	new->dir =3D NULL;
> @@ -1345,6 +1407,13 @@ out_thread:
>  		kthread_stop(t);
>  		put_task_struct(t);
>  	}
> +	if (new->secondary && new->secondary->thread) {
> +		struct task_struct *t =3D new->secondary->thread;
> +
> +		new->secondary->thread =3D NULL;
> +		kthread_stop(t);
> +		put_task_struct(t);
> +	}
>  out_mput:
>  	module_put(desc->owner);
>  	return ret;
> @@ -1452,9 +1521,14 @@ static struct irqaction *__free_irq(unsigned i=
nt irq, void *dev_id)
>  	if (action->thread) {
>  		kthread_stop(action->thread);
>  		put_task_struct(action->thread);
> +		if (action->secondary && action->secondary->thread) {
> +			kthread_stop(action->secondary->thread);
> +			put_task_struct(action->secondary->thread);
> +		}
>  	}
> =20
>  	module_put(desc->owner);
> +	kfree(action->secondary);
>  	return action;
>  }
> =20
> @@ -1593,8 +1667,10 @@ int request_threaded_irq(unsigned int irq, irq=
_handler_t handler,
>  	retval =3D __setup_irq(irq, desc, action);
>  	chip_bus_sync_unlock(desc);
> =20
> -	if (retval)
> +	if (retval) {
> +		kfree(action->secondary);
>  		kfree(action);
> +	}
> =20
>  #ifdef CONFIG_DEBUG_SHIRQ_FIXME
>  	if (!retval && (irqflags & IRQF_SHARED)) {

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
