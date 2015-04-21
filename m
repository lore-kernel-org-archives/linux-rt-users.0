From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Tue, 21 Apr 2015 08:42:23 +0200
Message-ID: <20150421064222.GA22291@gmail.com>
References: <20150418133444.GD23685@linux.vnet.ibm.com>
 <20150418143238.GA2337@gmail.com>
 <20150419020541.GA5561@linux.vnet.ibm.com>
 <20150420113554.598e503f@sluggy>
 <20150420170902.GU5561@linux.vnet.ibm.com>
 <20150420180107.GE24936@home.goodmis.org>
 <20150420180904.GA19229@gmail.com>
 <20150420142149.3ac58a2c@gandalf.local.home>
 <20150420182831.GA19510@gmail.com>
 <20150420143440.49e1e537@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	a.p.zijlstra@chello.nl, akpm@linux-foundation.org,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150420143440.49e1e537@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 20 Apr 2015 20:28:32 +0200
> Ingo Molnar <mingo@kernel.org> wrote:
> 
> > Instrumentation - especially instrumentation that should have been 
> > implemented mostly in user-space, like ftrace ;-) - is another special 
> > case that should stay as flexible as possible via sysctls, obviously.
> 
> I know I used ftrace as an example, but a more appropriate example
> would be the sched knobs, as this is more about rcu scheduling than
> anything else.
> 
> See:
> 
> sched_autogroup_enabled      sched_rr_timeslice_ms
> sched_child_runs_first       sched_rt_period_us
> sched_domain/                sched_rt_runtime_us
> sched_latency_ns             sched_shares_window_ns
> sched_migration_cost_ns      sched_time_avg_ms
> sched_min_granularity_ns     sched_tunable_scaling
> sched_nr_migrate             sched_wakeup_granularity_ns

You are comparing apples to oranges.

1)

Many of these are only sysctls if CONFIG_SCHED_DEBUG is enabled, see:

 triton:~/tip> git grep const_debug kernel/sched/*.c
 kernel/sched/core.c:const_debug unsigned int sysctl_sched_features =
 kernel/sched/core.c:const_debug unsigned int sysctl_sched_nr_migrate = 32;
 kernel/sched/core.c:const_debug unsigned int sysctl_sched_time_avg = MSEC_PER_SEC;
 kernel/sched/core.c:const_debug unsigned int sysctl_timer_migration = 1;
 kernel/sched/fair.c:const_debug unsigned int sysctl_sched_migration_cost = 500000UL;

and they turn into 'const' otherwise:

 /*
  * Tunables that become constants when CONFIG_SCHED_DEBUG is off:
  */
 #ifdef CONFIG_SCHED_DEBUG
 # include <linux/static_key.h>
 # define const_debug __read_mostly
 #else
 # define const_debug const
 #endif

2)

A handful of them are simple on/off knobs, such as the 
sched_child_runs_first quirk, or the sched_autogroup_enabled.

3)

There's basically just the three sched_rt_* ones that are 'true' 
tunables (not on/off knobs), mostly because of ABI weakness: 
setscheduler() has no interface for them.

Note that modern scheduler policies, like SCHED_DEADLINE, get all 
their policy parameters from the sched_setparam() user-space ABI, they 
are not driven by sysctls.

So my point stands.

Thanks,

	Ingo
