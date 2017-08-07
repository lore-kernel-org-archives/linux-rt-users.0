From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH -rt] kvm: lockdep annotate mmu_lock wait_lock
Date: Mon, 7 Aug 2017 15:35:01 +0200
Message-ID: <20170807133501.mwwopzv5ptw4cc22@linutronix.de>
References: <20170718120347.GA25342@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718120347.GA25342@amt.cnet>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-07-18 09:03:47 [-0300], Marcelo Tosatti wrote:
> 
> wait_lock for mmu_lock, being allocated in kmalloc memory,
> can't be tracked by LOCKDEP. 

there is:
	struct kvm *kvm = kvm_arch_alloc_vm(); 

	spin_lock_init(&kvm->mmu_lock);

and kvm_arch_alloc_vm() itself is "kzalloc(sizeof(struct kvm),
GFP_KERNEL);". I don't see anything wrong with it. This does not explain
why this lockdep warning.

> Disable LOCKDEP verification for it.
> 
> Fixes


>  INFO: trying to register non-static key.
>  the code is fine but needs lockdep annotation.
>  turning off the locking correctness validator.

not convinced. 

>  CPU: 0 PID: 12386 Comm: qemu-kvm Not tainted 3.10.0-631.rt56.546.el7.x86_64.debug #1
oh.

Sebastian
