Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A227C04A95
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Sep 2022 10:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiIYKev (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 25 Sep 2022 06:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiIYKet (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 25 Sep 2022 06:34:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B92EE0A;
        Sun, 25 Sep 2022 03:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664102084; x=1695638084;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AzjMN8M1hyW76bzY/qqhHv+8AwzopllUtlSeYRDbq7M=;
  b=EWiRWUnTjr0DDhNkuB2cmAKQdgSKBqAb6te6YFmZD99KuX95o/pd+EPQ
   UhxCqHG6ktyYyVWItb8HFDjtvscRiZ9DE10kIeTZsy9NqPsVkkc6Z5yrj
   9YQBDkrZemoiYp9S7CU/aUlqAnlOvUy5r4pMJkHY3YCIM3VbZPEji4M6R
   si3+MJUyPHMup2Xjw6SwV4GDPcfPqeFC+3PcQasWEyRM97VRCaknD+6gu
   TyiiWvN7bQig84SLXzomSZWsb8HcGFkQT4fZrQobJfLPFLXtC2/3cpd+Z
   Yb+wTZ0a0Xpf5xBNqw4GQyupTbR8oxFjANlROhVkLw3PYVMC3mcw3rsLV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="299573871"
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="299573871"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 03:34:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="623019177"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 03:34:39 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     bigeasy@linutronix.de, tglx@linutronix.de,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH] irq_work: Migrate the remaining work of the offline CPU on PREEMPT_RT
Date:   Sun, 25 Sep 2022 18:41:11 +0800
Message-Id: <20220925104111.1454100-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When CPU goes offline and invoke CPU_DYING callbacks, the
smpcfd_dying_cpu() be invoked to flush the remaining irq_work of the
offline CPU, for lazy irq_work, will wakeup per-CPU irq_work kthreads
to invoke callbacks, but the irq_work kthreads are in TASK_PARKED
state, will not get the actual wakeup, resulting in the remaining lazy
irq_work not being executed.

This commit requeue remaining of lazy irq_work to online CPU.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 include/linux/irq_work.h |  1 +
 kernel/cpu.c             |  1 +
 kernel/irq_work.c        | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 8cd11a223260..900d9053a62d 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -66,6 +66,7 @@ void irq_work_sync(struct irq_work *work);
 void irq_work_run(void);
 bool irq_work_needs_cpu(void);
 void irq_work_single(void *arg);
+void irq_work_migrate(int cpu);
 #else
 static inline bool irq_work_needs_cpu(void) { return false; }
 static inline void irq_work_run(void) { }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..70461b6d785d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1075,6 +1075,7 @@ static int takedown_cpu(unsigned int cpu)
 
 	tick_cleanup_dead_cpu(cpu);
 	rcutree_migrate_callbacks(cpu);
+	irq_work_migrate(cpu);
 	return 0;
 }
 
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc4..bfa21468c2df 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -242,6 +242,26 @@ static void irq_work_run_list(struct llist_head *list)
 		irq_work_single(work);
 }
 
+void irq_work_migrate(int cpu)
+{
+	struct irq_work *work, *tmp;
+	struct llist_node *llnode;
+	struct llist_head *list = per_cpu_ptr(&lazy_list, cpu);
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		return;
+
+	if (llist_empty(list))
+		return;
+
+	llnode = llist_del_all(list);
+	llist_for_each_entry_safe(work, tmp, llnode, node.llist) {
+		atomic_set(&work->node.a_flags, 0);
+		irq_work_queue(work);
+	}
+}
+EXPORT_SYMBOL_GPL(irq_work_migrate);
+
 /*
  * hotplug calls this through:
  *  hotplug_cfd() -> flush_smp_call_function_queue()
-- 
2.25.1

