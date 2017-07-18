From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -rt] kvm: lockdep annotate mmu_lock wait_lock
Date: Tue, 18 Jul 2017 14:45:04 +0200
Message-ID: <20170718124504.fzo4mqakvsfu624t@hirez.programming.kicks-ass.net>
References: <20170718120347.GA25342@amt.cnet>
 <20170718121606.dvkwlnxiflrdmsn3@hirez.programming.kicks-ass.net>
 <20170718122238.GA5356@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, kvm@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718122238.GA5356@amt.cnet>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jul 18, 2017 at 09:22:38AM -0300, Marcelo Tosatti wrote:
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index 7e80f62..6375db8 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -613,6 +613,8 @@ static struct kvm *kvm_create_vm(unsigned long type)
> > >  		return ERR_PTR(-ENOMEM);
> > >  
> > >  	spin_lock_init(&kvm->mmu_lock);
> > > +
> > > +	lockdep_set_novalidate_class(&kvm->mmu_lock.lock.wait_lock);
> > >  	mmgrab(current->mm);
> > >  	kvm->mm = current->mm;
> > >  	kvm_eventfd_init(kvm);
> > 
> > This doesn't make sense... It looks like a spin_lock_init() is missing,
> > at which point it'll try and use the lock address itself and then bails
> > because that is in dynamic memory.
> 
> Do you see the spin_lock_init just above, after "return
> PTR_ERR(-ENOMEM)"... That should take care of wait_lock i suppose.

D'0h... so much for being 'awake'..

> "struct kvm" (which contains the mmu_lock spinlock) is allocated with
> kmalloc, can LOCKDEP handle spinlocks in kmalloc'ed memory?

Yep, what _should_ happen is that we use a macro like:

(I don't have an -RT tree handy atm)

# define raw_spin_lock_init(lock)                               \
do {                                                            \
        static struct lock_class_key __key;                     \
                                                                \
        __raw_spin_lock_init((lock), #lock, &__key);            \
} while (0)

Which defines a key per callsite. So while the lock itself is in dynamic
memory, the key will be static.
