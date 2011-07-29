From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 1/3] cpupri: Add profiling
Date: Fri, 29 Jul 2011 11:13:41 -0400
Message-ID: <20110729151954.577848562@goodmis.org>
References: <20110729151340.419467771@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <mgalbraith@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:32807 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab1G2PT4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 11:19:56 -0400
Content-Disposition: inline; filename=cpupri-benchmark.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Index: linux-rt.git/kernel/sched_cpupri.c
===================================================================
--- linux-rt.git.orig/kernel/sched_cpupri.c
+++ linux-rt.git/kernel/sched_cpupri.c
@@ -28,8 +28,83 @@
  */
 
 #include <linux/gfp.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 #include "sched_cpupri.h"
 
+static DEFINE_PER_CPU(unsigned long long, cpupri_loop_start);
+static DEFINE_PER_CPU(unsigned long long, cpupri_loop_max);
+static DEFINE_PER_CPU(unsigned long long, cpupri_loop_min);
+static DEFINE_PER_CPU(unsigned long long, cpupri_loop_total);
+static DEFINE_PER_CPU(atomic_t, cpupri_loop_count);
+
+static DEFINE_PER_CPU(unsigned long long, cpupri_vec_start);
+static DEFINE_PER_CPU(unsigned long long, cpupri_vec_max);
+static DEFINE_PER_CPU(unsigned long long, cpupri_vec_min);
+static DEFINE_PER_CPU(unsigned long long, cpupri_vec_total);
+static DEFINE_PER_CPU(atomic_t, cpupri_vec_count);
+
+static inline void __cpupri_start(unsigned long long *start)
+{
+	*start = sched_clock();
+}
+
+static inline void __cpupri_stop(unsigned long long *start,
+				 unsigned long long *max,
+				 unsigned long long *min,
+				 unsigned long long *total,
+				 atomic_t *count)
+{
+	unsigned long long end, delta;
+
+	end = sched_clock();
+	delta = end - *start;
+
+	/* Init for the first run */
+	if (atomic_inc_return(count) == 1) {
+		*max = delta;
+		*min = delta;
+		*total = delta;
+		return;
+	}
+
+	if (delta > *max)
+		*max = delta;
+
+	if (delta < *min)
+		*min = delta;
+
+	(*total) += delta;
+}
+
+static inline void cpupri_start_loop(void)
+{
+	__cpupri_start(&__get_cpu_var(cpupri_loop_start));
+}
+
+static inline void cpupri_stop_loop(void)
+{
+	__cpupri_stop(&__get_cpu_var(cpupri_loop_start),
+		      &__get_cpu_var(cpupri_loop_max),
+		      &__get_cpu_var(cpupri_loop_min),
+		      &__get_cpu_var(cpupri_loop_total),
+		      &__get_cpu_var(cpupri_loop_count));
+}
+
+static inline void cpupri_start_vec(void)
+{
+	__cpupri_start(&__get_cpu_var(cpupri_vec_start));
+}
+
+static inline void cpupri_stop_vec(void)
+{
+	__cpupri_stop(&__get_cpu_var(cpupri_vec_start),
+		      &__get_cpu_var(cpupri_vec_max),
+		      &__get_cpu_var(cpupri_vec_min),
+		      &__get_cpu_var(cpupri_vec_total),
+		      &__get_cpu_var(cpupri_vec_count));
+}
+
 /* Convert between a 140 based task->prio, and our 102 based cpupri */
 static int convert_prio(int prio)
 {
@@ -71,6 +146,7 @@ int cpupri_find(struct cpupri *cp, struc
 	int                  idx      = 0;
 	int                  task_pri = convert_prio(p->prio);
 
+	cpupri_start_loop();
 	for_each_cpupri_active(cp->pri_active, idx) {
 		struct cpupri_vec *vec  = &cp->pri_to_cpu[idx];
 
@@ -95,8 +171,10 @@ int cpupri_find(struct cpupri *cp, struc
 				continue;
 		}
 
+		cpupri_stop_loop();
 		return 1;
 	}
+	cpupri_stop_loop();
 
 	return 0;
 }
@@ -124,6 +202,7 @@ void cpupri_set(struct cpupri *cp, int c
 	if (newpri == oldpri)
 		return;
 
+	cpupri_start_vec();
 	/*
 	 * If the cpu was currently mapped to a different value, we
 	 * need to map it to the new value then remove the old value.
@@ -155,6 +234,7 @@ void cpupri_set(struct cpupri *cp, int c
 
 		raw_spin_unlock_irqrestore(&vec->lock, flags);
 	}
+	cpupri_stop_vec();
 
 	*currpri = newpri;
 }
@@ -202,3 +282,146 @@ void cpupri_cleanup(struct cpupri *cp)
 	for (i = 0; i < CPUPRI_NR_PRIORITIES; i++)
 		free_cpumask_var(cp->pri_to_cpu[i].mask);
 }
+
+
+static void *t_start(struct seq_file *m, loff_t *pos)
+{
+	if (*pos >= num_online_cpus())
+		return NULL;
+
+	/* Add one, because 0 abort seq_file */
+	return (void *)(*pos)+1;
+}
+
+static void *t_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	(*pos)++;
+
+	if (*pos >= num_online_cpus())
+		return NULL;
+
+	return (void *)(*pos)+1;
+}
+
+static void norm(struct seq_file *m, unsigned long long val)
+{
+	unsigned long rem;
+
+	rem = do_div(val, 1000);
+
+	seq_printf(m, "\t%lld.%03ld", val, rem);
+}
+
+static int _t_show(struct seq_file *m, const char *name,
+		   unsigned long long max,
+		   unsigned long long min,
+		   unsigned long long total,
+		   unsigned long count)
+{
+	unsigned long long avg = total;
+
+	seq_printf(m, "\t%s\t%ld", name, count);
+
+	if (!count) {
+		seq_printf(m, "\t0\t0\t0\t0\n");
+		return 0;
+	}
+
+	do_div(avg, count);
+	norm(m, max);
+	norm(m, min);
+	norm(m, avg);
+	norm(m, total);
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static int t_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = ((unsigned long)v) - 1;
+
+	if (!cpu) {
+		seq_printf(m, "CPU:\tName\tCount\tMax\tMin\tAverage\tTotal\n");
+		seq_printf(m, "----\t----\t-----\t---\t---\t-------\t-----\n");
+	}
+
+	seq_printf(m, "cpu %ld:", cpu);
+
+	_t_show(m, "loop", per_cpu(cpupri_loop_max, cpu),
+		per_cpu(cpupri_loop_min, cpu),
+		per_cpu(cpupri_loop_total, cpu),
+		atomic_read(&per_cpu(cpupri_loop_count, cpu)));
+
+	_t_show(m, "vec", per_cpu(cpupri_vec_max, cpu),
+		per_cpu(cpupri_vec_min, cpu),
+		per_cpu(cpupri_vec_total, cpu),
+		atomic_read(&per_cpu(cpupri_vec_count, cpu)));
+	return 0;
+}
+
+static void t_stop(struct seq_file *m, void *p)
+{
+}
+
+static const struct seq_operations cpupri_seq_ops = {
+	.start = t_start,
+	.next = t_next,
+	.stop = t_stop,
+	.show = t_show,
+};
+
+static int cpupri_open(struct inode *inode, struct file *file)
+{
+	int ret = 0;
+	int cpu;
+
+	if (file->f_mode & FMODE_WRITE) {
+		for_each_online_cpu(cpu) {
+			atomic_set(&per_cpu(cpupri_loop_count, cpu), 0);
+			atomic_set(&per_cpu(cpupri_vec_count, cpu), 0);
+		}
+	}
+	if (file->f_mode & FMODE_READ)
+		ret = seq_open(file, &cpupri_seq_ops);
+
+	return ret;
+}
+
+static ssize_t
+cpupri_write(struct file *filp, const char __user *ubuf,
+		     size_t cnt, loff_t *ppos)
+{
+	return cnt;
+}
+
+
+static int cpupri_release(struct inode *inode, struct file *file)
+{
+	if (file->f_mode & FMODE_READ)
+		seq_release(inode, file);
+	return 0;
+}
+
+static const struct file_operations cpupri_fops = {
+	.open		= cpupri_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= cpupri_release,
+	.write		= cpupri_write,
+};
+
+static __init int debug_cpupri_init(void)
+{
+	struct dentry *dentry;
+
+	if (!debugfs_initialized())
+		return -1;
+
+	dentry = debugfs_create_file("cpupri", 0644, NULL, NULL, &cpupri_fops);
+	if (!dentry)
+		pr_warning("Could not create debugfs cpupri entry\n");
+	return 0;
+}
+
+fs_initcall(debug_cpupri_init);

