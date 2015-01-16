From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Fri, 16 Jan 2015 11:56:27 -0500
Message-ID: <20150116115627.425daf95@gandalf.local.home>
References: <20150114171251.882318257@redhat.com>
	<20150114171459.593877145@redhat.com>
	<20150116114846.4e7b718d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150116114846.4e7b718d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 16 Jan 2015 11:48:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> >  static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
> >  {
> > -	DEFINE_WAIT(wait);
> > +	DEFINE_SWAITER(wait);
> >  
> > -	prepare_to_wait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
> > +	swait_prepare(&vc->wq, &wait, TASK_INTERRUPTIBLE);
> >  	vc->vcore_state = VCORE_SLEEPING;
> >  	spin_unlock(&vc->lock);
> >  	schedule();
> > -	finish_wait(&vc->wq, &wait);
> > +	swait_finish(&vc->wq, &wait);
> >  	spin_lock(&vc->lock);
> >  	vc->vcore_state = VCORE_INACTIVE;
> >  }
> > @@ -1613,7 +1613,7 @@
> >  			kvmppc_create_dtl_entry(vcpu, vc);
> >  			kvmppc_start_thread(vcpu);
> >  		} else if (vc->vcore_state == VCORE_SLEEPING) {
> > -			wake_up(&vc->wq);
> > +			swait_wake(&vc->wq);
> 
> I notice everywhere you have a swait_wake_interruptible() but here. Is
> there a reason why?
> 

Of course I could have misread this patch, and this specific work queue
will only be woken up by swait_wake() and not
swait_wake_interruptible(). If that's the case, then its fine as is
(except for that typo I pointed out before).

-- Steve
