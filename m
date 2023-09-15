Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF710EDE989
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Sep 2023 02:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjIOCc3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 22:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjIOCc2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Sep 2023 22:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 189C9268E
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Sep 2023 19:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694745105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5L+Jn0F7zLb52RidADD9lkM9eBiKlAbRiVsnymoszvs=;
        b=Am/Pf5gBZ74MyMd6WfcMPfV9t0BGrp6H9ox2nafXZ7VE+bakQ2RUXlYnczb2ubfxPqLrm3
        FTNjikINY62kX7k3x9Og8ckE4vWRTAScANWAeKsOwPpZtXoLpTqAEyyRvYqFZ1ZMfwJWmV
        h64GgkYxVLdQXqOjCXhq8pmL0v5lVYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-d90y6dWZNbCDZOu6fdG_bQ-1; Thu, 14 Sep 2023 22:31:42 -0400
X-MC-Unique: d90y6dWZNbCDZOu6fdG_bQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 452C3857A9C;
        Fri, 15 Sep 2023 02:31:41 +0000 (UTC)
Received: from localhost (unknown [10.22.17.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D825C40C2070;
        Fri, 15 Sep 2023 02:31:40 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Wang Yong <wang.yong12@zte.com.cn>,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 1/2] arm64: signal: Use ARCH_RT_DELAYS_SIGNAL_SEND
Date:   Thu, 14 Sep 2023 23:31:34 -0300
Message-ID: <20230915023135.201399-2-lgoncalv@redhat.com>
In-Reply-To: <20230915023135.201399-1-lgoncalv@redhat.com>
References: <20230915023135.201399-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Wang Yong <wang.yong12@zte.com.cn>

v5.10.194-rt95-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


The ltp test prompts the following bug information under the 5.10 kernel:
BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 796, name: cat
Preemption disabled at:
[<ffffffe40f433980>] do_debug_exception+0x60/0x180
CPU: 3 PID: 796 Comm: cat Not tainted 5.10.59-rt52-KERNEL_VERSION #38
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x198
 show_stack+0x20/0x30
 dump_stack+0xf0/0x13c
 ___might_sleep+0x140/0x178
 rt_spin_lock+0x30/0x90
 force_sig_info_to_task+0x30/0xe0
 force_sig_fault_to_task+0x54/0x78
 force_sig_fault+0x1c/0x28
 arm64_force_sig_fault+0x48/0x78
 send_user_sigtrap+0x4c/0x80
 brk_handler+0x3c/0x68
 do_debug_exception+0xac/0x180
 el0_dbg+0x34/0x58
 el0_sync_handler+0x50/0xb8
 el0_sync+0x180/0x1c0

It has been fixed by
0c34700de5e7 ("arm64: signal: Use ARCH_RT_DELAYS_SIGNAL_SEND.") in
higher versions of the kernel. This patch needs to be compatible with 5.10.
5.10 kernel does not have signal.h file, so adding signal.h file to
define ARCH_RT_DELAYS_SIGNAL_SEND.

Link: https://lore.kernel.org/r/202309121514283793475@zte.com.cn
Signed-off-by: Wang Yong <wang.yong12@zte.com.cn>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 arch/arm64/include/asm/signal.h | 12 ++++++++++++
 arch/arm64/kernel/signal.c      |  9 +++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/arm64/include/asm/signal.h

diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/signal.h
new file mode 100644
index 000000000000..0fb418cf4c17
--- /dev/null
+++ b/arch/arm64/include/asm/signal.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_ASM_SIGNAL_H
+#define __ARM64_ASM_SIGNAL_H
+
+#include <uapi/asm/signal.h>
+#include <uapi/asm/siginfo.h>
+
+#if defined(CONFIG_PREEMPT_RT)
+#define ARCH_RT_DELAYS_SIGNAL_SEND
+#endif
+
+#endif
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 94eed0dc3afc..5b08f55ec85d 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -929,6 +929,15 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		} else {
 			local_daif_restore(DAIF_PROCCTX);
 
+#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
+			if (unlikely(current->forced_info.si_signo)) {
+				struct task_struct *t = current;
+
+				force_sig_info(&t->forced_info);
+				t->forced_info.si_signo = 0;
+			}
+#endif
+
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);
 
-- 
2.41.0

