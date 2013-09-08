From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 07/19] kernel/cpu: fix cpu down problem if kthreads cpu is going down
Date: Sun, 08 Sep 2013 11:14:02 -0400
Message-ID: <20130908151446.911305484@goodmis.org>
References: <20130908151355.362583092@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0007-kernel-cpu-fix-cpu-down-problem-if-kthread-s-cpu-is-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

If kthread is pinned to CPUx and CPUx is going down then we get into
trouble:
- first the unplug thread is created
- it will set itself to hp->unplug. As a result, every task that is
  going to take a lock, has to leave the CPU.
- the CPU_DOWN_PREPARE notifier are started. The worker thread will
  start a new process for the "high priority worker".
  Now kthread would like to take a lock but since it can't leave the CPU
  it will never complete its task.

We could fire the unplug thread after the notifier but then the cpu is
no longer marked "online" and the unplug thread will run on CPU0 which
was fixed before :)

So instead the unplug thread is started and kept waiting until the
notfier complete their work.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cpu.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 295bf9d..22063f3 100644
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
 	struct hotplug_pcp *hp = data;
 
+	wait_for_completion(&hp->unplug_wait);
 	preempt_disable();
 	hp->unplug = current;
 	wait_for_pinned_cpus(hp);
@@ -245,6 +247,14 @@ static void __cpu_unplug_sync(struct hotplug_pcp *hp)
 	wait_for_completion(&hp->synced);
 }
 
+static void __cpu_unplug_wait(unsigned int cpu)
+{
+	struct hotplug_pcp *hp = &per_cpu(hotplug_pcp, cpu);
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
 
 	init_completion(&hp->synced);
+	init_completion(&hp->unplug_wait);
 
 	hp->sync_tsk = kthread_create(sync_unplug_thread, hp, "sync_unplug/%d", cpu);
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
 
@@ -590,6 +600,8 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
 		goto out_release;
 	}
 
+	__cpu_unplug_wait(cpu);
+
 	/* Notifiers are done. Don't let any more tasks pin this CPU. */
 	cpu_unplug_sync(cpu);
 
-- 
1.7.10.4
