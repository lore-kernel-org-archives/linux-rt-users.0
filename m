From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/1] From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Fri, 14 Feb 2014 18:16:42 +0100
Message-ID: <20140214172023.963348502@osadl.org>
References: <20140214171641.048899133@osadl.org>
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:51159 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbaBNRUx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Feb 2014 12:20:53 -0500
Content-Disposition: inline; filename=kernel-trace-latency-hist-checkpatch-cleanup.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This checkpatch.pl cleanup.
What remains is "WARNING: quoted string split across lines" and I am not
going to extend pr_info() over 80 chars.

Most things are cosmetic. There is one spot where NR_CPUS got replaced
with cpu_possible()

Cc: Carsten Emde <C.Emde@osadl.org>
Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/trace/latency_hist.c |   65 ++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

Index: linux-3.12.10-rt15/kernel/trace/latency_hist.c
===================================================================
--- linux-3.12.10-rt15.orig/kernel/trace/latency_hist.c
+++ linux-3.12.10-rt15/kernel/trace/latency_hist.c
@@ -22,7 +22,7 @@
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
 #include <linux/slab.h>
-#include <asm/atomic.h>
+#include <linux/atomic.h>
 #include <asm/div64.h>
 
 #include "trace.h"
@@ -95,7 +95,7 @@ static struct enable_data preemptirqsoff
 #endif
 
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 struct maxlatproc_data {
 	char comm[FIELD_SIZEOF(struct task_struct, comm)];
 	char current_comm[FIELD_SIZEOF(struct task_struct, comm)];
@@ -115,11 +115,11 @@ static DEFINE_PER_CPU(struct hist_data,
 static char *wakeup_latency_hist_dir = "wakeup";
 static char *wakeup_latency_hist_dir_sharedprio = "sharedprio";
 static notrace void probe_wakeup_latency_hist_start(void *v,
-    struct task_struct *p, int success);
+	struct task_struct *p, int success);
 static notrace void probe_wakeup_latency_hist_stop(void *v,
-    struct task_struct *prev, struct task_struct *next);
+	struct task_struct *prev, struct task_struct *next);
 static notrace void probe_sched_migrate_task(void *,
-    struct task_struct *task, int cpu);
+	struct task_struct *task, int cpu);
 static struct enable_data wakeup_latency_enabled_data = {
 	.latency_type = WAKEUP_LATENCY,
 	.enabled = 0,
@@ -135,7 +135,7 @@ static unsigned long wakeup_pid;
 static DEFINE_PER_CPU(struct hist_data, missed_timer_offsets);
 static char *missed_timer_offsets_dir = "missed_timer_offsets";
 static notrace void probe_hrtimer_interrupt(void *v, int cpu,
-    long long offset, struct task_struct *curr, struct task_struct *task);
+	long long offset, struct task_struct *curr, struct task_struct *task);
 static struct enable_data missed_timer_offsets_enabled_data = {
 	.latency_type = MISSED_TIMER_OFFSETS,
 	.enabled = 0,
@@ -145,7 +145,7 @@ static unsigned long missed_timer_offset
 #endif
 
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 static DEFINE_PER_CPU(struct hist_data, timerandwakeup_latency_hist);
 static char *timerandwakeup_latency_hist_dir = "timerandwakeup";
 static struct enable_data timerandwakeup_enabled_data = {
@@ -161,11 +161,11 @@ void notrace latency_hist(int latency_ty
 {
 	struct hist_data *my_hist;
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 	struct maxlatproc_data *mp = NULL;
 #endif
 
-	if (cpu < 0 || cpu >= NR_CPUS || latency_type < 0 ||
+	if (!cpu_possible(cpu) || latency_type < 0 ||
 	    latency_type >= MAX_LATENCY_TYPE)
 		return;
 
@@ -202,7 +202,7 @@ void notrace latency_hist(int latency_ty
 		break;
 #endif
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 	case TIMERANDWAKEUP_LATENCY:
 		my_hist = &per_cpu(timerandwakeup_latency_hist, cpu);
 		mp = &per_cpu(timerandwakeup_maxlatproc, cpu);
@@ -229,7 +229,7 @@ void notrace latency_hist(int latency_ty
 	if (unlikely(latency > my_hist->max_lat ||
 	    my_hist->min_lat == LONG_MAX)) {
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 		if (latency_type == WAKEUP_LATENCY ||
 		    latency_type == WAKEUP_LATENCY_SHAREDPRIO ||
 		    latency_type == MISSED_TIMER_OFFSETS ||
@@ -334,7 +334,7 @@ static int l_show(struct seq_file *m, vo
 	return 0;
 }
 
-static struct seq_operations latency_hist_seq_op = {
+static const struct seq_operations latency_hist_seq_op = {
 	.start = l_start,
 	.next  = l_next,
 	.stop  = l_stop,
@@ -353,7 +353,7 @@ static int latency_hist_open(struct inod
 	return ret;
 }
 
-static struct file_operations latency_hist_fops = {
+static const struct file_operations latency_hist_fops = {
 	.open = latency_hist_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -361,7 +361,7 @@ static struct file_operations latency_hi
 };
 
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 static void clear_maxlatprocdata(struct maxlatproc_data *mp)
 {
 	mp->comm[0] = mp->current_comm[0] = '\0';
@@ -393,7 +393,7 @@ latency_hist_reset(struct file *file, co
 	int cpu;
 	struct hist_data *hist = NULL;
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 	struct maxlatproc_data *mp = NULL;
 #endif
 	off_t latency_type = (off_t) file->private_data;
@@ -433,7 +433,7 @@ latency_hist_reset(struct file *file, co
 			break;
 #endif
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 		case TIMERANDWAKEUP_LATENCY:
 			hist = &per_cpu(timerandwakeup_latency_hist, cpu);
 			mp = &per_cpu(timerandwakeup_maxlatproc, cpu);
@@ -443,7 +443,7 @@ latency_hist_reset(struct file *file, co
 
 		hist_reset(hist);
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 		if (latency_type == WAKEUP_LATENCY ||
 		    latency_type == WAKEUP_LATENCY_SHAREDPRIO ||
 		    latency_type == MISSED_TIMER_OFFSETS ||
@@ -456,7 +456,7 @@ latency_hist_reset(struct file *file, co
 }
 
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 static ssize_t
 show_pid(struct file *file, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -483,8 +483,8 @@ static ssize_t do_pid(struct file *file,
 
 	buf[cnt] = '\0';
 
-	if (strict_strtoul(buf, 10, &pid))
-		return(-EINVAL);
+	if (kstrtoul(buf, 10, &pid))
+		return -EINVAL;
 
 	*this_pid = pid;
 
@@ -493,7 +493,7 @@ static ssize_t do_pid(struct file *file,
 #endif
 
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 static ssize_t
 show_maxlatproc(struct file *file, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -554,8 +554,8 @@ do_enable(struct file *file, const char
 
 	buf[cnt] = 0;
 
-	if (strict_strtol(buf, 10, &enable))
-		return(-EINVAL);
+	if (kstrtoul(buf, 10, &enable))
+		return -EINVAL;
 
 	if ((enable && ed->enabled) || (!enable && !ed->enabled))
 		return cnt;
@@ -637,7 +637,7 @@ do_enable(struct file *file, const char
 			break;
 #endif
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 		case TIMERANDWAKEUP_LATENCY:
 			if (!wakeup_latency_enabled_data.enabled ||
 			    !missed_timer_offsets_enabled_data.enabled)
@@ -726,7 +726,7 @@ static const struct file_operations enab
 };
 
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 static const struct file_operations pid_fops = {
 	.open = tracing_open_generic,
 	.read = show_pid,
@@ -741,7 +741,7 @@ static const struct file_operations maxl
 
 #if defined(CONFIG_INTERRUPT_OFF_HIST) || defined(CONFIG_PREEMPT_OFF_HIST)
 static notrace void probe_preemptirqsoff_hist(void *v, int reason,
-    int starthist)
+	int starthist)
 {
 	int cpu = raw_smp_processor_id();
 	int time_set = 0;
@@ -846,7 +846,7 @@ static notrace void probe_preemptirqsoff
 #ifdef CONFIG_WAKEUP_LATENCY_HIST
 static DEFINE_RAW_SPINLOCK(wakeup_lock);
 static notrace void probe_sched_migrate_task(void *v, struct task_struct *task,
-    int cpu)
+	int cpu)
 {
 	int old_cpu = task_cpu(task);
 
@@ -869,7 +869,7 @@ static notrace void probe_sched_migrate_
 }
 
 static notrace void probe_wakeup_latency_hist_start(void *v,
-    struct task_struct *p, int success)
+	struct task_struct *p, int success)
 {
 	unsigned long flags;
 	struct task_struct *curr = current;
@@ -907,7 +907,7 @@ out:
 }
 
 static notrace void probe_wakeup_latency_hist_stop(void *v,
-    struct task_struct *prev, struct task_struct *next)
+	struct task_struct *prev, struct task_struct *next)
 {
 	unsigned long flags;
 	int cpu = task_cpu(next);
@@ -976,7 +976,8 @@ out:
 
 #ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
 static notrace void probe_hrtimer_interrupt(void *v, int cpu,
-    long long latency_ns, struct task_struct *curr, struct task_struct *task)
+	long long latency_ns, struct task_struct *curr,
+	struct task_struct *task)
 {
 	if (latency_ns <= 0 && task != NULL && rt_task(task) &&
 	    (task->prio < curr->prio ||
@@ -1016,7 +1017,7 @@ static __init int latency_hist_init(void
 	char name[64];
 	char *cpufmt = "CPU%d";
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 	char *cpufmt_maxlatproc = "max_latency-CPU%d";
 	struct maxlatproc_data *mp = NULL;
 #endif
@@ -1147,7 +1148,7 @@ static __init int latency_hist_init(void
 #endif
 
 #if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
-    defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
+	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
 	dentry = debugfs_create_dir(timerandwakeup_latency_hist_dir,
 	    latency_hist_root);
 	for_each_possible_cpu(i) {

