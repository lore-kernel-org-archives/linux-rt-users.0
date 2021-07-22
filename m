Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56341C6377D
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jul 2021 17:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB8B61408
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jul 2021 17:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhGVRMh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:12:37 -0400
Received: from foss.arm.com ([217.140.110.172]:58010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhGVRMe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Jul 2021 13:12:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5706D11FB;
        Thu, 22 Jul 2021 10:53:09 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4030B3F73D;
        Thu, 22 Jul 2021 10:53:07 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64/fpsimd: Fix FPSIMD context handling vs PREEMPT_RT
Date:   Thu, 22 Jul 2021 18:51:57 +0100
Message-Id: <20210722175157.1367122-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722175157.1367122-1-valentin.schneider@arm.com>
References: <20210722175157.1367122-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Running v5.13-rt1 on my arm64 Juno board triggers:

[   11.337654] WARNING: CPU: 4 PID: 1 at arch/arm64/kernel/fpsimd.c:296 task_fpsimd_load (arch/arm64/kernel/fpsimd.c:296 (discriminator 1))
[   11.337692] Modules linked in:
[   11.337705] CPU: 4 PID: 1 Comm: init Not tainted 5.13.0-rt1 #52
[   11.337719] Hardware name: ARM Juno development board (r0) (DT)
[   11.337727] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
[   11.337740] pc : task_fpsimd_load (arch/arm64/kernel/fpsimd.c:296 (discriminator 1))
[   11.337755] lr : task_fpsimd_load (arch/arm64/kernel/fpsimd.c:296 (discriminator 3))
[   11.337769] sp : ffff800012f4bdd0
[   11.337775] x29: ffff800012f4bdd0 x28: ffff000800160000 x27: 0000000000000000
[   11.337797] x26: 0000000000000000 x25: 0000000000000000 x24: ffff0008001606f0
[   11.337816] x23: ffff000800160000 x22: ffff000800160700 x21: ffff000800160000
[   11.337837] x20: ffff800012f4beb0 x19: 0000000000000008 x18: 000000000000c9a0
[   11.337857] x17: 00000000ae3495d5 x16: 000000000000c9a0 x15: ffff80001240e128
[   11.337878] x14: ffff8000124b0128 x13: 000000000000000a x12: ffff80001205e5f0
[   11.337898] x11: 0000000000000000 x10: ffff800011a37d28 x9 : 0000000000000050
[   11.337917] x8 : ffff000800160000 x7 : 0000000000000002 x6 : 0000000000000000
[   11.337937] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[   11.337956] x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
[   11.337975] Call trace:
[   11.337980] task_fpsimd_load (arch/arm64/kernel/fpsimd.c:296 (discriminator 1))
[   11.337996] fpsimd_restore_current_state (arch/arm64/kernel/fpsimd.c:1186)
[   11.338012] do_notify_resume (./arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/signal.c:947)
[   11.338032] work_pending (arch/arm64/kernel/entry.S:839)
[   11.338045] irq event stamp: 1228377
[   11.338051] hardirqs last enabled at (1228375): _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:194)
[   11.338076] hardirqs last disabled at (1228377): el1_dbg (arch/arm64/kernel/entry-common.c:144 arch/arm64/kernel/entry-common.c:234)
[   11.338098] softirqs last enabled at (1227024): __local_bh_enable_ip (./arch/arm64/include/asm/irqflags.h:85 kernel/softirq.c:262)
[   11.338121] softirqs last disabled at (1228376): fpsimd_restore_current_state (./include/linux/bottom_half.h:19 arch/arm64/kernel/fpsimd.c:183 arch/arm64/kernel/fpsimd.c:1182)

This is caused by local_bh_disable() not disabling preemption under
CONFIG_PREEMPT_RT, which fails have_cpu_fpsimd_context(). The per-CPU
access safety proved by the CONFIG_PREEMPT_RT version of local_bh_disable()
is not sufficient here, as we end up with both preemption and IRQs enabled
when running do_notify_resume(). This means we can hit:

  el0_sync
  `\
    do_notify_resume()
    `\
      fpsimd_restore_current_state()

  ~~> el1_irq
      `\
	preempt_schedule_irq()
	`\
	  fpsimd_thread_switch()

IOW we *really* need to disable preemption here, even on CONFIG_PREEMPT_RT.

The preempt_{enable, disable}_bh() helpers exist to handle this exact case,
so use them here. This is spiritually close to:

  cba08c5dc6dc ("x86/fpu: Make kernel FPU protection RT friendly")

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 9bf86cd7b605..0c66ea0dd97e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -177,10 +177,12 @@ static void __get_cpu_fpsimd_context(void)
  *
  * The double-underscore version must only be called if you know the task
  * can't be preempted.
+ *
+ * Disabling preemption prevents nesting via fpsimd_thread_switch().
  */
 static void get_cpu_fpsimd_context(void)
 {
-	local_bh_disable();
+	preempt_disable_bh();
 	__get_cpu_fpsimd_context();
 }
 
@@ -201,7 +203,7 @@ static void __put_cpu_fpsimd_context(void)
 static void put_cpu_fpsimd_context(void)
 {
 	__put_cpu_fpsimd_context();
-	local_bh_enable();
+	preempt_enable_bh();
 }
 
 static bool have_cpu_fpsimd_context(void)
-- 
2.25.1

