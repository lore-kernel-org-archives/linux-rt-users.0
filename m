From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RCU stall and the system boot hang with nfsroot
Date: Tue, 5 Jan 2016 10:51:42 -0800
Message-ID: <20160105185142.GD3818@linux.vnet.ibm.com>
References: <CALSz7m2KNryL1uo3u1jody3+VYcTga8ZwsHth95Ne1DKy7HzgA@mail.gmail.com>
 <CALSz7m00vj1yVETgwEAei+qXi+i+5=srNdY8oqZOcjAnv8Z4DQ@mail.gmail.com>
 <20151229234229.GJ4054@linux.vnet.ibm.com>
 <CALSz7m3C4vj3Rp2uZvYc--_Zo5z+=8joGfPSbw1wY+Z1HzM_7g@mail.gmail.com>
 <20151230174145.GN4054@linux.vnet.ibm.com>
 <20151231194949.GA20877@linux.vnet.ibm.com>
 <CALSz7m0yiX382+g4BEoZj4GF3vXsHkrBD-Y5oODM2DJE--vpfA@mail.gmail.com>
 <20160104211838.GF32217@linux.vnet.ibm.com>
 <CALSz7m0pfOZeExspD8vYAiwdso0Y94o=2OvaCvRZ6ee5TCTEnQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Aaron Ma <mapengyu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALSz7m0pfOZeExspD8vYAiwdso0Y94o=2OvaCvRZ6ee5TCTEnQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jan 05, 2016 at 03:57:54PM +0800, Aaron Ma wrote:
> On Tue, Jan 5, 2016 at 5:18 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Mon, Jan 04, 2016 at 06:01:37PM +0800, Aaron Ma wrote:
> >> On Fri, Jan 1, 2016 at 3:49 AM, Paul E. McKenney
> >> <paulmck@linux.vnet.ibm.com> wrote:
> >> > On Wed, Dec 30, 2015 at 09:41:45AM -0800, Paul E. McKenney wrote:
> >> >> On Wed, Dec 30, 2015 at 03:03:33PM +0800, Aaron Ma wrote:
> >> >> > On Wed, Dec 30, 2015 at 7:42 AM, Paul E. McKenney
> >> >> > <paulmck@linux.vnet.ibm.com> wrote:
> >> >
> >> > [ . . . ]
> >> >
> >> >> > cfg80211: Calling CRDA to update world regulatory domain
> >> >> > cfg80211: Calling CRDA to update world regulatory domain
> >> >> > cfg80211: Exceeded CRDA call max attempts. Not calling CRDA
> >> >> > INFO: rcu_preempt detected stalls on CPUs/tasks:
> >> >> >     71: (0 ticks this GP) idle=1ac/0/0 softirq=0/0 fqs=0
> >> >> >     (detected by 62, t=26002 jiffies, g=3735, c=3734, q=366014)
> >> >> > Task dump for CPU 71:
> >> >> > swapper/71      R  running task        0     0      1 0x00200000
> >> >> >  ffffffff81492587 ffff8804633cbe58 ffffffff814f21d7 0000000000000004
> >> >> >  0000000000000004 ffffe8fffb405310 ffffffff820dc5c0 ffff8804633cbea8
> >> >> >  ffffffff8181db85 0000000000000000 0000000000000000 0000000000000046
> >> >> > Call Trace:
> >> >> >  [<ffffffff81492587>] ? debug_smp_processor_id+0x17/0x20
> >> >> >  [<ffffffff814f21d7>] ? intel_idle+0x137/0x140
> >> >> >  [<ffffffff8181db85>] ? cpuidle_enter_state+0x65/0x3e0
> >> >> >  [<ffffffff8181df37>] ? cpuidle_enter+0x17/0x20
> >> >> >  [<ffffffff810a849d>] ? cpu_startup_entry+0x33d/0x630
> >> >> >  [<ffffffff8103ceae>] ? start_secondary+0x12e/0x140
> >> >> > rcu_preempt kthread starved for 26002 jiffies!
> >> >> > rcu_check_gp_kthread_starvation --->show task:
> >> >> > rcu_preempt     S ffff880456413c68     0     8      2 0x00000000
> >> >> >  ffff880456413c68 ffff8804564025d0 000000000000d7a0 ffff880456b18000
> >> >> >  ffff8804564025d0 ffff880456413c38 ffffffff81492587 ffff880456413c58
> >> >> >  ffff880456414000 ffff8804564025d0 ffff880456413cb8 ffff880869dce500
> >> >> > Call Trace:
> >> >> >  [<ffffffff81492587>] ? debug_smp_processor_id+0x17/0x20
> >> >> >  [<ffffffff81b5ce9f>] schedule+0x3f/0xd0
> >> >> >  [<ffffffff81b5ef19>] schedule_timeout+0x189/0x3f0
> >> >> >  [<ffffffff810a7904>] ? swait_prepare+0x24/0x90
> >> >> >  [<ffffffff810e8e60>] ? timer_cpu_notify+0x190/0x190
> >> >> >  [<ffffffff810a793b>] ? swait_prepare+0x5b/0x90
> >> >> >  [<ffffffff810de3f8>] rcu_gp_kthread+0x8a8/0x2190
> >> >> >  [<ffffffff810b275d>] ? trace_hardirqs_on+0xd/0x10
> >> >> >  [<ffffffff81b5c18f>] ? __schedule+0x4af/0x1180
> >> >> >  [<ffffffff810ddb50>] ? call_rcu_sched+0x20/0x20
> >> >> >  [<ffffffff8107f844>] kthread+0xe4/0x100
> >> >> >  [<ffffffff810b275d>] ? trace_hardirqs_on+0xd/0x10
> >> >> >  [<ffffffff8107f760>] ? kthread_create_on_node+0x240/0x240
> >> >> >  [<ffffffff81b61562>] ret_from_fork+0x42/0x70
> >> >> >  [<ffffffff8107f760>] ? kthread_create_on_node+0x240/0x240
> >> >> > rcu_check_gp_kthread_starvation --->end
> >> >> >
> >> >> > It seems wait in rcu_gp_kthread. it should be no task blocked right?
> >> >> > If so, why the swait_event_interruptible_timeout is not awaken? the
> >> >> > timeout is CONFIG_HZ=1000.
> >> >>
> >> >> Given that this happens at boot, perhaps ftrace is a good next step.
> >> >> The thought would be to enable ftrace via the kernel boot parameters
> >> >> for the timers.
> >> >>
> >> >> And how often does this problem occur?
> >> >
> >> > And does the following diagnostic patch help?  Its expected behavior
> >> > would be to turn a hard hang into something that recovered in a few
> >> > minutes, while giving a few stall-warning splats.
> >> >
> >> >                                                         Thanx, Paul
> >> >
> >> > ------------------------------------------------------------------------
> >> >
> >> > commit 7798a5efb2acabfa3ca788dd9b5b118eb1bff443
> >> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >> > Date:   Thu Dec 31 08:48:36 2015 -0800
> >> >
> >> >     rcu: Awaken grace-period kthread when stalled
> >> >
> >> >     Recent kernels can fail to awaken the grace-period kthread for
> >> >     quiescent-state forcing.  This commit is a crude hack that does
> >> >     a wakeup any time a stall is detected.
> >> >
> >> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >> >
> >> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> > index 4b3de6718f7c..51da7ef3561f 100644
> >> > --- a/kernel/rcu/tree.c
> >> > +++ b/kernel/rcu/tree.c
> >> > @@ -1225,8 +1225,10 @@ static void rcu_check_gp_kthread_starvation(struct rcu_state *rsp)
> >> >                        rsp->gp_flags,
> >> >                        gp_state_getname(rsp->gp_state), rsp->gp_state,
> >> >                        rsp->gp_kthread ? rsp->gp_kthread->state : ~0);
> >> > -               if (rsp->gp_kthread)
> >> > +               if (rsp->gp_kthread) {
> >> >                         sched_show_task(rsp->gp_kthread);
> >> > +                       wake_up_process(rsp->gp_kthread);
> >> > +               }
> >> >         }
> >> >  }
> >>
> >> Sorry for late response because of holiday.
> >>
> >> During my knowledge, now this issue is splitted to 2 issues.
> >>
> >> First, there is a mistake in the kernel I used.
> >> I used kernel is changed by someone else, and it ported a patch:
> >> Author: Thomas Gleixner <tglx@linutronix.de>
> >> Date:   Tue Apr 14 21:08:54 2015 +0000
> >>
> >>     tick: sched: Force tick interrupt and get rid of softirq magic
> >>
> >>     commit 0ff53d09642204c648424def0caa9117e7a3caaf upstream
> >>
> >>  static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
> >>                                          ktime_t now, int cpu)
> >>  {
> >> @@ -691,22 +705,18 @@ static ktime_t tick_nohz_stop_sched_tick(struct
> >> tick_sched *ts,
> >>                         if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
> >>                                 hrtimer_cancel(&ts->sched_timer);
> >>                         goto out;
> >> -               }
> >> +                }
> >>
> >> -               if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
> >> -                       hrtimer_start(&ts->sched_timer, expires,
> >> -                                     HRTIMER_MODE_ABS_PINNED);
> >> -                       goto out;
> >> -               } else if (!tick_program_event(expires, 0))
> >> -                       goto out;
> >> -               /*
> >> -                * We are past the event already. So we crossed a
> >> -                * jiffie boundary. Update jiffies and raise the
> >> -                * softirq.
> >> -                */
> >> -               tick_do_update_jiffies64(ktime_get());
> >> +                if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
> >> +                        hrtimer_start(&ts->sched_timer, expires,
> >> +                                      HRTIMER_MODE_ABS_PINNED);
> >> +                else
> >> +                        tick_program_event(expires, 1);
> >> +       } else {
> >> +               /* Tick is stopped, but required now. Enforce it */
> >> +               tick_nohz_restart(ts, now);
> >>         }
> >> -       raise_softirq_irqoff(TIMER_SOFTIRQ);
> >> +
> >>
> >> It remove the "raise_softirq_irqoff" in tick_nohz_stop_sched_tick, so
> >> the kernel will be not waked up in idle status.

By the way, this was a nice hint, but unfortunately did not pan out.
I don't see the problem on all NO_HZ_FULL scenarios, and do see it on
some non-NO_HZ_FULL scenarios.  :-/

							Thanx, Paul
