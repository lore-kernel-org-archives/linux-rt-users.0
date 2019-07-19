Return-Path: <SRS0=OCQz=VQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ED4C76196
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19012184E
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388820AbfGSVuA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Jul 2019 17:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388705AbfGSVt6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Jul 2019 17:49:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C3D121880;
        Fri, 19 Jul 2019 21:49:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hoalI-0007zl-Dl; Fri, 19 Jul 2019 17:49:56 -0400
Message-Id: <20190719214956.312858047@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Jul 2019 17:49:33 -0400
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
Subject: [PATCH RT 02/16] genirq: Do not invoke the affinity callback via a workqueue on RT
References: <20190719214931.700049248@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.59-rt24-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 2122adbe011cdc0eb62ad62494e181005b23c76a ]

Joe Korty reported, that __irq_set_affinity_locked() schedules a
workqueue while holding a rawlock which results in a might_sleep()
warning.
This patch uses swork_queue() instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/interrupt.h |  5 ++---
 kernel/irq/manage.c       | 19 ++++---------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 72333899f043..a9321f6429f2 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -13,7 +13,7 @@
 #include <linux/hrtimer.h>
 #include <linux/kref.h>
 #include <linux/workqueue.h>
-#include <linux/swork.h>
+#include <linux/kthread.h>
 
 #include <linux/atomic.h>
 #include <asm/ptrace.h>
@@ -228,7 +228,6 @@ extern void resume_device_irqs(void);
  * struct irq_affinity_notify - context for notification of IRQ affinity changes
  * @irq:		Interrupt to which notification applies
  * @kref:		Reference count, for internal use
- * @swork:		Swork item, for internal use
  * @work:		Work item, for internal use
  * @notify:		Function to be called on change.  This will be
  *			called in process context.
@@ -241,7 +240,7 @@ struct irq_affinity_notify {
 	unsigned int irq;
 	struct kref kref;
 #ifdef CONFIG_PREEMPT_RT_BASE
-	struct swork_event swork;
+	struct kthread_work work;
 #else
 	struct work_struct work;
 #endif
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7f4041357d2f..381305c48a0a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -261,7 +261,7 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 		kref_get(&desc->affinity_notify->kref);
 
 #ifdef CONFIG_PREEMPT_RT_BASE
-		swork_queue(&desc->affinity_notify->swork);
+		kthread_schedule_work(&desc->affinity_notify->work);
 #else
 		schedule_work(&desc->affinity_notify->work);
 #endif
@@ -326,21 +326,11 @@ static void _irq_affinity_notify(struct irq_affinity_notify *notify)
 }
 
 #ifdef CONFIG_PREEMPT_RT_BASE
-static void init_helper_thread(void)
-{
-	static int init_sworker_once;
-
-	if (init_sworker_once)
-		return;
-	if (WARN_ON(swork_get()))
-		return;
-	init_sworker_once = 1;
-}
 
-static void irq_affinity_notify(struct swork_event *swork)
+static void irq_affinity_notify(struct kthread_work *work)
 {
 	struct irq_affinity_notify *notify =
-		container_of(swork, struct irq_affinity_notify, swork);
+		container_of(work, struct irq_affinity_notify, work);
 	_irq_affinity_notify(notify);
 }
 
@@ -383,8 +373,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 		notify->irq = irq;
 		kref_init(&notify->kref);
 #ifdef CONFIG_PREEMPT_RT_BASE
-		INIT_SWORK(&notify->swork, irq_affinity_notify);
-		init_helper_thread();
+		kthread_init_work(&notify->work, irq_affinity_notify);
 #else
 		INIT_WORK(&notify->work, irq_affinity_notify);
 #endif
-- 
2.20.1


