From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-rt] kvm: Convert pvclock_gtod_sync_lock to raw_spinlock_t
Date: Fri, 20 Jan 2017 17:44:23 +0100
Message-ID: <20170120164423.iunwa3hntguswabj@linutronix.de>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
 <1482735248.4476.58.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482735248.4476.58.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-12-26 07:54:08 [+0100], Mike Galbraith wrote:

Not so sure about it.

> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1540,7 +1540,7 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu
>  	kvm_vcpu_write_tsc_offset(vcpu, offset);
>  	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
>  
> -	spin_lock(&kvm->arch.pvclock_gtod_sync_lock);
> +	raw_spin_lock(&kvm->arch.pvclock_gtod_sync_lock);
>  	if (!matched) {
>  		kvm->arch.nr_vcpus_matched_tsc = 0;
>  	} else if (!already_matched) {
> @@ -1548,7 +1548,7 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu
>  	}
>  
>  	kvm_track_tsc_matching(vcpu);
> -	spin_unlock(&kvm->arch.pvclock_gtod_sync_lock);
> +	raw_spin_unlock(&kvm->arch.pvclock_gtod_sync_lock);
>  }
>  
>  EXPORT_SYMBOL_GPL(kvm_write_tsc);
> @@ -1715,7 +1715,7 @@ static void kvm_gen_update_masterclock(s
>  	struct kvm_vcpu *vcpu;
>  	struct kvm_arch *ka = &kvm->arch;
>  
> -	spin_lock(&ka->pvclock_gtod_sync_lock);
> +	raw_spin_lock(&ka->pvclock_gtod_sync_lock);
>  	kvm_make_mclock_inprogress_request(kvm);

kvm_make_mclock_inprogress_request() will do zalloc_cpumask_var().
off-stack zalloc is not yet working but I would like to enable it. Also
it does a SMP function call.

Couldn't we go the other way around and drop the local_irq_disable()?

Sebastian
