From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Mon, 20 Apr 2015 14:34:40 -0400
Message-ID: <20150420143440.49e1e537@gandalf.local.home>
References: <20150416183812.GA5571@linux.vnet.ibm.com>
	<20150418130340.GA26931@gmail.com>
	<20150418133444.GD23685@linux.vnet.ibm.com>
	<20150418143238.GA2337@gmail.com>
	<20150419020541.GA5561@linux.vnet.ibm.com>
	<20150420113554.598e503f@sluggy>
	<20150420170902.GU5561@linux.vnet.ibm.com>
	<20150420180107.GE24936@home.goodmis.org>
	<20150420180904.GA19229@gmail.com>
	<20150420142149.3ac58a2c@gandalf.local.home>
	<20150420182831.GA19510@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	a.p.zijlstra@chello.nl, akpm@linux-foundation.org,
	linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150420182831.GA19510@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 20 Apr 2015 20:28:32 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> Instrumentation - especially instrumentation that should have been 
> implemented mostly in user-space, like ftrace ;-) - is another special 
> case that should stay as flexible as possible via sysctls, obviously.

I know I used ftrace as an example, but a more appropriate example
would be the sched knobs, as this is more about rcu scheduling than
anything else.

See:

sched_autogroup_enabled      sched_rr_timeslice_ms
sched_child_runs_first       sched_rt_period_us
sched_domain/                sched_rt_runtime_us
sched_latency_ns             sched_shares_window_ns
sched_migration_cost_ns      sched_time_avg_ms
sched_min_granularity_ns     sched_tunable_scaling
sched_nr_migrate             sched_wakeup_granularity_ns

In particular, the sched_rt_* ones.


-- Steve
