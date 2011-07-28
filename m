From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: Re: [ANNOUNCE] 3.0-rt4 , Follow up question
Date: Thu, 28 Jul 2011 11:42:04 +0200
Message-ID: <CAF-VNapwgfr66ib9OPcpJO-4K+6F-0VZA2Tc=4Fp==TDPKwkRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f52.google.com ([209.85.212.52]:59033 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab1G1JmF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 05:42:05 -0400
Received: by vws16 with SMTP id 16so2729258vws.11
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Jul 2011 02:42:04 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

How much is there left to do for mainline inclusion ?

A rough guess would be nice, just to assess the amount of work and seve=
rity.
As I understand it , a lot of subsystes are trying to go lockless, so
things should become easier.

 / regards, Lars Segerlund.

2011/7/27 Thomas Gleixner <tglx@linutronix.de>:
> Dear RT Folks,
>
> I'm pleased to announce the 3.0-rt4 release.
>
> Changes versus 3.0-rt3:
>
> =A0* futex/rtmutex fix - decoded by Darren Hart
>
> =A0* tracing fixes (Carsten Emde)
>
> =A0* Various compile fixes
>
> =A0* Lock annotations (Uwe Kleine-Koenig & myself)
>
> =A0* Disabled a few more config options on RT which have known issues
>
> The list of disabled config option is now:
>
> =A0- CONFIG_HIGHMEM [ see the mess it created in 33-rt ]
>
> =A0- CONFIG_RCU_BOOST [ weird crashes reported, no idea what's wrong.=
 Paul ?? ]
>
> =A0- CONFIG_RT_GROUP_SCHED [ brings the complete machine to stall. Pe=
ter ?? ]
>
> =A0- CONFIG_OPROFILE [ memory allocation in smp function call, trivia=
l
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 to fix ]
>
> =A0- CONFIG_NETCONSOLE [ preempt/irq_disable oddities ]
>
> =A0- CONFIG_NOHZ [ softirq pending warnings and yet undebugged stalls=
 ]
>
> =A0- CONFIG_TRANSPARENT_HUGEPAGE [ compound bit spin lock ]
>
> =A0- KGDB (not yet disabled) is reportedly unusable on -rt right now =
due
> =A0 to missing hacks in the console locking which I dropped on purpos=
e.
>
> If you care about one of the above functionalities you are heartly
> invited to have a stab on it, but please don't go there and just copy
> the hackery which was in 33-rt - I dropped it for a reason. :)
>
> None of the above except the console related maze - and of course the
> stuff already assigned to (Saints) Peter & Paul - is overly complex,
> but it all want's some thought and care.
>
> This is probably the last -rt release before I drop off the net for
> two weeks to attend to my annual kids summer camp kitchen duty. [ Tha=
t
> means no computers, e-mail, confcalls etc. - YAY! ]
>
> Patch against 3.0 can be found here:
>
> =A0http://www.kernel.org/pub/linux/kernel/projects/rt/patch-3.0-rt4.p=
atch.bz2
>
> The split quilt queue is available at:
>
> =A0http://www.kernel.org/pub/linux/kernel/projects/rt/patches-3.0-rt4=
=2Etar.bz2
>
> Delta patch below.
>
> Thanks,
>
> =A0 =A0 =A0 =A0tglx
> ----
> =A0arch/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/common/gic.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 26 ++++++++++++=
+-------------
> =A0arch/arm/include/asm/mmu.h =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mm/context.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 +++---
> =A0drivers/usb/gadget/ci13xxx_udc.c | =A0 =A02 +-
> =A0include/linux/hardirq.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0include/linux/sched.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +++++++++--
> =A0init/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0kernel/rtmutex.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0kernel/sched.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 ++++=
--
> =A0kernel/softirq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 ++--
> =A0kernel/time/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0kernel/trace/latency_hist.c =A0 =A0 =A0| =A0 =A08 ++++++--
> =A0kernel/trace/trace_irqsoff.c =A0 =A0 | =A0 11 +++++++++++
> =A0localversion-rt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A015 files changed, 56 insertions(+), 30 deletions(-)
>
> Index: linux-2.6/arch/arm/mm/context.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/arm/mm/context.c
> +++ linux-2.6/arch/arm/mm/context.c
> @@ -31,7 +31,7 @@ DEFINE_PER_CPU(struct mm_struct *, curre
> =A0void __init_new_context(struct task_struct *tsk, struct mm_struct =
*mm)
> =A0{
> =A0 =A0 =A0 =A0mm->context.id =3D 0;
> - =A0 =A0 =A0 spin_lock_init(&mm->context.id_lock);
> + =A0 =A0 =A0 raw_spin_lock_init(&mm->context.id_lock);
> =A0}
>
> =A0static void flush_context(void)
> @@ -58,7 +58,7 @@ static void set_mm_context(struct mm_str
> =A0 =A0 =A0 =A0 * the broadcast. This function is also called via IPI=
 so the
> =A0 =A0 =A0 =A0 * mm->context.id_lock has to be IRQ-safe.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 spin_lock_irqsave(&mm->context.id_lock, flags);
> + =A0 =A0 =A0 raw_spin_lock_irqsave(&mm->context.id_lock, flags);
> =A0 =A0 =A0 =A0if (likely((mm->context.id ^ cpu_last_asid) >> ASID_BI=
TS)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Old version of ASID found. Set the =
new one and
> @@ -67,7 +67,7 @@ static void set_mm_context(struct mm_str
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mm->context.id =3D asid;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpumask_clear(mm_cpumask(mm));
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 spin_unlock_irqrestore(&mm->context.id_lock, flags);
> + =A0 =A0 =A0 raw_spin_unlock_irqrestore(&mm->context.id_lock, flags)=
;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Set the mm_cpumask(mm) bit for the current CPU.
> Index: linux-2.6/include/linux/hardirq.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/hardirq.h
> +++ linux-2.6/include/linux/hardirq.h
> @@ -84,7 +84,7 @@
> =A0# define softirq_count() =A0 =A0 =A0 (preempt_count() & SOFTIRQ_MA=
SK)
> =A0# define in_serving_softirq() =A0(softirq_count() & SOFTIRQ_OFFSET=
)
> =A0#else
> -# define softirq_count() =A0 =A0 =A0 (0)
> +# define softirq_count() =A0 =A0 =A0 (0U)
> =A0extern int in_serving_softirq(void);
> =A0#endif
>
> Index: linux-2.6/include/linux/sched.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/sched.h
> +++ linux-2.6/include/linux/sched.h
> @@ -2046,21 +2046,28 @@ static inline void sched_autogroup_fork(
> =A0static inline void sched_autogroup_exit(struct signal_struct *sig)=
 { }
> =A0#endif
>
> -extern void task_setprio(struct task_struct *p, int prio);
> -
> =A0#ifdef CONFIG_RT_MUTEXES
> +extern void task_setprio(struct task_struct *p, int prio);
> =A0extern int rt_mutex_getprio(struct task_struct *p);
> =A0static inline void rt_mutex_setprio(struct task_struct *p, int pri=
o)
> =A0{
> =A0 =A0 =A0 =A0task_setprio(p, prio);
> =A0}
> =A0extern void rt_mutex_adjust_pi(struct task_struct *p);
> +static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
> +{
> + =A0 =A0 =A0 return tsk->pi_blocked_on !=3D NULL;
> +}
> =A0#else
> =A0static inline int rt_mutex_getprio(struct task_struct *p)
> =A0{
> =A0 =A0 =A0 =A0return p->normal_prio;
> =A0}
> =A0# define rt_mutex_adjust_pi(p) =A0 =A0 =A0 =A0 do { } while (0)
> +static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
> +{
> + =A0 =A0 =A0 return false;
> +}
> =A0#endif
>
> =A0extern bool yield_to(struct task_struct *p, bool preempt);
> Index: linux-2.6/init/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/init/Kconfig
> +++ linux-2.6/init/Kconfig
> @@ -493,7 +493,7 @@ config TREE_RCU_TRACE
>
> =A0config RCU_BOOST
> =A0 =A0 =A0 =A0bool "Enable RCU priority boosting"
> - =A0 =A0 =A0 depends on RT_MUTEXES && PREEMPT_RCU
> + =A0 =A0 =A0 depends on RT_MUTEXES && PREEMPT_RCU && !RT_PREEMPT_FUL=
L
> =A0 =A0 =A0 =A0default n
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This option boosts the priority of preempted RCU r=
eaders that
> Index: linux-2.6/kernel/rtmutex.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/rtmutex.c
> +++ linux-2.6/kernel/rtmutex.c
> @@ -1296,7 +1296,7 @@ EXPORT_SYMBOL_GPL(__rt_mutex_init);
> =A0void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct=
 task_struct *proxy_owner)
> =A0{
> - =A0 =A0 =A0 __rt_mutex_init(lock, NULL);
> + =A0 =A0 =A0 rt_mutex_init(lock);
> =A0 =A0 =A0 =A0debug_rt_mutex_proxy_lock(lock, proxy_owner);
> =A0 =A0 =A0 =A0rt_mutex_set_owner(lock, proxy_owner);
> =A0 =A0 =A0 =A0rt_mutex_deadlock_account_lock(lock, proxy_owner);
> Index: linux-2.6/kernel/sched.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/sched.c
> +++ linux-2.6/kernel/sched.c
> @@ -4313,7 +4313,7 @@ need_resched:
>
> =A0static inline void sched_submit_work(struct task_struct *tsk)
> =A0{
> - =A0 =A0 =A0 if (!tsk->state || tsk->pi_blocked_on)
> + =A0 =A0 =A0 if (!tsk->state || tsk_is_pi_blocked(tsk))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0/*
> @@ -4333,7 +4333,7 @@ static inline void sched_submit_work(str
>
> =A0static inline void sched_update_worker(struct task_struct *tsk)
> =A0{
> - =A0 =A0 =A0 if (tsk->pi_blocked_on)
> + =A0 =A0 =A0 if (tsk_is_pi_blocked(tsk))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0if (tsk->flags & PF_WQ_WORKER)
> @@ -4855,6 +4855,7 @@ long __sched sleep_on_timeout(wait_queue
> =A0}
> =A0EXPORT_SYMBOL(sleep_on_timeout);
>
> +#ifdef CONFIG_RT_MUTEXES
> =A0/*
> =A0* task_setprio - set the current priority of a task
> =A0* @p: task
> @@ -4919,6 +4920,7 @@ void task_setprio(struct task_struct *p,
> =A0out_unlock:
> =A0 =A0 =A0 =A0__task_rq_unlock(rq);
> =A0}
> +#endif
>
> =A0void set_user_nice(struct task_struct *p, long nice)
> =A0{
> Index: linux-2.6/kernel/softirq.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/softirq.c
> +++ linux-2.6/kernel/softirq.c
> @@ -101,7 +101,7 @@ void softirq_check_pending_idle(void)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (warnpending) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "NOHZ: local_softirq_pe=
nding %02lx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "NOHZ: local_softirq_pe=
nding %02x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pending);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rate_limit++;
> =A0 =A0 =A0 =A0}
> @@ -115,7 +115,7 @@ void softirq_check_pending_idle(void)
> =A0 =A0 =A0 =A0static int rate_limit;
>
> =A0 =A0 =A0 =A0if (rate_limit < 10) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "NOHZ: local_softirq_pe=
nding %02lx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "NOHZ: local_softirq_pe=
nding %02x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_softirq_pending());
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rate_limit++;
> =A0 =A0 =A0 =A0}
> Index: linux-2.6/kernel/trace/latency_hist.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/trace/latency_hist.c
> +++ linux-2.6/kernel/trace/latency_hist.c
> @@ -84,7 +84,7 @@ static DEFINE_PER_CPU(int, hist_preempti
> =A0#endif
>
> =A0#if defined(CONFIG_PREEMPT_OFF_HIST) || defined(CONFIG_INTERRUPT_O=
=46F_HIST)
> -static notrace void probe_preemptirqsoff_hist(int reason, int start)=
;
> +static notrace void probe_preemptirqsoff_hist(void *v, int reason, i=
nt start);
> =A0static struct enable_data preemptirqsoff_enabled_data =3D {
> =A0 =A0 =A0 =A0.latency_type =3D PREEMPTIRQSOFF_LATENCY,
> =A0 =A0 =A0 =A0.enabled =3D 0,
> @@ -358,6 +358,8 @@ static struct file_operations latency_hi
> =A0 =A0 =A0 =A0.release =3D seq_release,
> =A0};
>
> +#if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
> + =A0 =A0defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
> =A0static void clear_maxlatprocdata(struct maxlatproc_data *mp)
> =A0{
> =A0 =A0 =A0 =A0mp->comm[0] =3D mp->current_comm[0] =3D '\0';
> @@ -365,6 +367,7 @@ static void clear_maxlatprocdata(struct
> =A0 =A0 =A0 =A0 =A0 =A0mp->latency =3D mp->timeroffset =3D -1;
> =A0 =A0 =A0 =A0mp->timestamp =3D 0;
> =A0}
> +#endif
>
> =A0static void hist_reset(struct hist_data *hist)
> =A0{
> @@ -735,7 +738,8 @@ static const struct file_operations maxl
> =A0#endif
>
> =A0#if defined(CONFIG_INTERRUPT_OFF_HIST) || defined(CONFIG_PREEMPT_O=
=46F_HIST)
> -static notrace void probe_preemptirqsoff_hist(int reason, int starth=
ist)
> +static notrace void probe_preemptirqsoff_hist(void *v, int reason,
> + =A0 =A0int starthist)
> =A0{
> =A0 =A0 =A0 =A0int cpu =3D raw_smp_processor_id();
> =A0 =A0 =A0 =A0int time_set =3D 0;
> Index: linux-2.6/kernel/trace/trace_irqsoff.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/trace/trace_irqsoff.c
> +++ linux-2.6/kernel/trace/trace_irqsoff.c
> @@ -17,6 +17,7 @@
> =A0#include <linux/fs.h>
>
> =A0#include "trace.h"
> +#include <trace/events/hist.h>
>
> =A0static struct trace_array =A0 =A0 =A0 =A0 =A0 =A0 =A0*irqsoff_trac=
e __read_mostly;
> =A0static int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 tracer_enabled __read_mostly;
> @@ -424,11 +425,13 @@ void start_critical_timings(void)
> =A0{
> =A0 =A0 =A0 =A0if (preempt_trace() || irq_trace())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start_critical_timing(CALLER_ADDR0, CA=
LLER_ADDR1);
> + =A0 =A0 =A0 trace_preemptirqsoff_hist(TRACE_START, 1);
> =A0}
> =A0EXPORT_SYMBOL_GPL(start_critical_timings);
>
> =A0void stop_critical_timings(void)
> =A0{
> + =A0 =A0 =A0 trace_preemptirqsoff_hist(TRACE_STOP, 0);
> =A0 =A0 =A0 =A0if (preempt_trace() || irq_trace())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stop_critical_timing(CALLER_ADDR0, CAL=
LER_ADDR1);
> =A0}
> @@ -438,6 +441,7 @@ EXPORT_SYMBOL_GPL(stop_critical_timings)
> =A0#ifdef CONFIG_PROVE_LOCKING
> =A0void time_hardirqs_on(unsigned long a0, unsigned long a1)
> =A0{
> + =A0 =A0 =A0 trace_preemptirqsoff_hist(IRQS_ON, 0);
> =A0 =A0 =A0 =A0if (!preempt_trace() && irq_trace())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stop_critical_timing(a0, a1);
> =A0}
> @@ -446,6 +450,7 @@ void time_hardirqs_off(unsigned long a0,
> =A0{
> =A0 =A0 =A0 =A0if (!preempt_trace() && irq_trace())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start_critical_timing(a0, a1);
> + =A0 =A0 =A0 trace_preemptirqsoff_hist(IRQS_OFF, 1);
> =A0}
>
> =A0#else /* !CONFIG_PROVE_LOCKING */
> @@ -471,6 +476,7 @@ inline void print_irqtrace_events(struct
> =A0*/
> =A0void trace_hardirqs_on(void)
> =A0{
> + =A0 =A0 =A0 trace_preemptirqsoff_hist(IRQS_ON, 0);
> =A0 =A0 =A0 =A0if (!preempt_trace() && irq_trace())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stop_critical_timing(CALLER_ADDR0, CAL=
LER_ADDR1);
> =A0}
> @@ -480,11 +486,13 @@ void trace_hardirqs_off(void)
> =A0{
> =A0 =A0 =A0 =A0if (!preempt_trace() && irq_trace())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start_critical_timing(CALLER_ADDR0, CA=
LLER_ADDR1);
> + =A0 =A0 =A0 trace_preemptirqsoff_hist(IRQS_OFF, 1);
> =A0}
> =A0EXPORT_SYMBOL(trace_hardirqs_off);
>
> =A0void trace_hardirqs_on_caller(unsigned long caller_addr)
> =A0{
> + =A0 =A0 =A0 trace_preemptirqsoff_hist(IRQS_ON, 0);
> =A0 =A0 =A0 =A0if (!preempt_trace() && irq_trace())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stop_critical_timing(CALLER_ADDR0, cal=
ler_addr);
> =A0}
> @@ -494,6 +502,7 @@ void trace_hardirqs_off_caller(unsigned
> =A0{
> =A0 =A0 =A0 =A0if (!preempt_trace() && irq_trace())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start_critical_timing(CALLER_ADDR0, ca=
ller_addr);
> + =A0 =A0 =A0 trace_preemptirqsoff_hist(IRQS_OFF, 1);
> =A0}
> =A0EXPORT_SYMBOL(trace_hardirqs_off_caller);
>
> @@ -503,12 +512,14 @@ EXPORT_SYMBOL(trace_hardirqs_off_caller)
> =A0#ifdef CONFIG_PREEMPT_TRACER
> =A0void trace_preempt_on(unsigned long a0, unsigned long a1)
> =A0{
> + =A0 =A0 =A0 trace_preemptirqsoff_hist(PREEMPT_ON, 0);
> =A0 =A0 =A0 =A0if (preempt_trace())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stop_critical_timing(a0, a1);
> =A0}
>
> =A0void trace_preempt_off(unsigned long a0, unsigned long a1)
> =A0{
> + =A0 =A0 =A0 trace_preemptirqsoff_hist(PREEMPT_OFF, 1);
> =A0 =A0 =A0 =A0if (preempt_trace())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start_critical_timing(a0, a1);
> =A0}
> Index: linux-2.6/localversion-rt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/localversion-rt
> +++ linux-2.6/localversion-rt
> @@ -1 +1 @@
> --rt3
> +-rt4
> Index: linux-2.6/arch/arm/common/gic.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/arm/common/gic.c
> +++ linux-2.6/arch/arm/common/gic.c
> @@ -33,7 +33,7 @@
> =A0#include <asm/mach/irq.h>
> =A0#include <asm/hardware/gic.h>
>
> -static DEFINE_SPINLOCK(irq_controller_lock);
> +static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>
> =A0/* Address of GIC 0 CPU interface */
> =A0void __iomem *gic_cpu_base_addr __read_mostly;
> @@ -88,30 +88,30 @@ static void gic_mask_irq(struct irq_data
> =A0{
> =A0 =A0 =A0 =A0u32 mask =3D 1 << (d->irq % 32);
>
> - =A0 =A0 =A0 spin_lock(&irq_controller_lock);
> + =A0 =A0 =A0 raw_spin_lock(&irq_controller_lock);
> =A0 =A0 =A0 =A0writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABL=
E_CLEAR + (gic_irq(d) / 32) * 4);
> =A0 =A0 =A0 =A0if (gic_arch_extn.irq_mask)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gic_arch_extn.irq_mask(d);
> - =A0 =A0 =A0 spin_unlock(&irq_controller_lock);
> + =A0 =A0 =A0 raw_spin_unlock(&irq_controller_lock);
> =A0}
>
> =A0static void gic_unmask_irq(struct irq_data *d)
> =A0{
> =A0 =A0 =A0 =A0u32 mask =3D 1 << (d->irq % 32);
>
> - =A0 =A0 =A0 spin_lock(&irq_controller_lock);
> + =A0 =A0 =A0 raw_spin_lock(&irq_controller_lock);
> =A0 =A0 =A0 =A0if (gic_arch_extn.irq_unmask)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gic_arch_extn.irq_unmask(d);
> =A0 =A0 =A0 =A0writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABL=
E_SET + (gic_irq(d) / 32) * 4);
> - =A0 =A0 =A0 spin_unlock(&irq_controller_lock);
> + =A0 =A0 =A0 raw_spin_unlock(&irq_controller_lock);
> =A0}
>
> =A0static void gic_eoi_irq(struct irq_data *d)
> =A0{
> =A0 =A0 =A0 =A0if (gic_arch_extn.irq_eoi) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&irq_controller_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_spin_lock(&irq_controller_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gic_arch_extn.irq_eoi(d);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&irq_controller_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_spin_unlock(&irq_controller_lock);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_E=
OI);
> @@ -135,7 +135,7 @@ static int gic_set_type(struct irq_data
> =A0 =A0 =A0 =A0if (type !=3D IRQ_TYPE_LEVEL_HIGH && type !=3D IRQ_TYP=
E_EDGE_RISING)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 spin_lock(&irq_controller_lock);
> + =A0 =A0 =A0 raw_spin_lock(&irq_controller_lock);
>
> =A0 =A0 =A0 =A0if (gic_arch_extn.irq_set_type)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gic_arch_extn.irq_set_type(d, type);
> @@ -160,7 +160,7 @@ static int gic_set_type(struct irq_data
> =A0 =A0 =A0 =A0if (enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writel_relaxed(enablemask, base + GIC_=
DIST_ENABLE_SET + enableoff);
>
> - =A0 =A0 =A0 spin_unlock(&irq_controller_lock);
> + =A0 =A0 =A0 raw_spin_unlock(&irq_controller_lock);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -188,11 +188,11 @@ static int gic_set_affinity(struct irq_d
> =A0 =A0 =A0 =A0mask =3D 0xff << shift;
> =A0 =A0 =A0 =A0bit =3D 1 << (cpu + shift);
>
> - =A0 =A0 =A0 spin_lock(&irq_controller_lock);
> + =A0 =A0 =A0 raw_spin_lock(&irq_controller_lock);
> =A0 =A0 =A0 =A0d->node =3D cpu;
> =A0 =A0 =A0 =A0val =3D readl_relaxed(reg) & ~mask;
> =A0 =A0 =A0 =A0writel_relaxed(val | bit, reg);
> - =A0 =A0 =A0 spin_unlock(&irq_controller_lock);
> + =A0 =A0 =A0 raw_spin_unlock(&irq_controller_lock);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -222,9 +222,9 @@ static void gic_handle_cascade_irq(unsig
>
> =A0 =A0 =A0 =A0chained_irq_enter(chip, desc);
>
> - =A0 =A0 =A0 spin_lock(&irq_controller_lock);
> + =A0 =A0 =A0 raw_spin_lock(&irq_controller_lock);
> =A0 =A0 =A0 =A0status =3D readl_relaxed(chip_data->cpu_base + GIC_CPU=
_INTACK);
> - =A0 =A0 =A0 spin_unlock(&irq_controller_lock);
> + =A0 =A0 =A0 raw_spin_unlock(&irq_controller_lock);
>
> =A0 =A0 =A0 =A0gic_irq =3D (status & 0x3ff);
> =A0 =A0 =A0 =A0if (gic_irq =3D=3D 1023)
> Index: linux-2.6/arch/arm/include/asm/mmu.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/arm/include/asm/mmu.h
> +++ linux-2.6/arch/arm/include/asm/mmu.h
> @@ -6,7 +6,7 @@
> =A0typedef struct {
> =A0#ifdef CONFIG_CPU_HAS_ASID
> =A0 =A0 =A0 =A0unsigned int id;
> - =A0 =A0 =A0 spinlock_t id_lock;
> + =A0 =A0 =A0 raw_spinlock_t id_lock;
> =A0#endif
> =A0 =A0 =A0 =A0unsigned int kvm_seq;
> =A0} mm_context_t;
> Index: linux-2.6/drivers/usb/gadget/ci13xxx_udc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/usb/gadget/ci13xxx_udc.c
> +++ linux-2.6/drivers/usb/gadget/ci13xxx_udc.c
> @@ -816,7 +816,7 @@ static struct {
> =A0} dbg_data =3D {
> =A0 =A0 =A0 =A0.idx =3D 0,
> =A0 =A0 =A0 =A0.tty =3D 0,
> - =A0 =A0 =A0 .lck =3D __RW_LOCK_UNLOCKED(lck)
> + =A0 =A0 =A0 .lck =3D __RW_LOCK_UNLOCKED(dbg_data.lck)
> =A0};
>
> =A0/**
> Index: linux-2.6/arch/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/Kconfig
> +++ linux-2.6/arch/Kconfig
> @@ -6,6 +6,7 @@ config OPROFILE
> =A0 =A0 =A0 =A0tristate "OProfile system profiling"
> =A0 =A0 =A0 =A0depends on PROFILING
> =A0 =A0 =A0 =A0depends on HAVE_OPROFILE
> + =A0 =A0 =A0 depends on !PREEMPT_RT_FULL
> =A0 =A0 =A0 =A0select RING_BUFFER
> =A0 =A0 =A0 =A0select RING_BUFFER_ALLOW_SWAP
> =A0 =A0 =A0 =A0help
> Index: linux-2.6/kernel/time/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/time/Kconfig
> +++ linux-2.6/kernel/time/Kconfig
> @@ -7,6 +7,7 @@ config TICK_ONESHOT
> =A0config NO_HZ
> =A0 =A0 =A0 =A0bool "Tickless System (Dynamic Ticks)"
> =A0 =A0 =A0 =A0depends on !ARCH_USES_GETTIMEOFFSET && GENERIC_CLOCKEV=
ENTS
> + =A0 =A0 =A0 depends on !PREEMPT_RT_FULL
> =A0 =A0 =A0 =A0select TICK_ONESHOT
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This option enables a tickless system: timer inter=
rupts will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
