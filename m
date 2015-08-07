From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Fri, 7 Aug 2015 09:41:31 -0700
Message-ID: <20150807164131.GA20239@infradead.org>
References: <20150116114846.4e7b718d@gandalf.local.home>
 <20150119144100.GA10794@amt.cnet>
 <20150120054653.GA6473@iris.ozlabs.ibm.com>
 <20150120131613.009903a0@gandalf.local.home>
 <20150121150716.GD11596@twins.programming.kicks-ass.net>
 <20150217174419.GY26177@linutronix.de>
 <20150218140320.GY5029@twins.programming.kicks-ass.net>
 <20150225210250.GA25858@linutronix.de>
 <20150807105738.GF16853@twins.programming.kicks-ass.net>
 <20150807111415.GC18673@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul Mackerras <paulus@samba.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150807111415.GC18673@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Aug 07, 2015 at 01:14:15PM +0200, Peter Zijlstra wrote:
> On that, we cannot convert completions to swait. Because swait wake_all
> must not happen from IRQ context, and complete_all() typically is used
> from just that.

If swait queues aren't useable from IRQ context they will be fairly
useless.  What's the problem with making them irq safe?
