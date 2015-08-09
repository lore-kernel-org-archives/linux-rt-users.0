From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Sat, 8 Aug 2015 23:39:47 -0700
Message-ID: <20150809063947.GA2436@infradead.org>
References: <20150120054653.GA6473@iris.ozlabs.ibm.com>
 <20150120131613.009903a0@gandalf.local.home>
 <20150121150716.GD11596@twins.programming.kicks-ass.net>
 <20150217174419.GY26177@linutronix.de>
 <20150218140320.GY5029@twins.programming.kicks-ass.net>
 <20150225210250.GA25858@linutronix.de>
 <20150807105738.GF16853@twins.programming.kicks-ass.net>
 <20150807111415.GC18673@twins.programming.kicks-ass.net>
 <20150807164131.GA20239@infradead.org>
 <20150807164526.GO12596@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Hellwig <hch@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150807164526.GO12596@twins.programming.kicks-ass.net>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Aug 07, 2015 at 06:45:26PM +0200, Peter Zijlstra wrote:
> Its just the swait_wake_all() that is not. The entire purpose of them
> was to have something that allows bounded execution (RT and all).

Still not sure i that might be a too big burden for mainline, but at
least it's not as severe..
