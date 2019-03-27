Return-Path: <SRS0=WElg=R6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E537C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Mar 2019 18:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78ADF204FD
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Mar 2019 18:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391724AbfC0SdX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:33:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51487 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390945AbfC0SdX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Mar 2019 14:33:23 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9DMM-0004Tc-OB; Wed, 27 Mar 2019 19:33:10 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/4] printk: An all-in-one commit to fix build failures
Date:   Wed, 27 Mar 2019 19:33:07 +0100
Message-Id: <20190327183310.1015-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320171511.icjhdlulgal2yeho@linutronix.de>
References: <20190320171511.icjhdlulgal2yeho@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

This commit contains addresses several build failures which were
reported by the kbuild test robot.
The fixes were folded into the original commits.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/traps.c    |  1 -
 arch/powerpc/kernel/watchdog.c |  5 -----
 kernel/printk/printk.c         | 16 ++++++++++++++--
 lib/printk_ringbuffer.c        |  8 +++++++-
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 7a1de34f38c85..314be8e39d1fd 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -174,7 +174,6 @@ extern void panic_flush_kmsg_start(void)
 
 extern void panic_flush_kmsg_end(void)
 {
-	printk_safe_flush_on_panic();
 	kmsg_dump(KMSG_DUMP_PANIC);
 	bust_spinlocks(0);
 	debug_locks_off();
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 3c6ab22a0c4e3..bf98181c5b309 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -181,11 +181,6 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 
 	wd_smp_unlock(&flags);
 
-	printk_safe_flush();
-	/*
-	 * printk_safe_flush() seems to require another print
-	 * before anything actually goes out to console.
-	 */
 	if (sysctl_hardlockup_all_cpu_backtrace)
 		trigger_allbutself_cpu_backtrace();
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5cfd8ea445362..997d07b6bf975 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -370,6 +370,18 @@ static u64 clear_seq;
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
 
+/* Return log buffer address */
+char *log_buf_addr_get(void)
+{
+	return printk_rb.buffer;
+}
+
+/* Return log buffer size */
+u32 log_buf_len_get(void)
+{
+	return (1 << printk_rb.size_bits);
+}
+
 /* human readable text of the record */
 static char *log_text(const struct printk_log *msg)
 {
@@ -1910,7 +1922,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 }
 EXPORT_SYMBOL(vprintk_emit);
 
-__printf(1, 0) int vprintk_func(const char *fmt, va_list args)
+static __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 {
 	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
 }
@@ -2684,7 +2696,7 @@ static int __init init_printk_kthread(void)
 }
 late_initcall(init_printk_kthread);
 
-int vprintk_deferred(const char *fmt, va_list args)
+static int vprintk_deferred(const char *fmt, va_list args)
 {
 	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
 }
diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
index ce33b5add5a17..9a31d7dbdc005 100644
--- a/lib/printk_ringbuffer.c
+++ b/lib/printk_ringbuffer.c
@@ -196,8 +196,14 @@ void prb_commit(struct prb_handle *h)
 
 	if (changed) {
 		atomic_long_inc(&rb->wq_counter);
-		if (wq_has_sleeper(rb->wq))
+		if (wq_has_sleeper(rb->wq)) {
+#ifdef CONFIG_IRQ_WORK
 			irq_work_queue(rb->wq_work);
+#else
+			if (!in_nmi())
+				wake_up_interruptible_all(rb->wq);
+#endif
+		}
 	}
 }
 
-- 
2.20.1

