From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 2/4] KVM: use simple waitqueue for vcpu->wq
Date: Wed, 21 Oct 2015 19:55:00 +1100
Message-ID: <20151021085500.GB15591@fergus.ozlabs.ibm.com>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-3-git-send-email-daniel.wagner@bmw-carit.de>
 <20151020140031.GG17308@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151020140031.GG17308@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Oct 20, 2015 at 04:00:31PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 20, 2015 at 09:28:08AM +0200, Daniel Wagner wrote:
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 2280497..f534e15 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -2560,10 +2560,9 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
> >  {
> >  	struct kvm_vcpu *vcpu;
> >  	int do_sleep = 1;
> > +	DECLARE_SWAITQUEUE(wait);
> >  
> > -	DEFINE_WAIT(wait);
> > -
> > -	prepare_to_wait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
> > +	prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
> >  
> >  	/*
> >  	 * Check one last time for pending exceptions and ceded state after
> > @@ -2577,7 +2576,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
> >  	}
> >  
> >  	if (!do_sleep) {
> > -		finish_wait(&vc->wq, &wait);
> > +		finish_swait(&vc->wq, &wait);
> >  		return;
> >  	}
> >  
> > @@ -2585,7 +2584,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
> >  	trace_kvmppc_vcore_blocked(vc, 0);
> >  	spin_unlock(&vc->lock);
> >  	schedule();
> > -	finish_wait(&vc->wq, &wait);
> > +	finish_swait(&vc->wq, &wait);
> >  	spin_lock(&vc->lock);
> >  	vc->vcore_state = VCORE_INACTIVE;
> >  	trace_kvmppc_vcore_blocked(vc, 1);
> 
> This one looks buggy, one should _NOT_ assume that your blocking
> condition is true after schedule().

Do you mean it's buggy in calling finish_swait there, or it's buggy in
not immediately re-checking the condition?  If the latter, then it's
OK because the sole caller of this function calls it in a loop and
checks the condition (all runnable vcpus in this vcore are idle) each
time around the loop.

> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 8db1d93..45ab55f 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2019,7 +2018,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
> >  	}
> >  
> >  	for (;;) {
> > -		prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
> > +		prepare_to_swait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
> >  
> >  		if (kvm_vcpu_check_block(vcpu) < 0)
> >  			break;
> > @@ -2028,7 +2027,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
> >  		schedule();
> >  	}
> >  
> > -	finish_wait(&vcpu->wq, &wait);
> > +	finish_swait(&vcpu->wq, &wait);
> >  	cur = ktime_get();
> >  
> >  out:
> 
> Should we not take this opportunity to get rid of these open-coded wait
> loops?
> 
> 
> Does this work?
> 
> ---
>  arch/powerpc/kvm/book3s_hv.c | 33 +++++++++++++++++----------------
>  virt/kvm/kvm_main.c          | 13 ++-----------
>  2 files changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 228049786888..b5b8bcad5105 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -2552,18 +2552,10 @@ static void kvmppc_wait_for_exec(struct kvmppc_vcore *vc,
>  	finish_wait(&vcpu->arch.cpu_run, &wait);
>  }
>  
> -/*
> - * All the vcpus in this vcore are idle, so wait for a decrementer
> - * or external interrupt to one of the vcpus.  vc->lock is held.
> - */
> -static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
> +static inline bool kvmppc_vcore_should_sleep(struct kvmppc_vcore *vc)

This function could also be used in kvmppc_run_vcpu().

>  {
>  	struct kvm_vcpu *vcpu;
> -	int do_sleep = 1;
> -
> -	DEFINE_WAIT(wait);
> -
> -	prepare_to_wait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
> +	bool sleep = true;
>  
>  	/*
>  	 * Check one last time for pending exceptions and ceded state after
> @@ -2571,26 +2563,35 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>  	 */
>  	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list) {
>  		if (vcpu->arch.pending_exceptions || !vcpu->arch.ceded) {
> -			do_sleep = 0;
> +			sleep = false;
>  			break;
>  		}
>  	}
>  
> -	if (!do_sleep) {
> -		finish_wait(&vc->wq, &wait);
> -		return;
> -	}
> +	return sleep;
> +}
>  
> +static inline void kvmppc_vcore_schedule(struct kvmppc_vcore *vc)
> +{
>  	vc->vcore_state = VCORE_SLEEPING;
>  	trace_kvmppc_vcore_blocked(vc, 0);
>  	spin_unlock(&vc->lock);
>  	schedule();
> -	finish_wait(&vc->wq, &wait);
>  	spin_lock(&vc->lock);
>  	vc->vcore_state = VCORE_INACTIVE;
>  	trace_kvmppc_vcore_blocked(vc, 1);
>  }
>  
> +/*
> + * All the vcpus in this vcore are idle, so wait for a decrementer
> + * or external interrupt to one of the vcpus.  vc->lock is held.
> + */
> +static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
> +{
> +	___wait_event(vc->wq, !kvmppc_vcore_should_sleep(vc), TASK_IDLE, 0, 0,
> +		      kvmppc_vcore_schedule(vc));

Wow, triple underscores, that must be an ultra-trendy function. :)

> +}
> +
>  static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
>  {
>  	int n_ceded;

That all looks OK at a first glance, I'll give it a whirl.

Paul.
