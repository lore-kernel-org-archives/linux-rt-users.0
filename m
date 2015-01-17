From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Sat, 17 Jan 2015 08:57:44 +0100
Message-ID: <20150117075744.GM25256@twins.programming.kicks-ass.net>
References: <20150114171251.882318257@redhat.com>
 <20150114171459.593877145@redhat.com>
 <20150116114846.4e7b718d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150116114846.4e7b718d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Jan 16, 2015 at 11:48:46AM -0500, Steven Rostedt wrote:
> I notice everywhere you have a swait_wake_interruptible() but here. Is
> there a reason why?
> 
> IIRC, Peter wants to make swait wakeup usage homogenous. That is, you
> either sleep in an interruptible state, or you don't. You can't mix and
> match it.
> 
> Peter is that what you plan?

Yes, this is required for the single wakeup case to be bounded.

If you have both INTERRUPTIBLE and UNINTERRUPTIBLE waiters on a list,
and you were allowed to do INTERRUPTIBLE/UNINTERRUPTIBLE wakeups, the
wakeup would have to do O(n) iteration to find a matching waiter.

Seeing that the entire purpose of simple wait queues was to retain RT
properties, that's entirely retarded ;-)
