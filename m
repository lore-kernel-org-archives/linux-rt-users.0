Return-Path: <SRS0=CUgu=T6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0933DC28CC0
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 11:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A862585A
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 11:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfE3LbK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 May 2019 07:31:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34700 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfE3LbK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 May 2019 07:31:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78B11374;
        Thu, 30 May 2019 04:31:07 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 853FF3F5AF;
        Thu, 30 May 2019 04:31:05 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, dave.martin@arm.com,
        Julien Grall <julien.grall@arm.com>
Subject: [PATCH] arm64/cpufeature: Convert hook_lock to raw_spin_lock_t in cpu_enable_ssbs()
Date:   Thu, 30 May 2019 12:30:58 +0100
Message-Id: <20190530113058.1988-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

cpu_enable_ssbs() is called via stop_machine() as part of the cpu_enable
callback. A spin lock is used to ensure the hook is registered before
the rest of the callback is executed.

On -RT spin_lock() may sleep. However, all the callees in stop_machine()
are expected to not sleep. Therefore a raw_spin_lock() is required here.

Given this is already done under stop_machine() and the work done under
the lock is quite small, the latency should not increase too much.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---

It was noticed when looking at the current use of spin_lock in
arch/arm64. I don't have a platform calling that callback, so I have
hacked the code to reproduce the error and check it is now fixed.
---
 arch/arm64/kernel/cpufeature.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ca27e08e3d8a..2a7159fda3ce 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1194,14 +1194,14 @@ static struct undef_hook ssbs_emulation_hook = {
 static void cpu_enable_ssbs(const struct arm64_cpu_capabilities *__unused)
 {
 	static bool undef_hook_registered = false;
-	static DEFINE_SPINLOCK(hook_lock);
+	static DEFINE_RAW_SPINLOCK(hook_lock);
 
-	spin_lock(&hook_lock);
+	raw_spin_lock(&hook_lock);
 	if (!undef_hook_registered) {
 		register_undef_hook(&ssbs_emulation_hook);
 		undef_hook_registered = true;
 	}
-	spin_unlock(&hook_lock);
+	raw_spin_unlock(&hook_lock);
 
 	if (arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE) {
 		sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_DSSBS);
-- 
2.11.0

