From: Rolando Martins <rolando.martins@gmail.com>
Subject: Re: [ANNOUNCE] 3.0.6-rt17
Date: Fri, 7 Oct 2011 09:10:05 +0100
Message-ID: <CABcS5h3eJGRfzhA3YA0pxm_uyjksTv1uathF6+PwQfVYwaBR_A@mail.gmail.com>
References: <alpine.LFD.2.02.1110070046270.3240@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50352 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab1JGIKI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Oct 2011 04:10:08 -0400
In-Reply-To: <alpine.LFD.2.02.1110070046270.3240@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
I still experience a huge slowdown when enabling RT_GROUP with
rt_runtime_us=3D100 and rt_period_us=3D100.
Something that does not happen with mainline.
I tried with RCU prio boosting enabling and disable, without improvemen=
ts.
(dmesg does not print anything and system load is near 0)

Thanks for your efforts,
Rolando

On Fri, Oct 7, 2011 at 2:15 AM, Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.0.6-rt17 release.
>
> After chasing weird RCU stalls and hung task messages for quite some
> time a massive collaborative effort was able to track down and fix
> this showstopper. Explanation from the changelog:
>
> =A0 net: Avoid livelock in net_tx_action() on RT
>
> =A0 qdisc_lock is taken w/o disabling interrupts or bottom halfs. So =
code
> =A0 holding a qdisc_lock() can be interrupted and softirqs can run on=
 the
> =A0 return of interrupt in !RT.
>
> =A0 The spin_trylock() in net_tx_action() makes sure, that the softir=
q
> =A0 does not deadlock. When the lock can't be acquired q is requeued =
and
> =A0 the NET_TX softirq is raised. That causes the softirq to run over=
 and
> =A0 over.
>
> =A0 That works in mainline as do_softirq() has a retry loop limit and
> =A0 leaves the softirq processing in the interrupt return path and
> =A0 schedules ksoftirqd. The task which holds qdisc_lock cannot be
> =A0 preempted, so the lock is released and either ksoftirqd or the ne=
xt
> =A0 softirq in the return from interrupt path can proceed. Though it'=
s a
> =A0 bit strange to actually run MAX_SOFTIRQ_RESTART (10) loops before=
 it
> =A0 decides to bail out even if it's clear in the first iteration :)
>
> =A0 On RT all softirq processing is done in a FIFO thread and we don'=
t
> =A0 have a loop limit, so ksoftirqd preempts the lock holder forever =
and
> =A0 unqueues and requeues until the reset button is hit.
>
> =A0 Due to the forced threading of ksoftirqd on RT we actually cannot
> =A0 deadlock on qdisc_lock because it's a "sleeping lock". So it's sa=
fe to
> =A0 replace the spin_trylock() with a spin_lock(). When contended,
> =A0 ksoftirqd is scheduled out and the lock holder can proceed.
>
> Thanks to all involved in chasing that nasty issue down, which was
> unfortunately hard to reproduce. Thanks go to
>
> =A0 =A0- Carsten Emde for providing the initial debug data to narrow =
it
> =A0 =A0 =A0down, coming up with great ways of debugging it and happil=
y
> =A0 =A0 =A0testing whatever we came up with
>
> =A0 =A0- Steven Rostedt for coming up with the final debug patches wh=
ich
> =A0 =A0 =A0gave me a clue for decoding the issue and the now applied =
patch
> =A0 =A0 =A0which is much more cleaner than what I hacked together
>
> =A0 =A0- Paul McKenney for spending tons of time to discuss the RCU_B=
H
> =A0 =A0 =A0semantics in the light of RT with me and his findings that=
 we
> =A0 =A0 =A0need to bring back my initial patch (with a proper changel=
og -
> =A0 =A0 =A0written by Paul) and some additional fixups
>
> =A0 =A0- Peter Zijlstra for bearing with my bad mood and helping
> =A0 =A0 =A0analyzing all the findings. Peter finally decoded the mist=
ery
> =A0 =A0 =A0why the RT throttling mechanism did not detect that ksofti=
rqd
> =A0 =A0 =A0went into an infinite loop. As a result he provided an ama=
zingly
> =A0 =A0 =A0simple mechanism to make the RT overload detector going fr=
om
> =A0 =A0 =A0system wide to per cpu. We can now simply set the schedule=
r
> =A0 =A0 =A0feature RT_RUNTIME_SHARE to 0 which enables us to debug cp=
u
> =A0 =A0 =A0local RT hogs.
>
> =A0 =A0- Luis Claudio Goncalves for running whatever tests we came up
> =A0 =A0 =A0with on his reproducer machine
>
> Additional thanks go to
>
> =A0 =A0 - Frank Rowand who diligently runs each RT release through hi=
s
> =A0 =A0 =A0 seemingly endless supply of configs and testbeds and come=
s
> =A0 =A0 =A0 forth with fixes and enhancements with amazing speed!
>
> =A0 =A0 - OSADL and Carsten Emde for providing the invaluable service=
 of
> =A0 =A0 =A0 the RT QA farm
> =A0 =A0 =A0 (https://www.osadl.org/QA-Farm-Realtime.qa-farm-about.0.h=
tml)
> =A0 =A0 =A0 which provides longterm statistical data and when problem=
s
> =A0 =A0 =A0 arise always competent and helpful assistance for trackin=
g them
> =A0 =A0 =A0 down and providing fixes as his times allows.
>
> =A0 =A0 - Mike Galbraith for analyzing and decoding itty details all =
over
> =A0 =A0 =A0 the place.
>
> =A0 =A0 - all those who reported problems and provided debug data and
> =A0 =A0 =A0 fixes
>
>
> That said, here are the changes from 3.0.6-rt16 to 3.0.6-rt17
>
> =A0* Fix a livelock in net_tx_action (Steven Rostedt, myself)
>
> =A0* Bring back RCU_bh modifications with further fixups (Paul McKenn=
ey)
>
> =A0* Fix PF_THREAD_BOUND asymetry in workqueues
>
> =A0* UP compile fix (Frank Rowand)
>
> =A0* RT overload debug patch (Peter Zijlstra)
>
> =A0* Dropped a obsolete RCU protection fixup
>
> =A0* More IRQF_NO_THREAD annotations for powerpc
>
> Delta patch against 3.0.6-rt16
>
> =A0https://tglx.de/~tglx/rt/patch-3.0.6-rt16-rt17.patch.gz
>
> also appended below.
>
>
> Patch against 3.0.6 can be found here:
>
> =A0https://tglx.de/~tglx/rt/patch-3.0.6-rt17.patch.gz
>
>
> The split quilt queue is available at:
>
> =A0https://tglx.de/~tglx/rt/patches-3.0.6-rt17.tar.gz
>
> Enjoy,
>
> =A0 =A0 =A0 =A0tglx
>
> --------------->
> Index: linux-2.6/fs/ioprio.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/fs/ioprio.c
> +++ linux-2.6/fs/ioprio.c
> @@ -226,7 +226,6 @@ SYSCALL_DEFINE2(ioprio_get, int, which,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!user)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_lock();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_each_thread(g, p) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (__=
task_cred(p)->uid !=3D user->uid)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0continue;
> @@ -238,7 +237,6 @@ SYSCALL_DEFINE2(ioprio_get, int, which,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ret =3D ioprio_best(ret, tmpio);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} while_each_thread(g,=
 p);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (who)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_u=
id(user);
> Index: linux-2.6/include/linux/rcupdate.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/rcupdate.h
> +++ linux-2.6/include/linux/rcupdate.h
> @@ -78,7 +78,13 @@ struct rcu_head {
> =A0extern void call_rcu_sched(struct rcu_head *head,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void (*func)(stru=
ct rcu_head *rcu));
> =A0extern void synchronize_sched(void);
> +
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +# define rcu_barrier_bh =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rcu_barrier
> +#else
> =A0extern void rcu_barrier_bh(void);
> +#endif
> +
> =A0extern void rcu_barrier_sched(void);
>
> =A0static inline void __rcu_read_lock_bh(void)
> @@ -229,7 +235,14 @@ static inline int rcu_read_lock_held(voi
> =A0* rcu_read_lock_bh_held() is defined out of line to avoid #include=
-file
> =A0* hell.
> =A0*/
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +static inline int rcu_read_lock_bh_held(void)
> +{
> + =A0 =A0 =A0 return rcu_read_lock_held();
> +}
> +#else
> =A0extern int rcu_read_lock_bh_held(void);
> +#endif
>
> =A0/**
> =A0* rcu_read_lock_sched_held() - might we be in RCU-sched read-side =
critical section?
> @@ -638,8 +651,13 @@ static inline void rcu_read_unlock(void)
> =A0static inline void rcu_read_lock_bh(void)
> =A0{
> =A0 =A0 =A0 =A0__rcu_read_lock_bh();
> +
> +#ifdef CONFIG_PREEMPT_RT_FULL
> + =A0 =A0 =A0 rcu_read_lock();
> +#else
> =A0 =A0 =A0 =A0__acquire(RCU_BH);
> =A0 =A0 =A0 =A0rcu_read_acquire_bh();
> +#endif
> =A0}
>
> =A0/*
> @@ -649,8 +667,12 @@ static inline void rcu_read_lock_bh(void
> =A0*/
> =A0static inline void rcu_read_unlock_bh(void)
> =A0{
> +#ifdef CONFIG_PREEMPT_RT_FULL
> + =A0 =A0 =A0 rcu_read_unlock();
> +#else
> =A0 =A0 =A0 =A0rcu_read_release_bh();
> =A0 =A0 =A0 =A0__release(RCU_BH);
> +#endif
> =A0 =A0 =A0 =A0__rcu_read_unlock_bh();
> =A0}
>
> @@ -757,6 +779,9 @@ extern void call_rcu(struct rcu_head *he
>
> =A0#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +#define call_rcu_bh =A0 =A0call_rcu
> +#else
> =A0/**
> =A0* call_rcu_bh() - Queue an RCU for invocation after a quicker grac=
e period.
> =A0* @head: structure to be used for queueing the RCU updates.
> @@ -777,6 +802,7 @@ extern void call_rcu(struct rcu_head *he
> =A0*/
> =A0extern void call_rcu_bh(struct rcu_head *head,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void (*func)(struct rc=
u_head *head));
> +#endif
>
> =A0/*
> =A0* debug_rcu_head_queue()/debug_rcu_head_unqueue() are used interna=
lly
> Index: linux-2.6/kernel/rcutree.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/rcutree.c
> +++ linux-2.6/kernel/rcutree.c
> @@ -166,6 +166,12 @@ void rcu_sched_qs(int cpu)
> =A0 =A0 =A0 =A0rdp->passed_quiesc =3D 1;
> =A0}
>
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +void rcu_bh_qs(int cpu)
> +{
> + =A0 =A0 =A0 rcu_preempt_qs(cpu);
> +}
> +#else
> =A0void rcu_bh_qs(int cpu)
> =A0{
> =A0 =A0 =A0 =A0struct rcu_data *rdp =3D &per_cpu(rcu_bh_data, cpu);
> @@ -174,6 +180,7 @@ void rcu_bh_qs(int cpu)
> =A0 =A0 =A0 =A0barrier();
> =A0 =A0 =A0 =A0rdp->passed_quiesc =3D 1;
> =A0}
> +#endif
>
> =A0/*
> =A0* Note a context switch. =A0This is a quiescent state for RCU-sche=
d,
> @@ -216,6 +223,7 @@ long rcu_batches_completed_sched(void)
> =A0}
> =A0EXPORT_SYMBOL_GPL(rcu_batches_completed_sched);
>
> +#ifndef CONFIG_PREEMPT_RT_FULL
> =A0/*
> =A0* Return the number of RCU BH batches processed thus far for debug=
 & stats.
> =A0*/
> @@ -233,6 +241,7 @@ void rcu_bh_force_quiescent_state(void)
> =A0 =A0 =A0 =A0force_quiescent_state(&rcu_bh_state, 0);
> =A0}
> =A0EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
> +#endif
>
> =A0/*
> =A0* Record the number of times rcutorture tests have been initiated =
and
> @@ -1579,6 +1588,7 @@ void call_rcu_sched(struct rcu_head *hea
> =A0}
> =A0EXPORT_SYMBOL_GPL(call_rcu_sched);
>
> +#ifndef CONFIG_PREEMPT_RT_FULL
> =A0/*
> =A0* Queue an RCU for invocation after a quicker grace period.
> =A0*/
> @@ -1587,6 +1597,7 @@ void call_rcu_bh(struct rcu_head *head,
> =A0 =A0 =A0 =A0__call_rcu(head, func, &rcu_bh_state);
> =A0}
> =A0EXPORT_SYMBOL_GPL(call_rcu_bh);
> +#endif
>
> =A0/**
> =A0* synchronize_sched - wait until an rcu-sched grace period has ela=
psed.
> @@ -1628,6 +1639,7 @@ void synchronize_sched(void)
> =A0}
> =A0EXPORT_SYMBOL_GPL(synchronize_sched);
>
> +#ifndef CONFIG_PREEMPT_RT_FULL
> =A0/**
> =A0* synchronize_rcu_bh - wait until an rcu_bh grace period has elaps=
ed.
> =A0*
> @@ -1653,6 +1665,7 @@ void synchronize_rcu_bh(void)
> =A0 =A0 =A0 =A0destroy_rcu_head_on_stack(&rcu.head);
> =A0}
> =A0EXPORT_SYMBOL_GPL(synchronize_rcu_bh);
> +#endif
>
> =A0/*
> =A0* Check to see if there is any immediate RCU-related work to be do=
ne
> @@ -1806,6 +1819,7 @@ static void _rcu_barrier(struct rcu_stat
> =A0 =A0 =A0 =A0mutex_unlock(&rcu_barrier_mutex);
> =A0}
>
> +#ifndef CONFIG_PREEMPT_RT_FULL
> =A0/**
> =A0* rcu_barrier_bh - Wait until all in-flight call_rcu_bh() callback=
s complete.
> =A0*/
> @@ -1814,6 +1828,7 @@ void rcu_barrier_bh(void)
> =A0 =A0 =A0 =A0_rcu_barrier(&rcu_bh_state, call_rcu_bh);
> =A0}
> =A0EXPORT_SYMBOL_GPL(rcu_barrier_bh);
> +#endif
>
> =A0/**
> =A0* rcu_barrier_sched - Wait for in-flight call_rcu_sched() callback=
s.
> Index: linux-2.6/kernel/rcutree.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/rcutree.h
> +++ linux-2.6/kernel/rcutree.h
> @@ -422,6 +422,7 @@ DECLARE_PER_CPU(struct rcu_data, rcu_pre
> =A0/* Forward declarations for rcutree_plugin.h */
> =A0static void rcu_bootup_announce(void);
> =A0long rcu_batches_completed(void);
> +static void rcu_preempt_qs(int cpu);
> =A0static void rcu_preempt_note_context_switch(int cpu);
> =A0static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp);
> =A0#ifdef CONFIG_HOTPLUG_CPU
> Index: linux-2.6/kernel/rcutree_plugin.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/rcutree_plugin.h
> +++ linux-2.6/kernel/rcutree_plugin.h
> @@ -1892,7 +1892,7 @@ EXPORT_SYMBOL_GPL(synchronize_sched_expe
>
> =A0#endif /* #else #ifndef CONFIG_SMP */
>
> -#if !defined(CONFIG_RCU_FAST_NO_HZ)
> +#if 1 /* !defined(CONFIG_RCU_FAST_NO_HZ) */
>
> =A0/*
> =A0* Check to see if any future RCU-related work will need to be done
> Index: linux-2.6/kernel/rtmutex-debug.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/rtmutex-debug.h
> +++ linux-2.6/kernel/rtmutex-debug.h
> @@ -17,17 +17,17 @@ extern void debug_rt_mutex_free_waiter(s
> =A0extern void debug_rt_mutex_init(struct rt_mutex *lock, const char =
*name);
> =A0extern void debug_rt_mutex_lock(struct rt_mutex *lock);
> =A0extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
> -extern void
> -debug_rt_mutex_proxy_lock(struct rt_mutex *lock, struct task_struct =
*powner);
> +extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct task_struct *powner);
> =A0extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
> =A0extern void debug_rt_mutex_deadlock(int detect, struct rt_mutex_wa=
iter *waiter,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct rt_mutex *lock);
> =A0extern void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *=
waiter);
> -# define debug_rt_mutex_reset_waiter(w) \
> +# define debug_rt_mutex_reset_waiter(w) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0do { (w)->deadlock_lock =3D NULL; } while (0)
>
> -static inline int
> -debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter, int d=
etect)
> +static inline int debug_rt_mutex_detect_deadlock(struct rt_mutex_wai=
ter *waiter,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0int detect)
> =A0{
> - =A0 =A0 =A0 return waiter !=3D NULL;
> + =A0 =A0 =A0 return (waiter !=3D NULL);
> =A0}
> Index: linux-2.6/kernel/sched.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/sched.c
> +++ linux-2.6/kernel/sched.c
> @@ -2822,7 +2822,7 @@ static void __sched_fork(struct task_str
> =A0void sched_fork(struct task_struct *p)
> =A0{
> =A0 =A0 =A0 =A0unsigned long flags;
> - =A0 =A0 =A0 int cpu;
> + =A0 =A0 =A0 int cpu =3D get_cpu();
>
> =A0 =A0 =A0 =A0__sched_fork(p);
> =A0 =A0 =A0 =A0/*
> @@ -2862,7 +2862,6 @@ void sched_fork(struct task_struct *p)
> =A0 =A0 =A0 =A0if (!rt_prio(p->prio))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p->sched_class =3D &fair_sched_class;
>
> - =A0 =A0 =A0 cpu =3D get_cpu();
> =A0 =A0 =A0 =A0if (p->sched_class->task_fork)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p->sched_class->task_fork(p);
>
> @@ -2874,9 +2873,8 @@ void sched_fork(struct task_struct *p)
> =A0 =A0 =A0 =A0 * Silence PROVE_RCU.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0raw_spin_lock_irqsave(&p->pi_lock, flags);
> - =A0 =A0 =A0 set_task_cpu(p, smp_processor_id());
> + =A0 =A0 =A0 set_task_cpu(p, cpu);
> =A0 =A0 =A0 =A0raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> - =A0 =A0 =A0 put_cpu();
>
> =A0#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
> =A0 =A0 =A0 =A0if (likely(sched_info_on()))
> @@ -2892,6 +2890,8 @@ void sched_fork(struct task_struct *p)
> =A0#ifdef CONFIG_SMP
> =A0 =A0 =A0 =A0plist_node_init(&p->pushable_tasks, MAX_PRIO);
> =A0#endif
> +
> + =A0 =A0 =A0 put_cpu();
> =A0}
>
> =A0/*
> @@ -4207,7 +4207,7 @@ static inline void schedule_debug(struct
> =A0 =A0 =A0 =A0schedstat_inc(this_rq(), sched_count);
> =A0}
>
> -#ifdef CONFIG_PREEMPT_RT_FULL
> +#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
> =A0#define MIGRATE_DISABLE_SET_AFFIN =A0 =A0 =A0(1<<30) /* Can't make=
 a negative */
> =A0#define migrate_disabled_updated(p) =A0 =A0((p)->migrate_disable &=
 MIGRATE_DISABLE_SET_AFFIN)
> =A0#define migrate_disable_count(p) =A0 =A0 =A0 ((p)->migrate_disable=
 & ~MIGRATE_DISABLE_SET_AFFIN)
> Index: linux-2.6/kernel/sched_features.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/sched_features.h
> +++ linux-2.6/kernel/sched_features.h
> @@ -76,3 +76,4 @@ SCHED_FEAT(TTWU_QUEUE, 0)
> =A0#endif
>
> =A0SCHED_FEAT(FORCE_SD_OVERLAP, 0)
> +SCHED_FEAT(RT_RUNTIME_SHARE, 1)
> Index: linux-2.6/kernel/sched_rt.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/sched_rt.c
> +++ linux-2.6/kernel/sched_rt.c
> @@ -536,6 +536,9 @@ static int balance_runtime(struct rt_rq
> =A0{
> =A0 =A0 =A0 =A0int more =3D 0;
>
> + =A0 =A0 =A0 if (!sched_feat(RT_RUNTIME_SHARE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return more;
> +
> =A0 =A0 =A0 =A0if (rt_rq->rt_time > rt_rq->rt_runtime) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_spin_unlock(&rt_rq->rt_runtime_loc=
k);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0more =3D do_balance_runtime(rt_rq);
> Index: linux-2.6/kernel/softirq.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/softirq.c
> +++ linux-2.6/kernel/softirq.c
> @@ -138,7 +138,7 @@ static void wakeup_softirqd(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wake_up_process(tsk);
> =A0}
>
> -static void handle_pending_softirqs(u32 pending, int cpu)
> +static void handle_pending_softirqs(u32 pending, int cpu, int need_r=
cu_bh_qs)
> =A0{
> =A0 =A0 =A0 =A0struct softirq_action *h =3D softirq_vec;
> =A0 =A0 =A0 =A0unsigned int prev_count =3D preempt_count();
> @@ -161,7 +161,8 @@ static void handle_pending_softirqs(u32
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev_coun=
t, (unsigned int) preempt_count());
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0preempt_count() =3D pr=
ev_count;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_bh_qs(cpu);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (need_rcu_bh_qs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_bh_qs(cpu);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0local_irq_disable();
> =A0}
> @@ -313,7 +314,7 @@ restart:
> =A0 =A0 =A0 =A0/* Reset the pending bitmask before enabling irqs */
> =A0 =A0 =A0 =A0set_softirq_pending(0);
>
> - =A0 =A0 =A0 handle_pending_softirqs(pending, cpu);
> + =A0 =A0 =A0 handle_pending_softirqs(pending, cpu, 1);
>
> =A0 =A0 =A0 =A0pending =3D local_softirq_pending();
> =A0 =A0 =A0 =A0if (pending && --max_restart)
> @@ -383,7 +384,12 @@ static inline void ksoftirqd_clr_sched_p
> =A0static DEFINE_LOCAL_IRQ_LOCK(local_softirq_lock);
> =A0static DEFINE_PER_CPU(struct task_struct *, local_softirq_runner);
>
> -static void __do_softirq(void);
> +static void __do_softirq_common(int need_rcu_bh_qs);
> +
> +void __do_softirq(void)
> +{
> + =A0 =A0 =A0 __do_softirq_common(0);
> +}
>
> =A0void __init softirq_early_init(void)
> =A0{
> @@ -446,7 +452,7 @@ int in_serving_softirq(void)
> =A0* Called with bh and local interrupts disabled. For full RT cpu mu=
st
> =A0* be pinned.
> =A0*/
> -static void __do_softirq(void)
> +static void __do_softirq_common(int need_rcu_bh_qs)
> =A0{
> =A0 =A0 =A0 =A0u32 pending =3D local_softirq_pending();
> =A0 =A0 =A0 =A0int cpu =3D smp_processor_id();
> @@ -460,7 +466,7 @@ static void __do_softirq(void)
>
> =A0 =A0 =A0 =A0lockdep_softirq_enter();
>
> - =A0 =A0 =A0 handle_pending_softirqs(pending, cpu);
> + =A0 =A0 =A0 handle_pending_softirqs(pending, cpu, need_rcu_bh_qs);
>
> =A0 =A0 =A0 =A0pending =3D local_softirq_pending();
> =A0 =A0 =A0 =A0if (pending)
> @@ -499,7 +505,7 @@ static int __thread_do_softirq(int cpu)
> =A0 =A0 =A0 =A0 * schedule!
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (local_softirq_pending())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __do_softirq();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __do_softirq_common(cpu >=3D 0);
> =A0 =A0 =A0 =A0local_unlock(local_softirq_lock);
> =A0 =A0 =A0 =A0unpin_current_cpu();
> =A0 =A0 =A0 =A0preempt_disable();
> Index: linux-2.6/kernel/workqueue.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/workqueue.c
> +++ linux-2.6/kernel/workqueue.c
> @@ -1277,22 +1277,22 @@ __acquires(&gcwq->lock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * it races with cpu hotunplug operati=
on. =A0Verify
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * against GCWQ_DISASSOCIATED.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(gcwq->flags & GCWQ_DISASSOCIATED)=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Since we're bindin=
g to a particular cpu and need to
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* stay there for cor=
rectness, mark us PF_THREAD_BOUND.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 task->flags |=3D PF_THR=
EAD_BOUND;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(gcwq->flags & GCWQ_DISASSOCIATED)=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_cpus_allowed_ptr(t=
ask, get_cpu_mask(gcwq->cpu));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irq(&gcwq->lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gcwq->flags & GCWQ_DISASSOCIATED)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return false;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (task_cpu(task) =3D=3D gcwq->cpu &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpumask_equal(&current->cpus_a=
llowed,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get=
_cpu_mask(gcwq->cpu)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get=
_cpu_mask(gcwq->cpu))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Since we're bindin=
g to a particular cpu and need to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* stay there for cor=
rectness, mark us PF_THREAD_BOUND.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 task->flags |=3D PF_THR=
EAD_BOUND;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(&gcwq->lock);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> Index: linux-2.6/localversion-rt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/localversion-rt
> +++ linux-2.6/localversion-rt
> @@ -1 +1 @@
> --rt16
> +-rt17
> Index: linux-2.6/net/core/dev.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/net/core/dev.c
> +++ linux-2.6/net/core/dev.c
> @@ -2912,6 +2912,36 @@ int netif_rx_ni(struct sk_buff *skb)
> =A0}
> =A0EXPORT_SYMBOL(netif_rx_ni);
>
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +/*
> + * RT runs ksoftirqd as a real time thread and the root_lock is a
> + * "sleeping spinlock". If the trylock fails then we can go into an
> + * infinite loop when ksoftirqd preempted the task which actually
> + * holds the lock, because we requeue q and raise NET_TX softirq
> + * causing ksoftirqd to loop forever.
> + *
> + * It's safe to use spin_lock on RT here as softirqs run in thread
> + * context and cannot deadlock against the thread which is holding
> + * root_lock.
> + *
> + * On !RT the trylock might fail, but there we bail out from the
> + * softirq loop after 10 attempts which we can't do on RT. And the
> + * task holding root_lock cannot be preempted, so the only downside =
of
> + * that trylock is that we need 10 loops to decide that we should ha=
ve
> + * given up in the first one :)
> + */
> +static inline int take_root_lock(spinlock_t *lock)
> +{
> + =A0 =A0 =A0 spin_lock(lock);
> + =A0 =A0 =A0 return 1;
> +}
> +#else
> +static inline int take_root_lock(spinlock_t *lock)
> +{
> + =A0 =A0 =A0 return spin_trylock(lock);
> +}
> +#endif
> +
> =A0static void net_tx_action(struct softirq_action *h)
> =A0{
> =A0 =A0 =A0 =A0struct softnet_data *sd =3D &__get_cpu_var(softnet_dat=
a);
> @@ -2950,7 +2980,7 @@ static void net_tx_action(struct softirq
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0head =3D head->next_sc=
hed;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0root_lock =3D qdisc_lo=
ck(q);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spin_trylock(root_l=
ock)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (take_root_lock(root=
_lock)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0smp_mb=
__before_clear_bit();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clear_=
bit(__QDISC_STATE_SCHED,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0&q->state);
> Index: linux-2.6/arch/powerpc/platforms/wsp/opb_pic.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/platforms/wsp/opb_pic.c
> +++ linux-2.6/arch/powerpc/platforms/wsp/opb_pic.c
> @@ -320,7 +320,8 @@ void __init opb_pic_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Attach opb interrupt handler to new=
 virtual IRQ */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D request_irq(virq, opb_irq_handle=
r, 0, "OPB LS Cascade", opb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D request_irq(virq, opb_irq_handle=
r, IRQF_NO_THREAD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"OPB=
 LS Cascade", opb);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rc) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("opb: request_i=
rq failed: %d\n", rc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> Index: linux-2.6/arch/powerpc/kernel/smp.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/kernel/smp.c
> +++ linux-2.6/arch/powerpc/kernel/smp.c
> @@ -170,7 +170,7 @@ int smp_request_message_ipi(int virq, in
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0}
> =A0#endif
> - =A0 =A0 =A0 err =3D request_irq(virq, smp_ipi_action[msg], IRQF_DIS=
ABLED|IRQF_PERCPU,
> + =A0 =A0 =A0 err =3D request_irq(virq, smp_ipi_action[msg], IRQF_NO_=
THREAD|IRQF_PERCPU,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0smp_ipi_name[msg],=
 0);
> =A0 =A0 =A0 =A0WARN(err < 0, "unable to request_irq %d for %s (rc %d)=
\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0virq, smp_ipi_name[msg], err);
> Index: linux-2.6/arch/powerpc/platforms/powermac/smp.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/platforms/powermac/smp.c
> +++ linux-2.6/arch/powerpc/platforms/powermac/smp.c
> @@ -200,7 +200,7 @@ static int psurge_secondary_ipi_init(voi
>
> =A0 =A0 =A0 =A0if (psurge_secondary_virq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rc =3D request_irq(psurge_secondary_vi=
rq, psurge_ipi_intr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_DISABLED|IRQF_PERC=
PU, "IPI", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_NO_THREAD|IRQF_PER=
CPU, "IPI", NULL);
>
> =A0 =A0 =A0 =A0if (rc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("Failed to setup secondary cpu =
IPI\n");
> @@ -408,7 +408,7 @@ static int __init smp_psurge_kick_cpu(in
>
> =A0static struct irqaction psurge_irqaction =3D {
> =A0 =A0 =A0 =A0.handler =3D psurge_ipi_intr,
> - =A0 =A0 =A0 .flags =3D IRQF_DISABLED|IRQF_PERCPU,
> + =A0 =A0 =A0 .flags =3D IRQF_NO_THREAD|IRQF_PERCPU,
> =A0 =A0 =A0 =A0.name =3D "primary IPI",
> =A0};
>
> Index: linux-2.6/arch/powerpc/sysdev/xics/xics-common.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/sysdev/xics/xics-common.c
> +++ linux-2.6/arch/powerpc/sysdev/xics/xics-common.c
> @@ -134,11 +134,11 @@ static void xics_request_ipi(void)
> =A0 =A0 =A0 =A0BUG_ON(ipi =3D=3D NO_IRQ);
>
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* IPIs are marked IRQF_DISABLED as they must run wit=
h irqs
> - =A0 =A0 =A0 =A0* disabled, and PERCPU. =A0The handler was set in ma=
p.
> + =A0 =A0 =A0 =A0* IPIs are marked PERCPU and also IRQF_NO_THREAD as =
they must
> + =A0 =A0 =A0 =A0* run in hard interrupt context. The handler was set=
 in map.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0BUG_ON(request_irq(ipi, icp_ops->ipi_action,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_DISABLED|IR=
QF_PERCPU, "IPI", NULL));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_NO_THREAD|I=
RQF_PERCPU, "IPI", NULL));
> =A0}
>
> =A0int __init xics_smp_probe(void)
> Index: linux-2.6/include/linux/rcutree.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/rcutree.h
> +++ linux-2.6/include/linux/rcutree.h
> @@ -57,7 +57,11 @@ static inline void exit_rcu(void)
>
> =A0#endif /* #else #ifdef CONFIG_TREE_PREEMPT_RCU */
>
> +#ifndef CONFIG_PREEMPT_RT_FULL
> =A0extern void synchronize_rcu_bh(void);
> +#else
> +# define synchronize_rcu_bh() =A0synchronize_rcu()
> +#endif
> =A0extern void synchronize_sched_expedited(void);
> =A0extern void synchronize_rcu_expedited(void);
>
> @@ -71,13 +75,19 @@ extern void rcu_barrier(void);
> =A0extern unsigned long rcutorture_testseq;
> =A0extern unsigned long rcutorture_vernum;
> =A0extern long rcu_batches_completed(void);
> -extern long rcu_batches_completed_bh(void);
> =A0extern long rcu_batches_completed_sched(void);
>
> =A0extern void rcu_force_quiescent_state(void);
> -extern void rcu_bh_force_quiescent_state(void);
> =A0extern void rcu_sched_force_quiescent_state(void);
>
> +#ifndef CONFIG_PREEMPT_RT_FULL
> +extern void rcu_bh_force_quiescent_state(void);
> +extern long rcu_batches_completed_bh(void);
> +#else
> +# define rcu_bh_force_quiescent_state =A0rcu_force_quiescent_state
> +# define rcu_batches_completed_bh =A0 =A0 =A0rcu_batches_completed
> +#endif
> +
> =A0/* A context switch is a grace period for RCU-sched and RCU-bh. */
> =A0static inline int rcu_blocking_is_gp(void)
> =A0{
> Index: linux-2.6/kernel/rcupdate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/rcupdate.c
> +++ linux-2.6/kernel/rcupdate.c
> @@ -72,6 +72,7 @@ int debug_lockdep_rcu_enabled(void)
> =A0}
> =A0EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
>
> +#ifndef CONFIG_PREEMPT_RT_FULL
> =A0/**
> =A0* rcu_read_lock_bh_held() - might we be in RCU-bh read-side critic=
al section?
> =A0*
> @@ -91,6 +92,7 @@ int rcu_read_lock_bh_held(void)
> =A0 =A0 =A0 =A0return in_softirq() || irqs_disabled();
> =A0}
> =A0EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
> +#endif
>
> =A0#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>
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
