Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C22BC63797
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jul 2021 17:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0354561380
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jul 2021 17:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhGVRMe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:12:34 -0400
Received: from foss.arm.com ([217.140.110.172]:57966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230074AbhGVRMa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Jul 2021 13:12:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2C2411B3;
        Thu, 22 Jul 2021 10:53:04 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C0CD3F73D;
        Thu, 22 Jul 2021 10:53:02 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, x86@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/3] sched/preempt: Introduce preempt_{enable, disable}_bh()
Date:   Thu, 22 Jul 2021 18:51:55 +0100
Message-Id: <20210722175157.1367122-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722175157.1367122-1-valentin.schneider@arm.com>
References: <20210722175157.1367122-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

As pointed out by commit:

  cba08c5dc6dc ("x86/fpu: Make kernel FPU protection RT friendly")

local_bh_disable() is not sufficient under CONFIG_PREEMPT_RT for FPU
manipulation. This also affects at least arm64, so package the preemption /
softirq enablement handling into a pair of helpers.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/bottom_half.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index eed86eb0a1de..dd98d8c1eb0a 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -19,6 +19,24 @@ static inline void local_bh_disable(void)
 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
+/*
+ * local_bh_disable() protects against both preemption and soft interrupts
+ * on !RT kernels.
+ *
+ * On RT kernels local_bh_disable() is not sufficient because it only
+ * serializes soft interrupt related sections via a local lock, but stays
+ * preemptible. Disabling preemption is the right choice here as bottom
+ * half processing is always in thread context on RT kernels so it
+ * implicitly prevents bottom half processing as well.
+ */
+static inline void preempt_disable_bh(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+	else
+		local_bh_disable();
+}
+
 extern void _local_bh_enable(void);
 extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
 
@@ -32,6 +50,14 @@ static inline void local_bh_enable(void)
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
+static inline void preempt_enable_bh(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+	else
+		local_bh_enable();
+}
+
 #ifdef CONFIG_PREEMPT_RT
 extern bool local_bh_blocked(void);
 #else
-- 
2.25.1

