From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: srcu: use cpu_online() instead custom check
Date: Thu, 8 Nov 2018 10:48:47 -0800
Message-ID: <20181108184847.GT4170@linux.ibm.com>
References: <20181101231228.GA9118@linux.ibm.com>
 <20181108163850.sjedoaom64tzvqgc@linutronix.de>
 <20181108171024.GM4170@linux.ibm.com>
 <20181108174655.mnm3cr4wn2hrrtep@linutronix.de>
 <20181108180517.GR4170@linux.ibm.com>
 <20181108181630.nsr3cyjwsch2y2r5@linutronix.de>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181108181630.nsr3cyjwsch2y2r5@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Nov 08, 2018 at 07:16:30PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-11-08 10:05:17 [-0800], Paul E. McKenney wrote:
> > Just to make sure I understand, this is the call to queue_delayed_work_on()
> > from srcu_queue_delayed_work_on(), right?
> 
> correct.
> 
> > And if I am guessing correctly, you would like to get rid of the
> > constraint requiring CPUHP_RCUTREE_PREP to precede CPUHP_TIMERS_PREPARE?
> 
> no, my problem is the preempt_disable() around queue_delayed_work_on().
> If the CPUs goes offline _after_ queue_delayed_work_on() then the timer
> gets migrated and work item should show up on another CPU. 
> If the CPU is offline at queue_delayed_work_on() time then the timer
> gets enqueued and won't fire until the CPU is back online and I *think*
> that is the reason behind this "is CPU online" check.

The main reason for the "is CPU online" check was that workqueues would
very rarely splat when I tried running without it.  I did report this
to Tejun.  You could try just calling queue_delayed_work_on() without
the check, but this is a 10s of hours rcutorture splat if I remember
correctly.

> > If so, the swait_event_idle_timeout_exclusive() in rcu_gp_fqs_loop()
> > in kernel/rcu/tree.c also requires this ordering.  There are probably
> > other pieces of code needing this.
> > 
> > Plus the reason for running this on a specific CPU is that the workqueue
> > item is processing that CPU's per-CPU variables, including invoking that
> > CPU's callbacks.  The item is srcu_invoke_callbacks().
> 
> The SRCU callback is invoking per-CPU variables? Like this_cpu_ptr()?
> But if the CPU is offline then you fallback to queue_delayed_work()?

Yes, yes, and yes.  ;-)

The callbacks are queued on a per-CPU basis.

							Thanx, Paul
