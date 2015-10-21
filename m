From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/4] KVM: use simple waitqueue for vcpu->wq
Date: Wed, 21 Oct 2015 13:13:05 +0200
Message-ID: <20151021111305.GL17308@twins.programming.kicks-ass.net>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-3-git-send-email-daniel.wagner@bmw-carit.de>
 <20151020140031.GG17308@twins.programming.kicks-ass.net>
 <20151021092411.GD15591@fergus.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Paul Mackerras <paulus@ozlabs.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151021092411.GD15591@fergus.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 21, 2015 at 08:24:11PM +1100, Paul Mackerras wrote:
> On Tue, Oct 20, 2015 at 04:00:31PM +0200, Peter Zijlstra wrote:
> > 
> > Should we not take this opportunity to get rid of these open-coded wait
> > loops?
> > 
> > 
> > Does this work?
> 
> No, on Book3S HV (POWER8) the VM hangs immediately after the kernel
> brings up all the secondary vCPUs, and is then unkillable.  I'm not
> sure what's wrong, although I wonder why you have TASK_IDLE rather
> than TASK_INTERRUPTIBLE in the ___wait_event call.

This was under the assumption that INTERRUPTIBLE was because you wanted
to avoid increasing load. Which was based on the lack of
signal_pending() tests near there (although there might have been in the
outermost loop which I overlooked).

If it does rely on signals, then this was obviously false and TASK_IDLE
is indeed wrong.
