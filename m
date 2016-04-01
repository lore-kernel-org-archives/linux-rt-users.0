From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RT] Warning from swake_up_all_locked in rt-4.4.4-rt11
Date: Fri, 1 Apr 2016 12:33:18 +0200
Message-ID: <20160401103318.GA29603@linutronix.de>
References: <20160313225358.4eb9316a@sluggy.hsv.redhat.com>
 <alpine.DEB.2.11.1603140948560.3657@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clark Williams <williams@redhat.com>,
	Daniel Wagner <wagi@monom.org>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52959 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbcDAKdX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Apr 2016 06:33:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1603140948560.3657@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Thomas Gleixner | 2016-03-14 09:49:52 [+0100]:

>On Sun, 13 Mar 2016, Clark Williams wrote:
>
>> I'm hitting the WARN_ON(wakes > 2) in $SUBJECT when resuming from suspend on my laptop (quad-core i7 with HT on). Looks like the warning gets hit 36 times on resume. E.g.:
>If resume is the only case, then we can filter that out and not worry about it
>at all :)

This works with the "mem" and "disk" target:

--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -194,6 +194,12 @@ struct platform_freeze_ops {
 	void (*end)(void);
 };
 
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+extern bool pm_in_action;
+#else
+# define pm_in_action false
+#endif
+
 #ifdef CONFIG_SUSPEND
 /**
  * suspend_set_ops - set platform dependent suspend operations
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index bfd9e0982f15..fbb23f93e8d6 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -648,6 +648,10 @@ static void power_down(void)
 		cpu_relax();
 }
 
+#ifndef CONFIG_SUSPEND
+bool pm_in_action;
+#endif
+
 /**
  * hibernate - Carry out system hibernation, including saving the image.
  */
@@ -660,6 +664,8 @@ int hibernate(void)
 		return -EPERM;
 	}
 
+	pm_in_action = true;
+
 	lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
@@ -725,6 +731,7 @@ int hibernate(void)
 	atomic_inc(&snapshot_device_available);
  Unlock:
 	unlock_system_sleep();
+	pm_in_action = false;
 	return error;
 }
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 80ebc0726290..393bc342c586 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -522,6 +522,8 @@ static int enter_state(suspend_state_t state)
 	return error;
 }
 
+bool pm_in_action;
+
 /**
  * pm_suspend - Externally visible function for suspending the system.
  * @state: System sleep state to enter.
@@ -536,6 +538,8 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
+	pm_in_action = true;
+
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
@@ -543,6 +547,7 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+	pm_in_action = false;
 	return error;
 }
 EXPORT_SYMBOL(pm_suspend);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 8459561f0379..205fe36868f9 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -1,5 +1,6 @@
 #include <linux/sched.h>
 #include <linux/swait.h>
+#include <linux/suspend.h>
 
 void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
 			     struct lock_class_key *key)
@@ -42,7 +43,9 @@ void swake_up_all_locked(struct swait_queue_head *q)
 		list_del_init(&curr->task_list);
 		wakes++;
 	}
-	WARN_ON(wakes > 2);
+	if (pm_in_action)
+		return;
+	WARN(wakes > 2, "complate_all() with %d waiters\n", wakes);
 }
 EXPORT_SYMBOL(swake_up_all_locked);
 
Sebastian
