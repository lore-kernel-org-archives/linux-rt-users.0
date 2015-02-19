From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch-3.18.7-rt1] sched/context-tracking: fix PREEMPT_LAZY
 explosions
Date: Thu, 19 Feb 2015 07:30:40 +0100
Message-ID: <1424327440.7438.10.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
	 <1424258514.3819.39.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424258514.3819.39.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2015-02-18 at 12:21 +0100, Mike Galbraith wrote:
> On Mon, 2015-02-16 at 12:18 +0100, Sebastian Andrzej Siewior wrote:
> 
> > Known issues:
> >
> >       - lazy preempt on x86_64 leads to a crash with some load.
> 
> The below still works for me.  (it doesn't make nohz_full actually work
> in rt, but at least folks who want to tinker with it can do so)

Actually, with the below (and other local hacks obviously), it's looking
pretty darn good on my little desktop box.

---
 kernel/sched/core.c      |    2 +-
 kernel/time/tick-sched.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -810,7 +810,7 @@ bool sched_can_stop_tick(void)
 	 * nr_running update is assumed to be visible
 	 * after IPI is sent from wakers.
 	 */
-	if (this_rq()->nr_running > 1)
+	if (this_rq()->nr_running - task_is_softirqd(current) > 1)
 		return false;
 
 	return true;
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -164,7 +164,7 @@ bool tick_nohz_full_running;
 
 static bool can_stop_full_tick(void)
 {
-	WARN_ON_ONCE(!irqs_disabled());
+	WARN_ON_ONCE_NONRT(!irqs_disabled());  <== better way to shut warning up ;-)
 
 	if (!sched_can_stop_tick()) {
 		trace_tick_stop(0, "more than 1 task in runqueue\n");

With 2 shielded cored measuring perturbations (output 1 line/min)

homer:~ # cgexec -g cpuset:rtcpus taskset -c 2 pert 60
3591.74 MHZ CPU
perturbation threshold 0.013 usecs.
pert/s:       12 >7.76us:        0 min:  0.04 max:  0.78 avg:  0.09 sum/s:     1us overhead: 0.00%
pert/s:        7 >7.02us:        0 min:  0.04 max:  0.70 avg:  0.05 sum/s:     0us overhead: 0.00%
pert/s:       14 >8.11us:        1 min:  0.04 max: 35.72 avg:  0.09 sum/s:     1us overhead: 0.00%
pert/s:       39 >7.35us:        0 min:  0.04 max:  0.93 avg:  0.11 sum/s:     4us overhead: 0.00%
pert/s:       44 >6.66us:        0 min:  0.04 max:  0.84 avg:  0.11 sum/s:     5us overhead: 0.00%
pert/s:       46 >6.05us:        0 min:  0.04 max:  1.00 avg:  0.11 sum/s:     5us overhead: 0.00%
pert/s:       36 >5.49us:        0 min:  0.04 max:  0.71 avg:  0.10 sum/s:     4us overhead: 0.00%
pert/s:       42 >5.21us:        0 min:  0.04 max:  5.43 avg:  0.10 sum/s:     4us overhead: 0.00%
pert/s:       24 >4.73us:        0 min:  0.04 max:  0.74 avg:  0.10 sum/s:     2us overhead: 0.00%
pert/s:       33 >4.31us:        0 min:  0.04 max:  0.90 avg:  0.10 sum/s:     3us overhead: 0.00%
pert/s:       34 >3.92us:        0 min:  0.04 max:  0.70 avg:  0.10 sum/s:     4us overhead: 0.00%
pert/s:       64 >3.59us:        0 min:  0.04 max:  1.05 avg:  0.12 sum/s:     7us overhead: 0.00%
pert/s:       53 >3.27us:        0 min:  0.04 max:  0.66 avg:  0.11 sum/s:     6us overhead: 0.00%
pert/s:       55 >2.98us:        0 min:  0.04 max:  0.72 avg:  0.11 sum/s:     6us overhead: 0.00%
pert/s:       38 >2.70us:        0 min:  0.04 max:  0.35 avg:  0.10 sum/s:     4us overhead: 0.00%
pert/s:       35 >2.46us:        0 min:  0.04 max:  0.43 avg:  0.10 sum/s:     4us overhead: 0.00%
pert/s:       36 >2.25us:        0 min:  0.04 max:  0.58 avg:  0.10 sum/s:     4us overhead: 0.00%
pert/s:       44 >2.08us:        0 min:  0.04 max:  0.93 avg:  0.11 sum/s:     5us overhead: 0.00%
pert/s:       45 >1.91us:        0 min:  0.04 max:  0.76 avg:  0.11 sum/s:     5us overhead: 0.00%
pert/s:       33 >1.75us:        0 min:  0.04 max:  0.55 avg:  0.10 sum/s:     3us overhead: 0.00%
Terminated

homer:~ # cgexec -g cpuset:rtcpus taskset -c 3 pert 60
3591.73 MHZ CPU
perturbation threshold 0.013 usecs.
pert/s:       11 >6.26us:        0 min:  0.04 max:  0.77 avg:  0.08 sum/s:     1us overhead: 0.00%
pert/s:        7 >5.67us:        0 min:  0.04 max:  0.71 avg:  0.06 sum/s:     0us overhead: 0.00%
pert/s:        8 >5.14us:        0 min:  0.04 max:  0.57 avg:  0.05 sum/s:     0us overhead: 0.00%
pert/s:       39 >4.67us:        0 min:  0.04 max:  0.94 avg:  0.11 sum/s:     4us overhead: 0.00%
pert/s:       44 >4.25us:        0 min:  0.04 max:  0.83 avg:  0.11 sum/s:     5us overhead: 0.00%
pert/s:       46 >3.89us:        0 min:  0.04 max:  1.12 avg:  0.12 sum/s:     5us overhead: 0.00%
pert/s:       36 >3.54us:        0 min:  0.04 max:  0.70 avg:  0.11 sum/s:     4us overhead: 0.00%
pert/s:       40 >3.42us:        1 min:  0.04 max:  4.63 avg:  0.10 sum/s:     4us overhead: 0.00%
pert/s:       24 >3.12us:        0 min:  0.04 max:  0.60 avg:  0.10 sum/s:     2us overhead: 0.00%
pert/s:       34 >2.86us:        0 min:  0.04 max:  0.97 avg:  0.11 sum/s:     4us overhead: 0.00%
pert/s:       35 >2.60us:        0 min:  0.04 max:  0.39 avg:  0.10 sum/s:     4us overhead: 0.00%
pert/s:       64 >2.39us:        0 min:  0.04 max:  0.94 avg:  0.12 sum/s:     8us overhead: 0.00%
pert/s:       52 >2.19us:        0 min:  0.04 max:  0.73 avg:  0.12 sum/s:     6us overhead: 0.00%
pert/s:       55 >2.01us:        0 min:  0.04 max:  0.62 avg:  0.12 sum/s:     6us overhead: 0.00%
pert/s:       38 >1.83us:        0 min:  0.04 max:  0.35 avg:  0.11 sum/s:     4us overhead: 0.00%
pert/s:       35 >1.68us:        0 min:  0.04 max:  0.43 avg:  0.10 sum/s:     4us overhead: 0.00%
pert/s:       36 >1.54us:        0 min:  0.04 max:  0.61 avg:  0.11 sum/s:     4us overhead: 0.00%
pert/s:       45 >1.44us:        0 min:  0.04 max:  0.92 avg:  0.11 sum/s:     5us overhead: 0.00%
pert/s:       43 >1.33us:        0 min:  0.04 max:  0.64 avg:  0.11 sum/s:     5us overhead: 0.00%
pert/s:       34 >1.23us:        0 min:  0.04 max:  0.54 avg:  0.10 sum/s:     4us overhead: 0.00%
Terminated
