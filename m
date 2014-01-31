From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] timer: really raise softirq if there is irq_work to
 do
Date: Fri, 31 Jan 2014 21:05:35 +0100
Message-ID: <20140131200535.GR5002@laptop.programming.kicks-ass.net>
References: <1391178845-15837-1-git-send-email-bigeasy@linutronix.de>
 <1391178845-15837-2-git-send-email-bigeasy@linutronix.de>
 <20140131120757.594e24d6@gandalf.local.home>
 <20140131174227.GN9012@linux.vnet.ibm.com>
 <20140131125719.73340f6e@gandalf.local.home>
 <52EBF8FE.3080608@linutronix.de>
 <20140131143441.478f79ee@gandalf.local.home>
 <52EBFE1D.4020201@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, paulmck@linux.vnet.ibm.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, Clark Williams <williams@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52EBFE1D.4020201@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Jan 31, 2014 at 08:48:45PM +0100, Sebastian Andrzej Siewior wrote:
> 
> How "bad" is it? Is this something generic or just not getting
> perf events fast enough out? Most users don't seem to require small
> latencies.

I have vague memories of there being an actual perf problem if there's a
hole between the NMI/IRQ triggering the irq_work and the interrupt
running the work.

I should have some notes on it somewhere and an todo entry to plug the
hole.

But note that the MCE code also uses irq_work, they really _need_ to be
fast because the system might be crumbling under their feet.
