From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 2/4] tracing: Add hwlat_detector tracer
Date: Thu, 23 Apr 2015 15:08:27 -0400
Message-ID: <20150423191724.945833470@goodmis.org>
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
Content-Disposition: inline; filename=0002-tracing-Add-hwlat_detector-tracer.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Connect the hwlat_detector written by Jon Masters with the
tracing system as a new ftrace tracer.

A few files are created when the hwlat_detector is enabled
that exist in the tracing directory.

   hwlat_detector/count  - the count of records of latencies found
   hwlat_detector/width  - time in usecs for how long to spin for
   hwlat_detector/window - time in usecs between the start of each
			    iteration

The kernel thread will spin with interrupts disabled for "width"
microseconds in every "widow" cycle. It will not spin for
"window - width" microseconds, where the system can continue to operate.

To enable the tracer, simple echo in "hwlat_detector" into
"current_tracer"

 # echo hwlat_detector > /sys/kernel/debug/tracing/current_tracer

Every time a hardware latency is found that is greater than
tracing_thresh (set and viewed by the tracing_thresh file in the
tracing directory), it is reported into the ftrace ring buffer.

The default value of tracing_thresh (if it was zero when the
hwlat_detector tracer began) is 10us. If it is not zero, the
threshold does not change.

The max latency found is set in the tracing_max_latency file.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/Kconfig             |  37 ++++++
 kernel/trace/Makefile            |   1 +
 kernel/trace/trace.c             |   2 +-
 kernel/trace/trace.h             |   3 +
 kernel/trace/trace_entries.h     |  23 ++++
 kernel/trace/trace_hwlatdetect.c | 245 ++++++++++++++++++++++++++-------------
 kernel/trace/trace_output.c      |  84 ++++++++++++++
 7 files changed, 311 insertions(+), 84 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fedbdd7d5d1e..9b46a3322a89 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -221,6 +221,43 @@ config SCHED_TRACER
 	  This tracer tracks the latency of the highest priority task
 	  to be scheduled in, starting from the point it has woken up.
 
+config HWLAT_TRACER
+        bool "Tracer to detect hardware latencies (like SMIs)"
+     	select GENERIC_TRACER
+	select TRACER_MAX_TRACE
+	help
+	 This tracer, when enabled will create a kernel thread that
+	 spins in a loop looking for interruptions caused by
+	 something other than the kernel. For example, if a
+	 System Management Interrupt (SMI) takes a noticeable amount of
+	 time, this tracer will detect it. This is useful for testing
+	 if a system is reliable for Real Time tasks.
+
+	 Some files are created in the tracing directory when this
+	 is enabled:
+
+	   hwlat_detector/count  - the count of records of latencies found
+	   hwlat_detector/width  - time in usecs for how long to spin for
+	   hwlat_detector/window - time in usecs between the start of each
+				    iteration
+
+	 The kernel thread will spin with interrupts disabled for
+	 "width" microseconds in every "widow" cycle. It will not spin
+	 for "window - width" microseconds, where the system can
+	 continue to operate.
+
+	 Only a single thread is created that runs this tracer. The
+	 output will appear in the trace and trace_pipe files.
+
+	 When the tracer is not running, it has no affect on the system,
+	 but when it is running, it can cause the system to be
+	 periodically non responsive. Do not run this tracer on a
+	 production system.
+
+	 To enable this tracer, echo in "hwlat_detector" into the current_tracer
+	 file. Every time a latency is greater than tracing_thresh, it will
+	 be recorded into the ring buffer.
+
 config ENABLE_DEFAULT_TRACERS
 	bool "Trace process context switches and events"
 	depends on !GENERIC_TRACER
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 98f26588255e..0655bb6a0589 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
 obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_PREEMPT_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_SCHED_TRACER) += trace_sched_wakeup.o
+obj-$(CONFIG_HWLAT_TRACER) += trace_hwlatdetect.o
 obj-$(CONFIG_NOP_TRACER) += trace_nop.o
 obj-$(CONFIG_STACK_TRACER) += trace_stack.o
 obj-$(CONFIG_MMIOTRACE) += trace_mmiotrace.o
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 39e69568302e..7312418a1498 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -781,7 +781,7 @@ void disable_trace_on_warning(void)
  *
  * Shows real state of the ring buffer if it is enabled or not.
  */
-static int tracer_tracing_is_on(struct trace_array *tr)
+int tracer_tracing_is_on(struct trace_array *tr)
 {
 	if (tr->trace_buffer.buffer)
 		return ring_buffer_record_is_on(tr->trace_buffer.buffer);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b48d4b08f691..d321f8c70d76 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -38,6 +38,7 @@ enum trace_type {
 	TRACE_USER_STACK,
 	TRACE_BLK,
 	TRACE_BPUTS,
+	TRACE_HWLAT,
 
 	__TRACE_LAST_TYPE,
 };
@@ -307,6 +308,7 @@ extern void __ftrace_bad_type(void);
 			  TRACE_GRAPH_ENT);		\
 		IF_ASSIGN(var, ent, struct ftrace_graph_ret_entry,	\
 			  TRACE_GRAPH_RET);		\
+		IF_ASSIGN(var, ent, struct trace_hwlat_detector, TRACE_HWLAT);	\
 		__ftrace_bad_type();					\
 	} while (0)
 
@@ -528,6 +530,7 @@ trace_buffer_iter(struct trace_iterator *iter, int cpu)
 	return NULL;
 }
 
+int tracer_tracing_is_on(struct trace_array *tr);
 int tracer_init(struct tracer *t, struct trace_array *tr);
 int tracing_is_enabled(void);
 void tracing_reset(struct trace_buffer *buf, int cpu);
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index ee7b94a4810a..05592beacfdc 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -322,3 +322,26 @@ FTRACE_ENTRY(branch, trace_branch,
 	FILTER_OTHER
 );
 
+
+FTRACE_ENTRY(hwlat_detector, trace_hwlat_detector,
+
+	TRACE_HWLAT,
+
+	F_STRUCT(
+		__field(	u64,			duration	)
+		__field(	u64,			outer_duration	)
+		__field_struct( struct timespec,	timestamp	)
+		__field_desc(	long,	timestamp,	tv_sec		)
+		__field_desc(	long,	timestamp,	tv_nsec		)
+		__field(	unsigned int,		seqnum		)
+	),
+
+	F_printk("cnt:%u\tts:%010lu.%010lu\tinner:%llu\touter:%llu\n",
+		 __entry->seqnum,
+		 __entry->tv_sec,
+		 __entry->tv_nsec,
+		 __entry->duration,
+		 __entry->outer_duration),
+
+	FILTER_OTHER
+);
diff --git a/kernel/trace/trace_hwlatdetect.c b/kernel/trace/trace_hwlatdetect.c
index 87ccb313afe0..7437c992746a 100644
--- a/kernel/trace/trace_hwlatdetect.c
+++ b/kernel/trace/trace_hwlatdetect.c
@@ -31,7 +31,7 @@
  *          guarantee(s).
  *
  * Copyright (C) 2008-2009 Jon Masters, Red Hat, Inc. <jcm@redhat.com>
- * Copyright (C) 2013 Steven Rostedt, Red Hat, Inc. <srostedt@redhat.com>
+ * Copyright (C) 2013-2015 Steven Rostedt, Red Hat, Inc. <srostedt@redhat.com>
  *
  * Includes useful feedback from Clark Williams <clark@redhat.com>
  *
@@ -55,8 +55,6 @@
 
 #include "trace.h"
 
-#define BUF_SIZE_DEFAULT	262144UL		/* 8K*(sizeof(entry)) */
-#define BUF_FLAGS		(RB_FL_OVERWRITE)	/* no block on full */
 #define U64STR_SIZE		22			/* 20 digits max */
 
 #define BANNER			"hwlat_detector: "
@@ -64,9 +62,10 @@
 #define DEFAULT_SAMPLE_WIDTH	500000			/* 0.5s */
 #define DEFAULT_LAT_THRESHOLD	10			/* 10us */
 
-static int threshold;
-static struct ring_buffer *ring_buffer;		/* sample buffer */
-static unsigned long buf_size = BUF_SIZE_DEFAULT;
+/* Tracer handle */
+
+static struct trace_array *hwlat_detector_trace_array;
+
 static struct task_struct *kthread;		/* sampling thread */
 
 /* DebugFS filesystem entries */
@@ -75,8 +74,14 @@ static struct dentry *debug_count;		/* total detect count */
 static struct dentry *debug_sample_width;	/* sample width us */
 static struct dentry *debug_sample_window;	/* sample window us */
 
+/* Save the previous tracing_thresh value */
+static unsigned long save_tracing_thresh;
+
 /* Individual samples and global state */
 
+/* If the user changed threshold, remember it */
+static u64 last_tracing_thresh = DEFAULT_LAT_THRESHOLD * NSEC_PER_USEC;
+
 /*
  * Individual latency samples are stored here when detected and packed into
  * the ring_buffer circular buffer, where they are overwritten when
@@ -95,14 +100,41 @@ static struct data {
 	struct mutex lock;		/* protect changes */
 
 	u64	count;			/* total since reset */
-	u64	max_sample;		/* max hardware latency */
-	u64	threshold;		/* sample threshold level */
 
 	u64	sample_window;		/* total sampling window (on+off) */
 	u64	sample_width;		/* active sampling portion of window */
 
-	atomic_t sample_open;		/* whether the sample file is open */
-} data;
+} data = {
+	.sample_window		= DEFAULT_SAMPLE_WINDOW,
+	.sample_width		= DEFAULT_SAMPLE_WIDTH,
+};
+
+static void trace_hwlat_sample(struct sample *sample)
+{
+	struct trace_array *tr = hwlat_detector_trace_array;
+	struct ftrace_event_call *call = &event_hwlat_detector;
+	struct ring_buffer *buffer = tr->trace_buffer.buffer;
+	struct ring_buffer_event *event;
+	struct trace_hwlat_detector *entry;
+	unsigned long flags;
+	int pc;
+
+	pc = preempt_count();
+	local_save_flags(flags);
+
+	event = trace_buffer_lock_reserve(buffer, TRACE_HWLAT, sizeof(*entry),
+					  flags, pc);
+	if (!event)
+		return;
+	entry	= ring_buffer_event_data(event);
+	entry->seqnum			= sample->seqnum;
+	entry->duration			= sample->duration;
+	entry->outer_duration		= sample->outer_duration;
+	entry->timestamp		= sample->timestamp;
+
+	if (!call_filter_check_discard(call, entry, buffer, event))
+		__buffer_unlock_commit(buffer, event);
+}
 
 /* Macros used in case the time capture is changed */
 #define time_type	u64
@@ -113,19 +145,6 @@ static struct data {
 #define time_u64(a)	a
 
 /**
- * __buffer_add_sample - add a new latency sample recording to the ring buffer
- * @sample: The new latency sample value
- *
- * This receives a new latency sample and records it in a global ring buffer.
- * No additional locking is used in this case.
- */
-static int __buffer_add_sample(struct sample *sample)
-{
-	return ring_buffer_write(ring_buffer,
-				 sizeof(struct sample), sample);
-}
-
-/**
  * get_sample - sample the CPU TSC and look for likely hardware latencies
  *
  * Used to repeatedly capture the CPU TSC (or similar), looking for potential
@@ -134,12 +153,16 @@ static int __buffer_add_sample(struct sample *sample)
  */
 static int get_sample(void)
 {
+	struct trace_array *tr = hwlat_detector_trace_array;
 	time_type start, t1, t2, last_t2;
-	s64 diff, total = 0;
+	s64 diff, total = 0, last_total = 0;
 	u64 sample = 0;
+	u64 thresh = tracing_thresh;
 	u64 outer_sample = 0;
 	int ret = -1;
 
+	do_div(thresh, NSEC_PER_USEC); /* modifies interval value */
+
 	init_time(last_t2, 0);
 	start = time_get(); /* start timestamp */
 
@@ -163,6 +186,13 @@ static int get_sample(void)
 
 		total = time_to_us(time_sub(t2, start)); /* sample width */
 
+		/* Check for possible overflows */
+		if (total < last_total) {
+			pr_err("Time total overflowed\n");
+			break;
+		}
+		last_total = total;
+
 		/* This checks the inner loop (t1 to t2) */
 		diff = time_to_us(time_sub(t2, t1));     /* current diff */
 
@@ -180,7 +210,7 @@ static int get_sample(void)
 	ret = 0;
 
 	/* If we exceed the threshold value, we have found a hardware latency */
-	if (sample > data.threshold || outer_sample > data.threshold) {
+	if (sample > thresh || outer_sample > thresh) {
 		struct sample s;
 
 		ret = 1;
@@ -190,11 +220,11 @@ static int get_sample(void)
 		s.duration = sample;
 		s.outer_duration = outer_sample;
 		s.timestamp = CURRENT_TIME;
-		__buffer_add_sample(&s);
+		trace_hwlat_sample(&s);
 
 		/* Keep a running maximum ever recorded hardware latency */
-		if (sample > data.max_sample)
-			data.max_sample = sample;
+		if (sample > tr->max_latency)
+			tr->max_latency = sample;
 	}
 
 out:
@@ -203,11 +233,10 @@ out:
 
 /*
  * kthread_fn - The CPU time sampling/hardware latency detection kernel thread
- * @unused: A required part of the kthread API.
  *
  * Used to periodically sample the CPU TSC via a call to get_sample. We
  * disable interrupts, which does (intentionally) introduce latency since we
- * need to ensure nothing else might be running (and thus pre-empting).
+ * need to ensure nothing else might be running (and thus preempting).
  * Obviously this should never be used in production environments.
  *
  * Currently this runs on which ever CPU it was scheduled on, but most
@@ -222,17 +251,16 @@ static int kthread_fn(void *unused)
 
 	while (!kthread_should_stop()) {
 
-		mutex_lock(&data.lock);
-
 		local_irq_disable();
 		ret = get_sample();
 		local_irq_enable();
 
+		mutex_lock(&data.lock);
 		interval = data.sample_window - data.sample_width;
-		do_div(interval, USEC_PER_MSEC); /* modifies interval value */
-
 		mutex_unlock(&data.lock);
 
+		do_div(interval, USEC_PER_MSEC); /* modifies interval value */
+
 		if (msleep_interruptible(interval))
 			break;
 	}
@@ -283,64 +311,44 @@ static int stop_kthread(void)
  * function in order to reset those when "enable" is toggled on or off, and
  * also at initialization.
  */
-static void __reset_stats(void)
+static void __reset_stats(struct trace_array *tr)
 {
 	data.count = 0;
-	data.max_sample = 0;
-	ring_buffer_reset(ring_buffer); /* flush out old sample entries */
+	tr->max_latency = 0;
 }
 
 /**
  * init_stats - Setup global state statistics for the hardware latency detector
  *
- * We use data to store various statistics and global state. We also use
- * a global ring buffer (ring_buffer) to keep raw samples of detected hardware
- * induced system latencies. This function initializes these structures and
- * allocates the global ring buffer also.
+ * We use data to store various statistics and global state.
  */
-static int init_stats(void)
+static void init_stats(struct trace_array *tr)
 {
-	int ret = -ENOMEM;
+	__reset_stats(tr);
 
-	mutex_init(&data.lock);
-	atomic_set(&data.sample_open, 0);
-
-	ring_buffer = ring_buffer_alloc(buf_size, BUF_FLAGS);
-
-	if (WARN(!ring_buffer, KERN_ERR BANNER
-			       "failed to allocate ring buffer!\n"))
-		goto out;
-
-	__reset_stats();
-	data.threshold = threshold ?: DEFAULT_LAT_THRESHOLD; /* threshold us */
-	data.sample_window = DEFAULT_SAMPLE_WINDOW; /* window us */
-	data.sample_width = DEFAULT_SAMPLE_WIDTH;   /* width us */
-
-	ret = 0;
-
-out:
-	return ret;
+	save_tracing_thresh = tracing_thresh;
 
+	/* tracing_thresh is in nsecs, we speak in usecs */
+	if (!tracing_thresh)
+		tracing_thresh = last_tracing_thresh;
 }
 
 /*
- * simple_data_read - Wrapper read function for global state debugfs entries
+ * hwlat_read - Wrapper read function for global state debugfs entries
  * @filp: The active open file structure for the debugfs "file"
  * @ubuf: The userspace provided buffer to read value into
  * @cnt: The maximum number of bytes to read
  * @ppos: The current "file" position
- * @entry: The entry to read from
  *
  * This function provides a generic read implementation for the global state
- * "data" structure debugfs filesystem entries. It would be nice to use
- * simple_attr_read directly, but we need to make sure that the data.lock
- * is held during the actual read.
+ * "data" structure debugfs filesystem entries.
  */
-static ssize_t simple_data_read(struct file *filp, char __user *ubuf,
-				size_t cnt, loff_t *ppos, const u64 *entry)
+static ssize_t hwlat_read(struct file *filp, char __user *ubuf,
+			  size_t cnt, loff_t *ppos)
 {
+	unsigned long *entry = filp->private_data;
 	char buf[U64STR_SIZE];
-	u64 val = 0;
+	unsigned long val = 0;
 	int len = 0;
 
 	memset(buf, 0, sizeof(buf));
@@ -357,21 +365,19 @@ static ssize_t simple_data_read(struct file *filp, char __user *ubuf,
 }
 
 /*
- * simple_data_write - Wrapper write function for global state debugfs entries
+ * hwlat_write - Wrapper write function for global state debugfs entries
  * @filp: The active open file structure for the debugfs "file"
  * @ubuf: The userspace provided buffer to write value from
  * @cnt: The maximum number of bytes to write
  * @ppos: The current "file" position
- * @entry: The entry to write to
  *
  * This function provides a generic write implementation for the global state
- * "data" structure debugfs filesystem entries. It would be nice to use
- * simple_attr_write directly, but we need to make sure that the data.lock
- * is held during the actual write.
+ * "data" structure debugfs filesystem entries.
  */
-static ssize_t simple_data_write(struct file *filp, const char __user *ubuf,
-				 size_t cnt, loff_t *ppos, u64 *entry)
+static ssize_t hwlat_write(struct file *filp, const char __user *ubuf,
+			   size_t cnt, loff_t *ppos)
 {
+	unsigned long *entry = filp->private_data;
 	char buf[U64STR_SIZE];
 	int csize = min(cnt, sizeof(buf)-1);
 	u64 val = 0;
@@ -390,7 +396,7 @@ static ssize_t simple_data_write(struct file *filp, const char __user *ubuf,
 }
 
 /**
- * debug_width_fwrite - Write function for "width" debugfs entry
+ * debug_width_write - Write function for "width" debugfs entry
  * @filp: The active open file structure for the debugfs "file"
  * @ubuf: The user buffer that contains the value to write
  * @cnt: The maximum number of bytes to write to "file"
@@ -436,13 +442,13 @@ debug_width_write(struct file *filp, const char __user *ubuf,
 }
 
 /**
- * debug_window_fwrite - Write function for "window" debugfs entry
+ * debug_window_write - Write function for "window" debugfs entry
  * @filp: The active open file structure for the debugfs "file"
  * @ubuf: The user buffer that contains the value to write
  * @cnt: The maximum number of bytes to write to "file"
  * @ppos: The current position in the debugfs "file"
  *
- * This function provides a write implementation for the "window" debufds
+ * This function provides a write implementation for the "window" debugfs
  * interface to the hardware latency detetector. The window is the total time
  * in us that will be considered one sample period. Conceptually, windows
  * occur back-to-back and contain a sample width period during which
@@ -483,6 +489,8 @@ debug_window_write(struct file *filp, const char __user *ubuf,
  */
 static const struct file_operations count_fops = {
 	.open		= tracing_open_generic,
+	.read		= hwlat_read,
+	.write		= hwlat_write,
 };
 
 /*
@@ -490,6 +498,7 @@ static const struct file_operations count_fops = {
  */
 static const struct file_operations width_fops = {
 	.open		= tracing_open_generic,
+	.read		= hwlat_read,
 	.write		= debug_width_write,
 };
 
@@ -498,16 +507,17 @@ static const struct file_operations width_fops = {
  */
 static const struct file_operations window_fops = {
 	.open		= tracing_open_generic,
+	.read		= hwlat_read,
 	.write		= debug_window_write,
 };
 
 /**
  * init_debugfs - A function to initialize the debugfs interface files
  *
- * This function creates entries in debugfs for "hwlat_detector", including
- * files to read values from the detector, current samples, and the
- * maximum sample that has been captured since the hardware latency
- * dectector was started.
+ * This function creates entries in debugfs for "hwlat_detector".
+ * It creates the hwlat_detector directory in the tracing directory,
+ * and within that directory is the count, width and window files to
+ * change and view those values.
  */
 static int init_debugfs(void)
 {
@@ -551,3 +561,72 @@ err_count:
 err_debug_dir:
 	return -ENOMEM;
 }
+
+static void hwlat_detector_tracer_start(struct trace_array *tr)
+{
+	int err;
+
+	err = start_kthread();
+	if (err)
+		pr_err(BANNER "cannot start kthread\n");
+}
+
+static void hwlat_detector_tracer_stop(struct trace_array *tr)
+{
+	int err;
+
+	err = stop_kthread();
+	if (err)
+		pr_err(BANNER "cannot stop kthread\n");
+}
+
+static bool hwlat_detector_enabled;
+
+static int hwlat_detector_tracer_init(struct trace_array *tr)
+{
+	/* Only allow one instance to enable this */
+	if (hwlat_detector_enabled)
+		return -EBUSY;
+
+	hwlat_detector_trace_array = tr;
+
+	init_stats(tr);
+
+	if (tracer_tracing_is_on(tr))
+		hwlat_detector_tracer_start(tr);
+
+	hwlat_detector_enabled = true;
+
+	return 0;
+}
+
+static void hwlat_detector_tracer_reset(struct trace_array *tr)
+{
+	if (tracer_tracing_is_on(tr))
+		hwlat_detector_tracer_stop(tr);
+
+	/* the tracing threshold is static between runs */
+	last_tracing_thresh = tracing_thresh;
+
+	tracing_thresh = save_tracing_thresh;
+	hwlat_detector_enabled = false;
+}
+
+static struct tracer hwlatdetect_tracer __read_mostly = {
+	.name		= "hwlat_detector",
+	.init		= hwlat_detector_tracer_init,
+	.reset		= hwlat_detector_tracer_reset,
+	.start		= hwlat_detector_tracer_start,
+	.stop		= hwlat_detector_tracer_stop,
+	.allow_instances = true,
+};
+
+static int __init init_hwlat_detector_tracer(void)
+{
+	register_tracer(&hwlatdetect_tracer);
+
+	mutex_init(&data.lock);
+	init_debugfs();
+	return 0;
+}
+fs_initcall(init_hwlat_detector_tracer);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 692bf7184c8c..7c89b4fd9ce1 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1221,6 +1221,89 @@ static struct trace_event trace_print_event = {
 	.funcs		= &trace_print_funcs,
 };
 
+/* TRACE_HWLAT */
+static enum print_line_t
+trace_hwlat_trace(struct trace_iterator *iter, int flags,
+		  struct trace_event *event)
+{
+	struct trace_hwlat_detector *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+
+	trace_seq_printf(s, "cnt:%u\tts:%010lu.%010lu\tinner:%llu\touter:%llu\n",
+			 field->seqnum,
+			 field->timestamp.tv_sec,
+			 field->timestamp.tv_nsec,
+			 field->duration,
+			 field->outer_duration);
+
+	return trace_handle_return(s);
+}
+
+static enum print_line_t trace_hwlat_raw(struct trace_iterator *iter, int flags,
+				      struct trace_event *event)
+{
+	struct trace_hwlat_detector *field;
+
+	trace_assign_type(field, iter->ent);
+
+	trace_seq_printf(&iter->seq, "%u %010lu.%010lu %llu %llu",
+			 field->seqnum,
+			 field->timestamp.tv_sec,
+			 field->timestamp.tv_nsec,
+			 field->duration,
+			 field->outer_duration);
+
+	return trace_handle_return(&iter->seq);
+}
+
+static enum print_line_t trace_hwlat_hex(struct trace_iterator *iter, int flags,
+					 struct trace_event *event)
+{
+	struct trace_hwlat_detector *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+
+	SEQ_PUT_HEX_FIELD(s, field->seqnum);
+	SEQ_PUT_HEX_FIELD(s, field->timestamp.tv_sec);
+	SEQ_PUT_HEX_FIELD(s, field->timestamp.tv_nsec);
+	SEQ_PUT_HEX_FIELD(s, field->duration);
+	SEQ_PUT_HEX_FIELD(s, field->outer_duration);
+
+	return trace_handle_return(s);
+}
+
+static enum print_line_t trace_hwlat_bin(struct trace_iterator *iter, int flags,
+					 struct trace_event *event)
+{
+	struct trace_hwlat_detector *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+
+	SEQ_PUT_FIELD(s, field->seqnum);
+	SEQ_PUT_FIELD(s, field->timestamp.tv_sec);
+	SEQ_PUT_FIELD(s, field->timestamp.tv_nsec);
+	SEQ_PUT_FIELD(s, field->duration);
+	SEQ_PUT_FIELD(s, field->outer_duration);
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions trace_hwlat_funcs = {
+	.trace		= trace_hwlat_trace,
+	.raw		= trace_hwlat_raw,
+	.hex		= trace_hwlat_hex,
+	.binary		= trace_hwlat_bin,
+};
+
+static struct trace_event trace_hwlat_event = {
+	.type		= TRACE_HWLAT,
+	.funcs		= &trace_hwlat_funcs,
+};
+
 
 static struct trace_event *events[] __initdata = {
 	&trace_fn_event,
@@ -1231,6 +1314,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_bputs_event,
 	&trace_bprint_event,
 	&trace_print_event,
+	&trace_hwlat_event,
 	NULL
 };
 
-- 
2.1.4
