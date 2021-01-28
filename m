Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01551C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jan 2021 01:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95DE64DD1
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jan 2021 01:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhA1BtM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Jan 2021 20:49:12 -0500
Received: from ptr.189.cn ([183.61.185.101]:10948 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbhA1BtI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Jan 2021 20:49:08 -0500
X-Greylist: delayed 639 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 20:49:07 EST
HMM_SOURCE_IP: 10.64.10.45:46020.92961643
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.10.45])
        by 189.cn (HERMES) with SMTP id E5BC81009B8;
        Thu, 28 Jan 2021 09:35:06 +0800 (CST)
Received: from  ([10.64.8.34])
        by gateway-151646-dep-54888d799-vh9dt with ESMTP id ade7fa247f284845bd3a2edc94e5c5d2 for rostedt@goodmis.org;
        Thu Jan 28 09:35:06 2021
X-Transaction-ID: ade7fa247f284845bd3a2edc94e5c5d2
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 10.64.8.34
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Song Chen <chensong_2000@189.cn>
Subject: [PATCH] kernel: trace: preemptirq_delay_test: add cpu affinity
Date:   Thu, 28 Jan 2021 09:35:13 +0800
Message-Id: <1611797713-20965-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The kernel thread executing test can run on any cpu, which might be
different cpu latency tracer is running on, as a result, the
big latency caused by preemptirq delay test can't be detected.

Therefore, the argument cpu_affinity is added to be passed to test,
ensure it's running on the same cpu with latency tracer.

e.g.
cyclictest -p 90 -m -c 0 -i 1000 -a 3
modprobe preemptirq_delay_test test_mode=preempt delay=500 \
burst_size=3 cpu_affinity=3

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/trace/Kconfig                 |  4 ++++
 kernel/trace/preemptirq_delay_test.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index c1a62ae..44dd5c0 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -886,6 +886,10 @@ config PREEMPTIRQ_DELAY_TEST
 	  irq-disabled critical sections for 500us:
 	  modprobe preemptirq_delay_test test_mode=irq delay=500 burst_size=3
 
+	  What's more, if you want to attach the test on the cpu which the latency
+	  tracer is running on, specify cpu_affinity=cpu_num at the end of the
+	  command.
+
 	  If unsure, say N
 
 config SYNTH_EVENT_GEN_TEST
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 312d1a0..8c4ffd0 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -21,13 +21,16 @@
 static ulong delay = 100;
 static char test_mode[12] = "irq";
 static uint burst_size = 1;
+static int  cpu_affinity = -1;
 
 module_param_named(delay, delay, ulong, 0444);
 module_param_string(test_mode, test_mode, 12, 0444);
 module_param_named(burst_size, burst_size, uint, 0444);
+module_param_named(cpu_affinity, cpu_affinity, int, 0444);
 MODULE_PARM_DESC(delay, "Period in microseconds (100 us default)");
 MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt, irq, or alternate (default irq)");
 MODULE_PARM_DESC(burst_size, "The size of a burst (default 1)");
+MODULE_PARM_DESC(cpu_affinity, "Cpu num test is running on");
 
 static struct completion done;
 
@@ -36,7 +39,9 @@ static struct completion done;
 static void busy_wait(ulong time)
 {
 	u64 start, end;
+
 	start = trace_clock_local();
+
 	do {
 		end = trace_clock_local();
 		if (kthread_should_stop())
@@ -47,6 +52,7 @@ static void busy_wait(ulong time)
 static __always_inline void irqoff_test(void)
 {
 	unsigned long flags;
+
 	local_irq_save(flags);
 	busy_wait(delay);
 	local_irq_restore(flags);
@@ -113,6 +119,14 @@ static int preemptirq_delay_run(void *data)
 {
 	int i;
 	int s = MIN(burst_size, NR_TEST_FUNCS);
+	struct cpumask cpu_mask;
+
+	if (cpu_affinity > -1) {
+		cpumask_clear(&cpu_mask);
+		cpumask_set_cpu(cpu_affinity, &cpu_mask);
+		if (set_cpus_allowed_ptr(current, &cpu_mask))
+			pr_err("cpu_affinity:%d, failed\n", cpu_affinity);
+	}
 
 	for (i = 0; i < s; i++)
 		(testfuncs[i])(i);
-- 
2.7.4

