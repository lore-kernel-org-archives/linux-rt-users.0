From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH -rt] kvm: lockdep annotate mmu_lock wait_lock
Date: Tue, 18 Jul 2017 09:22:38 -0300
Message-ID: <20170718122238.GA5356@amt.cnet>
References: <20170718120347.GA25342@amt.cnet>
 <20170718121606.dvkwlnxiflrdmsn3@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, kvm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbdGRMW4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jul 2017 08:22:56 -0400
Content-Disposition: inline
In-Reply-To: <20170718121606.dvkwlnxiflrdmsn3@hirez.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jul 18, 2017 at 02:16:06PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 18, 2017 at 09:03:47AM -0300, Marcelo Tosatti wrote:
> > 
> > wait_lock for mmu_lock, being allocated in kmalloc memory,
> > can't be tracked by LOCKDEP. 
> > 
> > Disable LOCKDEP verification for it.
> > 
> > Fixes
> > 
> >  INFO: trying to register non-static key.
> >  the code is fine but needs lockdep annotation.
> >  turning off the locking correctness validator.
> >  CPU: 0 PID: 12386 Comm: qemu-kvm Not tainted 3.10.0-631.rt56.546.el7.x86_64.debug #1
> >  Hardware name: To be filled by O.E.M. To be filled by O.E.M./PMH61ML, BIOS 4.6.4 07/14/2011
> >  0000000000000002 00000000ee340fa8 ffff88008e2d7bc0 ffffffffa57534fc
> >  ffff88008e2d7bd0 ffffffffa574ce9f ffff88008e2d7c50 ffffffffa510e565
> >  ffff88008e2d7bf8 00000001a50cf83d 0000000000000000 ffff880000000000
> >  Call Trace:
> >  [<ffffffffa57534fc>] dump_stack+0x19/0x1b
> >  [<ffffffffa574ce9f>] register_lock_class.part.27+0x38/0x3c
> >  [<ffffffffa510e565>] __lock_acquire+0xcc5/0xdc0
> >  [<ffffffffa510efb2>] lock_acquire+0xb2/0x230
> >  [<ffffffffa5759ccd>] ? rt_spin_lock_slowlock+0x6d/0x3c0
> >  [<ffffffffa575c5f0>] _raw_spin_lock_irqsave+0x70/0xc0
> >  [<ffffffffa5759ccd>] ? rt_spin_lock_slowlock+0x6d/0x3c0
> >  [<ffffffffa5759ccd>] rt_spin_lock_slowlock+0x6d/0x3c0
> >  [<ffffffffa575b7ac>] rt_spin_lock+0x2c/0x60
> >  [<ffffffffc09b387f>] kvm_page_track_register_notifier+0x1f/0x60 [kvm]
> >  [<ffffffffc099a8eb>] kvm_mmu_init_vm+0x2b/0x30 [kvm]
> >  [<ffffffffc0987e04>] kvm_arch_init_vm+0x264/0x290 [kvm]
> >  [<ffffffffc096a14e>] kvm_dev_ioctl+0xde/0x740 [kvm]
> >  [<ffffffffa5250d45>] do_vfs_ioctl+0x365/0x5b0
> >  [<ffffffffa5251031>] SyS_ioctl+0xa1/0xc0
> >  [<ffffffffa57656ed>] tracesys+0xdd/0xe2
> >  ---------------------------
> >  | preempt count: 00000001 ]
> >  | 1-level deep critical section nesting:
> >  ----------------------------------------
> >  .. [<ffffffffa575c5cd>] .... _raw_spin_lock_irqsave+0x4d/0xc0
> >  .....[<ffffffffa5759ccd>] ..   ( <= rt_spin_lock_slowlock+0x6d/0x3c0)
> > 
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 7e80f62..6375db8 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -613,6 +613,8 @@ static struct kvm *kvm_create_vm(unsigned long type)
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	spin_lock_init(&kvm->mmu_lock);
> > +
> > +	lockdep_set_novalidate_class(&kvm->mmu_lock.lock.wait_lock);
> >  	mmgrab(current->mm);
> >  	kvm->mm = current->mm;
> >  	kvm_eventfd_init(kvm);
> 
> This doesn't make sense... It looks like a spin_lock_init() is missing,
> at which point it'll try and use the lock address itself and then bails
> because that is in dynamic memory.

Do you see the spin_lock_init just above, after "return
PTR_ERR(-ENOMEM)"... That should take care of wait_lock i suppose.

"struct kvm" (which contains the mmu_lock spinlock) is allocated with
kmalloc, can LOCKDEP handle spinlocks in kmalloc'ed memory?

> That doesn't mean you cannot initialize it properly.
> 
> And using novalidate for this is absolutely bonkers.

I imagined so, not entirely sure what is the proper LOCKDEP annotation
in this case...
