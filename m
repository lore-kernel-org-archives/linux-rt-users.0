From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [rt-patch 4/3] arm,KVM: Move phys_timer handling to hard irq
 context
Date: Thu, 2 Aug 2018 12:31:04 -0400
Message-ID: <20180802123104.7fed73b4@gandalf.local.home>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
        <1532764179.9882.14.camel@gmx.de>
        <1532768853.9882.73.camel@gmx.de>
        <1533192980.11791.8.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533192980.11791.8.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 02 Aug 2018 08:56:20 +0200
Mike Galbraith <efault@gmx.de> wrote:

> (arm-land adventures 1/3 take2 will have to wait, my cup runeth over) 
> 
> v4.14..v4.15 timer handling changes including calling kvm_timer_vcpu_load()

I take it that this should be added to v4.16-rt and marked stable-rt?

-- Steve

> during kvm_preempt_ops.sched_in and taking vgic_dist.lpi_list_lock in the
> timer interrupt handler required locks for which locking rules/context had
> been changed be converted to raw_spinlock_t...
> 
> Quoting virt/kvm/arm/vgic/vgic.c:
>  * Locking order is always:
>  * kvm->lock (mutex)
>  *   its->cmd_lock (mutex)
>  *     its->its_lock (mutex)
>  *       vgic_cpu->ap_list_lock         must be taken with IRQs disabled
>  *         kvm->lpi_list_lock           must be taken with IRQs disabled
>  *           vgic_irq->irq_lock         must be taken with IRQs disabled
>  *
>  * As the ap_list_lock might be taken from the timer interrupt handler,
>  * we have to disable IRQs before taking this lock and everything lower
>  * than it.
> 
> ...and fixed the obvious bricking consequence of those changes for RT,
> but left an RT specific kvm unit test timer failure in its wake.  Handling
> phys_timer in hard interrupt context as expected cures that failure.
> 
> Pre:
> PASS selftest-setup (2 tests)
> PASS selftest-vectors-kernel (2 tests)
> PASS selftest-vectors-user (2 tests)
> PASS selftest-smp (65 tests)
> PASS pci-test (1 tests)
> PASS pmu (3 tests)
> PASS gicv2-ipi (3 tests)
> PASS gicv3-ipi (3 tests)
> PASS gicv2-active (1 tests)
> PASS gicv3-active (1 tests)
> PASS psci (4 tests)
> FAIL timer (8 tests, 1 unexpected failures)
> 
> Post:
> PASS selftest-setup (2 tests)
> PASS selftest-vectors-kernel (2 tests)
> PASS selftest-vectors-user (2 tests)
> PASS selftest-smp (65 tests)
> PASS pci-test (1 tests)
> PASS pmu (3 tests)
> PASS gicv2-ipi (3 tests)
> PASS gicv3-ipi (3 tests)
> PASS gicv2-active (1 tests)
> PASS gicv3-active (1 tests)
> PASS psci (4 tests)
> PASS timer (8 tests)
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  virt/kvm/arm/arch_timer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -634,7 +634,7 @@ void kvm_timer_vcpu_init(struct kvm_vcpu
>  	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>  	timer->bg_timer.function = kvm_bg_timer_expire;
>  
> -	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
> +	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
>  	timer->phys_timer.function = kvm_phys_timer_expire;
>  
>  	vtimer->irq.irq = default_vtimer_irq.irq;
