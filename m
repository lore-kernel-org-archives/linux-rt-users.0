From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [rt-patch 3/3] arm, KVM: convert vgic_irq.irq_lock to
 raw_spinlock_t
Date: Mon, 30 Jul 2018 11:27:28 +0200
Message-ID: <20180730092728.GE2494@hirez.programming.kicks-ass.net>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
 <1532764179.9882.14.camel@gmx.de>
 <1532768853.9882.73.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532768853.9882.73.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, Jul 28, 2018 at 11:07:33AM +0200, Mike Galbraith wrote:
> 
> b103cc3f10c0 ("KVM: arm/arm64: Avoid timer save/restore in vcpu entry/exit")
> requires vgic_irq.irq_lock be converted to raw_spinlock_t.
> 
> Problem: kvm_preempt_ops.sched_in = kvm_sched_in;
>    kvm_sched_in()
>       kvm_arch_vcpu_load()
>          kvm_timer_vcpu_load() <- b103cc3f10c0 addition
>             kvm_timer_vcpu_load_gic()
>                kvm_vgic_map_is_active()
>                   spin_lock_irqsave(&irq->irq_lock, flags);
> 
> Quoting virt/kvm/arm/vgic/vgic.c, locking order is...
> 
>   kvm->lock (mutex)
>     its->cmd_lock (mutex)
>       its->its_lock (mutex)
>         vgic_cpu->ap_list_lock         must be taken with IRQs disabled
>           kvm->lpi_list_lock           must be taken with IRQs disabled
>             vgic_irq->irq_lock         must be taken with IRQs disabled
> 
> ...meaning vgic_dist.lpi_list_lock and vgic_cpu.ap_list_lock must be
> converted as well.

The thing missing from the Changelog is the analysis that all the work
done under these locks is indeed properly bounded and cannot cause
excessive latencies.
