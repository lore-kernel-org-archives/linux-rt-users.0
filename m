From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 24/25][RFC 3.0.23-rt39-rc1] cpu: Make hotplug.lock a "sleeping" spinlock on RT
Date: Tue, 06 Mar 2012 11:17:00 -0500
Message-ID: <20120306161952.267327135@goodmis.org>
References: <20120306161636.491172179@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0024-cpu-Make-hotplug.lock-a-sleeping-spinlock-on-RT.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

Tasks can block on hotplug.lock in pin_current_cpu(), but their state
might be != RUNNING. So the mutex wakeup will set the state
unconditionally to RUNNING. That might cause spurious unexpected
wakeups. We could provide a state preserving mutex_lock() function,
but this is semantically backwards. So instead we convert the
hotplug.lock() to a spinlock for RT, which has the state preserving
semantics already.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Carsten Emde <C.Emde@osadl.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Clark Williams <clark.williams@gmail.com>
Cc: stable-rt@vger.kernel.org
Link: http://lkml.kernel.org/r/1330702617.25686.265.camel@gandalf.stny.rr.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/cpu.c |   35 ++++++++++++++++++++++++++---------
 1 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index b2de274..21c8380 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -46,7 +46,12 @@ static int cpu_hotplug_disabled;
 
 static struct {
 	struct task_struct *active_writer;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	/* Makes the lock keep the task's state */
+	spinlock_t lock;
+#else
 	struct mutex lock; /* Synchronizes accesses to refcount, */
+#endif
 	/*
 	 * Also blocks the new readers during
 	 * an ongoing cpu hotplug operation.
@@ -54,10 +59,22 @@ static struct {
 	int refcount;
 } cpu_hotplug = {
 	.active_writer = NULL,
+#ifdef CONFIG_PREEMPT_RT_FULL
+	.lock = __SPIN_LOCK_UNLOCKED(cpu_hotplug.lock),
+#else
 	.lock = __MUTEX_INITIALIZER(cpu_hotplug.lock),
+#endif
 	.refcount = 0,
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+# define hotplug_lock() rt_spin_lock(&cpu_hotplug.lock)
+# define hotplug_unlock() rt_spin_unlock(&cpu_hotplug.lock)
+#else
+# define hotplug_lock() mutex_lock(&cpu_hotplug.lock)
+# define hotplug_unlock() mutex_unlock(&cpu_hotplug.lock)
+#endif
+
 struct hotplug_pcp {
 	struct task_struct *unplug;
 	int refcount;
@@ -87,8 +104,8 @@ retry:
 		return;
 	}
 	preempt_enable();
-	mutex_lock(&cpu_hotplug.lock);
-	mutex_unlock(&cpu_hotplug.lock);
+	hotplug_lock();
+	hotplug_unlock();
 	preempt_disable();
 	goto retry;
 }
@@ -161,9 +178,9 @@ void get_online_cpus(void)
 	might_sleep();
 	if (cpu_hotplug.active_writer == current)
 		return;
-	mutex_lock(&cpu_hotplug.lock);
+	hotplug_lock();
 	cpu_hotplug.refcount++;
-	mutex_unlock(&cpu_hotplug.lock);
+	hotplug_unlock();
 
 }
 EXPORT_SYMBOL_GPL(get_online_cpus);
@@ -172,10 +189,10 @@ void put_online_cpus(void)
 {
 	if (cpu_hotplug.active_writer == current)
 		return;
-	mutex_lock(&cpu_hotplug.lock);
+	hotplug_lock();
 	if (!--cpu_hotplug.refcount && unlikely(cpu_hotplug.active_writer))
 		wake_up_process(cpu_hotplug.active_writer);
-	mutex_unlock(&cpu_hotplug.lock);
+	hotplug_unlock();
 
 }
 EXPORT_SYMBOL_GPL(put_online_cpus);
@@ -207,11 +224,11 @@ static void cpu_hotplug_begin(void)
 	cpu_hotplug.active_writer = current;
 
 	for (;;) {
-		mutex_lock(&cpu_hotplug.lock);
+		hotplug_lock();
 		if (likely(!cpu_hotplug.refcount))
 			break;
 		__set_current_state(TASK_UNINTERRUPTIBLE);
-		mutex_unlock(&cpu_hotplug.lock);
+		hotplug_unlock();
 		schedule();
 	}
 }
@@ -219,7 +236,7 @@ static void cpu_hotplug_begin(void)
 static void cpu_hotplug_done(void)
 {
 	cpu_hotplug.active_writer = NULL;
-	mutex_unlock(&cpu_hotplug.lock);
+	hotplug_unlock();
 }
 
 #else /* #if CONFIG_HOTPLUG_CPU */
-- 
1.7.8.3
