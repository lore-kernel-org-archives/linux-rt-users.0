From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/1] Add trace latency histogram to monitor context switch time
Date: Fri, 15 Jan 2016 12:16:00 +0100
Message-ID: <20160115112203.235662679@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:39399 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134AbcAOL0w (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 06:26:52 -0500
Content-Disposition: inline; filename=trace-add-switchtime-hist.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The existing two on-line methods to record system latency (timer and
wakeup latency) do not completely reflect the user-space wakeup time,
since the duration of the context switch is not taken into account. This
patch adds two new histograms - one that records the duration of the
context switch and another one that records the sum of the timer delay,
the wakeup latency and the newly available duration of the context
switch. The latter histogram probably is best suitable to determine the
worst-case total preemption latency of a given system.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
 include/linux/sched.h       |    8 
 kernel/trace/Kconfig        |   32 +++
 kernel/trace/latency_hist.c |  412 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 400 insertions(+), 52 deletions(-)

Index: linux-4.1.13-rt15/include/linux/sched.h
===================================================================
--- linux-4.1.13-rt15.orig/include/linux/sched.h
+++ linux-4.1.13-rt15/include/linux/sched.h
@@ -1776,6 +1776,14 @@ struct task_struct {
 	long timer_offset;
 #endif
 #endif
+#ifdef CONFIG_SWITCHTIME_HIST
+	u64 switchtime_timestamp_hist;
+	struct task_struct *switchtime_prev;
+#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	unsigned long switchtime_timerandwakeup;
+#endif
+#endif
 #endif /* CONFIG_TRACING */
 #ifdef CONFIG_MEMCG
 	struct memcg_oom_info {
Index: linux-4.1.13-rt15/kernel/trace/Kconfig
===================================================================
--- linux-4.1.13-rt15.orig/kernel/trace/Kconfig
+++ linux-4.1.13-rt15/kernel/trace/Kconfig
@@ -325,6 +325,38 @@ config MISSED_TIMER_OFFSETS_HIST
 
 	      /sys/kernel/debug/tracing/latency_hist/enable/timerandwakeup
 
+config SWITCHTIME_HIST
+	depends on HIGH_RES_TIMERS
+	depends on HAVE_SYSCALL_TRACEPOINTS
+	depends on WAKEUP_LATENCY_HIST
+	select GENERIC_TRACER
+	select FTRACE_SYSCALLS
+	bool "Context Switch Time Histogram"
+	help
+	  Generate a histogram of the context switch duration per CPU. The
+	  histograms are disabled by default. To enable them, write a non-zero
+	  number to
+
+	      /sys/kernel/debug/tracing/latency_hist/enable/switchtime
+
+	  The histogram data will be located in the debug file system at
+
+	      /sys/kernel/debug/tracing/latency_hist/switchtime
+
+	  If both Scheduling Latency Histogram, Missed Timer Offsets and the
+	  newly provided Context Switch Time Histogram are selected, additional
+	  histogram data will be collected from the sum of the wakeup latency,
+	  the timer latency, if available, and the switch time per CPU. These
+	  histograms are available in the
+
+	      /sys/kernel/debug/tracing/latency_hist/timerwakeupswitch
+
+	  directory. They reflect the apparent interrupt and scheduling latency
+	  and are best suitable to determine the worst-case latency of a given
+	  system. To enable these histograms, write a non-zero number to
+
+	      /sys/kernel/debug/tracing/latency_hist/enable/timerwakeupswitch
+
 config ENABLE_DEFAULT_TRACERS
 	bool "Trace process context switches and events"
 	depends on !GENERIC_TRACER
Index: linux-4.1.13-rt15/kernel/trace/latency_hist.c
===================================================================
--- linux-4.1.13-rt15.orig/kernel/trace/latency_hist.c
+++ linux-4.1.13-rt15/kernel/trace/latency_hist.c
@@ -23,11 +23,15 @@
 #include <linux/sched/rt.h>
 #include <linux/slab.h>
 #include <linux/atomic.h>
+#include <trace/syscall.h>
 #include <asm/div64.h>
+#include <asm/syscall.h>
 
 #include "trace.h"
 #include <trace/events/sched.h>
 
+extern struct tracepoint __tracepoint_sys_exit;
+
 #define NSECS_PER_USECS 1000L
 
 #define CREATE_TRACE_POINTS
@@ -41,6 +45,8 @@ enum {
 	WAKEUP_LATENCY_SHAREDPRIO,
 	MISSED_TIMER_OFFSETS,
 	TIMERANDWAKEUP_LATENCY,
+	SWITCHTIME,
+	TIMERWAKEUPSWITCH_LATENCY,
 	MAX_LATENCY_TYPE,
 };
 
@@ -104,8 +110,9 @@ struct maxlatproc_data {
 	int prio;
 	int current_prio;
 	long latency;
-	long timeroffset;
+	long otherlatency;
 	cycle_t timestamp;
+	int nr;
 };
 #endif
 
@@ -144,6 +151,19 @@ static DEFINE_PER_CPU(struct maxlatproc_
 static unsigned long missed_timer_offsets_pid;
 #endif
 
+#ifdef CONFIG_SWITCHTIME_HIST
+static DEFINE_PER_CPU(struct hist_data, switchtime);
+static char *switchtime_dir = "switchtime";
+static notrace void probe_syscall_exit(void *v, struct pt_regs *regs, long ret);
+static struct enable_data switchtime_enabled_data = {
+	.latency_type = SWITCHTIME,
+	.enabled = 0,
+};
+static DEFINE_PER_CPU(struct maxlatproc_data, switchtime_maxlatproc);
+static DEFINE_PER_CPU(struct task_struct *, switchtime_task);
+static unsigned long switchtime_pid;
+#endif
+
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
 	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 static DEFINE_PER_CPU(struct hist_data, timerandwakeup_latency_hist);
@@ -155,13 +175,26 @@ static struct enable_data timerandwakeup
 static DEFINE_PER_CPU(struct maxlatproc_data, timerandwakeup_maxlatproc);
 #endif
 
+#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST) && \
+	defined(CONFIG_SWITCHTIME_HIST)
+static DEFINE_PER_CPU(struct hist_data, timerwakeupswitch_latency_hist);
+static char *timerwakeupswitch_latency_hist_dir = "timerwakeupswitch";
+static struct enable_data timerwakeupswitch_enabled_data = {
+	.latency_type = TIMERWAKEUPSWITCH_LATENCY,
+	.enabled = 0,
+};
+static DEFINE_PER_CPU(struct maxlatproc_data, timerwakeupswitch_maxlatproc);
+#endif
+
 void notrace latency_hist(int latency_type, int cpu, long latency,
-			  long timeroffset, cycle_t stop,
-			  struct task_struct *p)
+			  long otherlatency, cycle_t stop,
+			  struct task_struct *p, int nr)
 {
 	struct hist_data *my_hist;
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST) || \
+	defined(CONFIG_SWITCHTIME_HIST)
 	struct maxlatproc_data *mp = NULL;
 #endif
 
@@ -201,6 +234,12 @@ void notrace latency_hist(int latency_ty
 		mp = &per_cpu(missed_timer_offsets_maxlatproc, cpu);
 		break;
 #endif
+#ifdef CONFIG_SWITCHTIME_HIST
+	case SWITCHTIME:
+		my_hist = &per_cpu(switchtime, cpu);
+		mp = &per_cpu(switchtime_maxlatproc, cpu);
+		break;
+#endif
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
 	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 	case TIMERANDWAKEUP_LATENCY:
@@ -208,6 +247,14 @@ void notrace latency_hist(int latency_ty
 		mp = &per_cpu(timerandwakeup_maxlatproc, cpu);
 		break;
 #endif
+#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST) && \
+	defined(CONFIG_SWITCHTIME_HIST)
+	case TIMERWAKEUPSWITCH_LATENCY:
+		my_hist = &per_cpu(timerwakeupswitch_latency_hist, cpu);
+		mp = &per_cpu(timerwakeupswitch_maxlatproc, cpu);
+		break;
+#endif
 
 	default:
 		return;
@@ -229,21 +276,37 @@ void notrace latency_hist(int latency_ty
 	if (unlikely(latency > my_hist->max_lat ||
 	    my_hist->min_lat == LONG_MAX)) {
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST) || \
+	defined(CONFIG_SWITCHTIME_HIST)
 		if (latency_type == WAKEUP_LATENCY ||
 		    latency_type == WAKEUP_LATENCY_SHAREDPRIO ||
 		    latency_type == MISSED_TIMER_OFFSETS ||
-		    latency_type == TIMERANDWAKEUP_LATENCY) {
-			strncpy(mp->comm, p->comm, sizeof(mp->comm));
-			strncpy(mp->current_comm, current->comm,
-			    sizeof(mp->current_comm));
-			mp->pid = task_pid_nr(p);
-			mp->current_pid = task_pid_nr(current);
-			mp->prio = p->prio;
-			mp->current_prio = current->prio;
+		    latency_type == TIMERANDWAKEUP_LATENCY ||
+		    latency_type == SWITCHTIME ||
+		    latency_type == TIMERWAKEUPSWITCH_LATENCY) {
+			if (latency_type == SWITCHTIME ||
+			    latency_type == TIMERWAKEUPSWITCH_LATENCY) {
+				strncpy(mp->current_comm, p->comm,
+				    sizeof(mp->current_comm));
+				strncpy(mp->comm, current->comm,
+				    sizeof(mp->comm));
+				mp->current_pid = task_pid_nr(p);
+				mp->pid = task_pid_nr(current);
+				mp->current_prio = p->prio;
+				mp->prio = current->prio;
+			} else {
+				strncpy(mp->comm, p->comm, sizeof(mp->comm));
+				strncpy(mp->current_comm, current->comm,
+				    sizeof(mp->current_comm));
+				mp->pid = task_pid_nr(p);
+				mp->current_pid = task_pid_nr(current);
+				mp->prio = p->prio;
+				mp->current_prio = current->prio;
+			}
 			mp->latency = latency;
-			mp->timeroffset = timeroffset;
+			mp->otherlatency = otherlatency;
 			mp->timestamp = stop;
+			mp->nr = nr;
 		}
 #endif
 		my_hist->max_lat = latency;
@@ -366,8 +429,9 @@ static void clear_maxlatprocdata(struct
 {
 	mp->comm[0] = mp->current_comm[0] = '\0';
 	mp->prio = mp->current_prio = mp->pid = mp->current_pid =
-	    mp->latency = mp->timeroffset = -1;
+	    mp->latency = mp->otherlatency = -1;
 	mp->timestamp = 0;
+	mp->nr = 0;
 }
 #endif
 
@@ -426,6 +490,12 @@ latency_hist_reset(struct file *file, co
 			mp = &per_cpu(wakeup_maxlatproc_sharedprio, cpu);
 			break;
 #endif
+#ifdef CONFIG_SWITCHTIME_HIST
+		case SWITCHTIME:
+			hist = &per_cpu(switchtime, cpu);
+			mp = &per_cpu(switchtime_maxlatproc, cpu);
+			break;
+#endif
 #ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
 		case MISSED_TIMER_OFFSETS:
 			hist = &per_cpu(missed_timer_offsets, cpu);
@@ -439,15 +509,26 @@ latency_hist_reset(struct file *file, co
 			mp = &per_cpu(timerandwakeup_maxlatproc, cpu);
 			break;
 #endif
+#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST) && \
+	defined(CONFIG_SWITCHTIME_HIST)
+		case TIMERWAKEUPSWITCH_LATENCY:
+			hist = &per_cpu(timerwakeupswitch_latency_hist, cpu);
+			mp = &per_cpu(timerwakeupswitch_maxlatproc, cpu);
+			break;
+#endif
 		}
 
 		hist_reset(hist);
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST) || \
+	defined(CONFIG_SWITCHTIME_HIST)
 		if (latency_type == WAKEUP_LATENCY ||
 		    latency_type == WAKEUP_LATENCY_SHAREDPRIO ||
 		    latency_type == MISSED_TIMER_OFFSETS ||
-		    latency_type == TIMERANDWAKEUP_LATENCY)
+		    latency_type == TIMERANDWAKEUP_LATENCY ||
+		    latency_type == SWITCHTIME ||
+		    latency_type == TIMERWAKEUPSWITCH_LATENCY)
 			clear_maxlatprocdata(mp);
 #endif
 	}
@@ -456,7 +537,8 @@ latency_hist_reset(struct file *file, co
 }
 
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST) || \
+	defined(CONFIG_SWITCHTIME_HIST)
 static ssize_t
 show_pid(struct file *file, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -499,7 +581,7 @@ show_maxlatproc(struct file *file, char
 {
 	int r;
 	struct maxlatproc_data *mp = file->private_data;
-	int strmaxlen = (TASK_COMM_LEN * 2) + (8 * 8);
+	int strmaxlen = (TASK_COMM_LEN * 2) + 32 + (8 * 8);
 	unsigned long long t;
 	unsigned long usecs, secs;
 	char *buf;
@@ -518,10 +600,17 @@ show_maxlatproc(struct file *file, char
 	usecs = do_div(t, USEC_PER_SEC);
 	secs = (unsigned long) t;
 	r = snprintf(buf, strmaxlen,
-	    "%d %d %ld (%ld) %s <- %d %d %s %lu.%06lu\n", mp->pid,
-	    MAX_RT_PRIO-1 - mp->prio, mp->latency, mp->timeroffset, mp->comm,
+	    "%d %d %ld (%ld) %s <- %d %d %s %lu.%06lu", mp->pid,
+	    MAX_RT_PRIO-1 - mp->prio, mp->latency, mp->otherlatency, mp->comm,
 	    mp->current_pid, MAX_RT_PRIO-1 - mp->current_prio, mp->current_comm,
 	    secs, usecs);
+#ifdef CONFIG_SWITCHTIME_HIST
+	if (mp->nr >= 0 && mp->nr < NR_syscalls)
+		r += snprintf(buf + r, strmaxlen - r, " %pf",
+		    (void *) sys_call_table[mp->nr]);
+#endif
+	r += snprintf(buf + r, strmaxlen - r, "\n");
+
 	r = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 	kfree(buf);
 	return r;
@@ -569,9 +658,7 @@ do_enable(struct file *file, const char
 			ret = register_trace_preemptirqsoff_hist(
 			    probe_preemptirqsoff_hist, NULL);
 			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_preemptirqsoff_hist "
-				    "to trace_preemptirqsoff_hist\n");
+				pr_info("Couldn't register preemptirqsoff_hist probe\n");
 				return ret;
 			}
 			break;
@@ -581,17 +668,13 @@ do_enable(struct file *file, const char
 			ret = register_trace_sched_wakeup(
 			    probe_wakeup_latency_hist_start, NULL);
 			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_wakeup_latency_hist_start "
-				    "to trace_sched_wakeup\n");
+				pr_info("Couldn't register sched_wakeup probe\n");
 				return ret;
 			}
 			ret = register_trace_sched_wakeup_new(
 			    probe_wakeup_latency_hist_start, NULL);
 			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_wakeup_latency_hist_start "
-				    "to trace_sched_wakeup_new\n");
+				pr_info("Couldn't register sched_wakeup_new probe\n");
 				unregister_trace_sched_wakeup(
 				    probe_wakeup_latency_hist_start, NULL);
 				return ret;
@@ -599,9 +682,7 @@ do_enable(struct file *file, const char
 			ret = register_trace_sched_switch(
 			    probe_wakeup_latency_hist_stop, NULL);
 			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_wakeup_latency_hist_stop "
-				    "to trace_sched_switch\n");
+				pr_info("Couldn't register sched_switch probe\n");
 				unregister_trace_sched_wakeup(
 				    probe_wakeup_latency_hist_start, NULL);
 				unregister_trace_sched_wakeup_new(
@@ -611,9 +692,7 @@ do_enable(struct file *file, const char
 			ret = register_trace_sched_migrate_task(
 			    probe_sched_migrate_task, NULL);
 			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_sched_migrate_task "
-				    "to trace_sched_migrate_task\n");
+				pr_info("Couldn't register sched_migrate_task probe\n");
 				unregister_trace_sched_wakeup(
 				    probe_wakeup_latency_hist_start, NULL);
 				unregister_trace_sched_wakeup_new(
@@ -629,9 +708,19 @@ do_enable(struct file *file, const char
 			ret = register_trace_hrtimer_interrupt(
 			    probe_hrtimer_interrupt, NULL);
 			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_hrtimer_interrupt "
-				    "to trace_hrtimer_interrupt\n");
+				pr_info("Couldn't register hrtimer IRQ probe\n");
+				return ret;
+			}
+			break;
+#endif
+#ifdef CONFIG_SWITCHTIME_HIST
+		case SWITCHTIME:
+			if (!wakeup_latency_enabled_data.enabled)
+				return -EINVAL;
+			ret = tracepoint_probe_register(&__tracepoint_sys_exit,
+			    probe_syscall_exit, NULL);
+			if (ret) {
+				pr_info("Couldn't register sys_exit probe\n");
 				return ret;
 			}
 			break;
@@ -644,6 +733,16 @@ do_enable(struct file *file, const char
 				return -EINVAL;
 			break;
 #endif
+#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST) && \
+	defined(CONFIG_SWITCHTIME_HIST)
+		case TIMERWAKEUPSWITCH_LATENCY:
+			if (!wakeup_latency_enabled_data.enabled ||
+			    !missed_timer_offsets_enabled_data.enabled ||
+			    !switchtime_enabled_data.enabled)
+				return -EINVAL;
+			break;
+#endif
 		default:
 			break;
 		}
@@ -695,6 +794,12 @@ do_enable(struct file *file, const char
 #ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
 			timerandwakeup_enabled_data.enabled = 0;
 #endif
+#ifdef CONFIG_SWITCHTIME_HIST
+			switchtime_enabled_data.enabled = 0;
+#endif
+#ifdef CONFIG_TIMERWAKEUPSWITCH_LATENCY_HIST
+			timerwakeupswitch_enabled_data.enabled = 0;
+#endif
 			break;
 #endif
 #ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
@@ -704,6 +809,25 @@ do_enable(struct file *file, const char
 #ifdef CONFIG_WAKEUP_LATENCY_HIST
 			timerandwakeup_enabled_data.enabled = 0;
 #endif
+#ifdef CONFIG_TIMERWAKEUPSWITCH_LATENCY_HIST
+			timerwakeupswitch_enabled_data.enabled = 0;
+#endif
+			break;
+#endif
+#ifdef CONFIG_SWITCHTIME_HIST
+		case SWITCHTIME:
+			{
+				int cpu;
+
+				tracepoint_probe_unregister(&__tracepoint_sys_exit,
+				    probe_syscall_exit, NULL);
+
+				for_each_online_cpu(cpu)
+					per_cpu(switchtime_task, cpu) = NULL;
+			}
+#ifdef CONFIG_TIMERWAKEUPSWITCH_LATENCY_HIST
+			timerwakeupswitch_enabled_data.enabled = 0;
+#endif
 			break;
 #endif
 		default:
@@ -797,7 +921,7 @@ static notrace void probe_preemptirqsoff
 				    NSECS_PER_USECS;
 
 				latency_hist(IRQSOFF_LATENCY, cpu, latency, 0,
-				    stop, NULL);
+				    stop, NULL, -1);
 			}
 			per_cpu(hist_irqsoff_counting, cpu) = 0;
 		}
@@ -815,7 +939,7 @@ static notrace void probe_preemptirqsoff
 				    NSECS_PER_USECS;
 
 				latency_hist(PREEMPTOFF_LATENCY, cpu, latency,
-				    0, stop, NULL);
+				    0, stop, NULL, -1);
 			}
 			per_cpu(hist_preemptoff_counting, cpu) = 0;
 		}
@@ -834,7 +958,7 @@ static notrace void probe_preemptirqsoff
 				    NSECS_PER_USECS;
 
 				latency_hist(PREEMPTIRQSOFF_LATENCY, cpu,
-				    latency, 0, stop, NULL);
+				    latency, 0, stop, NULL, -1);
 			}
 			per_cpu(hist_preemptirqsoff_counting, cpu) = 0;
 		}
@@ -845,6 +969,9 @@ static notrace void probe_preemptirqsoff
 
 #ifdef CONFIG_WAKEUP_LATENCY_HIST
 static DEFINE_RAW_SPINLOCK(wakeup_lock);
+#ifdef CONFIG_SWITCHTIME_HIST
+static DEFINE_RAW_SPINLOCK(switchtime_lock);
+#endif
 static notrace void probe_sched_migrate_task(void *v, struct task_struct *task,
 	int cpu)
 {
@@ -855,7 +982,6 @@ static notrace void probe_sched_migrate_
 		struct task_struct *cpu_wakeup_task;
 
 		raw_spin_lock_irqsave(&wakeup_lock, flags);
-
 		cpu_wakeup_task = per_cpu(wakeup_task, old_cpu);
 		if (task == cpu_wakeup_task) {
 			put_task_struct(cpu_wakeup_task);
@@ -863,8 +989,24 @@ static notrace void probe_sched_migrate_
 			cpu_wakeup_task = per_cpu(wakeup_task, cpu) = task;
 			get_task_struct(cpu_wakeup_task);
 		}
-
 		raw_spin_unlock_irqrestore(&wakeup_lock, flags);
+
+#ifdef CONFIG_SWITCHTIME_HIST
+		{
+			struct task_struct *cpu_switchtime_task;
+
+			raw_spin_lock_irqsave(&switchtime_lock, flags);
+			cpu_switchtime_task = per_cpu(switchtime_task, old_cpu);
+			if (task == cpu_switchtime_task) {
+				put_task_struct(cpu_switchtime_task);
+				per_cpu(switchtime_task, old_cpu) = NULL;
+				cpu_switchtime_task =
+				    per_cpu(switchtime_task, cpu) = task;
+				get_task_struct(cpu_switchtime_task);
+			}
+			raw_spin_unlock_irqrestore(&switchtime_lock, flags);
+		}
+#endif
 	}
 }
 
@@ -876,8 +1018,23 @@ static notrace void probe_wakeup_latency
 	int cpu = task_cpu(p);
 	struct task_struct *cpu_wakeup_task;
 
-	raw_spin_lock_irqsave(&wakeup_lock, flags);
+#ifdef CONFIG_SWITCHTIME_HIST
+	struct task_struct *cpu_switchtime_task;
 
+	if (!switchtime_pid) {
+		raw_spin_lock_irqsave(&switchtime_lock, flags);
+		cpu_switchtime_task = per_cpu(switchtime_task, cpu);
+		if (cpu_switchtime_task &&
+		    p->prio < cpu_switchtime_task->prio) {
+			cpu_switchtime_task->switchtime_timestamp_hist = 0;
+			put_task_struct(cpu_switchtime_task);
+			per_cpu(switchtime_task, cpu) = NULL;
+		}
+		raw_spin_unlock_irqrestore(&switchtime_lock, flags);
+	}
+#endif
+
+	raw_spin_lock_irqsave(&wakeup_lock, flags);
 	cpu_wakeup_task = per_cpu(wakeup_task, cpu);
 
 	if (wakeup_pid) {
@@ -914,6 +1071,7 @@ static notrace void probe_wakeup_latency
 	long latency;
 	cycle_t stop;
 	struct task_struct *cpu_wakeup_task;
+	int hit = 0;
 
 	raw_spin_lock_irqsave(&wakeup_lock, flags);
 
@@ -950,27 +1108,49 @@ static notrace void probe_wakeup_latency
 
 	if (per_cpu(wakeup_sharedprio, cpu)) {
 		latency_hist(WAKEUP_LATENCY_SHAREDPRIO, cpu, latency, 0, stop,
-		    next);
+		    next, -1);
 		per_cpu(wakeup_sharedprio, cpu) = 0;
 	} else {
-		latency_hist(WAKEUP_LATENCY, cpu, latency, 0, stop, next);
+		latency_hist(WAKEUP_LATENCY, cpu, latency, 0, stop, next, -1);
 #ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
 		if (timerandwakeup_enabled_data.enabled) {
 			latency_hist(TIMERANDWAKEUP_LATENCY, cpu,
 			    next->timer_offset + latency, next->timer_offset,
-			    stop, next);
+			    stop, next, -1);
 		}
+		hit = 1;
 #endif
 	}
 
 out_reset:
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-	next->timer_offset = 0;
-#endif
 	put_task_struct(cpu_wakeup_task);
 	per_cpu(wakeup_task, cpu) = NULL;
 out:
 	raw_spin_unlock_irqrestore(&wakeup_lock, flags);
+
+#ifdef CONFIG_SWITCHTIME_HIST
+	if (hit && switchtime_enabled_data.enabled &&
+	    (switchtime_pid == 0 || task_pid_nr(next) == switchtime_pid)) {
+		unsigned long flags;
+		struct task_struct *cpu_switchtime_task;
+
+		raw_spin_lock_irqsave(&switchtime_lock, flags);
+
+		cpu_switchtime_task = per_cpu(switchtime_task, cpu) =
+		    next;
+		get_task_struct(cpu_switchtime_task);
+
+		raw_spin_unlock_irqrestore(&switchtime_lock, flags);
+
+		next->switchtime_timestamp_hist = stop;
+		next->switchtime_timerandwakeup =
+		    next->timer_offset + latency;
+		next->switchtime_prev = current;
+	}
+#endif
+#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
+	next->timer_offset = 0;
+#endif
 }
 #endif
 
@@ -992,10 +1172,28 @@ static notrace void probe_hrtimer_interr
 				return;
 		}
 
+#ifdef CONFIG_SWITCHTIME_HIST
+		if (!switchtime_pid) {
+			unsigned long flags;
+			struct task_struct *cpu_switchtime_task;
+
+			raw_spin_lock_irqsave(&switchtime_lock, flags);
+			cpu_switchtime_task = per_cpu(switchtime_task, cpu);
+			if (cpu_switchtime_task &&
+			    task->prio < cpu_switchtime_task->prio) {
+				cpu_switchtime_task->switchtime_timestamp_hist =
+				    0;
+				put_task_struct(cpu_switchtime_task);
+				per_cpu(switchtime_task, cpu) = NULL;
+			}
+			raw_spin_unlock_irqrestore(&switchtime_lock, flags);
+		}
+#endif
+
 		now = ftrace_now(cpu);
 		latency = (long) div_s64(-latency_ns, NSECS_PER_USECS);
 		latency_hist(MISSED_TIMER_OFFSETS, cpu, latency, latency, now,
-		    task);
+		    task, -1);
 #ifdef CONFIG_WAKEUP_LATENCY_HIST
 		task->timer_offset = latency;
 #endif
@@ -1003,6 +1201,64 @@ static notrace void probe_hrtimer_interr
 }
 #endif
 
+#ifdef CONFIG_SWITCHTIME_HIST
+static notrace void probe_syscall_exit(void *v, struct pt_regs *regs, long ret)
+{
+	unsigned long flags;
+	int cpu = task_cpu(current);
+	struct task_struct *cpu_switchtime_task;
+
+	raw_spin_lock_irqsave(&switchtime_lock, flags);
+
+	cpu_switchtime_task = per_cpu(switchtime_task, cpu);
+	if (cpu_switchtime_task == NULL)
+		goto out;
+
+	if (current == cpu_switchtime_task) {
+		unsigned long latency;
+		cycle_t stop;
+		int syscall_nr;
+
+		if (switchtime_pid) {
+			if (likely(switchtime_pid !=
+			    task_pid_nr(current)))
+				goto out;
+		}
+
+		/*
+		 * The task we are waiting for exited from sytem call.
+		 * Calculate latency since start of context switch and store it
+		 * in histogram.
+		 */
+		stop = ftrace_now(raw_smp_processor_id());
+
+		latency = ((long) (stop - current->switchtime_timestamp_hist)) /
+		    NSECS_PER_USECS;
+
+		syscall_nr = syscall_get_nr(current, regs);
+
+		current->switchtime_timestamp_hist = 0;
+
+		latency_hist(SWITCHTIME, cpu, latency, 0, stop,
+		    current->switchtime_prev, syscall_nr);
+#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+		if (timerwakeupswitch_enabled_data.enabled) {
+			latency_hist(TIMERWAKEUPSWITCH_LATENCY, cpu,
+			    current->switchtime_timerandwakeup + latency,
+			    current->switchtime_timerandwakeup, stop,
+			    current->switchtime_prev, syscall_nr);
+		}
+#endif
+	}
+	put_task_struct(cpu_switchtime_task);
+	per_cpu(switchtime_task, cpu) = NULL;
+
+out:
+	raw_spin_unlock_irqrestore(&switchtime_lock, flags);
+}
+#endif
+
 static __init int latency_hist_init(void)
 {
 	struct dentry *latency_hist_root = NULL;
@@ -1147,6 +1403,32 @@ static __init int latency_hist_init(void
 	    &enable_fops);
 #endif
 
+#ifdef CONFIG_SWITCHTIME_HIST
+	dentry = debugfs_create_dir(switchtime_dir,
+	    latency_hist_root);
+	for_each_possible_cpu(i) {
+		sprintf(name, cpufmt, i);
+		entry = debugfs_create_file(name, 0444, dentry,
+		    &per_cpu(switchtime, i), &latency_hist_fops);
+		my_hist = &per_cpu(switchtime, i);
+		atomic_set(&my_hist->hist_mode, 1);
+		my_hist->min_lat = LONG_MAX;
+
+		sprintf(name, cpufmt_maxlatproc, i);
+		mp = &per_cpu(switchtime_maxlatproc, i);
+		entry = debugfs_create_file(name, 0444, dentry, mp,
+		    &maxlatproc_fops);
+		clear_maxlatprocdata(mp);
+	}
+	entry = debugfs_create_file("pid", 0644, dentry,
+	    (void *)&switchtime_pid, &pid_fops);
+	entry = debugfs_create_file("reset", 0644, dentry,
+	    (void *)SWITCHTIME, &latency_hist_reset_fops);
+	entry = debugfs_create_file("switchtime", 0644,
+	    enable_root, (void *)&switchtime_enabled_data,
+	    &enable_fops);
+#endif
+
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
 	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 	dentry = debugfs_create_dir(timerandwakeup_latency_hist_dir,
@@ -1172,6 +1454,32 @@ static __init int latency_hist_init(void
 	    enable_root, (void *)&timerandwakeup_enabled_data,
 	    &enable_fops);
 #endif
+#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST) && \
+	defined(CONFIG_SWITCHTIME_HIST)
+	dentry = debugfs_create_dir(timerwakeupswitch_latency_hist_dir,
+	    latency_hist_root);
+	for_each_possible_cpu(i) {
+		sprintf(name, cpufmt, i);
+		entry = debugfs_create_file(name, 0444, dentry,
+		    &per_cpu(timerwakeupswitch_latency_hist, i),
+		    &latency_hist_fops);
+		my_hist = &per_cpu(timerwakeupswitch_latency_hist, i);
+		atomic_set(&my_hist->hist_mode, 1);
+		my_hist->min_lat = LONG_MAX;
+
+		sprintf(name, cpufmt_maxlatproc, i);
+		mp = &per_cpu(timerwakeupswitch_maxlatproc, i);
+		entry = debugfs_create_file(name, 0444, dentry, mp,
+		    &maxlatproc_fops);
+		clear_maxlatprocdata(mp);
+	}
+	entry = debugfs_create_file("reset", 0644, dentry,
+	    (void *)TIMERWAKEUPSWITCH_LATENCY, &latency_hist_reset_fops);
+	entry = debugfs_create_file("timerwakeupswitch", 0644,
+	    enable_root, (void *)&timerwakeupswitch_enabled_data,
+	    &enable_fops);
+#endif
 	return 0;
 }
 

