From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT] arm*: disable NEON in kernel mode
Date: Fri, 1 Dec 2017 18:39:43 +0100
Message-ID: <20171201173943.5mnr7zkr4axxgpfx@hirez.programming.kicks-ass.net>
References: <20171130142216.GB12606@linutronix.de>
 <20171130143028.GA1351@linutronix.de>
 <20171201104331.GB1612@linutronix.de>
 <20171201134506.GF1612@linutronix.de>
 <20171201141827.yip6pl3tt7kxzek7@lakrids.cambridge.arm.com>
 <20171201143648.GK1612@linutronix.de>
 <20171201171458.3a2acsltiq54gvuu@hirez.programming.kicks-ass.net>
 <20171201173120.GL10595@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org, ard.biesheuvel@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201173120.GL10595@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Dec 01, 2017 at 05:31:20PM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 01, 2017 at 06:14:58PM +0100, Peter Zijlstra wrote:
> > Well, PREEMPT cares about that too.
> 
> Preempt may care, but it's the hit you take to use neon in the kernel.
> The neon register set shares with the FPU, so preempting during that
> path means that the normal FPU register saving would corrupt the
> already saved user FPU context - and even worse would result in the
> kernel's crypto function register contents being leaked to userspace.

Same thing on x86.

> If you care about preempt deeply, the only solution is to avoid using
> kernel mode neon.

Not quite, you can write the code such that it drops out of neon mode
regularly to allow preemption.

So setup a crypto block, enter neon, transform the block, drop out of
neon, rinse repeat.
