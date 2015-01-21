From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Wed, 21 Jan 2015 16:07:16 +0100
Message-ID: <20150121150716.GD11596@twins.programming.kicks-ass.net>
References: <20150114171251.882318257@redhat.com>
 <20150114171459.593877145@redhat.com>
 <20150116114846.4e7b718d@gandalf.local.home>
 <20150119144100.GA10794@amt.cnet>
 <20150120054653.GA6473@iris.ozlabs.ibm.com>
 <20150120131613.009903a0@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150120131613.009903a0@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jan 20, 2015 at 01:16:13PM -0500, Steven Rostedt wrote:
> I'm actually wondering if we should just nuke the _interruptible()
> version of swait. As it should only be all interruptible or all not
> interruptible, that the swait_wake() should just do the wake up
> regardless. In which case, swait_wake() is good enough. No need to have
> different versions where people may think do something special.
> 
> Peter?

Yeah, I think the lastest thing I have sitting here on my disk only has
the swake_up() which does TASK_NORMAL, no choice there.
