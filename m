From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Sat, 18 Apr 2015 19:05:42 -0700
Message-ID: <20150419020541.GA5561@linux.vnet.ibm.com>
References: <20150416183812.GA5571@linux.vnet.ibm.com>
 <20150418130340.GA26931@gmail.com>
 <20150418133444.GD23685@linux.vnet.ibm.com>
 <20150418143238.GA2337@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	a.p.zijlstra@chello.nl, akpm@linux-foundation.org,
	linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150418143238.GA2337@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, Apr 18, 2015 at 04:32:38PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Sat, Apr 18, 2015 at 03:03:41PM +0200, Ingo Molnar wrote:
> > > 
> > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > > 
> > > > Hello, Ingo,
> > > > 
> > > > This series contains a single change that fixes Kconfig asking pointless
> > > > questions (https://lkml.org/lkml/2015/4/14/616).  This is an RFC pull
> > > > because there has not yet been a -next build for April 16th.  If you
> > > > would prefer to wait until after -next has pulled this, please let me
> > > > know and I will redo this pull request after that has happened.
> > > > 
> > > > In the meantime, this change is available in the git repository at:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> > > > 
> > > > for you to fetch changes up to 8d7dc9283f399e1fda4e48a1c453f689326d9396:
> > > > 
> > > >   rcu: Control grace-period delays directly from value (2015-04-14 19:33:59 -0700)
> > > > 
> > > > ----------------------------------------------------------------
> > > > Paul E. McKenney (1):
> > > >       rcu: Control grace-period delays directly from value
> > > > 
> > > >  kernel/rcu/tree.c | 16 +++++++++-------
> > > >  lib/Kconfig.debug |  1 +
> > > >  2 files changed, 10 insertions(+), 7 deletions(-)
> > > 
> > > Pulled, thanks a lot Paul!
> > > 
> > > Note, while this fixes Linus's immediate complaint that arose from the 
> > > new option, I still think we need to do more fixes in this area.
> > 
> > Good point!
> > 
> > > To demonstrate the current situation I tried the following experiment, 
> > > I did a 'make defconfig' on an x86 box and then took the .config and 
> > > deleted all 'RCU Subsystem' options not marked as debugging.
> > > 
> > > Then I did a 'make oldconfig' to see what kinds of questions a user is 
> > > facing when trying to configure RCU:
> > > 
> > > 	*
> > > 	* Restart config...
> > > 	*
> > > 	*
> > > 	* RCU Subsystem
> > > 	*
> > > 	RCU Implementation
> > > 	> 1. Tree-based hierarchical RCU (TREE_RCU) (NEW)
> > > 	choice[1]: 1
> > 
> > Hmmm...  Given that there is no choice, I agree that it is a bit silly
> > to ask...
> 
> To clarify: this doesn't actually ask - it gets skipped by the kconfig 
> tool. All the rest is an interactive prompt.

Ah, good point!

> > > 	Task_based RCU implementation using voluntary context switch (TASKS_RCU) [N/y/?] (NEW) 
> > 
> > Agreed, this one should be driven directly off of CONFIG_RCU_TORTURE_TEST
> > and the tracing use case.
> 
> Yeah.

OK, will do.

> > > 	Consider userspace as in RCU extended quiescent state (RCU_USER_QS) [N/y/?] (NEW) 
> > 
> > This should be driven directly off of CONFIG_NO_HZ_FULL, unless 
> > Frederic knows something I don't.
> 
> Yes.

Then unless Frederic objects...  ;-)

> > > 	Tree-based hierarchical RCU fanout value (RCU_FANOUT) [64] (NEW) 
> > 
> > Hmmm...  I could drop/obscure this one in favor of a boot parameter.
> 
> Well, what I think might be even bette to make it scale based on 
> CONFIG_NR_CPUS. Distros already actively manage the 'maximum number of 
> CPUs we support', so relying on that value makes sense.
> 
> So if someone sets CONFIG_NR_CPUS to 1024, it gets scaled accordingly. 
> If CONFIG_NR_CPUS is set to 2, it gets scaled to a minimal config. 
> Note that this would excercise and test the affected codepaths better 
> as well, as we'd get different size setups.
> 
> As for the boot option to override it: what would be the usecase for 
> that?

Well, in normal circumstances, it should be 64 for 64-bit systems and
32 for 32-bit systems, regardless of number of CPUs.  But if you had
an odd-sized multisocket system with extremely high socket-to-socket
memory latencies, you might want to select a different value.  For
a silly example, suppose your system had 27 hardware threads per socket.
Then you might want to set both RCU_FANOUT_LEAF and RCU_FANOUT to 27.

Or use a boot parameter to do so, as can be done today for RCU_FANOUT_LEAF.

@@@

> > > 	Tree-based hierarchical RCU leaf-level fanout value (RCU_FANOUT_LEAF) [16] (NEW) 
> > 
> > Ditto -- though large configurations really do set this to 64 in 
> > combination with the skew_tick boot parameter.  Maybe we need to 
> > drive these off of some large-system parameter, like CONFIG_MAX_SMP.
> 
> Or rather CONFIG_NR_CPUS. CONFIG_MAX_SMP is really a debugging thing, 
> to configure the system to the silliest high settings that doesn't 
> outright crash - but it doesn't make much sense otherwise.

Except that setting RCU_FANOUT_LEAF to 64 without also booting with
skew_tick=1 is a really bad idea, as the synchronized scheduling-clock
interrupts will cause ugly levels of lock contention on the rcu_node
->lock.  :-(

But perhaps making the default value of sched_skew_tick be 1 if
RCU_FANOUT_LEAF is greater than 16 is the right solution.

> > > 	Disable tree-based hierarchical RCU auto-balancing (RCU_FANOUT_EXACT) [N/y/?] (NEW) 
> > 
> > I should just make this a boot parameter.  Absolutely no reason for 
> > it to be a Kconfig parameter.
> 
> Again I'd size this to NR_CPUS - and for the boot parameter, I'd think 
> about actual usecases.

The intended use case is related to the odd-sized systems mentioned
for RCU_FANOUT.  By default, we spread CPUs across the leaf-level
rcu_node structures to reduce lock contention, via RCU_FANOUT_EXACT=n.
Systems with high remote memory latencies might want RCU_FANOUT_EXACT=y
to have full control of the geometry.

Maybe I should just eliminate this choice, forcing the current default.

> > > 	Accelerate last non-dyntick-idle CPU's grace periods (RCU_FAST_NO_HZ) [N/y/?] (NEW) 
> > 
> > On this one, I have no idea.  Its purpose is energy efficiency, but 
> > it does have some downsides, for example, increasing idle entry/exit 
> > latency. I am a bit nervous about having it be a boot parameter 
> > because that would leave an extra compare-branch in the path.  This 
> > one will require some thought.
> 
> Keeping this one configurable, with a good default and a good 
> explanation makes sense. There's a lot of 
> 
> > > 	Real-time priority to use for RCU worker threads (RCU_KTHREAD_PRIO) [0] (NEW) 
> > 
> > Indeed, Linus complained about this one.  ;-)
> 
> :-) Yes, it's an essentially unanswerable question.
> 
> > This Kconfig parameter is a stopgap, and needs a real solution.  
> > People with crazy-heavy workloads involving realtime cannot live 
> > without it, but that means that most people don't have to care.  I 
> > have had solving this on my list, and this clearly increases its 
> > priority.
> 
> So what value do they use, prio 99? 98? It might be better to offer 
> this option as a binary choice, and set a given priority. If -rt 
> people complain then they might help us in solving it properly.

I honestly do not remember what priority they were using, it is
not in email, and I don't keep IRC logs that far back.  Adding
linux-rt-users@vger.kernel.org on CC.

> > > 	Offload RCU callback processing from boot-selected CPUs (RCU_NOCB_CPU) [N/y/?] (NEW) 
> > 
> > Hmmm...  Maybe a boot parameter, but I thought that there was some 
> > reason that this was problematic.  I will have to take another look.
> > 
> > Anyway, this one is important to non-NO_HZ_FULL real-time workloads. 
> > In a -rt kernel, making CONFIG_PREEMPT_RT (or whatever it is these 
> > days) drive this one makes a lot of sense.
> 
> Ok.

But in the meantime, it looks like making non-default settings depend on
RCU_EXPERT it the right thing to do.

> > > 	#
> > > 	# configuration written to .config
> > > 	#
> > > 
> > > Only TREE_RCU is available on defconfig, so all the other options 
> > > marked with '(NEW)' were offered as an interactive prompt.
> > > 
> > > I don't think that any of the 8 interactive options (!) here are 
> > > particularly useful to even advanced users who configure kernels, and 
> > > I don't think they should be offered under non-expert settings.
> > 
> > Would it make sense to have a CONFIG_RCU_EXPERT setting to hide the 
> > remaining settings?  That would reduce the common-case number of 
> > questions to one, which would be a quick and safe improvement. 
> > Especially when combined with the changes I called out above.
> 
> Yes, that's absolutely sensible - although I'd also do the 
> CONFIG_NR_CPUS based auto-scaling if it's not set, to make sure 
> distros don't end up tuning this (inevitably imperfectly) which won't 
> flow back upstream:
> 
> That's the other main problem with widely tunable, numeric settings, 
> beyond their user hostility: if they are wrong and are corrected in a 
> distro they don't flow back to upstream, so they are dead end 
> mechanisms as far as code quality and good defaults are concerned.

OK, I will put the surviving options under CONFIG_RCU_EXPERT, and I will
check around to see if I can find any cases of distros setting them to
non-default values.

							Thanx, Paul
