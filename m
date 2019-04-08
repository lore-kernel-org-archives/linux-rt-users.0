Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18009C10F13
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2C620880
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750912;
	bh=Ff3TTc+LHwIZFC2i7NyGcQ8qDDWEAIHqM53xhMo5L90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=d598kaI3i6vhrO9iEb+4QR7JWgXsExhA5wBZkaxfix1miZ2+El66LYPIANm1KuTPr
	 qdeWolphBlaizVInHX32ozJd7J3bknOvKKRRDdZ2pFOUYt3oozkmw2A8O6wKhlifAG
	 SMqExr2rJy7KagjUQzof1mMhSNAQAV22Fk5YlLx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfDHTOh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbfDHTOh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:37 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2CAF21909;
        Mon,  8 Apr 2019 19:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750876;
        bh=Ff3TTc+LHwIZFC2i7NyGcQ8qDDWEAIHqM53xhMo5L90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PheQNAhVfmxIdwhrn2FwrE5F/kWjn86zWGPK4U6vGwdcD0DQcBxpFaMB2VvbPxUeB
         biDzgzvVRRmkK+zct7qg57gfxDPFGk0R4xIsdG2C3Mtq2tgi1oO1DKUTA5fLHrd8vo
         fsdYvNC3/nkXbF0O7+F+iUUbbO8LgU+ny9j4eYNc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 11/13] tty/sysrq: Convert show_lock to raw_spinlock_t
Date:   Mon,  8 Apr 2019 14:14:13 -0500
Message-Id: <835a07298fab3573e7c0973e47b5203ac5b5f5fc.1554737688.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.14.109-rt58-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Julien Grall <julien.grall@arm.com>

[ Upstream commit db80c207bffd0f49e984e9889ce62279bc3abd6c ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/tty/sysrq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 377b3592384e..5d1c6d496e2e 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -215,7 +215,7 @@ static struct sysrq_key_op sysrq_showlocks_op = {
 #endif
 
 #ifdef CONFIG_SMP
-static DEFINE_SPINLOCK(show_lock);
+static DEFINE_RAW_SPINLOCK(show_lock);
 
 static void showacpu(void *dummy)
 {
@@ -225,10 +225,10 @@ static void showacpu(void *dummy)
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
2.14.1

