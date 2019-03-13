Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32185C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BADA2183F
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 11:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCMLkr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:40:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56542 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfCMLkr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 07:40:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8258680D;
        Wed, 13 Mar 2019 04:40:46 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0779D3F71D;
        Wed, 13 Mar 2019 04:40:44 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     jslaby@suse.com, gregkh@linuxfoundation.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, Julien Grall <julien.grall@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] tty/sysrq: Convert show_lock to raw_spinlock_t
Date:   Wed, 13 Mar 2019 11:40:34 +0000
Message-Id: <20190313114034.12408-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Systems which don't provide arch_trigger_cpumask_backtrace() will
invoke showacpu() from a smp_call_function() function which is invoked
with disabled interrupts even on -RT systems.

The function acquires the show_lock lock which only purpose is to
ensure that the CPUs don't print simultaneously. Otherwise the
output would clash and it would be hard to tell the output from CPUx
apart from CPUy.

On -RT the spin_lock() can not be acquired from this context. A
raw_spin_lock() is required. It will introduce the system's latency
by performing the sysrq request and other CPUs will block on the lock
until the request is done. This is okay because the user asked for a
backtrace of all active CPUs and under "normal circumstances in
production" this path should not be triggered.

Signed-off-by: Julien Grall <julien.grall@arm.com>
[bigeasy@linuxtronix.de: commit description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

---
    Changes in v2:
        - Update commit description
        - Add Sebastian's acked-by
---
 drivers/tty/sysrq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index fa0ce7dd9e24..59e82e6d776d 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -208,7 +208,7 @@ static struct sysrq_key_op sysrq_showlocks_op = {
 #endif
 
 #ifdef CONFIG_SMP
-static DEFINE_SPINLOCK(show_lock);
+static DEFINE_RAW_SPINLOCK(show_lock);
 
 static void showacpu(void *dummy)
 {
@@ -218,10 +218,10 @@ static void showacpu(void *dummy)
 	if (idle_cpu(smp_processor_id()))
 		return;
 
-	spin_lock_irqsave(&show_lock, flags);
+	raw_spin_lock_irqsave(&show_lock, flags);
 	pr_info("CPU%d:\n", smp_processor_id());
 	show_stack(NULL, NULL);
-	spin_unlock_irqrestore(&show_lock, flags);
+	raw_spin_unlock_irqrestore(&show_lock, flags);
 }
 
 static void sysrq_showregs_othercpus(struct work_struct *dummy)
-- 
2.11.0

