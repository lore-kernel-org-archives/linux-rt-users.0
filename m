From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH] hwlat_detector: Detect hardware-induced latencies
Date: Wed,  8 Apr 2015 17:47:01 +0200
Message-ID: <1428508021-28166-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Jon Masters <jcm@redhat.com>, Carsten Emde <C.Emde@osadl.org>,
	Steven Rostedt <srostedt@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mike Galbraith <bitbucket@online.de>,
	linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

A simple hardware latency detector. Use this module to detect large
latencies introduced by the behavior of the underlying system firmware
external to Linux. The hardware latency detector works by disabling
interrupts while running a tight loop taking timestams and measure for
unexplainable gaps in the CPU timestamp counter(s). Any gap indicates
a time when the polling was interrupted and interrupts turned off the
only thing that could do that would be an SMI.

By default, the module is not enabled until the "enable" file within
the "hwlat_detector" debugfs directory is toggled.

Jon Masters developed this wonderful SMI detector. For details please
consult Documentation/hwlat_detector.txt.

[dw: rewrote everything except the detector itself (sample_get()]

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: Jon Masters <jcm@redhat.com>
Cc: Carsten Emde <C.Emde@osadl.org>
Cc: Steven Rostedt <srostedt@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mike Galbraith <bitbucket@online.de>
Cc: linux-kernel@vger.kernel.org
Cc; linux-rt-users@vger.kernel.org

Link: http://www.spinics.net/lists/linux-rt-users/msg10350.html
---
Hi,

Here is my attempt to rewritte hwlat_detector. Most of the code is a
new except the detection routine itself. With some luck I didn't break
it.  I hope I updated the documentation correctly and also added all
the credits.

@Carsten, I haven't found your original post of the hwlatdetect.patch
patch. I assume you have written most of the documentation. I guess
should be also added as copyright holder.

cheers,
daniel

 Documentation/hwlat_detector.txt |  67 +++++
 drivers/misc/Kconfig             |  29 ++
 drivers/misc/Makefile            |   1 +
 drivers/misc/hwlat_detector.c    | 597 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 694 insertions(+)
 create mode 100644 Documentation/hwlat_detector.txt
 create mode 100644 drivers/misc/hwlat_detector.c

diff --git a/Documentation/hwlat_detector.txt b/Documentation/hwlat_detector.txt
new file mode 100644
index 0000000..d1ea526
--- /dev/null
+++ b/Documentation/hwlat_detector.txt
@@ -0,0 +1,67 @@
+Introduction:
+-------------
+
+The module hwlat_detector is a special purpose kernel module that is
+used to detect large system latencies induced by the behavior of
+certain underlying hardware or firmware, independent of Linux
+itself. The code was developed originally to detect SMIs (System
+Management Interrupts) on x86 systems, however there is nothing x86
+specific about this patchset. It was originally written for use by the
+"RT" patch since the Real Time kernel is highly latency sensitive.
+
+SMIs are usually not serviced by the Linux kernel, which typically
+does not even know that they are occuring. SMIs are instead are set up
+by BIOS code and are serviced by BIOS code, usually for "critical"
+events such as management of thermal sensors and fans. Sometimes
+though, SMIs are used for other tasks and those tasks can spend an
+inordinate amount of time in the handler (sometimes measured in
+milliseconds). Obviously this is a problem if you are trying to keep
+event service latencies down in the microsecond range.
+
+The hardware latency detector works by disabling interrupts while
+running a tight loop taking timestams and measure for unexplainable
+gaps in the CPU timestamp counter(s). Any gap indicates a time when
+the polling was interrupted and interrupts turned off the only thing
+that could do that would be an SMI.
+
+Note that the SMI detector should *NEVER* be used in a production
+environment.  It is intended to be run manually to determine if the
+hardware platform has a problem with long system firmware service
+routines.
+
+Usage:
+------
+
+Loading the module hwlat_detector passing the parameter "enable=1" (or
+by setting the "enable" entry in "hwlat_detector" debugfs toggled on)
+is the only step required to start the hwlat_detector. It is possible
+to redefine the threshold in microseconds (us) above which latency
+spikes will be taken into account (parameter "threshold=").
+
+Example:
+
+	# modprobe hwlat_detector enable=1 threshold=100
+
+After the module is loaded, it creates a directory named
+"hwlat_detector" under the debugfs mountpoint,
+"/sys/kernel/debug/hwlat_detector" for this text.
+
+The /sys/kernel/debug/hwlat_detector interface contains the following files:
+
+count			- number of latency spikes observed since last reset
+enable			- a global enable/disable toggle (0/1), resets count
+max			- maximum hardware latency actually observed (usecs)
+sample			- a pipe from which to read current raw sample data
+			  in the format <timestamp> <latency observed usecs>
+			  (can be opened O_NONBLOCK for a single sample)
+threshold		- minimum latency value to be considered (usecs)
+width			- time period to sample with CPUs held (usecs)
+			  must be less than the total window size (enforced)
+window			- total period of sampling, width being inside (usecs)
+
+By default we will set width to 500,000 and window to 1,000,000,
+meaning that we will sample every 1,000,000 usecs (1s) for 500,000
+usecs (0.5s). If we observe any latencies that exceed the threshold
+(initially 100 usecs), then we write to a sample ring buffer space for
+512 samples, which is consumed by reading from the "sample" (pipe)
+debugfs file interface.
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 006242c..972f184 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -515,6 +515,35 @@ config VEXPRESS_SYSCFG
 	  bus. System Configuration interface is one of the possible means
 	  of generating transactions on this bus.
 
+config HWLAT_DETECTOR
+	tristate "Testing module to detect hardware-induced latencies"
+	depends on DEBUG_FS
+	default m
+	---help---
+	  A simple hardware latency detector. Use this module to
+	  detect large latencies introduced by the behavior of the
+	  underlying system firmware external to Linux. We do this by
+	  disabling interrupts while running a tight loop taking
+	  timestams and measure for unexplainable gaps in the CPU
+	  timestamp counter(s). By default, the module is not enabled
+	  until the "enable" file within the "hwlat_detector" debugfs
+	  directory is toggled.
+
+	  This module is often used to detect SMI (System Management
+	  Interrupts) on x86 systems, though is not x86 specific. To
+	  this end, we default to using a sample window of 1 second,
+	  during which we will sample for 0.5 seconds. If an SMI or
+	  similar event occurs during that time, it is recorded
+	  into an samples ring buffer with space for 512 entries.
+
+	  WARNING: This software should never be enabled (it can be built
+	  but should not be turned on after it is loaded) in a production
+	  environment where high latencies are a concern since the
+	  sampling mechanism actually introduces latencies for
+	  regular tasks while the CPU(s) are being held.
+
+	  If unsure, say N
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 7d5c4cd..7ef5e82 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,3 +56,4 @@ obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_HWLAT_DETECTOR)	+= hwlat_detector.o
diff --git a/drivers/misc/hwlat_detector.c b/drivers/misc/hwlat_detector.c
new file mode 100644
index 0000000..f82e306
--- /dev/null
+++ b/drivers/misc/hwlat_detector.c
@@ -0,0 +1,597 @@
+/*
+ * hwlat_detector.c - A simple Hardware Latency detector.
+ *
+ * Use this module to detect large system latencies induced by the
+ * behavior of certain underlying system hardware or firmware,
+ * independent of Linux itself.  The code was developed originally to
+ * detect the presence of SMIs on Intel and AMD systems, although
+ * there is no dependency upon x86 herein.
+ *
+ * The classical example usage of this module is in detecting the
+ * presence of SMIs or System Management Interrupts on Intel and AMD
+ * systems. An SMI is a somewhat special form of hardware interrupt
+ * spawned from earlier CPU debug modes in which the (BIOS/EFI/etc.)
+ * firmware arranges for the South Bridge LPC (or other device) to
+ * generate a special interrupt under certain circumstances, for
+ * example, upon expiration of a special SMI timer device, due to
+ * certain external thermal readings, on certain I/O address accesses,
+ * and other situations. An SMI hits a special CPU pin, triggers a
+ * special SMI mode (complete with special memory map), and the OS is
+ * unaware.
+ *
+ * Although certain hardware-inducing latencies are necessary (for
+ * example, a modern system often requires an SMI handler for correct
+ * thermal control and remote management) they can wreak havoc upon
+ * any OS-level performance guarantees toward low-latency, especially
+ * when the OS is not even made aware of the presence of these
+ * interrupts. For this reason, we need a somewhat brute force
+ * mechanism to detect these interrupts. In this case, we do it by
+ * hogging all of the CPU(s) for configurable timer intervals,
+ * sampling the built-in CPU timer, looking for discontiguous
+ * readings.
+ *
+ * WARNING: This implementation necessarily introduces latencies.
+ *          Therefore, you should NEVER use this module in a
+ *          production environment requiring any kind of low-latency
+ *          performance guarantee(s).
+ *
+ * Copyright (C) 2015, BMW Car IT GbmH, Daniel Wagner <daniel.wagner@bmw-carit.de>
+ * Copyright (C) 2008-2009 Jon Masters, Red Hat, Inc. <jcm@redhat.com>
+ *
+ * Includes useful feedback from Clark Williams <clark@redhat.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/debugfs.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/uaccess.h>
+#include <linux/kfifo.h>
+#include <linux/trace_clock.h>
+
+#define BANNER			"hwlat_detector: "
+#define DRVNAME			"hwlat_detector"
+
+#define DEFAULT_SAMPLE_WINDOW	1000000			/* 1s */
+#define DEFAULT_SAMPLE_WIDTH	500000			/* 0.5s */
+#define DEFAULT_LAT_THRESHOLD	10			/* 10us */
+
+#define FIFO_ENTRIES		512UL			/* max entries */
+
+struct sample {
+	u64		duration;	/* ktime delta */
+	u64		outer_duration;	/* ktime delta (outer loop) */
+	struct timespec	timestamp;	/* wall time */
+};
+
+/* Sampling configuration parameters */
+static struct {
+	u64 threshold;			/* sample threshold level */
+	u64 window;			/* total sampling window (on+off) */
+	u64 width;			/* active sampling portion of window */
+
+	/*
+	 * Serialize updates of parameters with sampling, that is no
+	 * changes while sampling.
+	 */
+	struct mutex lock;
+} param;
+
+/* Statistic values gathered while sampling */
+static struct {
+	u64 count;			/* total since reset */
+	u64 max;			/* max hardware latency */
+} stats;
+
+/*
+ * fifo is used as ring buffer, sampling function sample_get()
+ * procudes the samples adds it to the fifo and file_sample_read()
+ * consumes it.  On overflow the oldest entry will be overwritten
+ */
+static DEFINE_KFIFO(fifo, struct sample, FIFO_ENTRIES);
+static DEFINE_SPINLOCK(fifo_lock);
+
+static struct task_struct *kthread;	/* thread for sampling function */
+static wait_queue_head_t s_wq;		/* waitqeue for new sample values */
+
+/* module parameters */
+static int enable;
+static int param_threshold;
+static int param_window;
+static int param_width;
+
+module_param_named(enable, enable, int, 0);
+module_param_named(threshold, param_threshold, int, 0);
+module_param_named(window, param_window, int, 0);
+module_param_named(width, param_width, int, 0);
+
+static void stats_reset(void)
+{
+	stats.count = 0;
+	stats.max = 0;
+	kfifo_reset(&fifo);
+}
+
+static void fifo_add_sample(struct sample *sample)
+{
+	/*
+	 * Mimic a ring buffer by overwriting oldest entry when the
+	 * fifo is full.
+	 *
+	 * We need to make sure in case the fifo is full and we remove
+	 * the oldest entry before adding a new entry that the reader
+	 * side always sees one element in the fifo. That means we
+	 * need make sure we do not race with kfifo_out_locked().
+	 */
+	spin_lock(&fifo_lock);
+	if (kfifo_is_full(&fifo))
+		kfifo_skip(&fifo);
+	kfifo_in(&fifo, sample, 1);
+	spin_unlock(&fifo_lock);
+}
+
+#ifndef CONFIG_TRACING
+#define time_type	ktime_t
+#define time_get()	ktime_get()
+#define time_to_us(x)	ktime_to_us(x)
+#define time_sub(a, b)	ktime_sub(a, b)
+#define init_time(a, b)	(a).tv64 = b
+#define time_u64(a)	((a).tv64)
+#else
+#define time_type	u64
+#define time_get()	trace_clock_local()
+#define time_to_us(x)	div_u64(x, 1000)
+#define time_sub(a, b)	((a) - (b))
+#define init_time(a, b)	(a = b)
+#define time_u64(a)	a
+#endif
+
+/**
+ * sample_get - sample the CPU TSC and look for likely hardware latencies
+ *
+ * Used to repeatedly capture the CPU TSC (or similar), looking for
+ * potential hardware-induced latency. Called with interrupts disabled
+ * and with param.lock held.
+ */
+static int sample_get(void)
+{
+	time_type start, t1, t2, last_t2;
+	s64 diff, total = 0;
+	u64 sample = 0;
+	u64 outer_sample = 0;
+	int ret = -1;
+
+	init_time(last_t2, 0);
+	start = time_get(); /* start timestamp */
+
+	do {
+		t1 = time_get();	/* we'll look for a discontinuity */
+		t2 = time_get();
+
+		if (time_u64(last_t2)) {
+			/* Check the delta from outer loop (t2 to next t1) */
+			diff = time_to_us(time_sub(t1, last_t2));
+			/* This shouldn't happen */
+			if (diff < 0) {
+				pr_err(BANNER "time running backwards\n");
+				goto out;
+			}
+			if (diff > outer_sample)
+				outer_sample = diff;
+		}
+		last_t2 = t2;
+
+		total = time_to_us(time_sub(t2, start)); /* sample width */
+
+		/* This checks the inner loop (t1 to t2) */
+		diff = time_to_us(time_sub(t2, t1));     /* current diff */
+
+		/* This shouldn't happen */
+		if (diff < 0) {
+			pr_err(BANNER "time running backwards\n");
+			goto out;
+		}
+
+		if (diff > sample)
+			sample = diff; /* only want highest value */
+
+	} while (total <= param.width);
+
+	ret = 0;
+
+	/* If we exceed the threshold value, we have found a hardware latency */
+	if (sample > param.threshold || outer_sample > param.threshold) {
+		struct sample s;
+
+		ret = 1;
+
+		stats.count++;
+		s.duration = sample;
+		s.outer_duration = outer_sample;
+		s.timestamp = CURRENT_TIME;
+		fifo_add_sample(&s);
+
+		/* Keep a running maximum ever recorded hardware latency */
+		if (sample > stats.max)
+			stats.max = sample;
+	}
+
+out:
+	return ret;
+}
+
+static int sample_fn(void *arg)
+{
+	u64 interval;
+	int err;
+
+	while (!kthread_should_stop()) {
+		mutex_lock(&param.lock);
+		local_irq_disable();
+
+		err = sample_get();
+
+		local_irq_enable();
+		mutex_unlock(&param.lock);
+
+		if (err > 0)
+			wake_up_interruptible(&s_wq);
+
+		interval = param.window - param.width;
+		do_div(interval, USEC_PER_MSEC);
+
+		if (msleep_interruptible(interval))
+			break;
+	}
+
+	return 0;
+}
+
+static int sample_start(void)
+{
+	kthread = kthread_run(sample_fn, NULL, DRVNAME);
+	if (IS_ERR(kthread)) {
+		pr_err(BANNER "could not start sampling thread\n");
+		enable = 0;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void sample_stop(void)
+{
+	int err;
+
+	err = kthread_stop(kthread);
+	if (err) {
+		pr_err(BANNER "could not stop sampling thread\n");
+		return;
+	}
+
+	enable = 0;
+}
+
+#define TMPBUFSIZE 128
+
+static ssize_t sample_to_user(struct sample *sample,
+				char __user *buf, size_t count)
+{
+	char tmpbuf[TMPBUFSIZE];
+	size_t len;
+
+	len = snprintf(tmpbuf, TMPBUFSIZE, "%010lu.%010lu\t%llu\t%llu\n",
+			sample->timestamp.tv_sec,
+			sample->timestamp.tv_nsec,
+			sample->duration,
+			sample->outer_duration);
+
+	if (len > TMPBUFSIZE)
+		len = TMPBUFSIZE;
+
+	if (len > count)
+		len = count;
+
+	if (copy_to_user(buf, tmpbuf, len))
+		return -EFAULT;
+
+	return len;
+}
+
+static ssize_t u64_to_user(u64 val, char __user *buf,
+				size_t count, loff_t *offset)
+{
+	char tmpbuf[TMPBUFSIZE];
+	size_t len;
+
+	len = snprintf(tmpbuf, TMPBUFSIZE, "%llu\n", val);
+	if (len > TMPBUFSIZE)
+		len = TMPBUFSIZE;
+
+	return simple_read_from_buffer(buf, count, offset, tmpbuf, len);
+}
+
+static int u64_from_user(u64 *val, char const __user *buf, size_t count)
+{
+	char tmpbuf[TMPBUFSIZE];
+	int err;
+
+	if (!count)
+		return 0;
+
+	if (count > TMPBUFSIZE - 1)
+		return -EINVAL;
+
+	memset(tmpbuf, 0x0, TMPBUFSIZE);
+
+	if (copy_from_user(tmpbuf, buf, count))
+		return -EFAULT;
+
+	err = kstrtoull(tmpbuf, 10, val);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static ssize_t file_write(u64 *val, char const __user *buf,
+				size_t count, loff_t *offset)
+{
+	u64 tmp;
+	int err;
+
+	if (*offset)
+		return -EINVAL;
+
+	err = u64_from_user(&tmp, buf, count);
+	if (err <= 0)
+		return err;
+
+	err = 0;
+	mutex_lock(&param.lock);
+	if (tmp < *val)
+		*val = tmp;
+	else
+		err = -EINVAL;
+	mutex_unlock(&param.lock);
+
+	if (err)
+		return err;
+	return count;
+}
+
+static ssize_t file_window_read(struct file *file, char __user *buf,
+					size_t count, loff_t *offset)
+{
+	return u64_to_user(param.window, buf, count, offset);
+}
+
+static ssize_t file_window_write(struct file *file, char const __user *buf,
+					size_t count, loff_t *offset)
+{
+	return file_write(&param.window, buf, count, offset);
+}
+
+static ssize_t file_width_read(struct file *file, char __user *buf,
+					size_t count, loff_t *offset)
+{
+	return u64_to_user(param.width, buf, count, offset);
+}
+
+static ssize_t file_width_write(struct file *file, char const __user *buf,
+					size_t count, loff_t *offset)
+{
+	return file_write(&param.width, buf, count, offset);
+}
+
+static ssize_t file_threshold_read(struct file *file, char __user *buf,
+					size_t count, loff_t *offset)
+{
+	return u64_to_user(param.threshold, buf, count, offset);
+}
+
+static ssize_t file_threshold_write(struct file *file, char const __user *buf,
+					size_t count, loff_t *offset)
+{
+	return file_write(&param.threshold, buf, count, offset);
+}
+
+static ssize_t file_sample_read(struct file *file, char __user *buf,
+					size_t count, loff_t *offset)
+{
+	struct sample sample;
+
+	if (!(file->f_flags & O_NONBLOCK)) {
+		/* block until we have a sample */
+		wait_event_interruptible(s_wq, !kfifo_is_empty(&fifo));
+		if (signal_pending(current))
+			return -EINTR;
+	}
+
+	if (!kfifo_out_locked(&fifo, &sample, 1, &fifo_lock))
+		return -EAGAIN;
+
+	/* Ignore offset and just produce the next sample */
+	return sample_to_user(&sample, buf, count);
+}
+
+static ssize_t file_enable_read(struct file *file, char __user *buf,
+					size_t count, loff_t *offset)
+{
+	return u64_to_user(enable, buf, count, offset);
+}
+
+static ssize_t file_enable_write(struct file *file, char const __user *buf,
+					size_t count, loff_t *offset)
+{
+	u64 val;
+	int err;
+
+	if (*offset)
+		return -EINVAL;
+
+	err = u64_from_user(&val, buf, count);
+	if (err <= 0)
+		return err;
+
+	if (val == enable)
+		return count;
+
+	err = 0;
+	if (val) {
+		enable = 1;
+		stats_reset();
+		err = sample_start();
+	} else
+		sample_stop();
+
+	if (err)
+		return err;
+	return count;
+}
+
+static const struct file_operations window_fops = {
+	.read		= file_window_read,
+	.write		= file_window_write,
+	.llseek		= no_llseek,
+	.owner		= THIS_MODULE
+};
+
+static const struct file_operations width_fops = {
+	.read		= file_width_read,
+	.write		= file_width_write,
+	.llseek		= no_llseek,
+	.owner		= THIS_MODULE
+};
+
+static const struct file_operations threshold_fops = {
+	.read		= file_threshold_read,
+	.write		= file_threshold_write,
+	.llseek		= no_llseek,
+	.owner		= THIS_MODULE
+};
+
+static const struct file_operations sample_fops = {
+	.read		= file_sample_read,
+	.llseek		= no_llseek,
+	.owner		= THIS_MODULE,
+};
+
+static const struct file_operations enable_fops = {
+	.read		= file_enable_read,
+	.write		= file_enable_write,
+	.llseek		= no_llseek,
+	.owner		= THIS_MODULE
+};
+
+static struct dentry *hwlatdir;
+
+static int __init debugfs_init(void)
+{
+	struct dentry *retval;
+
+	retval = debugfs_create_dir(DRVNAME, NULL);
+	if (IS_ERR_OR_NULL(retval))
+		return PTR_ERR(retval);
+
+	hwlatdir = retval;
+
+	retval = debugfs_create_u64("count", S_IRUGO,
+				hwlatdir, &stats.count);
+	if (IS_ERR(retval))
+		goto err;
+
+	retval = debugfs_create_u64("max", S_IRUGO,
+				hwlatdir, &stats.max);
+	if (IS_ERR(retval))
+		goto err;
+
+	retval = debugfs_create_file("window",
+				S_IRUGO | S_IWUSR,
+				hwlatdir, NULL, &window_fops);
+	if (IS_ERR(retval))
+		goto err;
+
+	retval = debugfs_create_file("width",
+				S_IRUGO | S_IWUSR,
+				hwlatdir, NULL, &width_fops);
+	if (IS_ERR(retval))
+		goto err;
+
+	retval = debugfs_create_file("threshold",
+				S_IRUGO | S_IWUSR,
+				hwlatdir, NULL, &threshold_fops);
+	if (IS_ERR(retval))
+		goto err;
+
+	retval = debugfs_create_file("sample", S_IRUGO,
+				hwlatdir, NULL, &sample_fops);
+	if (IS_ERR(retval))
+		goto err;
+
+	retval = debugfs_create_file("enable",
+				S_IRUGO | S_IWUSR,
+				hwlatdir, NULL, &enable_fops);
+	if (IS_ERR(retval))
+		goto err;
+
+	return 0;
+err:
+	debugfs_remove_recursive(hwlatdir);
+	hwlatdir = NULL;
+	return retval ? PTR_ERR(retval) : -ENODEV;
+}
+
+static void __exit debugfs_cleanup(void)
+{
+	debugfs_remove_recursive(hwlatdir);
+}
+
+static void __init __hwlat_init(void)
+{
+	init_waitqueue_head(&s_wq);
+
+	mutex_init(&param.lock);
+	param.threshold = param_threshold ?
+		param_threshold : DEFAULT_LAT_THRESHOLD;
+	param.window = param_window ? param_window : DEFAULT_SAMPLE_WINDOW;
+	param.width = param_width ? param_width : DEFAULT_SAMPLE_WIDTH;
+}
+
+static int __init hwlat_init(void)
+{
+	int err;
+
+	__hwlat_init();
+
+	err = debugfs_init();
+	if (err)
+		return err;
+
+	if (enable)
+		err = sample_start();
+
+	return err;
+}
+
+static void __exit hwlat_exit(void)
+{
+	if (enable)
+		sample_stop();
+
+	debugfs_cleanup();
+}
+
+module_init(hwlat_init);
+module_exit(hwlat_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Daniel Wagner");
+MODULE_DESCRIPTION("Hardware latency detector");
-- 
2.1.0
