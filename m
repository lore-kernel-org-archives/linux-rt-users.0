From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.1.3-rt3
Date: Sat, 25 Jul 2015 12:32:30 +0200
Message-ID: <20150725103230.GA9470@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51736 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbbGYKcd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Jul 2015 06:32:33 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.1.3-rt3 patch set.
Changes since v4.1.3-rt2:

- fix compile of locktorture. Patch by Wolfgang M. Reimer.

- fix compile pid_namespace without lockdep on ARM. Patch by Grygorii
  Strashko

- The annoying "cpufreq_stat_notifier_trans: No policy found" is finally
  gone. 

- xor / raid_pq
  The max latency will increase into the ms range if the raid6_pq is
  loaded. This should not matter under normal circumstances because that
  module should only be loaded at boot time if required (and not while a
  -RT task is active in production). It might also get loaded at
  run-time manually. 
  Dropping the preempt_disable() might cause different results for the
  individual implementations. People who don't care (load it at
  run-time) don't need to load it at all. People who care (load it boot
  time) would prefer to stick with the best implementation.
  Therefore I think it is enough to document this (don't load it at run
  time if you don't need it) and I cross it off my list. Patches are
  welcome if someone needs / has an improvement.

Known issues:
 
- bcache is disabled.

- CPU hotplug works in general. Steven's test script however
  deadlocks usually on the second invocation.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-4.1.y-rt
    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-4.1.y-rt-rebase
    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-4.1.y-rt-queue

The delta patch against 4.0.8-rt5 is appended below and can be found here:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.3-rt2-rt3.patch.xz

The RT patch against 4.1.3 can be found here:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.3-rt3.patch.xz

The split quilt queue is available at:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patches-4.1.3-rt3.tar.xz

Sebastian

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8ae655c364f4..ce1d93e93d1a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -64,12 +64,6 @@ static inline bool has_target(void)
 	return cpufreq_driver->target_index || cpufreq_driver->target;
 }
 
-/*
- * rwsem to guarantee that cpufreq driver module doesn't unload during critical
- * sections
- */
-static DECLARE_RWSEM(cpufreq_rwsem);
-
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy,
 		unsigned int event);
@@ -215,9 +209,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	if (cpu >= nr_cpu_ids)
 		return NULL;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return NULL;
-
 	/* get the cpufreq driver */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 
@@ -230,9 +221,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	if (!policy)
-		up_read(&cpufreq_rwsem);
-
 	return policy;
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
@@ -240,7 +228,6 @@ EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
 void cpufreq_cpu_put(struct cpufreq_policy *policy)
 {
 	kobject_put(&policy->kobj);
-	up_read(&cpufreq_rwsem);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
 
@@ -765,9 +752,6 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return -EINVAL;
-
 	down_read(&policy->rwsem);
 
 	if (fattr->show)
@@ -776,7 +760,6 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 		ret = -EIO;
 
 	up_read(&policy->rwsem);
-	up_read(&cpufreq_rwsem);
 
 	return ret;
 }
@@ -793,9 +776,6 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	if (!cpu_online(policy->cpu))
 		goto unlock;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		goto unlock;
-
 	down_write(&policy->rwsem);
 
 	if (fattr->store)
@@ -804,8 +784,6 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 		ret = -EIO;
 
 	up_write(&policy->rwsem);
-
-	up_read(&cpufreq_rwsem);
 unlock:
 	put_online_cpus();
 
@@ -1117,16 +1095,12 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (unlikely(policy))
 		return 0;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return 0;
-
 	/* Check if this cpu was hot-unplugged earlier and has siblings */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 	for_each_policy(policy) {
 		if (cpumask_test_cpu(cpu, policy->related_cpus)) {
 			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 			ret = cpufreq_add_policy_cpu(policy, cpu, dev);
-			up_read(&cpufreq_rwsem);
 			return ret;
 		}
 	}
@@ -1269,8 +1243,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
 
-	up_read(&cpufreq_rwsem);
-
 	/* Callback for handling stuff after policy is ready */
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
@@ -1304,8 +1276,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	cpufreq_policy_free(policy);
 
 nomem_out:
-	up_read(&cpufreq_rwsem);
-
 	return ret;
 }
 
@@ -2499,19 +2469,20 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 
 	pr_debug("unregistering driver %s\n", driver->name);
 
+	/* Protect against concurrent cpu hotplug */
+	get_online_cpus();
 	subsys_interface_unregister(&cpufreq_interface);
 	if (cpufreq_boost_supported())
 		cpufreq_sysfs_remove_file(&boost.attr);
 
 	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
 
-	down_write(&cpufreq_rwsem);
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 
 	cpufreq_driver = NULL;
 
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-	up_write(&cpufreq_rwsem);
+	put_online_cpus();
 
 	return 0;
 }
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 23705a53abba..2cc64b779f03 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,6 +2,7 @@
 #define _LINUX_PID_H
 
 #include <linux/rcupdate.h>
+#include <linux/atomic.h>
 
 enum pid_type
 {
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ec8cce259779..aa60d919e336 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -24,7 +24,6 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/spinlock.h>
-#include <linux/rwlock.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/smp.h>
diff --git a/localversion-rt b/localversion-rt
index c3054d08a112..1445cd65885c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
