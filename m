Return-Path: <SRS0=GKw7=XP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9DDC4CEC9
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Sep 2019 21:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD41D21907
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Sep 2019 21:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfITV4i (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730461AbfITV4Y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Sep 2019 17:56:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A558E20C01;
        Fri, 20 Sep 2019 21:56:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iBQt3-0005IN-SB; Fri, 20 Sep 2019 17:56:21 -0400
Message-Id: <20190920215621.753333463@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 20 Sep 2019 17:53:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [RFC][PATCH RT 3/7] revert-thermal
References: <20190920215311.165260719@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Revert: thermal: Defer thermal wakups to threads

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/thermal/x86_pkg_temp_thermal.c | 52 ++------------------------
 1 file changed, 3 insertions(+), 49 deletions(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index a5991cbb408f..1ef937d799e4 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -29,7 +29,6 @@
 #include <linux/pm.h>
 #include <linux/thermal.h>
 #include <linux/debugfs.h>
-#include <linux/swork.h>
 #include <asm/cpu_device_id.h>
 #include <asm/mce.h>
 
@@ -330,7 +329,7 @@ static void pkg_thermal_schedule_work(int cpu, struct delayed_work *work)
 	schedule_delayed_work_on(cpu, work, ms);
 }
 
-static void pkg_thermal_notify_work(struct swork_event *event)
+static int pkg_thermal_notify(u64 msr_val)
 {
 	int cpu = smp_processor_id();
 	struct pkg_device *pkgdev;
@@ -349,47 +348,9 @@ static void pkg_thermal_notify_work(struct swork_event *event)
 	}
 
 	spin_unlock_irqrestore(&pkg_temp_lock, flags);
-}
-
-#ifdef CONFIG_PREEMPT_RT_FULL
-static struct swork_event notify_work;
-
-static int pkg_thermal_notify_work_init(void)
-{
-	int err;
-
-	err = swork_get();
-	if (err)
-		return err;
-
-	INIT_SWORK(&notify_work, pkg_thermal_notify_work);
 	return 0;
 }
 
-static void pkg_thermal_notify_work_cleanup(void)
-{
-	swork_put();
-}
-
-static int pkg_thermal_notify(u64 msr_val)
-{
-	swork_queue(&notify_work);
-	return 0;
-}
-
-#else  /* !CONFIG_PREEMPT_RT_FULL */
-
-static int pkg_thermal_notify_work_init(void) { return 0; }
-
-static void pkg_thermal_notify_work_cleanup(void) {  }
-
-static int pkg_thermal_notify(u64 msr_val)
-{
-	pkg_thermal_notify_work(NULL);
-	return 0;
-}
-#endif /* CONFIG_PREEMPT_RT_FULL */
-
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
 	int pkgid = topology_logical_package_id(cpu);
@@ -554,16 +515,11 @@ static int __init pkg_temp_thermal_init(void)
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
-	if (!pkg_thermal_notify_work_init())
-		return -ENODEV;
-
 	max_packages = topology_max_packages();
 	packages = kcalloc(max_packages, sizeof(struct pkg_device *),
 			   GFP_KERNEL);
-	if (!packages) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!packages)
+		return -ENOMEM;
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "thermal/x86_pkg:online",
 				pkg_thermal_cpu_online,	pkg_thermal_cpu_offline);
@@ -581,7 +537,6 @@ static int __init pkg_temp_thermal_init(void)
 	return 0;
 
 err:
-	pkg_thermal_notify_work_cleanup();
 	kfree(packages);
 	return ret;
 }
@@ -595,7 +550,6 @@ static void __exit pkg_temp_thermal_exit(void)
 	cpuhp_remove_state(pkg_thermal_hp_state);
 	debugfs_remove_recursive(debugfs);
 	kfree(packages);
-	pkg_thermal_notify_work_cleanup();
 }
 module_exit(pkg_temp_thermal_exit)
 
-- 
2.20.1


