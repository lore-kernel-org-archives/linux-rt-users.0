From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 4/4] hwlat: Add per cpu mask for hwlat_detector
Date: Thu, 23 Apr 2015 15:08:29 -0400
Message-ID: <20150423191725.363886450@goodmis.org>
References: <20150423190825.714359844@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Daniel Wagner <wagi@monom.org>, Jon Masters <jcm@redhat.com>,
	Clark Williams <williams@redhat.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-hwlat-Add-per-cpu-mask-for-hwlat_detector.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Instead of just running a single kernel thread to do the hardware latency
detection, run one on each CPU that the user specificies. By default
this will be just one CPU (on CPU 0). But the user may specify what
CPUs they would like to run the tests on.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/trace/hwlat_detector.txt |   5 +
 kernel/trace/Kconfig                   |  21 +--
 kernel/trace/trace.c                   |   9 +-
 kernel/trace/trace.h                   |   2 +
 kernel/trace/trace_hwlatdetect.c       | 245 +++++++++++++++++++++++++--------
 5 files changed, 212 insertions(+), 70 deletions(-)

diff --git a/Documentation/trace/hwlat_detector.txt b/Documentation/trace/hwlat_detector.txt
index db98dd1fa4ed..de08fd5ce931 100644
--- a/Documentation/trace/hwlat_detector.txt
+++ b/Documentation/trace/hwlat_detector.txt
@@ -46,6 +46,7 @@ count			- number of latency spikes observed since last reset
 width			- time period to sample with CPUs held (usecs)
 			  must be less than the total window size (enforced)
 window			- total period of sampling, width being inside (usecs)
+cpumask			- the cpu mask to run the hwlat detector kthreads on
 
 By default we will set width to 500,000 and window to 1,000,000, meaning that
 we will sample every 1,000,000 usecs (1s) for 500,000 usecs (0.5s). If we
@@ -53,6 +54,10 @@ observe any latencies that exceed the threshold (initially 100 usecs),
 then we write to a global sample ring buffer of 8K samples, which is
 consumed by reading from the "sample" (pipe) debugfs file interface.
 
+The cpumask is set to default of 1, meaning it will only kick off one thread
+on CPU 0. If you want to test other CPUs, writing a cpumask number (hex digit
+like 'e') into the cpumask file will spawn new threads to run on those CPUs.
+
 Also the following tracing directory files are used by the hwlat_detector:
 
 in /sys/kernel/debug/tracing:
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 9b46a3322a89..54a78fdfb56a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -226,8 +226,9 @@ config HWLAT_TRACER
      	select GENERIC_TRACER
 	select TRACER_MAX_TRACE
 	help
-	 This tracer, when enabled will create a kernel thread that
-	 spins in a loop looking for interruptions caused by
+	 This tracer, when enabled will create one or more kernel threads,
+	 depening on what the cpumask file is set to, which each thread
+	 spinning in a loop looking for interruptions caused by
 	 something other than the kernel. For example, if a
 	 System Management Interrupt (SMI) takes a noticeable amount of
 	 time, this tracer will detect it. This is useful for testing
@@ -236,18 +237,20 @@ config HWLAT_TRACER
 	 Some files are created in the tracing directory when this
 	 is enabled:
 
-	   hwlat_detector/count  - the count of records of latencies found
-	   hwlat_detector/width  - time in usecs for how long to spin for
-	   hwlat_detector/window - time in usecs between the start of each
-				    iteration
+	   hwlat_detector/count   - the count of records of latencies found
+	   hwlat_detector/width   - time in usecs for how long to spin for
+	   hwlat_detector/window  - time in usecs between the start of each
+				     iteration
+	   hwlat_detector/cpumask - The mask of what CPUs the test should run on.
 
-	 The kernel thread will spin with interrupts disabled for
+	 A kernel thread is created on each CPU specified by "cpumask".
+
+	 Each kernel thread will spin with interrupts disabled for
 	 "width" microseconds in every "widow" cycle. It will not spin
 	 for "window - width" microseconds, where the system can
 	 continue to operate.
 
-	 Only a single thread is created that runs this tracer. The
-	 output will appear in the trace and trace_pipe files.
+	 The output will appear in the trace and trace_pipe files.
 
 	 When the tracer is not running, it has no affect on the system,
 	 but when it is running, it can cause the system to be
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7312418a1498..8e806ac2849c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3372,13 +3372,13 @@ static const struct file_operations show_traces_fops = {
  * The tracer itself will not take this lock, but still we want
  * to provide a consistent cpumask to user-space:
  */
-static DEFINE_MUTEX(tracing_cpumask_update_lock);
+DEFINE_MUTEX(tracing_cpumask_update_lock);
 
 /*
  * Temporary storage for the character representation of the
  * CPU bitmask (and one more byte for the newline):
  */
-static char mask_str[NR_CPUS + 1];
+char tracing_mask_str[NR_CPUS + 1];
 
 static ssize_t
 tracing_cpumask_read(struct file *filp, char __user *ubuf,
@@ -3389,13 +3389,14 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 
 	mutex_lock(&tracing_cpumask_update_lock);
 
-	len = snprintf(mask_str, count, "%*pb\n",
+	len = snprintf(tracing_mask_str, count, "%*pb\n",
 		       cpumask_pr_args(tr->tracing_cpumask));
 	if (len >= count) {
 		count = -EINVAL;
 		goto out_err;
 	}
-	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, NR_CPUS+1);
+	count = simple_read_from_buffer(ubuf, count, ppos,
+					tracing_mask_str, NR_CPUS+1);
 
 out_err:
 	mutex_unlock(&tracing_cpumask_update_lock);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d321f8c70d76..d4686d1f130e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -598,6 +598,8 @@ int is_tracing_stopped(void);
 loff_t tracing_lseek(struct file *file, loff_t offset, int whence);
 
 extern cpumask_var_t __read_mostly tracing_buffer_mask;
+extern char tracing_mask_str[NR_CPUS + 1];
+extern struct mutex tracing_cpumask_update_lock;
 
 #define for_each_tracing_cpu(cpu)	\
 	for_each_cpu(cpu, tracing_buffer_mask)
diff --git a/kernel/trace/trace_hwlatdetect.c b/kernel/trace/trace_hwlatdetect.c
index 7437c992746a..393d37da6f6c 100644
--- a/kernel/trace/trace_hwlatdetect.c
+++ b/kernel/trace/trace_hwlatdetect.c
@@ -48,6 +48,7 @@
 #include <linux/debugfs.h>
 #include <linux/uaccess.h>
 #include <linux/version.h>
+#include <linux/percpu.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/time.h>
@@ -66,17 +67,23 @@
 
 static struct trace_array *hwlat_detector_trace_array;
 
-static struct task_struct *kthread;		/* sampling thread */
+/* sampling threads*/
+static DEFINE_PER_CPU(struct task_struct *, hwlat_kthread);
+static cpumask_var_t kthread_mask;
 
 /* DebugFS filesystem entries */
 
 static struct dentry *debug_count;		/* total detect count */
 static struct dentry *debug_sample_width;	/* sample width us */
 static struct dentry *debug_sample_window;	/* sample window us */
+static struct dentry *debug_hwlat_cpumask;	/* cpumask to run on */
 
 /* Save the previous tracing_thresh value */
 static unsigned long save_tracing_thresh;
 
+/* Set when hwlat_detector is running */
+static bool hwlat_detector_enabled;
+
 /* Individual samples and global state */
 
 /* If the user changed threshold, remember it */
@@ -85,9 +92,9 @@ static u64 last_tracing_thresh = DEFAULT_LAT_THRESHOLD * NSEC_PER_USEC;
 /*
  * Individual latency samples are stored here when detected and packed into
  * the ring_buffer circular buffer, where they are overwritten when
- * more than buf_size/sizeof(sample) samples are received.
+ * more than buf_size/sizeof(hwlat_sample) samples are received.
  */
-struct sample {
+struct hwlat_sample {
 	u64		seqnum;		/* unique sequence */
 	u64		duration;	/* ktime delta */
 	u64		outer_duration;	/* ktime delta (outer loop) */
@@ -95,7 +102,7 @@ struct sample {
 };
 
 /* keep the global state somewhere. */
-static struct data {
+static struct hwlat_data {
 
 	struct mutex lock;		/* protect changes */
 
@@ -104,12 +111,12 @@ static struct data {
 	u64	sample_window;		/* total sampling window (on+off) */
 	u64	sample_width;		/* active sampling portion of window */
 
-} data = {
+} hwlat_data = {
 	.sample_window		= DEFAULT_SAMPLE_WINDOW,
 	.sample_width		= DEFAULT_SAMPLE_WIDTH,
 };
 
-static void trace_hwlat_sample(struct sample *sample)
+static void trace_hwlat_sample(struct hwlat_sample *sample)
 {
 	struct trace_array *tr = hwlat_detector_trace_array;
 	struct ftrace_event_call *call = &event_hwlat_detector;
@@ -149,7 +156,7 @@ static void trace_hwlat_sample(struct sample *sample)
  *
  * Used to repeatedly capture the CPU TSC (or similar), looking for potential
  * hardware-induced latency. Called with interrupts disabled and with
- * data.lock held.
+ * hwlat_data.lock held.
  */
 static int get_sample(void)
 {
@@ -205,18 +212,18 @@ static int get_sample(void)
 		if (diff > sample)
 			sample = diff; /* only want highest value */
 
-	} while (total <= data.sample_width);
+	} while (total <= hwlat_data.sample_width);
 
 	ret = 0;
 
 	/* If we exceed the threshold value, we have found a hardware latency */
 	if (sample > thresh || outer_sample > thresh) {
-		struct sample s;
+		struct hwlat_sample s;
 
 		ret = 1;
 
-		data.count++;
-		s.seqnum = data.count;
+		hwlat_data.count++;
+		s.seqnum = hwlat_data.count;
 		s.duration = sample;
 		s.outer_duration = outer_sample;
 		s.timestamp = CURRENT_TIME;
@@ -244,20 +251,27 @@ out:
  * but we might later generalize this if we find there are any actualy
  * systems with alternate SMI delivery or other hardware latencies.
  */
-static int kthread_fn(void *unused)
+static int kthread_fn(void *data)
 {
+	unsigned long cpu = (unsigned long)data;
 	int ret;
 	u64 interval;
 
+	preempt_disable();
+	WARN(cpu != smp_processor_id(),
+	     "hwlat_detector thread on wrong cpu %d (expected %ld)",
+	     smp_processor_id(), cpu);
+	preempt_enable();
+
 	while (!kthread_should_stop()) {
 
 		local_irq_disable();
 		ret = get_sample();
 		local_irq_enable();
 
-		mutex_lock(&data.lock);
-		interval = data.sample_window - data.sample_width;
-		mutex_unlock(&data.lock);
+		mutex_lock(&hwlat_data.lock);
+		interval = hwlat_data.sample_window - hwlat_data.sample_width;
+		mutex_unlock(&hwlat_data.lock);
 
 		do_div(interval, USEC_PER_MSEC); /* modifies interval value */
 
@@ -269,58 +283,79 @@ static int kthread_fn(void *unused)
 }
 
 /**
- * start_kthread - Kick off the hardware latency sampling/detector kthread
+ * start_kthreads - Kick off the hardware latency sampling/detector kthreads
  *
- * This starts a kernel thread that will sit and sample the CPU timestamp
+ * This starts the kernel threads that will sit and sample the CPU timestamp
  * counter (TSC or similar) and look for potential hardware latencies.
  */
-static int start_kthread(void)
+static int start_kthreads(void)
 {
-	kthread = kthread_run(kthread_fn, NULL, "hwlat_detector");
-	if (IS_ERR(kthread)) {
-		kthread = NULL;
-		pr_err(BANNER "could not start sampling thread\n");
-		return -ENOMEM;
+	struct task_struct *kthread;
+	unsigned long cpu;
+
+	for_each_cpu(cpu, kthread_mask) {
+		kthread = kthread_create(kthread_fn, (void *)cpu,
+					 "hwlatd/%ld", cpu);
+		if (IS_ERR(kthread)) {
+			pr_err(BANNER "could not start sampling thread\n");
+			goto fail;
+		}
+		kthread_bind(kthread, cpu);
+		per_cpu(hwlat_kthread, cpu) = kthread;
+		wake_up_process(kthread);
 	}
 
 	return 0;
+ fail:
+	for_each_cpu(cpu, kthread_mask) {
+		kthread = per_cpu(hwlat_kthread, cpu);
+		if (!kthread)
+			continue;
+		kthread_stop(kthread);
+	}
+		
+	return -ENOMEM;
+
 }
 
 /**
- * stop_kthread - Inform the hardware latency samping/detector kthread to stop
+ * stop_kthreads - Inform the hardware latency samping/detector kthread to stop
  *
  * This kicks the running hardware latency sampling/detector kernel thread and
  * tells it to stop sampling now. Use this on unload and at system shutdown.
  */
-static int stop_kthread(void)
+static int stop_kthreads(void)
 {
-	int ret = 0;
-
-	if (kthread) {
-		ret = kthread_stop(kthread);
-		kthread = NULL;
+	struct task_struct *kthread;
+	int cpu;
+
+	for_each_cpu(cpu, kthread_mask) {
+		kthread = per_cpu(hwlat_kthread, cpu);
+		per_cpu(hwlat_kthread, cpu) = NULL;
+		if (WARN_ON_ONCE(!kthread))
+			continue;
+		kthread_stop(kthread);
 	}
-
-	return ret;
+	return 0;
 }
 
 /**
  * __reset_stats - Reset statistics for the hardware latency detector
  *
- * We use data to store various statistics and global state. We call this
+ * We use hwlat_data to store various statistics and global state. We call this
  * function in order to reset those when "enable" is toggled on or off, and
  * also at initialization.
  */
 static void __reset_stats(struct trace_array *tr)
 {
-	data.count = 0;
+	hwlat_data.count = 0;
 	tr->max_latency = 0;
 }
 
 /**
  * init_stats - Setup global state statistics for the hardware latency detector
  *
- * We use data to store various statistics and global state.
+ * We use hwlat_data to store various statistics and global state.
  */
 static void init_stats(struct trace_array *tr)
 {
@@ -333,6 +368,80 @@ static void init_stats(struct trace_array *tr)
 		tracing_thresh = last_tracing_thresh;
 }
 
+static ssize_t
+hwlat_cpumask_read(struct file *filp, char __user *ubuf,
+		   size_t count, loff_t *ppos)
+{
+	int len;
+
+	mutex_lock(&tracing_cpumask_update_lock);
+
+	len = snprintf(tracing_mask_str, count, "%*pb\n",
+		       cpumask_pr_args(kthread_mask));
+	if (len >= count) {
+		count = -EINVAL;
+		goto out_err;
+	}
+	count = simple_read_from_buffer(ubuf, count, ppos,
+					tracing_mask_str, NR_CPUS+1);
+
+out_err:
+	mutex_unlock(&tracing_cpumask_update_lock);
+
+	return count;
+}
+
+static ssize_t
+hwlat_cpumask_write(struct file *filp, const char __user *ubuf,
+		    size_t count, loff_t *ppos)
+{
+	struct trace_array *tr = hwlat_detector_trace_array;
+	cpumask_var_t tracing_cpumask_new;
+	int err;
+
+	if (!alloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = cpumask_parse_user(ubuf, count, tracing_cpumask_new);
+	if (err)
+		goto err_unlock;
+
+	/* Keep the tracer from changing midstream */
+	mutex_lock(&trace_types_lock);
+
+	/* Protect the kthread_mask from changing */
+	mutex_lock(&tracing_cpumask_update_lock);
+
+	/* Stop the threads */
+	if (hwlat_detector_enabled && tracer_tracing_is_on(tr))
+		stop_kthreads();
+
+	cpumask_copy(kthread_mask, tracing_cpumask_new);
+
+	/* Restart the kthreads with the new mask */
+	if (hwlat_detector_enabled && tracer_tracing_is_on(tr))
+		start_kthreads();
+
+	mutex_unlock(&tracing_cpumask_update_lock);
+	mutex_unlock(&trace_types_lock);
+
+	free_cpumask_var(tracing_cpumask_new);
+
+	return count;
+
+err_unlock:
+	free_cpumask_var(tracing_cpumask_new);
+
+	return err;
+}
+
+static const struct file_operations hwlat_cpumask_fops = {
+	.open		= tracing_open_generic,
+	.read		= hwlat_cpumask_read,
+	.write		= hwlat_cpumask_write,
+	.llseek		= generic_file_llseek,
+};
+
 /*
  * hwlat_read - Wrapper read function for global state debugfs entries
  * @filp: The active open file structure for the debugfs "file"
@@ -341,7 +450,7 @@ static void init_stats(struct trace_array *tr)
  * @ppos: The current "file" position
  *
  * This function provides a generic read implementation for the global state
- * "data" structure debugfs filesystem entries.
+ * "hwlat_data" structure debugfs filesystem entries.
  */
 static ssize_t hwlat_read(struct file *filp, char __user *ubuf,
 			  size_t cnt, loff_t *ppos)
@@ -372,7 +481,7 @@ static ssize_t hwlat_read(struct file *filp, char __user *ubuf,
  * @ppos: The current "file" position
  *
  * This function provides a generic write implementation for the global state
- * "data" structure debugfs filesystem entries.
+ * "hwlat_data" structure debugfs filesystem entries.
  */
 static ssize_t hwlat_write(struct file *filp, const char __user *ubuf,
 			   size_t cnt, loff_t *ppos)
@@ -414,10 +523,12 @@ static ssize_t
 debug_width_write(struct file *filp, const char __user *ubuf,
 		  size_t cnt, loff_t *ppos)
 {
+	struct task_struct *kthread;
 	char buf[U64STR_SIZE];
 	int csize = min(cnt, sizeof(buf));
 	u64 val = 0;
 	int err = 0;
+	int cpu;
 
 	memset(buf, '\0', sizeof(buf));
 	if (copy_from_user(buf, ubuf, csize))
@@ -428,15 +539,18 @@ debug_width_write(struct file *filp, const char __user *ubuf,
 	if (0 != err)
 		return -EINVAL;
 
-	mutex_lock(&data.lock);
-	if (val < data.sample_window)
-		data.sample_width = val;
+	mutex_lock(&hwlat_data.lock);
+	if (val < hwlat_data.sample_window)
+		hwlat_data.sample_width = val;
 	else
 		csize = -EINVAL;
-	mutex_unlock(&data.lock);
+	mutex_unlock(&hwlat_data.lock);
 
-	if (kthread)
-		wake_up_process(kthread);
+	for_each_cpu(cpu, kthread_mask) {
+		kthread = per_cpu(hwlat_kthread, cpu);
+		if (kthread)
+			wake_up_process(kthread);
+	}
 
 	return csize;
 }
@@ -474,12 +588,12 @@ debug_window_write(struct file *filp, const char __user *ubuf,
 	if (0 != err)
 		return -EINVAL;
 
-	mutex_lock(&data.lock);
-	if (data.sample_width < val)
-		data.sample_window = val;
+	mutex_lock(&hwlat_data.lock);
+	if (hwlat_data.sample_width < val)
+		hwlat_data.sample_window = val;
 	else
 		csize = -EINVAL;
-	mutex_unlock(&data.lock);
+	mutex_unlock(&hwlat_data.lock);
 
 	return csize;
 }
@@ -533,25 +647,35 @@ static int init_debugfs(void)
 		goto err_debug_dir;
 
 	debug_count = debugfs_create_file("count", 0440,
-					  debug_dir, &data.count,
+					  debug_dir, &hwlat_data.count,
 					  &count_fops);
 	if (!debug_count)
 		goto err_count;
 
 	debug_sample_window = debugfs_create_file("window", 0640,
-						      debug_dir, &data.sample_window,
-						      &window_fops);
+						  debug_dir,
+						  &hwlat_data.sample_window,
+						  &window_fops);
 	if (!debug_sample_window)
 		goto err_window;
 
 	debug_sample_width = debugfs_create_file("width", 0644,
-						     debug_dir, &data.sample_width,
-						     &width_fops);
+						 debug_dir,
+						 &hwlat_data.sample_width,
+						 &width_fops);
 	if (!debug_sample_width)
 		goto err_width;
 
+	debug_hwlat_cpumask = debugfs_create_file("cpumask", 0644,
+						  debug_dir, NULL,
+						  &hwlat_cpumask_fops);
+	if (!debug_hwlat_cpumask)
+		goto err_cpumask;
+
 	return 0;
 
+err_cpumask:
+	debugfs_remove(debug_sample_width);
 err_width:
 	debugfs_remove(debug_sample_window);
 err_window:
@@ -566,7 +690,7 @@ static void hwlat_detector_tracer_start(struct trace_array *tr)
 {
 	int err;
 
-	err = start_kthread();
+	err = start_kthreads();
 	if (err)
 		pr_err(BANNER "cannot start kthread\n");
 }
@@ -575,13 +699,11 @@ static void hwlat_detector_tracer_stop(struct trace_array *tr)
 {
 	int err;
 
-	err = stop_kthread();
+	err = stop_kthreads();
 	if (err)
 		pr_err(BANNER "cannot stop kthread\n");
 }
 
-static bool hwlat_detector_enabled;
-
 static int hwlat_detector_tracer_init(struct trace_array *tr)
 {
 	/* Only allow one instance to enable this */
@@ -623,9 +745,18 @@ static struct tracer hwlatdetect_tracer __read_mostly = {
 
 static int __init init_hwlat_detector_tracer(void)
 {
+	int ret;
+
+	ret = alloc_cpumask_var(&kthread_mask, GFP_KERNEL);
+	if (WARN_ON(!ret))
+		return -ENOMEM;
+
+	/* By default, only CPU 0 runs the hwlat detector thread */
+	cpumask_set_cpu(0, kthread_mask);
+
 	register_tracer(&hwlatdetect_tracer);
 
-	mutex_init(&data.lock);
+	mutex_init(&hwlat_data.lock);
 	init_debugfs();
 	return 0;
 }
-- 
2.1.4
