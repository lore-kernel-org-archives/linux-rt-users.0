From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: allow preemption in check_task_state
Date: Mon, 10 Feb 2014 18:38:33 +0100
Message-ID: <20140210173833.GQ9987@twins.programming.kicks-ass.net>
References: <20140210153856.GD20017@opentech.at>
 <20140210111106.67438d1e@gandalf.local.home>
 <20140210171712.GA17517@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140210171712.GA17517@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Feb 10, 2014 at 06:17:12PM +0100, Nicholas Mc Guire wrote:
> maybe I'm missing/missunderstanding something here but
> pi_unlock -> arch_spin_unlock is a full mb() 

Nope, arch_spin_unlock() on x86 is a single add[wb] without LOCK prefix.

The lock and unlock primitives are in general specified to have ACQUIRE
resp. RELEASE semantics.

See Documentation/memory-barriers.txt for far too much head-hurting
details.
