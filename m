From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/1] Workaround to access sysfs cpufreq variables
Date: Mon, 16 Feb 2015 16:41:47 +0100
Message-ID: <20150216155056.597280203@osadl.org>
References: <20150216145826.GD21649@linutronix.de>
 <20150216154146.703580675@osadl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:33130 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755730AbbBPPxL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Feb 2015 10:53:11 -0500
Content-Disposition: inline; filename=drivers-cpufreq-disregard-lock-if-own-pid.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Any attempt to write to one of the sysfs cpufreq variables results in a
write error such as

# echo performance >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
-bash: echo: write error: Invalid argument

that is caused by lock contention. This patch is not a solution but a
workaround to demonstrate the situation.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
 drivers/cpufreq/cpufreq.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: linux-3.18.7-rt1/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-3.18.7-rt1.orig/drivers/cpufreq/cpufreq.c
+++ linux-3.18.7-rt1/drivers/cpufreq/cpufreq.c
@@ -205,8 +205,16 @@ struct cpufreq_policy *cpufreq_cpu_get(u
 	if (cpufreq_disabled() || (cpu >= nr_cpu_ids))
 		return NULL;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return NULL;
+	if (!down_read_trylock(&cpufreq_rwsem)) {
+		struct rt_mutex *rtm = &cpufreq_rwsem.lock;
+		struct task_struct *owner = rtm->owner;
+		if (owner->pid != current->pid) {
+			printk(KERN_INFO
+			    "%s: owner->pid %d (%s), current->pid %d\n",
+			    __func__, owner->pid, owner->comm, current->pid);
+			return NULL;
+		}
+	}
 
 	/* get the cpufreq driver */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);

