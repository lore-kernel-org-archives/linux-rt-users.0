Return-Path: <SRS0=OCQz=VQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE7BC7618F
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B81D2187F
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbfGSVvA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Jul 2019 17:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388695AbfGSVt6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Jul 2019 17:49:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269F72187F;
        Fri, 19 Jul 2019 21:49:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hoalI-0007zH-97; Fri, 19 Jul 2019 17:49:56 -0400
Message-Id: <20190719214956.170195069@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Jul 2019 17:49:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [PATCH RT 01/16] kthread: add a global worker thread.
References: <20190719214931.700049248@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.59-rt24-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 0532e87d9d44795221aa921ba7024bde689cc894 ]

Add kthread_schedule_work() which uses a global kthread for all its
jobs.
Split the cgroup include to avoid recussive includes from interrupt.h.
Fixup everything that fails to build (and did not include all header).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/block/loop.c           |  2 +-
 drivers/spi/spi-rockchip.c     |  1 +
 include/linux/kthread-cgroup.h | 17 +++++++++++++++++
 include/linux/kthread.h        | 17 +++++++----------
 init/main.c                    |  1 +
 kernel/kthread.c               | 14 ++++++++++++++
 6 files changed, 41 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/kthread-cgroup.h

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f1e63eb7cbca..aa76c816dbb4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -70,7 +70,7 @@
 #include <linux/writeback.h>
 #include <linux/completion.h>
 #include <linux/highmem.h>
-#include <linux/kthread.h>
+#include <linux/kthread-cgroup.h>
 #include <linux/splice.h>
 #include <linux/sysfs.h>
 #include <linux/miscdevice.h>
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fdcf3076681b..b56619418cea 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -22,6 +22,7 @@
 #include <linux/spi/spi.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
+#include <linux/interrupt.h>
 
 #define DRIVER_NAME "rockchip-spi"
 
diff --git a/include/linux/kthread-cgroup.h b/include/linux/kthread-cgroup.h
new file mode 100644
index 000000000000..53d34bca9d72
--- /dev/null
+++ b/include/linux/kthread-cgroup.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KTHREAD_CGROUP_H
+#define _LINUX_KTHREAD_CGROUP_H
+#include <linux/kthread.h>
+#include <linux/cgroup.h>
+
+#ifdef CONFIG_BLK_CGROUP
+void kthread_associate_blkcg(struct cgroup_subsys_state *css);
+struct cgroup_subsys_state *kthread_blkcg(void);
+#else
+static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
+static inline struct cgroup_subsys_state *kthread_blkcg(void)
+{
+	return NULL;
+}
+#endif
+#endif
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index ad292898f7f2..7cf56eb54103 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -4,7 +4,6 @@
 /* Simple interface for creating and stopping kernel threads without mess. */
 #include <linux/err.h>
 #include <linux/sched.h>
-#include <linux/cgroup.h>
 
 __printf(4, 5)
 struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
@@ -106,7 +105,7 @@ struct kthread_delayed_work {
 };
 
 #define KTHREAD_WORKER_INIT(worker)	{				\
-	.lock = __SPIN_LOCK_UNLOCKED((worker).lock),			\
+	.lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),		\
 	.work_list = LIST_HEAD_INIT((worker).work_list),		\
 	.delayed_work_list = LIST_HEAD_INIT((worker).delayed_work_list),\
 	}
@@ -198,14 +197,12 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
-#ifdef CONFIG_BLK_CGROUP
-void kthread_associate_blkcg(struct cgroup_subsys_state *css);
-struct cgroup_subsys_state *kthread_blkcg(void);
-#else
-static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
-static inline struct cgroup_subsys_state *kthread_blkcg(void)
+extern struct kthread_worker kthread_global_worker;
+void kthread_init_global_worker(void);
+
+static inline bool kthread_schedule_work(struct kthread_work *work)
 {
-	return NULL;
+	return kthread_queue_work(&kthread_global_worker, work);
 }
-#endif
+
 #endif /* _LINUX_KTHREAD_H */
diff --git a/init/main.c b/init/main.c
index 4a7471606e53..b0e95351c22c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1130,6 +1130,7 @@ static noinline void __init kernel_init_freeable(void)
 	smp_prepare_cpus(setup_max_cpus);
 
 	workqueue_init();
+	kthread_init_global_worker();
 
 	init_mm_internals();
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5641b55783a6..9db017761a1f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -20,6 +20,7 @@
 #include <linux/freezer.h>
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
+#include <linux/cgroup.h>
 #include <trace/events/sched.h>
 
 static DEFINE_SPINLOCK(kthread_create_lock);
@@ -1180,6 +1181,19 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 }
 EXPORT_SYMBOL(kthread_destroy_worker);
 
+DEFINE_KTHREAD_WORKER(kthread_global_worker);
+EXPORT_SYMBOL(kthread_global_worker);
+
+__init void kthread_init_global_worker(void)
+{
+	kthread_global_worker.task = kthread_create(kthread_worker_fn,
+						    &kthread_global_worker,
+						    "kswork");
+	if (WARN_ON(IS_ERR(kthread_global_worker.task)))
+		return;
+	wake_up_process(kthread_global_worker.task);
+}
+
 #ifdef CONFIG_BLK_CGROUP
 /**
  * kthread_associate_blkcg - associate blkcg to current kthread
-- 
2.20.1


