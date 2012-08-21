From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Using random in interrupts for RT
Date: Tue, 21 Aug 2012 14:12:13 -0400
Message-ID: <1345572733.5069.9.camel@gandalf.local.home>
References: <1344954649.6724.13.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	RT <linux-rt-users@vger.kernel.org>,
	Theodore Tso <tedtso@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344954649.6724.13.camel@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2012-08-14 at 10:30 -0400, Steven Rostedt wrote:
> Thomas,
> 
> Ben Hutchings asked me if we still need "genirq: Disable random call on
> preempt-rt" for -rt? With commit 902c098a366 "random: use lockless
> techniques in the interrupt path" there is no more locks used. But does
> it still produce high latencies?

Ben,

Looks that the #ifndef can't be removed just yet. The code is not
totally lockless...


add_interrupt_randomness ->
	credit_entropy_bits ->
		kill_fasync ->
			kill_fasync_rcu ->
				spin_lock_irqsave(&fa->fa_lock, flags)

to make things worse, that spinlock turns into a mutex on -rt, so it may
crash the box if triggered.

-- Steve
