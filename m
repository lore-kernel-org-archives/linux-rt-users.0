From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.6.11.8-rt41
Date: Wed, 11 Sep 2013 21:07:38 -0400
Message-ID: <20130911210738.063ddae6@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:23560 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab3ILBHl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Sep 2013 21:07:41 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.6.11.8-rt41 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.6-rt
  Head SHA1: 70c67d3efde6ef4fa2fae0ba7fac3aaf011a1385


Or to build 3.6.11.8-rt41 directly, the following patches should be app=
lied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.6.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.6.11.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/stable/patch-3=
=2E6.11.8.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.11.8=
-rt41.patch.xz



You can also build from 3.6.11.8-rt40 by applying the incremental patch=
:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6=
=2E11.8-rt40-rt41.patch.xz



Enjoy,

-- Steve


Changes from v3.6.11.8-rt40:

---

Ivo Sieben (1):
      genirq: Set irq thread to RT priority on creation

John Kacur (1):
      hpsa: fix warning with smp_processor_id() in preemptible section

Mike Galbraith (1):
      x86/mce: fix mce timer interval

Paul Gortmaker (1):
      list_bl.h: make list head locking RT safe

Sebastian Andrzej Siewior (5):
      kernel/cpu: fix cpu down problem if kthread's cpu is going down
      kernel/hotplug: restore original cpu mask oncpu/down
      gpu: i915: allow the user not to do the wbinvd
      drm/i915: drop trace_i915_gem_ring_dispatch on rt
      genirq: do not invoke the affinity callback via a workqueue

Steven Rostedt (5):
      sched/workqueue: Only wake up idle workers if not blocked on slee=
ping spin lock
      rt,ntp: Move call to schedule_delayed_work() to helper thread
      hwlat-detector: Update hwlat_detector to add outer loop detection
      hwlat-detector: Use trace_clock_local if available
      hwlat-detector: Use thread instead of stop machine

Steven Rostedt (Red Hat) (2):
      hwlat-detect/trace: Export trace_clock_local for hwlat-detector
      Linux 3.6.11.8-rt41

Thomas Gleixner (1):
      sched: Distangle worker accounting from rqlock

Uwe Kleine-K=C3=B6nig (1):
      list_bl.h: fix it for for !SMP && !DEBUG_SPINLOCK

Zhao Hongjiang (1):
      timers: prepare for full preemption improve

----
 arch/x86/kernel/cpu/mcheck/mce.c           |    2 +-
 drivers/gpu/drm/i915/i915_gem.c            |   17 +++-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    2 +
 drivers/misc/hwlat_detector.c              |  117 +++++++++++++++++---=
--------
 drivers/scsi/hpsa.c                        |    2 +-
 include/linux/interrupt.h                  |    1 +
 include/linux/list_bl.h                    |   28 ++++++-
 kernel/cpu.c                               |   29 ++++++-
 kernel/irq/manage.c                        |   90 +++++++++++++++++++-=
-
 kernel/sched/core.c                        |   68 ++++------------
 kernel/time/ntp.c                          |   40 ++++++++++
 kernel/timer.c                             |    8 +-
 kernel/trace/trace_clock.c                 |    1 +
 kernel/workqueue.c                         |   59 +++++++-------
 kernel/workqueue_sched.h                   |    5 +-
 localversion-rt                            |    2 +-
 16 files changed, 319 insertions(+), 152 deletions(-)
---------------------------
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mch=
eck/mce.c
index e31ea90..339bb4d0 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1649,7 +1649,7 @@ static void __mcheck_cpu_init_timer(void)
 	__this_cpu_write(mce_next_interval, iv);
 	if (!iv)
 		return;
-	hrtimer_start_range_ns(t, ns_to_ktime(jiffies_to_usecs(iv) * 1000),
+	hrtimer_start_range_ns(t, ns_to_ktime(jiffies_to_usecs(iv) * 1000ULL)=
,
 			       0, HRTIMER_MODE_REL_PINNED);
 }
=20
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i91=
5_gem.c
index 18da42c..a3f72cb 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -36,6 +36,7 @@
 #include <linux/swap.h>
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
+#include <linux/module.h>
=20
 static __must_check int i915_gem_object_flush_gpu_write_domain(struct =
drm_i915_gem_object *obj);
 static void i915_gem_object_flush_gtt_write_domain(struct drm_i915_gem=
_object *obj);
@@ -2525,6 +2526,10 @@ static inline int fence_number(struct drm_i915_p=
rivate *dev_priv,
 	return fence - dev_priv->fence_regs;
 }
=20
+static bool do_wbinvd =3D true;
+module_param(do_wbinvd, bool, 0644);
+MODULE_PARM_DESC(do_wbinvd, "Do expensive synchronization. Say no afte=
r you pin each GPU process to the same CPU in order to lower the latenc=
y.");
+
 static void i915_gem_write_fence__ipi(void *data)
 {
 	wbinvd();
@@ -2548,8 +2553,16 @@ static void i915_gem_object_update_fence(struct =
drm_i915_gem_object *obj,
 	 * on each processor in order to manually flush all memory
 	 * transactions before updating the fence register.
 	 */
-	if (HAS_LLC(obj->base.dev))
-		on_each_cpu(i915_gem_write_fence__ipi, NULL, 1);
+	if (HAS_LLC(obj->base.dev)) {
+		if (do_wbinvd) {
+#ifdef CONFIG_PREEMPT_RT_FULL
+			pr_err_once("WARNING! The i915 invalidates all caches which increas=
es the latency.");
+			pr_err_once("As a workaround use 'i915.do_wbinvd=3Dno' and PIN each=
 process doing ");
+			pr_err_once("any kind of GPU activity to the same CPU to avoid prob=
lems.");
+#endif
+			on_each_cpu(i915_gem_write_fence__ipi, NULL, 1);
+		}
+	}
 	i915_gem_write_fence(dev, fence_reg, enable ? obj : NULL);
=20
 	if (enable) {
diff --git a/drivers/gpu/drm/i915/i915_gem_execbuffer.c b/drivers/gpu/d=
rm/i915/i915_gem_execbuffer.c
index c26a8f8a..14df3f6 100644
--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -1259,7 +1259,9 @@ i915_gem_do_execbuffer(struct drm_device *dev, vo=
id *data,
 			goto err;
 	}
=20
+#ifndef CONFIG_PREEMPT_RT_BASE
 	trace_i915_gem_ring_dispatch(ring, seqno);
+#endif
=20
 	exec_start =3D batch_obj->gtt_offset + args->batch_start_offset;
 	exec_len =3D args->batch_len;
diff --git a/drivers/misc/hwlat_detector.c b/drivers/misc/hwlat_detecto=
r.c
index b7b7c90..6f61d5f 100644
--- a/drivers/misc/hwlat_detector.c
+++ b/drivers/misc/hwlat_detector.c
@@ -41,7 +41,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ring_buffer.h>
-#include <linux/stop_machine.h>
 #include <linux/time.h>
 #include <linux/hrtimer.h>
 #include <linux/kthread.h>
@@ -51,6 +50,7 @@
 #include <linux/version.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/trace_clock.h>
=20
 #define BUF_SIZE_DEFAULT	262144UL		/* 8K*(sizeof(entry)) */
 #define BUF_FLAGS		(RB_FL_OVERWRITE)	/* no block on full */
@@ -106,7 +106,6 @@ struct data;					/* Global state */
 /* Sampling functions */
 static int __buffer_add_sample(struct sample *sample);
 static struct sample *buffer_get_sample(struct sample *sample);
-static int get_sample(void *unused);
=20
 /* Threading and state */
 static int kthread_fn(void *unused);
@@ -143,11 +142,12 @@ static void detector_exit(void);
 struct sample {
 	u64		seqnum;		/* unique sequence */
 	u64		duration;	/* ktime delta */
+	u64		outer_duration;	/* ktime delta (outer loop) */
 	struct timespec	timestamp;	/* wall time */
 	unsigned long   lost;
 };
=20
-/* keep the global state somewhere. Mostly used under stop_machine. */
+/* keep the global state somewhere. */
 static struct data {
=20
 	struct mutex lock;		/* protect changes */
@@ -170,7 +170,7 @@ static struct data {
  * @sample: The new latency sample value
  *
  * This receives a new latency sample and records it in a global ring =
buffer.
- * No additional locking is used in this case - suited for stop_machin=
e use.
+ * No additional locking is used in this case.
  */
 static int __buffer_add_sample(struct sample *sample)
 {
@@ -210,29 +210,60 @@ static struct sample *buffer_get_sample(struct sa=
mple *sample)
 	return sample;
 }
=20
+#ifndef CONFIG_TRACING
+#define time_type	ktime_t
+#define time_get()	ktime_get()
+#define time_to_us(x)	ktime_to_us(x)
+#define time_sub(a, b)	ktime_sub(a, b)
+#define init_time(a, b)	(a).tv64 =3D b
+#define time_u64(a)	(a).tv64
+#else
+#define time_type	u64
+#define time_get()	trace_clock_local()
+#define time_to_us(x)	div_u64(x, 1000)
+#define time_sub(a, b)	((a) - (b))
+#define init_time(a, b)	a =3D b
+#define time_u64(a)	a
+#endif
 /**
  * get_sample - sample the CPU TSC and look for likely hardware latenc=
ies
- * @unused: This is not used but is a part of the stop_machine API
  *
  * Used to repeatedly capture the CPU TSC (or similar), looking for po=
tential
- * hardware-induced latency. Called under stop_machine, with data.lock=
 held.
+ * hardware-induced latency. Called with interrupts disabled and with =
data.lock held.
  */
-static int get_sample(void *unused)
+static int get_sample(void)
 {
-	ktime_t start, t1, t2;
+	time_type start, t1, t2, last_t2;
 	s64 diff, total =3D 0;
 	u64 sample =3D 0;
-	int ret =3D 1;
+	u64 outer_sample =3D 0;
+	int ret =3D -1;
=20
-	start =3D ktime_get(); /* start timestamp */
+	init_time(last_t2, 0);
+	start =3D time_get(); /* start timestamp */
=20
 	do {
=20
-		t1 =3D ktime_get();	/* we'll look for a discontinuity */
-		t2 =3D ktime_get();
+		t1 =3D time_get();	/* we'll look for a discontinuity */
+		t2 =3D time_get();
+
+		if (time_u64(last_t2)) {
+			/* Check the delta from the outer loop (t2 to next t1) */
+			diff =3D time_to_us(time_sub(t1, last_t2));
+			/* This shouldn't happen */
+			if (diff < 0) {
+				printk(KERN_ERR BANNER "time running backwards\n");
+				goto out;
+			}
+			if (diff > outer_sample)
+				outer_sample =3D diff;
+		}
+		last_t2 =3D t2;
+
+		total =3D time_to_us(time_sub(t2, start)); /* sample width */
=20
-		total =3D ktime_to_us(ktime_sub(t2, start)); /* sample width */
-		diff =3D ktime_to_us(ktime_sub(t2, t1));     /* current diff */
+		/* This checks the inner loop (t1 to t2) */
+		diff =3D time_to_us(time_sub(t2, t1));     /* current diff */
=20
 		/* This shouldn't happen */
 		if (diff < 0) {
@@ -245,13 +276,18 @@ static int get_sample(void *unused)
=20
 	} while (total <=3D data.sample_width);
=20
+	ret =3D 0;
+
 	/* If we exceed the threshold value, we have found a hardware latency=
 */
-	if (sample > data.threshold) {
+	if (sample > data.threshold || outer_sample > data.threshold) {
 		struct sample s;
=20
+		ret =3D 1;
+
 		data.count++;
 		s.seqnum =3D data.count;
 		s.duration =3D sample;
+		s.outer_duration =3D outer_sample;
 		s.timestamp =3D CURRENT_TIME;
 		__buffer_add_sample(&s);
=20
@@ -260,7 +296,6 @@ static int get_sample(void *unused)
 			data.max_sample =3D sample;
 	}
=20
-	ret =3D 0;
 out:
 	return ret;
 }
@@ -270,32 +305,30 @@ out:
  * @unused: A required part of the kthread API.
  *
  * Used to periodically sample the CPU TSC via a call to get_sample. W=
e
- * use stop_machine, whith does (intentionally) introduce latency sinc=
e we
+ * disable interrupts, which does (intentionally) introduce latency si=
nce we
  * need to ensure nothing else might be running (and thus pre-empting)=
=2E
  * Obviously this should never be used in production environments.
  *
- * stop_machine will schedule us typically only on CPU0 which is fine =
for
- * almost every real-world hardware latency situation - but we might l=
ater
- * generalize this if we find there are any actualy systems with alter=
nate
- * SMI delivery or other non CPU0 hardware latencies.
+ * Currently this runs on which ever CPU it was scheduled on, but most
+ * real-worald hardware latency situations occur across several CPUs,
+ * but we might later generalize this if we find there are any actualy
+ * systems with alternate SMI delivery or other hardware latencies.
  */
 static int kthread_fn(void *unused)
 {
-	int err =3D 0;
-	u64 interval =3D 0;
+	int ret;
+	u64 interval;
=20
 	while (!kthread_should_stop()) {
=20
 		mutex_lock(&data.lock);
=20
-		err =3D stop_machine(get_sample, unused, 0);
-		if (err) {
-			/* Houston, we have a problem */
-			mutex_unlock(&data.lock);
-			goto err_out;
-		}
+		local_irq_disable();
+		ret =3D get_sample();
+		local_irq_enable();
=20
-		wake_up(&data.wq); /* wake up reader(s) */
+		if (ret > 0)
+			wake_up(&data.wq); /* wake up reader(s) */
=20
 		interval =3D data.sample_window - data.sample_width;
 		do_div(interval, USEC_PER_MSEC); /* modifies interval value */
@@ -303,15 +336,10 @@ static int kthread_fn(void *unused)
 		mutex_unlock(&data.lock);
=20
 		if (msleep_interruptible(interval))
-			goto out;
+			break;
 	}
-		goto out;
-err_out:
-	printk(KERN_ERR BANNER "could not call stop_machine, disabling\n");
-	enabled =3D 0;
-out:
-	return err;
=20
+	return 0;
 }
=20
 /**
@@ -407,8 +435,7 @@ out:
  * This function provides a generic read implementation for the global=
 state
  * "data" structure debugfs filesystem entries. It would be nice to us=
e
  * simple_attr_read directly, but we need to make sure that the data.l=
ock
- * spinlock is held during the actual read (even though we likely won'=
t ever
- * actually race here as the updater runs under a stop_machine context=
).
+ * is held during the actual read.
  */
 static ssize_t simple_data_read(struct file *filp, char __user *ubuf,
 				size_t cnt, loff_t *ppos, const u64 *entry)
@@ -443,8 +470,7 @@ static ssize_t simple_data_read(struct file *filp, =
char __user *ubuf,
  * This function provides a generic write implementation for the globa=
l state
  * "data" structure debugfs filesystem entries. It would be nice to us=
e
  * simple_attr_write directly, but we need to make sure that the data.=
lock
- * spinlock is held during the actual write (even though we likely won=
't ever
- * actually race here as the updater runs under a stop_machine context=
).
+ * is held during the actual write.
  */
 static ssize_t simple_data_write(struct file *filp, const char __user =
*ubuf,
 				 size_t cnt, loff_t *ppos, u64 *entry)
@@ -738,10 +764,11 @@ static ssize_t debug_sample_fread(struct file *fi=
lp, char __user *ubuf,
 		}
 	}
=20
-	len =3D snprintf(buf, sizeof(buf), "%010lu.%010lu\t%llu\n",
-		      sample->timestamp.tv_sec,
-		      sample->timestamp.tv_nsec,
-		      sample->duration);
+	len =3D snprintf(buf, sizeof(buf), "%010lu.%010lu\t%llu\t%llu\n",
+		       sample->timestamp.tv_sec,
+		       sample->timestamp.tv_nsec,
+		       sample->duration,
+		       sample->outer_duration);
=20
=20
 	/* handling partial reads is more trouble than it's worth */
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index f9823f2..be83a15 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -565,7 +565,7 @@ static void set_performant_mode(struct ctlr_info *h=
, struct CommandList *c)
 		c->busaddr |=3D 1 | (h->blockFetchTable[c->Header.SGList] << 1);
 		if (likely(h->msix_vector))
 			c->Header.ReplyQueue =3D
-				smp_processor_id() % h->nreply_queues;
+				raw_smp_processor_id() % h->nreply_queues;
 	}
 }
=20
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index fb81baa..16fbe2b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -263,6 +263,7 @@ struct irq_affinity_notify {
 	unsigned int irq;
 	struct kref kref;
 	struct work_struct work;
+	struct list_head list;
 	void (*notify)(struct irq_affinity_notify *, const cpumask_t *mask);
 	void (*release)(struct kref *ref);
 };
diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 31f9d75..becd7a6 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -2,6 +2,7 @@
 #define _LINUX_LIST_BL_H
=20
 #include <linux/list.h>
+#include <linux/spinlock.h>
 #include <linux/bit_spinlock.h>
=20
 /*
@@ -32,13 +33,22 @@
=20
 struct hlist_bl_head {
 	struct hlist_bl_node *first;
+#ifdef CONFIG_PREEMPT_RT_BASE
+	raw_spinlock_t lock;
+#endif
 };
=20
 struct hlist_bl_node {
 	struct hlist_bl_node *next, **pprev;
 };
-#define INIT_HLIST_BL_HEAD(ptr) \
-	((ptr)->first =3D NULL)
+
+static inline void INIT_HLIST_BL_HEAD(struct hlist_bl_head *h)
+{
+	h->first =3D NULL;
+#ifdef CONFIG_PREEMPT_RT_BASE
+	raw_spin_lock_init(&h->lock);
+#endif
+}
=20
 static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
 {
@@ -117,12 +127,26 @@ static inline void hlist_bl_del_init(struct hlist=
_bl_node *n)
=20
 static inline void hlist_bl_lock(struct hlist_bl_head *b)
 {
+#ifndef CONFIG_PREEMPT_RT_BASE
 	bit_spin_lock(0, (unsigned long *)b);
+#else
+	raw_spin_lock(&b->lock);
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	__set_bit(0, (unsigned long *)b);
+#endif
+#endif
 }
=20
 static inline void hlist_bl_unlock(struct hlist_bl_head *b)
 {
+#ifndef CONFIG_PREEMPT_RT_BASE
 	__bit_spin_unlock(0, (unsigned long *)b);
+#else
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	__clear_bit(0, (unsigned long *)b);
+#endif
+	raw_spin_unlock(&b->lock);
+#endif
 }
=20
 /**
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 295bf9d..16ec791 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -83,6 +83,7 @@ struct hotplug_pcp {
 	int refcount;
 	int grab_lock;
 	struct completion synced;
+	struct completion unplug_wait;
 #ifdef CONFIG_PREEMPT_RT_FULL
 	spinlock_t lock;
 #else
@@ -180,6 +181,7 @@ static int sync_unplug_thread(void *data)
 {
 	struct hotplug_pcp *hp =3D data;
=20
+	wait_for_completion(&hp->unplug_wait);
 	preempt_disable();
 	hp->unplug =3D current;
 	wait_for_pinned_cpus(hp);
@@ -245,6 +247,14 @@ static void __cpu_unplug_sync(struct hotplug_pcp *=
hp)
 	wait_for_completion(&hp->synced);
 }
=20
+static void __cpu_unplug_wait(unsigned int cpu)
+{
+	struct hotplug_pcp *hp =3D &per_cpu(hotplug_pcp, cpu);
+
+	complete(&hp->unplug_wait);
+	wait_for_completion(&hp->synced);
+}
+
 /*
  * Start the sync_unplug_thread on the target cpu and wait for it to
  * complete.
@@ -268,6 +278,7 @@ static int cpu_unplug_begin(unsigned int cpu)
 	tell_sched_cpu_down_begin(cpu);
=20
 	init_completion(&hp->synced);
+	init_completion(&hp->unplug_wait);
=20
 	hp->sync_tsk =3D kthread_create(sync_unplug_thread, hp, "sync_unplug/=
%d", cpu);
 	if (IS_ERR(hp->sync_tsk)) {
@@ -283,8 +294,7 @@ static int cpu_unplug_begin(unsigned int cpu)
 	 * wait for tasks that are going to enter these sections and
 	 * we must not have them block.
 	 */
-	__cpu_unplug_sync(hp);
-
+	wake_up_process(hp->sync_tsk);
 	return 0;
 }
=20
@@ -553,6 +563,7 @@ static int __ref _cpu_down(unsigned int cpu, int ta=
sks_frozen)
 		.hcpu =3D hcpu,
 	};
 	cpumask_var_t cpumask;
+	cpumask_var_t cpumask_org;
=20
 	if (num_online_cpus() =3D=3D 1)
 		return -EBUSY;
@@ -563,6 +574,12 @@ static int __ref _cpu_down(unsigned int cpu, int t=
asks_frozen)
 	/* Move the downtaker off the unplug cpu */
 	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
 		return -ENOMEM;
+	if (!alloc_cpumask_var(&cpumask_org, GFP_KERNEL))  {
+		free_cpumask_var(cpumask);
+		return -ENOMEM;
+	}
+
+	cpumask_copy(cpumask_org, tsk_cpus_allowed(current));
 	cpumask_andnot(cpumask, cpu_online_mask, cpumask_of(cpu));
 	set_cpus_allowed_ptr(current, cpumask);
 	free_cpumask_var(cpumask);
@@ -571,7 +588,8 @@ static int __ref _cpu_down(unsigned int cpu, int ta=
sks_frozen)
 	if (mycpu =3D=3D cpu) {
 		printk(KERN_ERR "Yuck! Still on unplug CPU\n!");
 		migrate_enable();
-		return -EBUSY;
+		err =3D -EBUSY;
+		goto restore_cpus;
 	}
=20
 	cpu_hotplug_begin();
@@ -590,6 +608,8 @@ static int __ref _cpu_down(unsigned int cpu, int ta=
sks_frozen)
 		goto out_release;
 	}
=20
+	__cpu_unplug_wait(cpu);
+
 	/* Notifiers are done. Don't let any more tasks pin this CPU. */
 	cpu_unplug_sync(cpu);
=20
@@ -627,6 +647,9 @@ out_cancel:
 	cpu_hotplug_done();
 	if (!err)
 		cpu_notify_nofail(CPU_POST_DEAD | mod, hcpu);
+restore_cpus:
+	set_cpus_allowed_ptr(current, cpumask_org);
+	free_cpumask_var(cpumask_org);
 	return err;
 }
=20
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 478ade0..0fe99a4 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -163,6 +163,62 @@ int irq_do_set_affinity(struct irq_data *data, con=
st struct cpumask *mask,
 	return ret;
 }
=20
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void _irq_affinity_notify(struct irq_affinity_notify *notify);
+static struct task_struct *set_affinity_helper;
+static LIST_HEAD(affinity_list);
+static DEFINE_RAW_SPINLOCK(affinity_list_lock);
+
+static int set_affinity_thread(void *unused)
+{
+	while (1) {
+		struct irq_affinity_notify *notify;
+		int empty;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		raw_spin_lock_irq(&affinity_list_lock);
+		empty =3D list_empty(&affinity_list);
+		raw_spin_unlock_irq(&affinity_list_lock);
+
+		if (empty)
+			schedule();
+		if (kthread_should_stop())
+			break;
+		set_current_state(TASK_RUNNING);
+try_next:
+		notify =3D NULL;
+
+		raw_spin_lock_irq(&affinity_list_lock);
+		if (!list_empty(&affinity_list)) {
+			notify =3D list_first_entry(&affinity_list,
+					struct irq_affinity_notify, list);
+			list_del_init(&notify->list);
+		}
+		raw_spin_unlock_irq(&affinity_list_lock);
+
+		if (!notify)
+			continue;
+		_irq_affinity_notify(notify);
+		goto try_next;
+	}
+	return 0;
+}
+
+static void init_helper_thread(void)
+{
+	if (set_affinity_helper)
+		return;
+	set_affinity_helper =3D kthread_run(set_affinity_thread, NULL,
+			"affinity-cb");
+	WARN_ON(IS_ERR(set_affinity_helper));
+}
+#else
+
+static inline void init_helper_thread(void) { }
+
+#endif
+
 int __irq_set_affinity_locked(struct irq_data *data, const struct cpum=
ask *mask)
 {
 	struct irq_chip *chip =3D irq_data_get_irq_chip(data);
@@ -181,7 +237,17 @@ int __irq_set_affinity_locked(struct irq_data *dat=
a, const struct cpumask *mask)
=20
 	if (desc->affinity_notify) {
 		kref_get(&desc->affinity_notify->kref);
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+		raw_spin_lock(&affinity_list_lock);
+		if (list_empty(&desc->affinity_notify->list))
+			list_add_tail(&affinity_list,
+					&desc->affinity_notify->list);
+		raw_spin_unlock(&affinity_list_lock);
+		wake_up_process(set_affinity_helper);
+#else
 		schedule_work(&desc->affinity_notify->work);
+#endif
 	}
 	irqd_set(data, IRQD_AFFINITY_SET);
=20
@@ -222,10 +288,8 @@ int irq_set_affinity_hint(unsigned int irq, const =
struct cpumask *m)
 }
 EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
=20
-static void irq_affinity_notify(struct work_struct *work)
+static void _irq_affinity_notify(struct irq_affinity_notify *notify)
 {
-	struct irq_affinity_notify *notify =3D
-		container_of(work, struct irq_affinity_notify, work);
 	struct irq_desc *desc =3D irq_to_desc(notify->irq);
 	cpumask_var_t cpumask;
 	unsigned long flags;
@@ -247,6 +311,13 @@ out:
 	kref_put(&notify->kref, notify->release);
 }
=20
+static void irq_affinity_notify(struct work_struct *work)
+{
+	struct irq_affinity_notify *notify =3D
+		container_of(work, struct irq_affinity_notify, work);
+	_irq_affinity_notify(notify);
+}
+
 /**
  *	irq_set_affinity_notifier - control notification of IRQ affinity ch=
anges
  *	@irq:		Interrupt for which to enable/disable notification
@@ -276,6 +347,8 @@ irq_set_affinity_notifier(unsigned int irq, struct =
irq_affinity_notify *notify)
 		notify->irq =3D irq;
 		kref_init(&notify->kref);
 		INIT_WORK(&notify->work, irq_affinity_notify);
+		INIT_LIST_HEAD(&notify->list);
+		init_helper_thread();
 	}
=20
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -824,9 +897,6 @@ static void irq_thread_dtor(struct callback_head *u=
nused)
 static int irq_thread(void *data)
 {
 	struct callback_head on_exit_work;
-	static const struct sched_param param =3D {
-		.sched_priority =3D MAX_USER_RT_PRIO/2,
-	};
 	struct irqaction *action =3D data;
 	struct irq_desc *desc =3D irq_to_desc(action->irq);
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
@@ -838,8 +908,6 @@ static int irq_thread(void *data)
 	else
 		handler_fn =3D irq_thread_fn;
=20
-	sched_setscheduler(current, SCHED_FIFO, &param);
-
 	init_task_work(&on_exit_work, irq_thread_dtor);
 	task_work_add(current, &on_exit_work, false);
=20
@@ -938,6 +1006,9 @@ __setup_irq(unsigned int irq, struct irq_desc *des=
c, struct irqaction *new)
 	 */
 	if (new->thread_fn && !nested) {
 		struct task_struct *t;
+		static const struct sched_param param =3D {
+			.sched_priority =3D MAX_USER_RT_PRIO/2,
+		};
=20
 		t =3D kthread_create(irq_thread, new, "irq/%d-%s", irq,
 				   new->name);
@@ -945,6 +1016,9 @@ __setup_irq(unsigned int irq, struct irq_desc *des=
c, struct irqaction *new)
 			ret =3D PTR_ERR(t);
 			goto out_mput;
 		}
+
+		sched_setscheduler(t, SCHED_FIFO, &param);
+
 		/*
 		 * We keep the reference to the task struct even if
 		 * the thread dies to avoid that the interrupt code
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5051ca6..1493f43 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1452,10 +1452,6 @@ static void ttwu_activate(struct rq *rq, struct =
task_struct *p, int en_flags)
 {
 	activate_task(rq, p, en_flags);
 	p->on_rq =3D 1;
-
-	/* if a worker is waking up, notify workqueue */
-	if (p->flags & PF_WQ_WORKER)
-		wq_worker_waking_up(p, cpu_of(rq));
 }
=20
 /*
@@ -1714,42 +1710,6 @@ out:
 }
=20
 /**
- * try_to_wake_up_local - try to wake up a local task with rq lock hel=
d
- * @p: the thread to be awakened
- *
- * Put @p on the run-queue if it's not already there. The caller must
- * ensure that this_rq() is locked, @p is bound to this_rq() and not
- * the current task.
- */
-static void try_to_wake_up_local(struct task_struct *p)
-{
-	struct rq *rq =3D task_rq(p);
-
-	if (WARN_ON_ONCE(rq !=3D this_rq()) ||
-	    WARN_ON_ONCE(p =3D=3D current))
-		return;
-
-	lockdep_assert_held(&rq->lock);
-
-	if (!raw_spin_trylock(&p->pi_lock)) {
-		raw_spin_unlock(&rq->lock);
-		raw_spin_lock(&p->pi_lock);
-		raw_spin_lock(&rq->lock);
-	}
-
-	if (!(p->state & TASK_NORMAL))
-		goto out;
-
-	if (!p->on_rq)
-		ttwu_activate(rq, p, ENQUEUE_WAKEUP);
-
-	ttwu_do_wakeup(rq, p, 0);
-	ttwu_stat(p, smp_processor_id(), 0);
-out:
-	raw_spin_unlock(&p->pi_lock);
-}
-
-/**
  * wake_up_process - Wake up a specific process
  * @p: The process to be woken up.
  *
@@ -3627,19 +3587,6 @@ need_resched:
 		} else {
 			deactivate_task(rq, prev, DEQUEUE_SLEEP);
 			prev->on_rq =3D 0;
-
-			/*
-			 * If a worker went to sleep, notify and ask workqueue
-			 * whether it wants to wake up a task to maintain
-			 * concurrency.
-			 */
-			if (prev->flags & PF_WQ_WORKER) {
-				struct task_struct *to_wakeup;
-
-				to_wakeup =3D wq_worker_sleeping(prev, cpu);
-				if (to_wakeup)
-					try_to_wake_up_local(to_wakeup);
-			}
 		}
 		switch_count =3D &prev->nvcsw;
 	}
@@ -3683,6 +3630,14 @@ static inline void sched_submit_work(struct task=
_struct *tsk)
 {
 	if (!tsk->state || tsk_is_pi_blocked(tsk))
 		return;
+
+	/*
+	 * If a worker went to sleep, notify and ask workqueue whether
+	 * it wants to wake up a task to maintain concurrency.
+	 */
+	if (tsk->flags & PF_WQ_WORKER)
+		wq_worker_sleeping(tsk);
+
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
@@ -3691,12 +3646,19 @@ static inline void sched_submit_work(struct tas=
k_struct *tsk)
 		blk_schedule_flush_plug(tsk);
 }
=20
+static inline void sched_update_worker(struct task_struct *tsk)
+{
+	if (tsk->flags & PF_WQ_WORKER)
+		wq_worker_running(tsk);
+}
+
 asmlinkage void __sched schedule(void)
 {
 	struct task_struct *tsk =3D current;
=20
 	sched_submit_work(tsk);
 	__schedule();
+	sched_update_worker(tsk);
 }
 EXPORT_SYMBOL(schedule);
=20
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index bb1edfa..3e93516 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -10,6 +10,7 @@
 #include <linux/workqueue.h>
 #include <linux/hrtimer.h>
 #include <linux/jiffies.h>
+#include <linux/kthread.h>
 #include <linux/math64.h>
 #include <linux/timex.h>
 #include <linux/time.h>
@@ -529,10 +530,49 @@ static void sync_cmos_clock(struct work_struct *w=
ork)
 	schedule_delayed_work(&sync_cmos_work, timespec_to_jiffies(&next));
 }
=20
+#ifdef CONFIG_PREEMPT_RT_FULL
+/*
+ * RT can not call schedule_delayed_work from real interrupt context.
+ * Need to make a thread to do the real work.
+ */
+static struct task_struct *cmos_delay_thread;
+static bool do_cmos_delay;
+
+static int run_cmos_delay(void *ignore)
+{
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (do_cmos_delay) {
+			do_cmos_delay =3D false;
+			schedule_delayed_work(&sync_cmos_work, 0);
+		}
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+static void notify_cmos_timer(void)
+{
+	do_cmos_delay =3D true;
+	/* Make visible before waking up process */
+	smp_wmb();
+	wake_up_process(cmos_delay_thread);
+}
+
+static __init int create_cmos_delay_thread(void)
+{
+	cmos_delay_thread =3D kthread_run(run_cmos_delay, NULL, "kcmosdelayd"=
);
+	BUG_ON(!cmos_delay_thread);
+	return 0;
+}
+early_initcall(create_cmos_delay_thread);
+#else
 static void notify_cmos_timer(void)
 {
 	schedule_delayed_work(&sync_cmos_work, 0);
 }
+#endif /* CONFIG_PREEMPT_RT_FULL */
=20
 #else
 static inline void notify_cmos_timer(void) { }
diff --git a/kernel/timer.c b/kernel/timer.c
index 027ce4e..61b57c1 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -76,7 +76,9 @@ struct tvec_root {
 struct tvec_base {
 	spinlock_t lock;
 	struct timer_list *running_timer;
+#ifdef CONFIG_PREEMPT_RT_FULL
 	wait_queue_head_t wait_for_running_timer;
+#endif
 	unsigned long timer_jiffies;
 	unsigned long next_timer;
 	unsigned long active_timers;
@@ -1006,7 +1008,7 @@ static void wait_for_running_timer(struct timer_l=
ist *timer)
 			   base->running_timer !=3D timer);
 }
=20
-# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_tunning_timer)
+# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
 #else
 static inline void wait_for_running_timer(struct timer_list *timer)
 {
@@ -1251,7 +1253,7 @@ static inline void __run_timers(struct tvec_base =
*base)
 			spin_lock_irq(&base->lock);
 		}
 	}
-	wake_up(&base->wait_for_running_timer);
+	wakeup_timer_waiters(base);
 	spin_unlock_irq(&base->lock);
 }
=20
@@ -1765,7 +1767,9 @@ static int __cpuinit init_timers_cpu(int cpu)
 			base =3D &boot_tvec_bases;
 		}
 		spin_lock_init(&base->lock);
+#ifdef CONFIG_PREEMPT_RT_FULL
 		init_waitqueue_head(&base->wait_for_running_timer);
+#endif
 		tvec_base_done[cpu] =3D 1;
 	} else {
 		base =3D per_cpu(tvec_bases, cpu);
diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 3947835..1bbb1b2 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -44,6 +44,7 @@ u64 notrace trace_clock_local(void)
=20
 	return clock;
 }
+EXPORT_SYMBOL_GPL(trace_clock_local);
=20
 /*
  * trace_clock(): 'between' trace clock. Not completely serialized,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b973d66..6308d9b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -148,6 +148,7 @@ struct worker {
 	unsigned long		last_active;	/* L: last active timestamp */
 	unsigned int		flags;		/* X: flags */
 	int			id;		/* I: worker id */
+	int			sleeping;	/* None */
=20
 	/* for rebinding worker to CPU */
 	struct idle_rebind	*idle_rebind;	/* L: for idle worker */
@@ -691,52 +692,45 @@ static void wake_up_worker(struct worker_pool *po=
ol)
 }
=20
 /**
- * wq_worker_waking_up - a worker is waking up
- * @task: task waking up
- * @cpu: CPU @task is waking up to
+ * wq_worker_running - a worker is running again
+ * @task: task returning from sleep
  *
- * This function is called during try_to_wake_up() when a worker is
- * being awoken.
- *
- * CONTEXT:
- * spin_lock_irq(rq->lock)
+ * This function is called when a worker returns from schedule()
  */
-void wq_worker_waking_up(struct task_struct *task, unsigned int cpu)
+void wq_worker_running(struct task_struct *task)
 {
 	struct worker *worker =3D kthread_data(task);
=20
+	if (!worker->sleeping)
+		return;
 	if (!(worker->flags & WORKER_NOT_RUNNING))
 		atomic_inc(get_pool_nr_running(worker->pool));
+	worker->sleeping =3D 0;
 }
=20
 /**
  * wq_worker_sleeping - a worker is going to sleep
  * @task: task going to sleep
- * @cpu: CPU in question, must be the current CPU number
- *
- * This function is called during schedule() when a busy worker is
- * going to sleep.  Worker on the same cpu can be woken up by
- * returning pointer to its task.
- *
- * CONTEXT:
- * spin_lock_irq(rq->lock)
- *
- * RETURNS:
- * Worker task on @cpu to wake up, %NULL if none.
+ * This function is called from schedule() when a busy worker is
+ * going to sleep.
  */
-struct task_struct *wq_worker_sleeping(struct task_struct *task,
-				       unsigned int cpu)
+void wq_worker_sleeping(struct task_struct *task)
 {
-	struct worker *worker =3D kthread_data(task), *to_wakeup =3D NULL;
-	struct worker_pool *pool =3D worker->pool;
-	atomic_t *nr_running =3D get_pool_nr_running(pool);
+	struct worker *next, *worker =3D kthread_data(task);
+	struct worker_pool *pool;
+	atomic_t *nr_running;
=20
 	if (worker->flags & WORKER_NOT_RUNNING)
-		return NULL;
+		return;
+
+	if (WARN_ON_ONCE(worker->sleeping))
+		return;
=20
-	/* this can only happen on the local cpu */
-	BUG_ON(cpu !=3D raw_smp_processor_id());
+	pool =3D worker->pool;
+	nr_running =3D get_pool_nr_running(pool);
=20
+	worker->sleeping =3D 1;
+	spin_lock_irq(&pool->gcwq->lock);
 	/*
 	 * The counterpart of the following dec_and_test, implied mb,
 	 * worklist not empty test sequence is in insert_work().
@@ -748,9 +742,12 @@ struct task_struct *wq_worker_sleeping(struct task=
_struct *task,
 	 * manipulating idle_list, so dereferencing idle_list without gcwq
 	 * lock is safe.
 	 */
-	if (atomic_dec_and_test(nr_running) && !list_empty(&pool->worklist))
-		to_wakeup =3D first_worker(pool);
-	return to_wakeup ? to_wakeup->task : NULL;
+	if (atomic_dec_and_test(nr_running) && !list_empty(&pool->worklist)) =
{
+		next =3D first_worker(pool);
+		if (next)
+			wake_up_process(next->task);
+	}
+	spin_unlock_irq(&pool->gcwq->lock);
 }
=20
 /**
diff --git a/kernel/workqueue_sched.h b/kernel/workqueue_sched.h
index 2d10fc9..3bf73e2 100644
--- a/kernel/workqueue_sched.h
+++ b/kernel/workqueue_sched.h
@@ -4,6 +4,5 @@
  * Scheduler hooks for concurrency managed workqueue.  Only to be
  * included from sched.c and workqueue.c.
  */
-void wq_worker_waking_up(struct task_struct *task, unsigned int cpu);
-struct task_struct *wq_worker_sleeping(struct task_struct *task,
-				       unsigned int cpu);
+void wq_worker_running(struct task_struct *task);
+void wq_worker_sleeping(struct task_struct *task);
diff --git a/localversion-rt b/localversion-rt
index 2af6c89..629e0b4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt40
+-rt41
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
