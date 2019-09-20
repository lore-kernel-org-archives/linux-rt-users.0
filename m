Return-Path: <SRS0=GKw7=XP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4908AC49ED7
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Sep 2019 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26702218AE
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Sep 2019 21:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfITV43 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730462AbfITV4Y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Sep 2019 17:56:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C282173E;
        Fri, 20 Sep 2019 21:56:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iBQt4-0005Ir-1G; Fri, 20 Sep 2019 17:56:22 -0400
Message-Id: <20190920215621.921710766@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 20 Sep 2019 17:53:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC][PATCH RT 4/7] thermal: Defer thermal wakups to threads
References: <20190920215311.165260719@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Daniel Wagner <wagi@monom.org>

[ Upstream commit ad2408dc248fe58536eef5b2b5734d8f9d3a280b ]

On RT the spin lock in pkg_temp_thermal_platfrom_thermal_notify will
call schedule while we run in irq context.

[<ffffffff816850ac>] dump_stack+0x4e/0x8f
[<ffffffff81680f7d>] __schedule_bug+0xa6/0xb4
[<ffffffff816896b4>] __schedule+0x5b4/0x700
[<ffffffff8168982a>] schedule+0x2a/0x90
[<ffffffff8168a8b5>] rt_spin_lock_slowlock+0xe5/0x2d0
[<ffffffff8168afd5>] rt_spin_lock+0x25/0x30
[<ffffffffa03a7b75>] pkg_temp_thermal_platform_thermal_notify+0x45/0x134 [x86_pkg_temp_thermal]
[<ffffffff8103d4db>] ? therm_throt_process+0x1b/0x160
[<ffffffff8103d831>] intel_thermal_interrupt+0x211/0x250
[<ffffffff8103d8c1>] smp_thermal_interrupt+0x21/0x40
[<ffffffff8169415d>] thermal_interrupt+0x6d/0x80

Let's defer the work to a kthread.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: reoder init/denit position. TODO: flush swork on exit]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/thermal/x86_pkg_temp_thermal.c | 28 +++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 1ef937d799e4..82f21fd4afb0 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -29,6 +29,7 @@
 #include <linux/pm.h>
 #include <linux/thermal.h>
 #include <linux/debugfs.h>
+#include <linux/kthread.h>
 #include <asm/cpu_device_id.h>
 #include <asm/mce.h>
 
@@ -329,7 +330,7 @@ static void pkg_thermal_schedule_work(int cpu, struct delayed_work *work)
 	schedule_delayed_work_on(cpu, work, ms);
 }
 
-static int pkg_thermal_notify(u64 msr_val)
+static void pkg_thermal_notify_work(struct kthread_work *work)
 {
 	int cpu = smp_processor_id();
 	struct pkg_device *pkgdev;
@@ -348,8 +349,32 @@ static int pkg_thermal_notify(u64 msr_val)
 	}
 
 	spin_unlock_irqrestore(&pkg_temp_lock, flags);
+}
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+static DEFINE_KTHREAD_WORK(notify_work, pkg_thermal_notify_work);
+
+static int pkg_thermal_notify(u64 msr_val)
+{
+	kthread_schedule_work(&notify_work);
+	return 0;
+}
+
+static void pkg_thermal_notify_flush(void)
+{
+	kthread_flush_work(&notify_work);
+}
+
+#else  /* !CONFIG_PREEMPT_RT_FULL */
+
+static void pkg_thermal_notify_flush(void) { }
+
+static int pkg_thermal_notify(u64 msr_val)
+{
+	pkg_thermal_notify_work(NULL);
 	return 0;
 }
+#endif /* CONFIG_PREEMPT_RT_FULL */
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
@@ -548,6 +573,7 @@ static void __exit pkg_temp_thermal_exit(void)
 	platform_thermal_package_rate_control = NULL;
 
 	cpuhp_remove_state(pkg_thermal_hp_state);
+	pkg_thermal_notify_flush();
 	debugfs_remove_recursive(debugfs);
 	kfree(packages);
 }
-- 
2.20.1


