Return-Path: <SRS0=4wg/=VM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6F6C7618F
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Jul 2019 20:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E6A20665
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Jul 2019 20:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfGOUZD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:25:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731055AbfGOUZD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Jul 2019 16:25:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62F673081244;
        Mon, 15 Jul 2019 20:25:02 +0000 (UTC)
Received: from torg.redhat.com (ovpn-121-239.rdu2.redhat.com [10.10.121.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 958225D721;
        Mon, 15 Jul 2019 20:25:01 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        RT List <linux-rt-users@vger.kernel.org>
Subject: [PATCH] x86_pkg_temp_thermal: make pkg_temp_lock a raw spinlock
Date:   Mon, 15 Jul 2019 15:25:00 -0500
Message-Id: <20190715202500.6742-1-williams@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 15 Jul 2019 20:25:02 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The spinlock pkg_temp_lock has the potential of being taken in atomic
context on v5.2-rt PREEMPT_RT. It's static and limited scope so
go ahead and make it a raw spinlock.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 24 ++++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 319b77126168..92ceed3de6f3 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -63,7 +63,7 @@ static int max_packages __read_mostly;
 /* Array of package pointers */
 static struct pkg_device **packages;
 /* Serializes interrupt notification, work and hotplug */
-static DEFINE_SPINLOCK(pkg_temp_lock);
+static DEFINE_RAW_SPINLOCK(pkg_temp_lock);
 /* Protects zone operation in the work function against hotplug removal */
 static DEFINE_MUTEX(thermal_zone_mutex);
 
@@ -279,12 +279,12 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
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
@@ -298,7 +298,7 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	}
 
 	enable_pkg_thres_interrupt();
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/*
 	 * If tzone is not NULL, then thermal_zone_mutex will prevent the
@@ -323,7 +323,7 @@ static int pkg_thermal_notify(u64 msr_val)
 	struct pkg_device *pkgdev;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pkg_temp_lock, flags);
+	raw_spin_lock_irqsave(&pkg_temp_lock, flags);
 	++pkg_interrupt_cnt;
 
 	disable_pkg_thres_interrupt();
@@ -335,7 +335,7 @@ static int pkg_thermal_notify(u64 msr_val)
 		pkg_thermal_schedule_work(pkgdev->cpu, &pkgdev->work);
 	}
 
-	spin_unlock_irqrestore(&pkg_temp_lock, flags);
+	raw_spin_unlock_irqrestore(&pkg_temp_lock, flags);
 	return 0;
 }
 
@@ -381,9 +381,9 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	      pkgdev->msr_pkg_therm_high);
 
 	cpumask_set_cpu(cpu, &pkgdev->cpumask);
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 	packages[pkgid] = pkgdev;
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 	return 0;
 }
 
@@ -420,7 +420,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	}
 
 	/* Protect against work and interrupts */
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 
 	/*
 	 * Check whether this cpu was the current target and store the new
@@ -452,9 +452,9 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
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
@@ -465,7 +465,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 			pkg_thermal_schedule_work(target, &pkgdev->work);
 	}
 
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
 	if (lastcpu)
-- 
2.21.0

