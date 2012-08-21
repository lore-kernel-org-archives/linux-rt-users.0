From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Using random in interrupts for RT
Date: Tue, 21 Aug 2012 20:12:55 +0100
Message-ID: <20120821191255.GH29217@decadent.org.uk>
References: <1344954649.6724.13.camel@gandalf.stny.rr.com>
 <1345572733.5069.9.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Theodore Tso <tedtso@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1345572733.5069.9.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Aug 21, 2012 at 02:12:13PM -0400, Steven Rostedt wrote:
> On Tue, 2012-08-14 at 10:30 -0400, Steven Rostedt wrote:
> > Thomas,
> > 
> > Ben Hutchings asked me if we still need "genirq: Disable random call on
> > preempt-rt" for -rt? With commit 902c098a366 "random: use lockless
> > techniques in the interrupt path" there is no more locks used. But does
> > it still produce high latencies?
> 
> Ben,
> 
> Looks that the #ifndef can't be removed just yet. The code is not
> totally lockless...
> 
> 
> add_interrupt_randomness ->
> 	credit_entropy_bits ->
> 		kill_fasync ->
> 			kill_fasync_rcu ->
> 				spin_lock_irqsave(&fa->fa_lock, flags)
> 
> to make things worse, that spinlock turns into a mutex on -rt, so it may
> crash the box if triggered.
 
Thanks for checking this.

Ben.

-- 
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                              - Albert Camus
