From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/4] KVM: use simple waitqueue for vcpu->wq
Date: Tue, 20 Oct 2015 18:06:09 +0200
Message-ID: <20151020160609.GH17308@twins.programming.kicks-ass.net>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-3-git-send-email-daniel.wagner@bmw-carit.de>
 <20151020140031.GG17308@twins.programming.kicks-ass.net>
 <56266074.8050707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56266074.8050707@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Oct 20, 2015 at 05:40:36PM +0200, Paolo Bonzini wrote:
> 
> 
> On 20/10/2015 16:00, Peter Zijlstra wrote:
> >> > -		prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
> >> > +		prepare_to_swait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
> >> >  
> >> >  		if (kvm_vcpu_check_block(vcpu) < 0)
> >> >  			break;
> >> > @@ -2028,7 +2027,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
> >> >  		schedule();
> >> >  	}
> >> >  
> >> > -	finish_wait(&vcpu->wq, &wait);
> >> > +	finish_swait(&vcpu->wq, &wait);
> >> >  	cur = ktime_get();
> >> >  
> >> >  out:
> > Should we not take this opportunity to get rid of these open-coded wait
> > loops?
> 
> I find them way more readable than a 6-argument __wait_event...

I could introduce wait_event_idle_cmd() and be at 3 if you think that
helps.

#define __wait_event_idle_cmd(wq, cond, cmd) \
	___wait_event(wq, cond, TASK_IDLE, 0, 0, cmd)

etc..

Its that awkward waited variable that makes it hard to use the 'regular'
2 parameter thing. Although you could of course do horrible things like:

	__wait_event_idle(vcpu->wq, ({
		bool done = kvm_cpu_check_block(vcpu) < 0;
		if (!done)
			waited = true;
		done;
	}));
