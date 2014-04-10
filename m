From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH RT] rwsem: The return of multi-reader PI rwsems
Date: Thu, 10 Apr 2014 15:17:41 -0400
Message-ID: <20140410151741.617f86d9@gandalf.local.home>
References: <20140409151922.5fa5d999@gandalf.local.home>
	<20140410094430.56ca9ee1@sluggy.gateway.2wire.net>
	<5346B2C8.6000207@linutronix.de>
	<20140410153617.GN10526@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140410153617.GN10526@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 10 Apr 2014 17:36:17 +0200
Peter Zijlstra <peterz@infradead.org> wrote:


> It defaults to the total number of CPUs in the system, given the default
> setup (all CPUs in a single balance domain), this should result in all
> CPUs working concurrently on the boosted read sides.

Unfortunately, it currently defaults to the number of possible CPUs in
the system. I should probably move the default assignment to after SMP
is setup. Currently it happens in early boot before all the CPUs are
running. On boot up, the limit is set to NR_CPUS which should be much
higher than what the system has, but shouldn't matter during boot. But
after all the CPUs are up and running, it can lower it to online CPUs.

I think I'll go and make v3 of this patch.

-- Steve
