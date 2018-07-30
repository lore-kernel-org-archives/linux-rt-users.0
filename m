From: Mike Galbraith <efault@gmx.de>
Subject: Re: [rt-patch 3/3] arm, KVM: convert vgic_irq.irq_lock to
 raw_spinlock_t
Date: Mon, 30 Jul 2018 15:34:42 +0200
Message-ID: <1532957682.30205.42.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de> <1532768853.9882.73.camel@gmx.de>
         <20180730092728.GE2494@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730092728.GE2494@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2018-07-30 at 11:27 +0200, Peter Zijlstra wrote:
> 
> The thing missing from the Changelog is the analysis that all the work
> done under these locks is indeed properly bounded and cannot cause
> excessive latencies.

True, I have no idea what worst case hold times are.  Nothing poked me
dead in the eye when looking around in completely alien code, nor did
cyclictest inspire concern running on box with no base of comparison.

I do know that latency is now < infinity, a modest improvement ;-)

	-Mike
