Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B906C433FF
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001292189D
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294082;
	bh=Wl/v+kMqCliTAzEFxqwHO5PoV20HmLtR8YI/gRJZrzg=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=xu13gmgAbHa8s33tfEDzDvrgNTpq/kTZhvpKCbo3KT6qlskLG0oUIobjalLpnyE1v
	 i2Tc+Bj99ZrGX+J5wveBS8u3zbOpuwReL+8n373GUQGc0b/Z810jfoRwW4GrZb3paT
	 Kl3UYqEDnuRpQU4w3Hp8aNHsq/ZUUVenqqGr9foE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390391AbfHHTyk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404296AbfHHTxN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:13 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785DB214C6;
        Thu,  8 Aug 2019 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293992;
        bh=Wl/v+kMqCliTAzEFxqwHO5PoV20HmLtR8YI/gRJZrzg=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Ds/D0d4oB7ZlRWIwUzjkuZx/eERIVktaq70pb0OzVrfcra0M9XY9Oj+RNDAjNABbt
         HWY6SXtN1AWJMLkwUhVy5qYNjFH0dajNQdyvxZ5Z1ppIGoOKJ2hm9K0LM+kAdLtXw8
         fjAetiGBA13eLvPlo97SCh9TZnQQajfEuMGHXFbw=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 03/19] genirq: Do not invoke the affinity callback via a workqueue on RT
Date:   Thu,  8 Aug 2019 14:52:31 -0500
Message-Id: <16a19c7974fd531ce68182de87fc7314db33117b.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 2122adbe011cdc0eb62ad62494e181005b23c76a ]

Joe Korty reported, that __irq_set_affinity_locked() schedules a
workqueue while holding a rawlock which results in a might_sleep()
warning.
This patch uses swork_queue() instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	include/linux/interrupt.h
	kernel/irq/manage.c
---
 include/linux/interrupt.h |  5 ++---
 kernel/irq/manage.c       | 19 ++++---------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 0f25fa19b2d8..233e3c027f53 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -15,7 +15,7 @@
 #include <linux/hrtimer.h>
 #include <linux/kref.h>
 #include <linux/workqueue.h>
-#include <linux/swork.h>
+#include <linux/kthread.h>
 
 #include <linux/atomic.h>
 #include <asm/ptrace.h>
@@ -230,7 +230,6 @@ extern void resume_device_irqs(void);
  * struct irq_affinity_notify - context for notification of IRQ affinity changes
  * @irq:		Interrupt to which notification applies
  * @kref:		Reference count, for internal use
- * @swork:		Swork item, for internal use
  * @work:		Work item, for internal use
  * @notify:		Function to be called on change.  This will be
  *			called in process context.
@@ -243,7 +242,7 @@ struct irq_affinity_notify {
 	unsigned int irq;
 	struct kref kref;
 #ifdef CONFIG_PREEMPT_RT_BASE
-	struct swork_event swork;
+	struct kthread_work work;
 #else
 	struct work_struct work;
 #endif
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f9415590661c..3d5b33fe874b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -228,7 +228,7 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 		kref_get(&desc->affinity_notify->kref);
 
 #ifdef CONFIG_PREEMPT_RT_BASE
-		swork_queue(&desc->affinity_notify->swork);
+		kthread_schedule_work(&desc->affinity_notify->work);
 #else
 		schedule_work(&desc->affinity_notify->work);
 #endif
@@ -293,21 +293,11 @@ static void _irq_affinity_notify(struct irq_affinity_notify *notify)
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
 
@@ -350,8 +340,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
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
2.14.1

