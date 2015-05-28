From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [ANNOUNCE] 3.14.39-rt38
Date: Thu, 28 May 2015 11:05:58 -0400
Message-ID: <55672ED6.4070504@windriver.com>
References: <20150520105535.63704e6b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41066 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbbE1PGe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 May 2015 11:06:34 -0400
In-Reply-To: <20150520105535.63704e6b@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 15-05-20 10:55 AM, Steven Rostedt wrote:
>=20
> Dear RT Folks,
>=20
> I'm pleased to announce the 3.14.39-rt38 stable release.

[...]

>=20
> Changes from v3.14.39-rt37:
>=20
> ---
>=20
> Marcelo Tosatti (2):
>       KVM: lapic: mark LAPIC timer handler as irqsafe
>       KVM: use simple waitqueue for vcpu->wq
>=20
> Mike Galbraith (2):
>       hotplug: Use set_cpus_allowed_ptr() in sync_unplug_thread()
>       rt, nohz_full: fix nohz_full for PREEMPT_RT_FULL
>=20
> Sebastian Andrzej Siewior (1):
>       kernel/irq_work: fix no_hz deadlock

Seems we can't use this commit above as-is on 3.14 (and earlier?)
since we'll get this:

kernel/time/tick-sched.c: In function =91can_stop_full_tick=92:
kernel/time/tick-sched.c:183:2: error: implicit declaration of function=
 =91arch_irq_work_has_interrupt=92 [-Werror=3Dimplicit-function-declara=
tion]
  if (!arch_irq_work_has_interrupt()) {
  ^
cc1: some warnings being treated as errors
make[2]: *** [kernel/time/tick-sched.o] Error 1

Problem arises because that fcn doesn't come in until 3.18+ with
the merge v3.18-rc1~114 (in the 2nd commit):

git log --oneline --reverse v3.18-rc1~114^2 ^v3.18-rc1~114^
 a80e49e2cc31 nohz: Move nohz full init call to tick init
 c5c38ef3d703 irq_work: Introduce arch_irq_work_has_interrupt()
 76a33061b932 irq_work: Force raised irq work to run on irq work interr=
upt
 3010279f0fc3 x86: Tell irq work about self IPI support
 09f6edd42421 arm: Tell irq work about self IPI support
 3631073659d0 arm64: Tell irq work about self IPI support
 4327b15f64b2 nohz: Consolidate nohz full init code
 9b01f5bf3999 nohz: nohz full depends on irq work self IPI support

Not sure whether we want to backport more stuff or change the
original backport to not use arch_irq_work_has_interrupt...

Config is basically a defconfig but with RT_FULL and NOHZ_FULL =3Dy.

Paul.
--

>=20
> Steven Rostedt (Red Hat) (1):
>       Linux 3.14.39-rt38
>=20
> ----
>  arch/arm/kernel/smp.c               |  2 --
>  arch/arm/kvm/arm.c                  |  4 ++--
>  arch/arm/kvm/psci.c                 |  4 ++--
>  arch/powerpc/include/asm/kvm_host.h |  4 ++--
>  arch/powerpc/kernel/time.c          |  2 +-
>  arch/powerpc/kvm/book3s_hv.c        | 20 ++++++++--------
>  arch/s390/include/asm/kvm_host.h    |  2 +-
>  arch/sparc/kernel/pcr.c             |  2 --
>  arch/x86/kernel/irq_work.c          |  2 --
>  arch/x86/kvm/lapic.c                | 48 +++++++++++++++++++++++++++=
+++++-----
>  include/linux/kvm_host.h            |  4 ++--
>  kernel/cpu.c                        |  2 +-
>  kernel/irq_work.c                   |  5 +---
>  kernel/sched/core.c                 | 29 +++++++++++++++++-----
>  kernel/time/tick-sched.c            | 10 ++++++++
>  kernel/timer.c                      |  2 +-
>  localversion-rt                     |  2 +-
>  virt/kvm/async_pf.c                 |  4 ++--
>  virt/kvm/kvm_main.c                 | 16 ++++++-------
>  19 files changed, 109 insertions(+), 55 deletions(-)
> ---------------------------
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 686f1d1eb32e..8cd3724714fe 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -463,14 +463,12 @@ void arch_send_call_function_single_ipi(int cpu=
)
>  }
> =20
>  #ifdef CONFIG_IRQ_WORK
> -#ifndef CONFIG_PREEMPT_RT_FULL
>  void arch_irq_work_raise(void)
>  {
>  	if (is_smp())
>  		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
>  }
>  #endif
> -#endif
> =20
>  static const char *ipi_types[NR_IPI] =3D {
>  #define S(x,s)	[x] =3D s
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index bd18bb8b2770..9100f8a609a2 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -495,9 +495,9 @@ static int kvm_vcpu_first_run_init(struct kvm_vcp=
u *vcpu)
> =20
>  static void vcpu_pause(struct kvm_vcpu *vcpu)
>  {
> -	wait_queue_head_t *wq =3D kvm_arch_vcpu_wq(vcpu);
> +	struct swait_head *wq =3D kvm_arch_vcpu_wq(vcpu);
> =20
> -	wait_event_interruptible(*wq, !vcpu->arch.pause);
> +	swait_event_interruptible(*wq, !vcpu->arch.pause);
>  }
> =20
>  static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index 448f60e8d23c..19c6c9c2118c 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -36,7 +36,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vc=
pu *source_vcpu)
>  {
>  	struct kvm *kvm =3D source_vcpu->kvm;
>  	struct kvm_vcpu *vcpu =3D NULL, *tmp;
> -	wait_queue_head_t *wq;
> +	struct swait_head *wq;
>  	unsigned long cpu_id;
>  	unsigned long mpidr;
>  	phys_addr_t target_pc;
> @@ -80,7 +80,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vc=
pu *source_vcpu)
>  	smp_mb();		/* Make sure the above is visible */
> =20
>  	wq =3D kvm_arch_vcpu_wq(vcpu);
> -	wake_up_interruptible(wq);
> +	swait_wake_interruptible(wq);
> =20
>  	return KVM_PSCI_RET_SUCCESS;
>  }
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/inclu=
de/asm/kvm_host.h
> index 1eaea2dea174..dfaf2c2d8e7f 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -295,7 +295,7 @@ struct kvmppc_vcore {
>  	u8 in_guest;
>  	struct list_head runnable_threads;
>  	spinlock_t lock;
> -	wait_queue_head_t wq;
> +	struct swait_head wq;
>  	u64 stolen_tb;
>  	u64 preempt_tb;
>  	struct kvm_vcpu *runner;
> @@ -612,7 +612,7 @@ struct kvm_vcpu_arch {
>  	u8 prodded;
>  	u32 last_inst;
> =20
> -	wait_queue_head_t *wqp;
> +	struct swait_head *wqp;
>  	struct kvmppc_vcore *vcore;
>  	int ret;
>  	int trap;
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 6d37d7603a8f..5bec5fd82a7e 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -423,7 +423,7 @@ unsigned long profile_pc(struct pt_regs *regs)
>  EXPORT_SYMBOL(profile_pc);
>  #endif
> =20
> -#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
> +#if defined(CONFIG_IRQ_WORK)
> =20
>  /*
>   * 64-bit uses a byte in the PACA, 32-bit uses a per-cpu variable...
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_h=
v.c
> index 7a25d9218a05..0019281510da 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -74,11 +74,11 @@ static void kvmppc_fast_vcpu_kick_hv(struct kvm_v=
cpu *vcpu)
>  {
>  	int me;
>  	int cpu =3D vcpu->cpu;
> -	wait_queue_head_t *wqp;
> +	struct swait_head *wqp;
> =20
>  	wqp =3D kvm_arch_vcpu_wq(vcpu);
> -	if (waitqueue_active(wqp)) {
> -		wake_up_interruptible(wqp);
> +	if (swaitqueue_active(wqp)) {
> +		swait_wake_interruptible(wqp);
>  		++vcpu->stat.halt_wakeup;
>  	}
> =20
> @@ -583,8 +583,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu=
)
>  		tvcpu->arch.prodded =3D 1;
>  		smp_mb();
>  		if (vcpu->arch.ceded) {
> -			if (waitqueue_active(&vcpu->wq)) {
> -				wake_up_interruptible(&vcpu->wq);
> +			if (swaitqueue_active(&vcpu->wq)) {
> +				swait_wake_interruptible(&vcpu->wq);
>  				vcpu->stat.halt_wakeup++;
>  			}
>  		}
> @@ -1199,7 +1199,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create=
_hv(struct kvm *kvm,
>  		if (vcore) {
>  			INIT_LIST_HEAD(&vcore->runnable_threads);
>  			spin_lock_init(&vcore->lock);
> -			init_waitqueue_head(&vcore->wq);
> +			init_swait_head(&vcore->wq);
>  			vcore->preempt_tb =3D TB_NIL;
>  			vcore->lpcr =3D kvm->arch.lpcr;
>  			vcore->first_vcpuid =3D core * threads_per_core;
> @@ -1566,13 +1566,13 @@ static void kvmppc_wait_for_exec(struct kvm_v=
cpu *vcpu, int wait_state)
>   */
>  static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>  {
> -	DEFINE_WAIT(wait);
> +	DEFINE_SWAITER(wait);
> =20
> -	prepare_to_wait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
> +	swait_prepare(&vc->wq, &wait, TASK_INTERRUPTIBLE);
>  	vc->vcore_state =3D VCORE_SLEEPING;
>  	spin_unlock(&vc->lock);
>  	schedule();
> -	finish_wait(&vc->wq, &wait);
> +	swait_finish(&vc->wq, &wait);
>  	spin_lock(&vc->lock);
>  	vc->vcore_state =3D VCORE_INACTIVE;
>  }
> @@ -1613,7 +1613,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_=
run, struct kvm_vcpu *vcpu)
>  			kvmppc_create_dtl_entry(vcpu, vc);
>  			kvmppc_start_thread(vcpu);
>  		} else if (vc->vcore_state =3D=3D VCORE_SLEEPING) {
> -			wake_up(&vc->wq);
> +			swait_wake(&vc->wq);
>  		}
> =20
>  	}
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm=
/kvm_host.h
> index eef3dd3fd9a9..65402d300a26 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -233,7 +233,7 @@ struct kvm_s390_local_interrupt {
>  	atomic_t active;
>  	struct kvm_s390_float_interrupt *float_int;
>  	int timer_due; /* event indicator for waitqueue below */
> -	wait_queue_head_t *wq;
> +	struct swait_head *wq;
>  	atomic_t *cpuflags;
>  	unsigned int action_bits;
>  };
> diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
> index 927d9c5e50f5..7e967c8018c8 100644
> --- a/arch/sparc/kernel/pcr.c
> +++ b/arch/sparc/kernel/pcr.c
> @@ -43,12 +43,10 @@ void __irq_entry deferred_pcr_work_irq(int irq, s=
truct pt_regs *regs)
>  	set_irq_regs(old_regs);
>  }
> =20
> -#ifndef CONFIG_PREEMPT_RT_FULL
>  void arch_irq_work_raise(void)
>  {
>  	set_softint(1 << PIL_DEFERRED_PCR_WORK);
>  }
> -#endif
> =20
>  const struct pcr_ops *pcr_ops;
>  EXPORT_SYMBOL_GPL(pcr_ops);
> diff --git a/arch/x86/kernel/irq_work.c b/arch/x86/kernel/irq_work.c
> index 3d21f7bd7b42..1de84e3ab4e0 100644
> --- a/arch/x86/kernel/irq_work.c
> +++ b/arch/x86/kernel/irq_work.c
> @@ -38,7 +38,6 @@ __visible void smp_trace_irq_work_interrupt(struct =
pt_regs *regs)
>  	exiting_irq();
>  }
> =20
> -#ifndef CONFIG_PREEMPT_RT_FULL
>  void arch_irq_work_raise(void)
>  {
>  #ifdef CONFIG_X86_LOCAL_APIC
> @@ -49,4 +48,3 @@ void arch_irq_work_raise(void)
>  	apic_wait_icr_idle();
>  #endif
>  }
> -#endif
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 453e5fbbb7ae..8b25d010d5e4 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1031,8 +1031,38 @@ static void update_divide_count(struct kvm_lap=
ic *apic)
>  				   apic->divide_count);
>  }
> =20
> +
> +static enum hrtimer_restart apic_timer_fn(struct hrtimer *data);
> +
> +static void apic_timer_expired(struct hrtimer *data)
> +{
> +	int ret, i =3D 0;
> +	enum hrtimer_restart r;
> +	struct kvm_timer *ktimer =3D container_of(data, struct kvm_timer, t=
imer);
> +
> +	r =3D apic_timer_fn(data);
> +
> +	if (r =3D=3D HRTIMER_RESTART) {
> +		do {
> +			ret =3D hrtimer_start_expires(data, HRTIMER_MODE_ABS);
> +			if (ret =3D=3D -ETIME)
> +				hrtimer_add_expires_ns(&ktimer->timer,
> +							ktimer->period);
> +			i++;
> +		} while (ret =3D=3D -ETIME && i < 10);
> +
> +		if (ret =3D=3D -ETIME) {
> +			printk_once(KERN_ERR "%s: failed to reprogram timer\n",
> +			       __func__);
> +			WARN_ON_ONCE(1);
> +		}
> +	}
> +}
> +
> +
>  static void start_apic_timer(struct kvm_lapic *apic)
>  {
> +	int ret;
>  	ktime_t now;
>  	atomic_set(&apic->lapic_timer.pending, 0);
> =20
> @@ -1062,9 +1092,11 @@ static void start_apic_timer(struct kvm_lapic =
*apic)
>  			}
>  		}
> =20
> -		hrtimer_start(&apic->lapic_timer.timer,
> +		ret =3D hrtimer_start(&apic->lapic_timer.timer,
>  			      ktime_add_ns(now, apic->lapic_timer.period),
>  			      HRTIMER_MODE_ABS);
> +		if (ret =3D=3D -ETIME)
> +			apic_timer_expired(&apic->lapic_timer.timer);
> =20
>  		apic_debug("%s: bus cycle is %" PRId64 "ns, now 0x%016"
>  			   PRIx64 ", "
> @@ -1094,8 +1126,10 @@ static void start_apic_timer(struct kvm_lapic =
*apic)
>  			ns =3D (tscdeadline - guest_tsc) * 1000000ULL;
>  			do_div(ns, this_tsc_khz);
>  		}
> -		hrtimer_start(&apic->lapic_timer.timer,
> +		ret =3D hrtimer_start(&apic->lapic_timer.timer,
>  			ktime_add_ns(now, ns), HRTIMER_MODE_ABS);
> +		if (ret =3D=3D -ETIME)
> +			apic_timer_expired(&apic->lapic_timer.timer);
> =20
>  		local_irq_restore(flags);
>  	}
> @@ -1533,7 +1567,7 @@ static enum hrtimer_restart apic_timer_fn(struc=
t hrtimer *data)
>  	struct kvm_timer *ktimer =3D container_of(data, struct kvm_timer, t=
imer);
>  	struct kvm_lapic *apic =3D container_of(ktimer, struct kvm_lapic, l=
apic_timer);
>  	struct kvm_vcpu *vcpu =3D apic->vcpu;
> -	wait_queue_head_t *q =3D &vcpu->wq;
> +	struct swait_head *q =3D &vcpu->wq;
> =20
>  	/*
>  	 * There is a race window between reading and incrementing, but we =
do
> @@ -1547,8 +1581,8 @@ static enum hrtimer_restart apic_timer_fn(struc=
t hrtimer *data)
>  		kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
>  	}
> =20
> -	if (waitqueue_active(q))
> -		wake_up_interruptible(q);
> +	if (swaitqueue_active(q))
> +		swait_wake_interruptible(q);
> =20
>  	if (lapic_is_periodic(apic)) {
>  		hrtimer_add_expires_ns(&ktimer->timer, ktimer->period);
> @@ -1581,6 +1615,7 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
>  	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
>  		     HRTIMER_MODE_ABS);
>  	apic->lapic_timer.timer.function =3D apic_timer_fn;
> +	apic->lapic_timer.timer.irqsafe =3D 1;
> =20
>  	/*
>  	 * APIC is created enabled. This will prevent kvm_lapic_set_base fr=
om
> @@ -1699,7 +1734,8 @@ void __kvm_migrate_apic_timer(struct kvm_vcpu *=
vcpu)
> =20
>  	timer =3D &vcpu->arch.apic->lapic_timer.timer;
>  	if (hrtimer_cancel(timer))
> -		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
> +		if (hrtimer_start_expires(timer, HRTIMER_MODE_ABS) =3D=3D -ETIME)
> +			apic_timer_expired(timer);
>  }
> =20
>  /*
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index b8e9a43e501a..aebf20c9bfab 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -231,7 +231,7 @@ struct kvm_vcpu {
> =20
>  	int fpu_active;
>  	int guest_fpu_loaded, guest_xcr0_loaded;
> -	wait_queue_head_t wq;
> +	struct swait_head wq;
>  	struct pid *pid;
>  	int sigset_active;
>  	sigset_t sigset;
> @@ -677,7 +677,7 @@ static inline bool kvm_arch_has_noncoherent_dma(s=
truct kvm *kvm)
>  }
>  #endif
> =20
> -static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *v=
cpu)
> +static inline struct swait_head *kvm_arch_vcpu_wq(struct kvm_vcpu *v=
cpu)
>  {
>  #ifdef __KVM_HAVE_ARCH_WQP
>  	return vcpu->arch.wqp;
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 285e18b2c420..a3890754e407 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -242,7 +242,7 @@ static int sync_unplug_thread(void *data)
>  	 * we don't want any more work on this CPU.
>  	 */
>  	current->flags &=3D ~PF_NO_SETAFFINITY;
> -	do_set_cpus_allowed(current, cpu_present_mask);
> +	set_cpus_allowed_ptr(current, cpu_present_mask);
>  	migrate_me();
>  	return 0;
>  }
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 35d21f93bbe8..5f7d93d89c7f 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -16,6 +16,7 @@
>  #include <linux/tick.h>
>  #include <linux/cpu.h>
>  #include <linux/notifier.h>
> +#include <linux/interrupt.h>
>  #include <asm/processor.h>
> =20
> =20
> @@ -51,11 +52,7 @@ static bool irq_work_claim(struct irq_work *work)
>  	return true;
>  }
> =20
> -#ifdef CONFIG_PREEMPT_RT_FULL
> -void arch_irq_work_raise(void)
> -#else
>  void __weak arch_irq_work_raise(void)
> -#endif
>  {
>  	/*
>  	 * Lame architectures will get the timer tick callback
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 883669d3e293..71c0bb1cdeb0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -696,17 +696,34 @@ static inline bool got_nohz_idle_kick(void)
>  #endif /* CONFIG_NO_HZ_COMMON */
> =20
>  #ifdef CONFIG_NO_HZ_FULL
> +
> +static int ksoftirqd_running(void)
> +{
> +	struct task_struct *softirqd;
> +
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> +		return 0;
> +	softirqd =3D this_cpu_ksoftirqd();
> +	if (softirqd && softirqd->on_rq)
> +		return 1;
> +	return 0;
> +}
> +
>  bool sched_can_stop_tick(void)
>  {
> -       struct rq *rq;
> +	struct rq *rq;
> =20
> -       rq =3D this_rq();
> +	rq =3D this_rq();
> =20
> -       /* Make sure rq->nr_running update is visible after the IPI *=
/
> -       smp_rmb();
> +	/* Make sure rq->nr_running update is visible after the IPI */
> +	smp_rmb();
> =20
> -       /* More than one running task need preemption */
> -       if (rq->nr_running > 1)
> +	/*
> +	 * More than one running task need preemption
> +	 *
> +	 * NOTE, RT: if ksoftirqd is awake, subtract it.
> +	 */
> +	if (rq->nr_running - ksoftirqd_running() > 1)
>                 return false;
> =20
>         return true;
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index ab32130964b6..57d5bb1b3919 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -180,6 +180,11 @@ static bool can_stop_full_tick(void)
>  		return false;
>  	}
> =20
> +	if (!arch_irq_work_has_interrupt()) {
> +		trace_tick_stop(0, "missing irq work interrupt\n");
> +		return false;
> +	}
> +
>  	/* sched_clock_tick() needs us? */
>  #ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
>  	/*
> @@ -221,7 +226,12 @@ void __tick_nohz_full_check(void)
> =20
>  static void nohz_full_kick_work_func(struct irq_work *work)
>  {
> +	unsigned long flags;
> +
> +	/* ksoftirqd processes sirqs with interrupts enabled */
> +	local_irq_save(flags);
>  	__tick_nohz_full_check();
> +	local_irq_restore(flags);
>  }
> =20
>  static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =3D {
> diff --git a/kernel/timer.c b/kernel/timer.c
> index 34fd2dbba3e3..36b9f10bb3c7 100644
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -1450,7 +1450,7 @@ void update_process_times(int user_tick)
>  	scheduler_tick();
>  	run_local_timers();
>  	rcu_check_callbacks(cpu, user_tick);
> -#if defined(CONFIG_IRQ_WORK)
> +#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
>  	if (in_irq())
>  		irq_work_run();
>  #endif
> diff --git a/localversion-rt b/localversion-rt
> index a3b2408c1da6..49bae8d6aa67 100644
> --- a/localversion-rt
> +++ b/localversion-rt
> @@ -1 +1 @@
> --rt37
> +-rt38
> diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
> index f2c80d5451c3..10634baf3b08 100644
> --- a/virt/kvm/async_pf.c
> +++ b/virt/kvm/async_pf.c
> @@ -82,8 +82,8 @@ static void async_pf_execute(struct work_struct *wo=
rk)
> =20
>  	trace_kvm_async_pf_completed(addr, gva);
> =20
> -	if (waitqueue_active(&vcpu->wq))
> -		wake_up_interruptible(&vcpu->wq);
> +	if (swaitqueue_active(&vcpu->wq))
> +		swait_wake_interruptible(&vcpu->wq);
> =20
>  	mmput(mm);
>  	kvm_put_kvm(vcpu->kvm);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 66112533b1e9..38a0d7a5ce74 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -219,7 +219,7 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct k=
vm *kvm, unsigned id)
>  	vcpu->kvm =3D kvm;
>  	vcpu->vcpu_id =3D id;
>  	vcpu->pid =3D NULL;
> -	init_waitqueue_head(&vcpu->wq);
> +	init_swait_head(&vcpu->wq);
>  	kvm_async_pf_vcpu_init(vcpu);
> =20
>  	page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> @@ -1675,10 +1675,10 @@ EXPORT_SYMBOL_GPL(mark_page_dirty);
>   */
>  void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  {
> -	DEFINE_WAIT(wait);
> +	DEFINE_SWAITER(wait);
> =20
>  	for (;;) {
> -		prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
> +		swait_prepare(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
> =20
>  		if (kvm_arch_vcpu_runnable(vcpu)) {
>  			kvm_make_request(KVM_REQ_UNHALT, vcpu);
> @@ -1692,7 +1692,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  		schedule();
>  	}
> =20
> -	finish_wait(&vcpu->wq, &wait);
> +	swait_finish(&vcpu->wq, &wait);
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_block);
> =20
> @@ -1704,11 +1704,11 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
>  {
>  	int me;
>  	int cpu =3D vcpu->cpu;
> -	wait_queue_head_t *wqp;
> +	struct swait_head *wqp;
> =20
>  	wqp =3D kvm_arch_vcpu_wq(vcpu);
> -	if (waitqueue_active(wqp)) {
> -		wake_up_interruptible(wqp);
> +	if (swaitqueue_active(wqp)) {
> +		swait_wake_interruptible(wqp);
>  		++vcpu->stat.halt_wakeup;
>  	}
> =20
> @@ -1814,7 +1814,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
>  				continue;
>  			if (vcpu =3D=3D me)
>  				continue;
> -			if (waitqueue_active(&vcpu->wq))
> +			if (swaitqueue_active(&vcpu->wq))
>  				continue;
>  			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
>  				continue;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
