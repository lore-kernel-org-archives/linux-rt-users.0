From: Joe Korty <joe.korty@ccur.com>
Subject: [PATCH] fix might sleep oops in irq affinity callback hook
Date: Tue, 20 Aug 2013 13:59:18 -0400
Message-ID: <20130820175918.GA18125@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from flusers.ccur.com ([173.221.59.2]:60323 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751442Ab3HTR7W (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Aug 2013 13:59:22 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Fix might_sleep oops in the irq affinity notifier logic.

Bug was due to the generic support function
irq_set_affinity() invoking schedule_work() underneath
a raw spin lock.  Our workaround is to move the
schedule_work() down a few lines to where the lock has
just been dropped.  This may not be ideal, as the resultant
code is a bit ugly.

This bug was discovered when the sfc networking driver
was loaded.  Perusal of the kernel source shows that the
mellanox and infiniband drivers are also likely to suffer
from this problem.

(applies to 3.6.11.6-rt38, appears to be applicable to
all later rt's and I expect it is valid for all earlier
rt's as well).

Signed-off-by: Joe Korty <joe.korty@ccur.com>

Index: b/kernel/irq/manage.c
===================================================================
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -163,7 +163,7 @@ int irq_do_set_affinity(struct irq_data 
 	return ret;
 }
 
-int __irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask)
+static int __irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask)
 {
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	struct irq_desc *desc = irq_data_to_desc(data);
@@ -179,10 +179,6 @@ int __irq_set_affinity_locked(struct irq
 		irq_copy_pending(desc, mask);
 	}
 
-	if (desc->affinity_notify) {
-		kref_get(&desc->affinity_notify->kref);
-		schedule_work(&desc->affinity_notify->work);
-	}
 	irqd_set(data, IRQD_AFFINITY_SET);
 
 	return ret;
@@ -205,7 +201,14 @@ int irq_set_affinity(unsigned int irq, c
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	ret =  __irq_set_affinity_locked(irq_desc_get_irq_data(desc), mask);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
+
+	if (!ret && desc->affinity_notify) {
+		kref_get(&desc->affinity_notify->kref);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+		schedule_work(&desc->affinity_notify->work);
+	} else
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+
 	return ret;
 }
 
Index: b/include/linux/irq.h
===================================================================
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -381,7 +381,6 @@ extern void remove_percpu_irq(unsigned i
 
 extern void irq_cpu_online(void);
 extern void irq_cpu_offline(void);
-extern int __irq_set_affinity_locked(struct irq_data *data,  const struct cpumask *cpumask);
 
 #ifdef CONFIG_GENERIC_HARDIRQS
 
