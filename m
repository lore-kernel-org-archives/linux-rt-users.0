From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/rt: don't try to balance rt_runtime when it is
 futile
Date: Tue, 20 May 2014 18:36:51 +0200
Message-ID: <20140520163651.GY2485@laptop.programming.kicks-ass.net>
References: <1400123931.5175.38.camel@marge.simpson.net>
 <1400386954.5140.36.camel@marge.simpson.net>
 <20140518052039.GF4570@linux.vnet.ibm.com>
 <1400402201.5166.13.camel@marge.simpson.net>
 <20140518155815.GK4570@linux.vnet.ibm.com>
 <1400467481.5211.48.camel@marge.simpson.net>
 <20140519053401.GP4570@linux.vnet.ibm.com>
 <20140520145350.GC17741@localhost.localdomain>
 <20140520155324.GD4570@linux.vnet.ibm.com>
 <20140520162433.GE17741@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Frederic Weisbecker <fweisbec@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140520162433.GE17741@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, May 20, 2014 at 06:24:36PM +0200, Frederic Weisbecker wrote:
> Of course one can argue that we can find out that the task is resuming in userspace from
> CPU 0 scheduler entry without the need for previous context tracking, but I couldn't find safe
> solution for that. This is because probing on user/kernel boundaries can only be done
> in the soft way, throught explicit function calls. So there is an inevitable shift
> between soft and hard boundaries, between what we probe and what we can guess.

you can hook into set_task_cpu(), not sure its going to be pretty, but
that is _the_ place to hook migration related nonsense.
