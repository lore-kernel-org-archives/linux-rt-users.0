From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [RFC PATCH RT] rwsem: The return of multi-reader PI rwsems
Date: Fri, 11 Apr 2014 06:25:27 +0200
Message-ID: <1397190327.5139.36.camel@marge.simpson.net>
References: <20140409151922.5fa5d999@gandalf.local.home>
	 <1397139510.5137.92.camel@marge.simpson.net>
	 <1397140123.5137.99.camel@marge.simpson.net>
	 <1397184626.5139.24.camel@marge.simpson.net>
	 <20140410232542.23ee9920@gandalf.local.home>
	 <1397188356.5139.33.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397188356.5139.33.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2014-04-11 at 05:52 +0200, Mike Galbraith wrote: 
> On Thu, 2014-04-10 at 23:25 -0400, Steven Rostedt wrote: 
> > On Fri, 11 Apr 2014 04:50:26 +0200
> > Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
> > 
> > > Oh, there was another useful bit. 
> > > 
> > > 3.12.17-rt25       403991     384216     377786
> > >                    405466     394011     392850
> > > 
> > > 3.12.17-nopreempt  109049     186133     118766  !?!.. ew, TTWU_QUEUE
> > >                    350385     318786     367336  !TTWU_QUEUE
> > >                    326009     356939     378215  !TTWU_QUEUE
> > > 
> > > IPI == low-pass filter.
> > 
> > I'm sorry, but I don't have the foggiest clue to what the above means.
> 
> It means..
> 
> # Overhead                                                                                                                                                                                   Symbol
> # ........  .......................................................................................................................................................................................
> #
>     17.33%  [k] native_write_msr_safe
>             |
>             |--88.45%-- __x2apic_send_IPI_mask
>             |          |
>             |          |--97.89%-- try_to_wake_up
>             |          |          |
>             |          |          |--99.91%-- wake_futex
>             |          |          |          |
>             |          |          |          |--99.77%-- futex_wake_op
>             |          |          |          |          do_futex
>             |          |          |          |          sys_futex
>             |          |          |          |          system_call_fastpath
> 
> ..wakeup frequency is restricted by the IPI.

Turn TTWU_QUEUE off, bottleneck goes away.

# Overhead                                                                                                                                                                                   Symbol
# ........  .......................................................................................................................................................................................
#
     6.12%  [.] _ZN13ObjectMonitor20TrySpin_VaryDurationEP6Thread
            |
            |--61.27%-- _ZN13ObjectMonitor5enterEP6Thread
            |          |
            |          |--99.96%-- _ZN13SharedRuntime26complete_monitor_locking_CEP7oopDescP9BasicLockP10JavaThread
            |          |          0x7f93149b2748
            |          |          |
            |          |          |--99.76%-- 0xf1a02b30
            |          |          |          0xbaba00000000fc24
            |          |           --0.24%-- [...]
            |           --0.04%-- [...]
            |
            |--38.40%-- _ZN13ObjectMonitor6EnterIEP6Thread
            |          _ZN13ObjectMonitor5enterEP6Thread
            |          |
            |          |--99.98%-- _ZN13SharedRuntime26complete_monitor_locking_CEP7oopDescP9BasicLockP10JavaThread
            |          |          0x7f93149b2748
            |          |          |
            |          |          |--99.89%-- 0xf1a02b30
            |          |          |          0xbaba00000000fc24
            |          |           --0.11%-- [...]
            |           --0.02%-- [...]
             --0.32%-- [...]

     3.59%  [k] intel_idle
            |
            --- cpuidle_enter_state
                cpuidle_idle_call
                arch_cpu_idle
                cpu_startup_entry
