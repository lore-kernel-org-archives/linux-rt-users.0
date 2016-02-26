From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 01/10] cpufreq: Remove cpufreq_rwsem
Date: Fri, 26 Feb 2016 16:39:12 -0500
Message-ID: <20160226213931.130245130@goodmis.org>
References: <20160226213911.445523575@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-cpufreq-Remove-cpufreq_rwsem.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.54-rt73-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

cpufreq_rwsem was introduced in commit 6eed9404ab3c4 ("cpufreq: Use
rwsem for protecting critical sections) in order to replace
try_module_get() on the cpu-freq driver. That try_module_get() worked
well until the refcount was so heavily used that module removal became
more or less impossible.

Though when looking at the various (undocumented) protection
mechanisms in that code, the randomly sprinkeled around cpufreq_rwsem
locking sites are superfluous.

The policy, which is acquired in cpufreq_cpu_get() and released in
cpufreq_cpu_put() is sufficiently protected already.

  cpufreq_cpu_get(cpu)
    /* Protects against concurrent driver removal */
    read_lock_irqsave(&cpufreq_driver_lock, flags);
    policy = per_cpu(cpufreq_cpu_data, cpu);
    kobject_get(&policy->kobj);
    read_unlock_irqrestore(&cpufreq_driver_lock, flags);

The reference on the policy serializes versus module unload already:

  cpufreq_unregister_driver()
    subsys_interface_unregister()
      __cpufreq_remove_dev_finish()
        per_cpu(cpufreq_cpu_data) = NULL;
	cpufreq_policy_put_kobj()

If there is a reference held on the policy, i.e. obtained prior to the
unregister call, then cpufreq_policy_put_kobj() will wait until that
reference is dropped. So once subsys_interface_unregister() returns
there is no policy pointer in flight and no new reference can be
obtained. So that rwsem protection is useless.

The other usage of cpufreq_rwsem in show()/store() of the sysfs
interface is redundant as well because sysfs already does the proper
kobject_get()/put() pairs.

That leaves CPU hotplug versus module removal. The current
down_write() around the write_lock() in cpufreq_unregister_driver() is
silly at best as it protects actually nothing.

The trivial solution to this is to prevent hotplug across
cpufreq_unregister_driver completely.

[upstream: rafael/linux-pm 454d3a2500a4eb33be85dde3bfba9e5f6b5efadc]
[fixes: "cpufreq_stat_notifier_trans: No policy found" since v4.0-rt]
Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/cpufreq/cpufreq.c | 49 +++++++----------------------------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8356b481e339..012d5169eee2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -90,12 +90,6 @@ static void unlock_policy_rwsem_##mode(int cpu)				\
 unlock_policy_rwsem(read, cpu);
 unlock_policy_rwsem(write, cpu);
 
-/*
- * rwsem to guarantee that cpufreq driver module doesn't unload during critical
- * sections
- */
-static DECLARE_RWSEM(cpufreq_rwsem);
-
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy,
 		unsigned int event);
@@ -191,9 +185,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	if (cpufreq_disabled() || (cpu >= nr_cpu_ids))
 		return NULL;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return NULL;
-
 	/* get the cpufreq driver */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 
@@ -206,9 +197,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	if (!policy)
-		up_read(&cpufreq_rwsem);
-
 	return policy;
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
@@ -219,7 +207,6 @@ void cpufreq_cpu_put(struct cpufreq_policy *policy)
 		return;
 
 	kobject_put(&policy->kobj);
-	up_read(&cpufreq_rwsem);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
 
@@ -664,13 +651,10 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
 	struct freq_attr *fattr = to_attr(attr);
-	ssize_t ret = -EINVAL;
-
-	if (!down_read_trylock(&cpufreq_rwsem))
-		goto exit;
+	ssize_t ret;
 
 	if (lock_policy_rwsem_read(policy->cpu) < 0)
-		goto up_read;
+		return -EINVAL;
 
 	if (fattr->show)
 		ret = fattr->show(policy, buf);
@@ -679,9 +663,6 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 
 	unlock_policy_rwsem_read(policy->cpu);
 
-up_read:
-	up_read(&cpufreq_rwsem);
-exit:
 	return ret;
 }
 
@@ -697,11 +678,8 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	if (!cpu_online(policy->cpu))
 		goto unlock;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		goto unlock;
-
 	if (lock_policy_rwsem_write(policy->cpu) < 0)
-		goto up_read;
+		goto unlock;
 
 	if (fattr->store)
 		ret = fattr->store(policy, buf, count);
@@ -710,8 +688,6 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 
 	unlock_policy_rwsem_write(policy->cpu);
 
-up_read:
-	up_read(&cpufreq_rwsem);
 unlock:
 	put_online_cpus();
 
@@ -1011,9 +987,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 	}
 #endif
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return 0;
-
 #ifdef CONFIG_HOTPLUG_CPU
 	/* Check if this cpu was hot-unplugged earlier and has siblings */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
@@ -1021,7 +994,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 		if (cpumask_test_cpu(cpu, tpolicy->related_cpus)) {
 			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 			ret = cpufreq_add_policy_cpu(tpolicy, cpu, dev, frozen);
-			up_read(&cpufreq_rwsem);
 			return ret;
 		}
 	}
@@ -1035,7 +1007,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 		policy = cpufreq_policy_alloc();
 
 	if (!policy)
-		goto nomem_out;
+		return ret;
 
 
 	/*
@@ -1106,7 +1078,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 	cpufreq_init_policy(policy);
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
-	up_read(&cpufreq_rwsem);
 
 	pr_debug("initialization complete\n");
 
@@ -1120,8 +1091,6 @@ err_out_unregister:
 
 err_set_policy_cpu:
 	cpufreq_policy_free(policy);
-nomem_out:
-	up_read(&cpufreq_rwsem);
 
 	return ret;
 }
@@ -1474,9 +1443,6 @@ unsigned int cpufreq_get(unsigned int cpu)
 	if (cpufreq_disabled() || !cpufreq_driver)
 		return -ENOENT;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return 0;
-
 	if (unlikely(lock_policy_rwsem_read(cpu)))
 		goto out_policy;
 
@@ -1485,8 +1451,6 @@ unsigned int cpufreq_get(unsigned int cpu)
 	unlock_policy_rwsem_read(cpu);
 
 out_policy:
-	up_read(&cpufreq_rwsem);
-
 	return ret_freq;
 }
 EXPORT_SYMBOL(cpufreq_get);
@@ -2184,16 +2148,17 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 
 	pr_debug("unregistering driver %s\n", driver->name);
 
+	/* Protect against concurrent cpu hotplug */
+	get_online_cpus();
 	subsys_interface_unregister(&cpufreq_interface);
 	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
 
-	down_write(&cpufreq_rwsem);
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 
 	cpufreq_driver = NULL;
 
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-	up_write(&cpufreq_rwsem);
+	put_online_cpus();
 
 	return 0;
 }
-- 
2.7.0
