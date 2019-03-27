Return-Path: <SRS0=WElg=R6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2F3C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Mar 2019 18:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599D1204FD
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Mar 2019 18:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391418AbfC0Sdd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:33:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51485 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391481AbfC0SdR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Mar 2019 14:33:17 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9DMN-0004Tc-Dk; Wed, 27 Mar 2019 19:33:11 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/4] powerpc/stackprotector: work around stack-guard init from atomic
Date:   Wed, 27 Mar 2019 19:33:08 +0100
Message-Id: <20190327183310.1015-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327183310.1015-1-bigeasy@linutronix.de>
References: <20190320171511.icjhdlulgal2yeho@linutronix.de>
 <20190327183310.1015-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is invoked from the secondary CPU in atomic context. On x86 we use
tsc instead. On Power we XOR it against mftb() so lets use stack address
as the initial value.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/include/asm/stackprotector.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
index 1c8460e235838..e764eb4b6c284 100644
--- a/arch/powerpc/include/asm/stackprotector.h
+++ b/arch/powerpc/include/asm/stackprotector.h
@@ -24,7 +24,11 @@ static __always_inline void boot_init_stack_canary(void)
 	unsigned long canary;
 
 	/* Try to get a semi random initial value. */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	canary = (unsigned long)&canary;
+#else
 	canary = get_random_canary();
+#endif
 	canary ^= mftb();
 	canary ^= LINUX_VERSION_CODE;
 	canary &= CANARY_MASK;
-- 
2.20.1

