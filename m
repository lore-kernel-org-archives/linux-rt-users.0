From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Mon, 17 Aug 2015 22:31:07 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508172228130.3873@nanos>
References: <20150114171459.593877145@redhat.com> <20150116114846.4e7b718d@gandalf.local.home> <20150119144100.GA10794@amt.cnet> <20150120054653.GA6473@iris.ozlabs.ibm.com> <20150120131613.009903a0@gandalf.local.home> <20150121150716.GD11596@twins.programming.kicks-ass.net>
 <20150217174419.GY26177@linutronix.de> <20150218140320.GY5029@twins.programming.kicks-ass.net> <20150225210250.GA25858@linutronix.de> <20150807105738.GF16853@twins.programming.kicks-ass.net> <20150807111415.GC18673@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-203970585-1439843468=:3873"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul Mackerras <paulus@samba.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150807111415.GC18673@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-203970585-1439843468=:3873
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 7 Aug 2015, Peter Zijlstra wrote:
> On Fri, Aug 07, 2015 at 12:57:38PM +0200, Peter Zijlstra wrote:
> 
> > > >+void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
> 
> > > this one has no users the __ suggests that it is locked edition. Maybe
> > > it is for the completions…
> > 
> > Yeah, who knows, I certainly do not anymore ;-)
> 
> On that, we cannot convert completions to swait. Because swait wake_all
> must not happen from IRQ context, and complete_all() typically is used
> from just that.

Well, completions are not the ones which have a gazillion of waiters
and we got quite some performance back from using swait in completions
on RT.

Thanks,

	tglx

--8323329-203970585-1439843468=:3873--
