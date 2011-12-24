From: Mike Galbraith <mgalbraith@suse.de>
Subject: 3.0.14-rt31 + 64 cores = very bad jitter == highly synchronized
 tick?
Date: Sat, 24 Dec 2011 10:06:09 +0100
Message-ID: <1324717569.5025.73.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56480 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab1LXJGP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Dec 2011 04:06:15 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

I'm trying to convince 3.0-rt to perform on a 64 core box, and having a
devil of a time with the darn thing.  I have a wild theory that cores
are much more closely synchronized in newer kernels, and that's causing
massive QPI jabbering and xtime lock contention as cores bang
cpupri_set() and ktime_get() in lockstep.

The 33-rt kernel in the numbers below has Steven's cpupri fix, and there
it works a treat.  In 3.0-rt, it does NOT save the day, and the only
reason I can imagine for observed behavior is that cores are ticking in
lockstep.

Anyway, tick perturbations are definitely much larger in 3.0-rt than in
33-rt, munching ~1.4% of every core vs ~.19% for 33-rt.

Has anything been done between 33 and 3.0 that would account for this?

Numbers and such below.

	-Mike

Test environment: nohz=off, cores 4-63 isolated via cpusets.  Start a
perturbation measurement proggy (tight self-calibrating rdtsc loop) as
the only thing running on isolated core 63.

(ponders telling customer that 10 x 8 core synchronized boxen has more
blinky lights, makes much sexier product than boring 1 x 80 core DL980:)


2.6.33.20-rt31
vogelweide:/abuild/mike/:[130]# sh -c 'echo $$ > /cpusets/rtcpus/tasks;taskset -c 63 pert 5'
2260.86 MHZ CPU
perturbation threshold 0.024 usecs.
pert/s:     1000 >14.27us:        1 min:  1.86 max: 16.22 avg:  1.90 sum/s:  1903us overhead: 0.19%
pert/s:     1000 >13.72us:        2 min:  1.86 max: 15.79 avg:  1.91 sum/s:  1909us overhead: 0.19%
pert/s:     1000 >13.23us:        1 min:  1.85 max: 15.59 avg:  1.91 sum/s:  1914us overhead: 0.19%


3.0.14-rt31 virgin
vogelweide:/abuild/mike/:[130]# sh -c 'echo $$ > /cpusets/rtcpus/tasks;taskset -c 63 pert 5'
2261.09 MHZ CPU
perturbation threshold 0.024 usecs.
pert/s:     1001 >57.09us:       52 min:  1.10 max: 83.94 avg: 14.38 sum/s: 14399us overhead: 1.44%
pert/s:     1001 >55.94us:       45 min:  1.10 max: 77.78 avg: 13.43 sum/s: 13455us overhead: 1.35%
pert/s:     1001 >54.87us:       65 min:  1.10 max: 75.77 avg: 14.57 sum/s: 14589us overhead: 1.46%


3.0.14-rt31 non-virgin, where I'm squabbling with this darn thing 
vogelweide:/abuild/mike/:[130]# sh -c 'echo $$ > /cpusets/rtcpus/tasks;taskset -c 63 pert 5'
2260.90 MHZ CPU
perturbation threshold 0.024 usecs.
pert/s:     1001 >15.15us:      613 min:  1.10 max: 62.47 avg:  6.88 sum/s:  6895us overhead: 0.69%
pert/s:     1001 >16.55us:      719 min:  1.10 max: 50.05 avg:  8.38 sum/s:  8394us overhead: 0.84%
pert/s:     1001 >17.77us:      795 min:  1.13 max: 48.51 avg:  8.98 sum/s:  8997us overhead: 0.90%
pert/s:     1001 >19.22us:      640 min:  1.10 max: 56.00 avg:  8.51 sum/s:  8524us overhead: 0.85%
pert/s:     1001 >20.36us:      560 min:  1.10 max: 52.73 avg:  8.41 sum/s:  8428us overhead: 0.84%
pert/s:     1001 >21.38us:      561 min:  1.11 max: 52.65 avg:  8.60 sum/s:  8611us overhead: 0.86%
pert/s:     1001 >22.21us:      583 min:  1.14 max: 50.35 avg:  8.90 sum/s:  8913us overhead: 0.89%
pert/s:     1001 >22.75us:      473 min:  1.12 max: 46.76 avg:  8.50 sum/s:  8516us overhead: 0.85%
pert/s:     1001 >23.42us:      383 min:  1.11 max: 51.04 avg:  7.86 sum/s:  7873us overhead: 0.79%
pert/s:     1001 >23.89us:      421 min:  1.11 max: 47.42 avg:  8.81 sum/s:  8825us overhead: 0.88%
(bend/spindle/mutilate below: echo RT_ISOLATE > sched_features)
pert/s:     1001 >18.74us:        2 min:  1.07 max: 22.62 avg:  2.57 sum/s:  2570us overhead: 0.26%
pert/s:     1001 >18.16us:        1 min:  1.13 max: 23.28 avg:  2.56 sum/s:  2566us overhead: 0.26%
pert/s:     1001 >17.64us:        1 min:  1.09 max: 23.30 avg:  2.61 sum/s:  2610us overhead: 0.26%
pert/s:     1001 >17.22us:        2 min:  1.09 max: 24.44 avg:  2.59 sum/s:  2593us overhead: 0.26%
pert/s:     1001 >16.21us:        0 min:  1.06 max: 11.46 avg:  2.62 sum/s:  2620us overhead: 0.26%
pert/s:     1001 >15.33us:        0 min:  1.14 max: 12.40 avg:  2.59 sum/s:  2597us overhead: 0.26%
pert/s:     1001 >14.83us:        1 min:  1.10 max: 17.94 avg:  2.59 sum/s:  2599us overhead: 0.26%
pert/s:     1001 >14.03us:        0 min:  1.07 max: 11.20 avg:  2.60 sum/s:  2605us overhead: 0.26%
pert/s:     1001 >13.84us:        1 min:  1.12 max: 21.51 avg:  2.62 sum/s:  2629us overhead: 0.26%
pert/s:     1001 >13.63us:        4 min:  1.12 max: 20.90 avg:  2.60 sum/s:  2604us overhead: 0.26%


profile CPU 63
 NO_RT_ISOLATE                                                RT_ISOLATE                                             (no hacks)
 3.0.14-rt31                                                  3.0.14-rt31                                            2.6.33-rt31
 47.83%  [kernel]  [k] cpupri_set                             8.67%  [kernel]  [k] tick_sched_timer                  8.28%  [kernel]  [k] cpupri_set
 18.38%  [kernel]  [k] native_write_msr_safe                  7.03%  [kernel]  [k] __schedule                        7.52%  [kernel]  [k] __schedule
  6.83%  [kernel]  [k] cpuacct_charge                         6.42%  [kernel]  [k] native_write_msr_safe             6.30%  [kernel]  [k] apic_timer_interrupt
  2.19%  [kernel]  [k] rcu_enter_nohz                         6.02%  [kernel]  [k] apic_timer_interrupt              5.66%  [kernel]  [k] native_write_msr_safe
  2.12%  [kernel]  [k] __schedule                             3.39%  [kernel]  [k] __switch_to                       3.13%  [kernel]  [k] scheduler_tick
  1.95%  [kernel]  [k] apic_timer_interrupt                   2.73%  [kernel]  [k] ktime_get                         2.69%  [kernel]  [k] _raw_spin_lock
  1.91%  [kernel]  [k] tick_sched_timer                       2.21%  [kernel]  [k] rcu_preempt_note_context_switch   2.61%  [kernel]  [k] __switch_to
  1.56%  [kernel]  [k] ktime_get                              1.97%  [kernel]  [k] rcu_check_callbacks               2.38%  [kernel]  [k] try_to_wake_up
  1.20%  [kernel]  [k] run_timer_softirq                      1.85%  [kernel]  [k] run_posix_cpu_timers              2.16%  [kernel]  [k] native_read_msr_safe
  0.72%  [kernel]  [k] __switch_to                            1.63%  [kernel]  [k] run_timer_softirq                 1.99%  [kernel]  [k] native_read_tsc
  0.61%  [kernel]  [k] rcu_preempt_note_context_switch        1.63%  [kernel]  [k] common_interrupt                  1.98%  [kernel]  [k] update_curr_rt
  0.55%  [kernel]  [k] scheduler_tick                         1.63%  [kernel]  [k] _raw_spin_unlock_irq              1.94%  [kernel]  [k] perf_event_task_sched_in
  0.54%  [kernel]  [k] __thread_do_softirq                    1.60%  [kernel]  [k] __thread_do_softirq               1.89%  [kernel]  [k] ktime_get
  0.51%  [kernel]  [k] __rcu_pending                          1.58%  [kernel]  [k] _raw_spin_lock                    1.87%  [kernel]  [k] cpuacct_charge
  0.51%  [kernel]  [k] _raw_spin_lock                         1.46%  [kernel]  [k] __rcu_pending                     1.80%  [kernel]  [k] run_ksoftirqd
  0.48%  [kernel]  [k] native_read_tsc                        1.36%  [kernel]  [k] wakeup_softirqd                   1.73%  [kernel]  [k] _raw_spin_unlock
  0.45%  [kernel]  [k] hrtimer_interrupt                      1.35%  [kernel]  [k] finish_task_switch                1.71%  [kernel]  [k] perf_adjust_period
  0.44%  [kernel]  [k] raise_softirq                          1.31%  [kernel]  [k] cpuacct_charge                    1.46%  [kernel]  [k] __dequeue_entity
  0.33%  [kernel]  [k] __enqueue_rt_entity                    1.28%  [kernel]  [k] handle_pending_softirqs           1.33%  [kernel]  [k] rb_insert_color
  0.31%  [kernel]  [k] rt_spin_unlock                         1.28%  [kernel]  [k] scheduler_tick                    1.28%  [kernel]  [k] __rcu_pending


profile all 64 CPUs
 (RT_ISOLATE hack turned back off)
 3.0.14-rt31                                                  2.6.33.20-rt31
 61.08%  [kernel]      [k] cpupri_set                         27.50%  [kernel]      [k] apic_timer_interrupt
 15.57%  [kernel]      [k] ktime_get                           7.52%  [kernel]      [k] cpupri_set
  5.79%  [kernel]      [k] apic_timer_interrupt                5.35%  [kernel]      [k] __schedule
  4.31%  [kernel]      [k] rcu_enter_nohz                      4.75%  [kernel]      [k] _raw_spin_lock
  2.84%  [kernel]      [k] cpuacct_charge                      3.88%  [kernel]      [k] scheduler_tick
  1.17%  [kernel]      [k] __schedule                          2.81%  [kernel]      [k] ktime_get
  0.92%  [kernel]      [k] tick_sched_timer                    2.59%  [kernel]      [k] tick_check_oneshot_broadcast
  0.65%  [kernel]      [k] native_write_msr_safe               2.50%  [kernel]      [k] native_write_msr_safe
  0.53%  [kernel]      [k] scheduler_tick                      2.28%  [kernel]      [k] native_read_tsc
  0.41%  [kernel]      [k] tick_check_oneshot_broadcast        2.22%  [kernel]      [k] native_read_msr_safe
  0.35%  [kernel]      [k] native_load_tls                     1.11%  [kernel]      [k] __switch_to
  0.34%  [kernel]      [k] update_cpu_load                     1.05%  [kernel]      [k] read_tsc
  0.27%  [kernel]      [k] __rcu_pending                       1.03%  [kernel]      [k] rb_erase
  0.23%  [kernel]      [k] _raw_spin_lock                      1.00%  [kernel]      [k] rcu_sched_qs
  0.23%  [kernel]      [k] __thread_do_softirq                 0.94%  [kernel]      [k] resched_task
  0.21%  [kernel]      [k] run_timer_softirq                   0.93%  [kernel]      [k] run_ksoftirqd
  0.19%  [kernel]      [k] read_tsc                            0.92%  [kernel]      [k] atomic_notifier_call_chain
  0.19%  [kernel]      [k] _raw_spin_lock_irqsave              0.91%  [kernel]      [k] _raw_spin_unlock
  0.19%  [kernel]      [k] native_read_tsc                     0.87%  [kernel]      [k] __rcu_read_unlock
  0.17%  [kernel]      [k] rcu_preempt_note_context_switch     0.87%  [kernel]      [k] native_sched_clock
  0.16%  [kernel]      [k] __switch_to                         0.87%  [kernel]      [k] x86_pmu_read
  0.14%  [kernel]      [k] rt_spin_lock                        0.85%  [kernel]      [k] perf_adjust_period
  0.13%  [kernel]      [k] profile_tick                        0.83%  [kernel]      [k] try_to_wake_up
  0.13%  [kernel]      [k] rt_spin_unlock                      0.81%  [kernel]      [k] tick_sched_timer
  0.13%  [kernel]      [k] finish_task_switch                  0.80%  [kernel]      [k] __perf_pending_run
  0.11%  [kernel]      [k] run_ksoftirqd                       0.77%  [kernel]      [k] sched_clock_cpu
  0.11%  [kernel]      [k] handle_pending_softirqs             0.70%  [kernel]      [k] finish_task_switch
  0.10%  [kernel]      [k] smp_apic_timer_interrupt            0.68%  [kernel]      [k] __atomic_notifier_call_chain
  0.09%  [kernel]      [k] tick_nohz_stop_sched_tick           0.67%  [kernel]      [k] hrtimer_interrupt
  0.09%  [kernel]      [k] pick_next_task_rt                   0.67%  [kernel]      [k] __remove_hrtimer
  0.09%  [kernel]      [k] _raw_spin_lock_irq                  0.66%  [kernel]      [k] save_args
  0.09%  [kernel]      [k] timerqueue_del                      0.64%  [kernel]      [k] rt_spin_lock
  0.08%  [kernel]      [k] hrtimer_interrupt                   0.61%  [kernel]      [k] _raw_spin_lock_irq
  0.07%  [kernel]      [k] pick_next_task_stop                 0.58%  [kernel]      [k] idle_cpu
  0.07%  [kernel]      [k] migrate_enable                      0.56%  [kernel]      [k] __rcu_pending
  0.07%  [kernel]      [k] wakeup_softirqd                     0.56%  [kernel]      [k] account_process_tick
  0.07%  [kernel]      [k] native_sched_clock                  0.55%  [kernel]      [k] tick_nohz_stop_sched_tick
  0.06%  [kernel]      [k] __dequeue_rt_entity                 0.51%  [kernel]      [k] rb_next
  0.06%  [kernel]      [k] update_curr_rt                      0.46%  [kernel]      [k] rt_spin_unlock
  0.06%  [kernel]      [k] _raw_spin_unlock_irq                0.45%  [kernel]      [k] rcu_irq_enter

RT_ISOLATE cpupri_set() insolation hacklet

---
 kernel/sched_features.h |    5 +++++
 kernel/sched_rt.c       |   17 +++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

--- a/kernel/sched_features.h
+++ b/kernel/sched_features.h
@@ -79,3 +79,8 @@ SCHED_FEAT(TTWU_QUEUE, 0)
 
 SCHED_FEAT(FORCE_SD_OVERLAP, 0)
 SCHED_FEAT(RT_RUNTIME_SHARE, 1)
+
+/*
+ * Protect isolated CPUs from cpupri latency
+ */
+SCHED_FEAT(RT_ISOLATE, 1)
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -876,6 +876,11 @@ void dec_rt_group(struct sched_rt_entity
 
 #endif /* CONFIG_RT_GROUP_SCHED */
 
+static inline int rq_isolate(struct rq *rq)
+{
+	return sched_feat(RT_ISOLATE) && !rq->sd;
+}
+
 static inline
 void inc_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 {
@@ -884,7 +889,8 @@ void inc_rt_tasks(struct sched_rt_entity
 	WARN_ON(!rt_prio(prio));
 	rt_rq->rt_nr_running++;
 
-	inc_rt_prio(rt_rq, prio);
+	if (!rq_isolate(rq_of_rt_rq(rt_rq)))
+		inc_rt_prio(rt_rq, prio);
 	inc_rt_migration(rt_se, rt_rq);
 	inc_rt_group(rt_se, rt_rq);
 }
@@ -896,7 +902,8 @@ void dec_rt_tasks(struct sched_rt_entity
 	WARN_ON(!rt_rq->rt_nr_running);
 	rt_rq->rt_nr_running--;
 
-	dec_rt_prio(rt_rq, rt_se_prio(rt_se));
+	if (!rq_isolate(rq_of_rt_rq(rt_rq)))
+		dec_rt_prio(rt_rq, rt_se_prio(rt_se));
 	dec_rt_migration(rt_se, rt_rq);
 	dec_rt_group(rt_se, rt_rq);
 }
@@ -1110,6 +1117,9 @@ static void check_preempt_equal_prio(str
 	if (rq->curr->rt.nr_cpus_allowed == 1)
 		return;
 
+	if (rq_isolate(rq))
+		return;
+
 	if (p->rt.nr_cpus_allowed != 1
 	    && cpupri_find(&rq->rd->cpupri, p, NULL))
 		return;
@@ -1300,6 +1310,9 @@ static int find_lowest_rq(struct task_st
 	if (task->rt.nr_cpus_allowed == 1)
 		return -1; /* No other targets possible */
 
+	if (rq_isolate(cpu_rq(this_cpu)))
+		return -1;
+
 	if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask))
 		return -1; /* No targets found */
 



