Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF70C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E3C246B0
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAWUjp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:39:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbgAWUjp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:39:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13E3424684;
        Thu, 23 Jan 2020 20:39:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iujGR-000mVx-0O; Thu, 23 Jan 2020 15:39:43 -0500
Message-Id: <20200123203942.890525265@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Jan 2020 15:39:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH RT 04/30] thermal/x86_pkg_temp: make pkg_temp_lock a raw spinlock
References: <20200123203930.646725253@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.94-rt39-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Clark Williams <williams@redhat.com>

[ Upstream commit 8b03bb3ea7861b70b506199a69b1c8f81fe2d4d0 ]

The spinlock pkg_temp_lock has the potential of being taken in atomic
context on v5.2-rt PREEMPT_RT. It's static and limited scope so
go ahead and make it a raw spinlock.

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/thermal/x86_pkg_temp_thermal.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 1ef937d799e4..540becb78a0f 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -75,7 +75,7 @@ static int max_packages __read_mostly;
 /* Array of package pointers */
 static struct pkg_device **packages;
 /* Serializes interrupt notification, work and hotplug */
-static DEFINE_SPINLOCK(pkg_temp_lock);
+static DEFINE_RAW_SPINLOCK(pkg_temp_lock);
 /* Protects zone operation in the work function against hotplug removal */
 static DEFINE_MUTEX(thermal_zone_mutex);
 
@@ -291,12 +291,12 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	u64 msr_val, wr_val;
 
 	mutex_lock(&thermal_zone_mutex);
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 	++pkg_work_cnt;
 
 	pkgdev = pkg_temp_thermal_get_dev(cpu);
 	if (!pkgdev) {
-		spin_unlock_irq(&pkg_temp_lock);
+		raw_spin_unlock_irq(&pkg_temp_lock);
 		mutex_unlock(&thermal_zone_mutex);
 		return;
 	}
@@ -310,7 +310,7 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	}
 
 	enable_pkg_thres_interrupt();
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/*
 	 * If tzone is not NULL, then thermal_zone_mutex will prevent the
@@ -335,7 +335,7 @@ static int pkg_thermal_notify(u64 msr_val)
 	struct pkg_device *pkgdev;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pkg_temp_lock, flags);
+	raw_spin_lock_irqsave(&pkg_temp_lock, flags);
 	++pkg_interrupt_cnt;
 
 	disable_pkg_thres_interrupt();
@@ -347,7 +347,7 @@ static int pkg_thermal_notify(u64 msr_val)
 		pkg_thermal_schedule_work(pkgdev->cpu, &pkgdev->work);
 	}
 
-	spin_unlock_irqrestore(&pkg_temp_lock, flags);
+	raw_spin_unlock_irqrestore(&pkg_temp_lock, flags);
 	return 0;
 }
 
@@ -393,9 +393,9 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	      pkgdev->msr_pkg_therm_high);
 
 	cpumask_set_cpu(cpu, &pkgdev->cpumask);
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 	packages[pkgid] = pkgdev;
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 	return 0;
 }
 
@@ -432,7 +432,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	}
 
 	/* Protect against work and interrupts */
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 
 	/*
 	 * Check whether this cpu was the current target and store the new
@@ -464,9 +464,9 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 		 * To cancel the work we need to drop the lock, otherwise
 		 * we might deadlock if the work needs to be flushed.
 		 */
-		spin_unlock_irq(&pkg_temp_lock);
+		raw_spin_unlock_irq(&pkg_temp_lock);
 		cancel_delayed_work_sync(&pkgdev->work);
-		spin_lock_irq(&pkg_temp_lock);
+		raw_spin_lock_irq(&pkg_temp_lock);
 		/*
 		 * If this is not the last cpu in the package and the work
 		 * did not run after we dropped the lock above, then we
@@ -477,7 +477,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 			pkg_thermal_schedule_work(target, &pkgdev->work);
 	}
 
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
 	if (lastcpu)
-- 
2.24.1


