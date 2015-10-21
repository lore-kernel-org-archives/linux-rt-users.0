From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/4] KVM: use simple waitqueue for vcpu->wq
Date: Wed, 21 Oct 2015 11:05:33 +0200
Message-ID: <20151021090533.GH2903@worktop.programming.kicks-ass.net>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-3-git-send-email-daniel.wagner@bmw-carit.de>
 <20151020140031.GG17308@twins.programming.kicks-ass.net>
 <20151021085500.GB15591@fergus.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Paul Mackerras <paulus@ozlabs.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151021085500.GB15591@fergus.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 21, 2015 at 07:55:00PM +1100, Paul Mackerras wrote:
> On Tue, Oct 20, 2015 at 04:00:31PM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 20, 2015 at 09:28:08AM +0200, Daniel Wagner wrote:
> > > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > > index 2280497..f534e15 100644
> > > --- a/arch/powerpc/kvm/book3s_hv.c
> > > +++ b/arch/powerpc/kvm/book3s_hv.c
> > > @@ -2560,10 +2560,9 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
> > >  {
> > >  	struct kvm_vcpu *vcpu;
> > >  	int do_sleep = 1;
> > > +	DECLARE_SWAITQUEUE(wait);
> > >  
> > > -	DEFINE_WAIT(wait);
> > > -
> > > -	prepare_to_wait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
> > > +	prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
> > >  
> > >  	/*
> > >  	 * Check one last time for pending exceptions and ceded state after
> > > @@ -2577,7 +2576,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
> > >  	}
> > >  
> > >  	if (!do_sleep) {
> > > -		finish_wait(&vc->wq, &wait);
> > > +		finish_swait(&vc->wq, &wait);
> > >  		return;
> > >  	}
> > >  
> > > @@ -2585,7 +2584,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
> > >  	trace_kvmppc_vcore_blocked(vc, 0);
> > >  	spin_unlock(&vc->lock);
> > >  	schedule();
> > > -	finish_wait(&vc->wq, &wait);
> > > +	finish_swait(&vc->wq, &wait);
> > >  	spin_lock(&vc->lock);
> > >  	vc->vcore_state = VCORE_INACTIVE;
> > >  	trace_kvmppc_vcore_blocked(vc, 1);
> > 
> > This one looks buggy, one should _NOT_ assume that your blocking
> > condition is true after schedule().
> 
> Do you mean it's buggy in calling finish_swait there, or it's buggy in
> not immediately re-checking the condition?  If the latter, then it's
> OK because the sole caller of this function calls it in a loop and
> checks the condition (all runnable vcpus in this vcore are idle) each
> time around the loop.

Ah, I missed the caller loop, yes that's fine.

I'm biased against such code for having seen a few too many broken
open-coded wait loops I suppose..
