From: Rolando Martins <rolando.martins@gmail.com>
Subject: Re: [ANNOUNCE] 3.0.7-rt20
Date: Wed, 19 Oct 2011 15:17:34 +0100
Message-ID: <CABcS5h2kDgTAD_nP0paw8=SFfyYT5B4zZBPHj_6MP0LeyAdR9A@mail.gmail.com>
References: <alpine.LFD.2.02.1110191150280.3240@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54903 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab1JSOWJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Oct 2011 10:22:09 -0400
In-Reply-To: <alpine.LFD.2.02.1110191150280.3240@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi to all,
this fixed my issues with cgroups and RT_GROUP_SCHED.
A big thanks to the RT maintainers, specially to Peter Zijlstra.
This patch provides the best performance I ever experience while using
RT_GROUP_SCHED!

Thanks,
Rolando

> =A0* Fix a long standing RT throttling problem with cgroups and
> =A0 =A0RT_GROUP_SCHED (Peter Zijlstra, Thanks to Carsten Emde for
> =A0 =A0providing the debug information!)


On Wed, Oct 19, 2011 at 10:59 AM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.0.7-rt20 release.
>
> 3.0.7-rt19 is an not announced intermediate release, which only
> updates to 3.0.7. No rt changes except dropping patches which made it
> into 3.0.7.
>
> Changes from 3.0.7-rt19 to 3.0.7-rt20
>
> =A0* Fix a long standing RT throttling problem with cgroups and
> =A0 =A0RT_GROUP_SCHED (Peter Zijlstra, Thanks to Carsten Emde for
> =A0 =A0providing the debug information!)
>
> =A0* Minor fixes (Yong Zhang)
>
> Delta patch against 3.0.7-rt19
>
> =A0https://tglx.de/~tglx/rt/patch-3.0.7-rt19-rt20.patch.gz
>
> also appended below.
>
>
> Patch against 3.0.7 can be found here:
>
> =A0https://tglx.de/~tglx/rt/patch-3.0.7-rt20.patch.gz
>
>
> The split quilt queue is available at:
>
> =A0https://tglx.de/~tglx/rt/patches-3.0.7-rt20.tar.gz
>
> Known issues:
>
> =A0Yong discovered a non critical cpuhotplug problem, which needs som=
e
> =A0more thought. Will try to address that in the next days as traveli=
ng
> =A0allows (about to head to Prague for a long RTLWS/KS/LinuxCon/ELCE
> =A0week).
>
> Enjoy,
>
> =A0 =A0 =A0 =A0tglx
>
> --------------->
> Index: linux-2.6/kernel/cpu.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/cpu.c
> +++ linux-2.6/kernel/cpu.c
> @@ -139,7 +139,7 @@ static int cpu_unplug_begin(unsigned int
> =A0 =A0 =A0 =A0struct task_struct *tsk;
>
> =A0 =A0 =A0 =A0init_completion(&hp->synced);
> - =A0 =A0 =A0 tsk =3D kthread_create(sync_unplug_thread, hp, "sync_un=
plug/%d\n", cpu);
> + =A0 =A0 =A0 tsk =3D kthread_create(sync_unplug_thread, hp, "sync_un=
plug/%d", cpu);
> =A0 =A0 =A0 =A0if (IS_ERR(tsk))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return (PTR_ERR(tsk));
> =A0 =A0 =A0 =A0kthread_bind(tsk, cpu);
> Index: linux-2.6/kernel/printk.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/printk.c
> +++ linux-2.6/kernel/printk.c
> @@ -1282,8 +1282,8 @@ void printk_tick(void)
>
> =A0int printk_needs_cpu(int cpu)
> =A0{
> - =A0 =A0 =A0 if (cpu_is_offline(cpu))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk_tick();
> + =A0 =A0 =A0 if (unlikely(cpu_is_offline(cpu)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __this_cpu_write(printk_pending, 0);
> =A0 =A0 =A0 =A0return __this_cpu_read(printk_pending);
> =A0}
>
> Index: linux-2.6/kernel/sched_rt.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/sched_rt.c
> +++ linux-2.6/kernel/sched_rt.c
> @@ -556,12 +556,9 @@ static inline int balance_runtime(struct
>
> =A0static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int=
 overrun)
> =A0{
> - =A0 =A0 =A0 int i, idle =3D 1;
> + =A0 =A0 =A0 int i, idle =3D 1, throttled =3D 0;
> =A0 =A0 =A0 =A0const struct cpumask *span;
>
> - =A0 =A0 =A0 if (!rt_bandwidth_enabled() || rt_b->rt_runtime =3D=3D =
RUNTIME_INF)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> -
> =A0 =A0 =A0 =A0span =3D sched_rt_period_mask();
> =A0 =A0 =A0 =A0for_each_cpu(i, span) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int enqueue =3D 0;
> @@ -596,12 +593,17 @@ static int do_sched_rt_period_timer(stru
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!rt_rq_throttled(r=
t_rq))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enqueu=
e =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rt_rq->rt_throttled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 throttled =3D 1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (enqueue)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sched_rt_rq_enqueue(rt=
_rq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_spin_unlock(&rq->lock);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (!throttled && (!rt_bandwidth_enabled() || rt_b->rt_=
runtime =3D=3D RUNTIME_INF))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> =A0 =A0 =A0 =A0return idle;
> =A0}
>
> @@ -633,8 +635,24 @@ static int sched_rt_runtime_exceeded(str
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0if (rt_rq->rt_time > runtime) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt_rq->rt_throttled =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk_once(KERN_WARNING "sched: RT thr=
ottling activated\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct rt_bandwidth *rt_b =3D sched_rt_=
bandwidth(rt_rq);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Don't actually throttle groups tha=
t have no runtime assigned
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* but accrue some time due to boosti=
ng.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (likely(rt_b->rt_runtime)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt_rq->rt_throttled =3D=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk_once(KERN_WARNIN=
G "sched: RT throttling activated\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In case we did any=
way, make it go away,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* replenishment is a=
 joke, since it will replenish us
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with exactly 0 ns.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt_rq->rt_time =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rt_rq_throttled(rt_rq)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sched_rt_rq_dequeue(rt=
_rq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> @@ -662,7 +680,8 @@ static void update_curr_rt(struct rq *rq
> =A0 =A0 =A0 =A0if (unlikely((s64)delta_exec < 0))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0delta_exec =3D 0;
>
> - =A0 =A0 =A0 schedstat_set(curr->se.statistics.exec_max, max(curr->s=
e.statistics.exec_max, delta_exec));
> + =A0 =A0 =A0 schedstat_set(curr->se.statistics.exec_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max(curr->se.statistics.exe=
c_max, delta_exec));
>
> =A0 =A0 =A0 =A0curr->se.sum_exec_runtime +=3D delta_exec;
> =A0 =A0 =A0 =A0account_group_exec_runtime(curr, delta_exec);
> Index: linux-2.6/kernel/workqueue.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/workqueue.c
> +++ linux-2.6/kernel/workqueue.c
> @@ -3274,14 +3274,14 @@ static void flush_gcwq(struct global_cwq
>
> =A0 =A0 =A0 =A0spin_unlock_irq(&gcwq->lock);
>
> - =A0 =A0 =A0 gcwq =3D get_gcwq(get_cpu());
> + =A0 =A0 =A0 gcwq =3D get_gcwq(get_cpu_light());
> =A0 =A0 =A0 =A0spin_lock_irq(&gcwq->lock);
> =A0 =A0 =A0 =A0list_for_each_entry_safe(work, nw, &non_affine_works, =
entry) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_del_init(&work->entry);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0___queue_work(get_work_cwq(work)->wq, =
gcwq, work);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0spin_unlock_irq(&gcwq->lock);
> - =A0 =A0 =A0 put_cpu();
> + =A0 =A0 =A0 put_cpu_light();
> =A0}
>
> =A0static int __devinit workqueue_cpu_down_callback(struct notifier_b=
lock *nfb,
> Index: linux-2.6/localversion-rt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/localversion-rt
> +++ linux-2.6/localversion-rt
> @@ -1 +1 @@
> --rt19
> +-rt20
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
