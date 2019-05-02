Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD45C43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1C0214DA
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556824574;
	bh=zTKiB59yTAOgeXBzuwna1gvCfKgXqxqkpL/Tomsj28c=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=MnHGPZjRg7Z+m/IhiAMIQTxCHS4x0jAmAsFA/kJgJ3VfGHc41MkeFl5TNGBq9jOPJ
	 n9xFiKKr17pkTcC9zhSXvRpKCve/X5W4sTRs2FWSH1wBKTJj2e0XvyH9kOPgjPO7YG
	 OHkP+kWyNyOiLei/taQ6xQbWauArgblE1/L+pPw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfEBTQG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfEBTQF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:16:05 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C52962133F;
        Thu,  2 May 2019 19:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556824564;
        bh=zTKiB59yTAOgeXBzuwna1gvCfKgXqxqkpL/Tomsj28c=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ekPBI3vq7auZZwdZAild0WCJENM03KV6CnckxH933Qnzjv5Zl2jn2Ai4o+Y3HHvny
         ujCQFwFfRrInuGl0HmX7gDDv25/vkPyonq6hrwCUCSGyXXyxAfNAq13Vhh/u7qcMDG
         q077FNxphmKvNqejhVkUKyWnsWZWLX4ZeSSPgPm0=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 3/4] tty/sysrq: Convert show_lock to raw_spinlock_t
Date:   Thu,  2 May 2019 14:15:38 -0500
Message-Id: <7433082948d7d5062f1d3fbbcae07616a8e07a98.1556824516.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1556824516.git.tom.zanussi@linux.intel.com>
References: <cover.1556824516.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1556824516.git.tom.zanussi@linux.intel.com>
References: <cover.1556824516.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Julien Grall <julien.grall@arm.com>

v3.18.138-rt116-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


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

 Conflicts:
        drivers/tty/sysrq.c
---
 drivers/tty/sysrq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f97e7dac3a98..36ed02aa5575 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -206,7 +206,7 @@ static struct sysrq_key_op sysrq_showlocks_op = {
 #endif
 
 #ifdef CONFIG_SMP
-static DEFINE_SPINLOCK(show_lock);
+static DEFINE_RAW_SPINLOCK(show_lock);
 
 static void showacpu(void *dummy)
 {
@@ -216,10 +216,10 @@ static void showacpu(void *dummy)
 	if (idle_cpu(smp_processor_id()))
 		return;
 
-	spin_lock_irqsave(&show_lock, flags);
+	raw_spin_lock_irqsave(&show_lock, flags);
 	printk(KERN_INFO "CPU%d:\n", smp_processor_id());
 	show_stack(NULL, NULL);
-	spin_unlock_irqrestore(&show_lock, flags);
+	raw_spin_unlock_irqrestore(&show_lock, flags);
 }
 
 static void sysrq_showregs_othercpus(struct work_struct *dummy)
-- 
2.14.1

