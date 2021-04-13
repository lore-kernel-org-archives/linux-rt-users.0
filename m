Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC9AC433B4
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Apr 2021 06:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED77613B1
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Apr 2021 06:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhDMG1t (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Apr 2021 02:27:49 -0400
Received: from ptr.189.cn ([183.61.185.104]:11141 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230350AbhDMG1s (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Apr 2021 02:27:48 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Apr 2021 02:27:47 EDT
HMM_SOURCE_IP: 10.64.8.31:47796.1151691861
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-117.136.54.20 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id ABEFC100790;
        Tue, 13 Apr 2021 14:19:39 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-84df4bfd9c-c55qc with ESMTP id c167afa262294536a60cdc0e11d95260 for linux-rt-users@vger.kernel.org;
        Tue Apr 13 14:19:45 2021
X-Transaction-ID: c167afa262294536a60cdc0e11d95260
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        gregkh@linuxfoundation.org, maz@kernel.org, joe@perches.com,
        romain.perier@gmail.com, john.garry@huawei.com
Cc:     Song Chen <chensong_2000@189.cn>
Subject: [PATCH] kernel:irq:manage: request threaded irq with a specified priority
Date:   Tue, 13 Apr 2021 14:19:34 +0800
Message-Id: <1618294774-24370-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

In general, irq handler thread will be assigned a default priority which
is MAX_RT_PRIO/2, as a result, no one can preempt others.

Here is the case I found in a real project, an interrupt int_a is
coming, wakes up its handler handler_a and handler_a wakes up a
userspace RT process task_a.

However, if another irq handler handler_b which has nothing to do
with any RT tasks is running when int_a is coming, handler_a can't
preempt handler_b, as a result, task_a can't be waken up immediately
as expected until handler_b gives up cpu voluntarily. In this case,
determinism breaks.

Therefore, this patch introduce a new api to give drivers a chance to
assign expected priorities to their irq handler thread.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 include/linux/interrupt.h  |  7 +++++
 include/linux/sched.h      |  1 +
 include/linux/sched/prio.h |  1 +
 kernel/irq/manage.c        | 64 +++++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/core.c        | 11 ++++++++
 5 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 967e257..5ab9169 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -121,6 +121,7 @@ struct irqaction {
 	unsigned long		thread_mask;
 	const char		*name;
 	struct proc_dir_entry	*dir;
+	int prio;
 } ____cacheline_internodealigned_in_smp;
 
 extern irqreturn_t no_action(int cpl, void *dev_id);
@@ -136,6 +137,12 @@ extern irqreturn_t no_action(int cpl, void *dev_id);
 #define IRQ_NOTCONNECTED	(1U << 31)
 
 extern int __must_check
+request_threaded_irq_with_prio(unsigned int irq, irq_handler_t handler,
+		     irq_handler_t thread_fn,
+		     unsigned long flags, const char *name, void *dev,
+			 int prio);
+
+extern int __must_check
 request_threaded_irq(unsigned int irq, irq_handler_t handler,
 		     irq_handler_t thread_fn,
 		     unsigned long flags, const char *name, void *dev);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef00bb2..50edae9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1711,6 +1711,7 @@ extern int sched_setscheduler(struct task_struct *, int, const struct sched_para
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
 extern void sched_set_fifo(struct task_struct *p);
 extern void sched_set_fifo_low(struct task_struct *p);
+extern void sched_set_fifo_with_prio(struct task_struct *p, int prio);
 extern void sched_set_normal(struct task_struct *p, int nice);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
 extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index ab83d85..1e1186e 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -15,6 +15,7 @@
 
 #define MAX_RT_PRIO		100
 
+#define DEFAULT_RT_PRIO	(MAX_RT_PRIO / 2)
 #define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH)
 #define DEFAULT_PRIO		(MAX_RT_PRIO + NICE_WIDTH / 2)
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 21ea370..111b8ce 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1394,7 +1394,7 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	if (IS_ERR(t))
 		return PTR_ERR(t);
 
-	sched_set_fifo(t);
+	sched_set_fifo_with_prio(t, new->prio);
 
 	/*
 	 * We keep the reference to the task struct even if
@@ -2032,7 +2032,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
 }
 
 /**
- *	request_threaded_irq - allocate an interrupt line
+ *	request_threaded_irq_with_prio - allocate an interrupt line
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs.
  *		  Primary handler for threaded interrupts
@@ -2043,6 +2043,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
  *	@irqflags: Interrupt type flags
  *	@devname: An ascii name for the claiming device
  *	@dev_id: A cookie passed back to the handler function
+ *	@prio: priority of the irq handler thread
  *
  *	This call allocates interrupt resources and enables the
  *	interrupt line and IRQ handling. From the point this
@@ -2067,15 +2068,18 @@ const void *free_nmi(unsigned int irq, void *dev_id)
  *	If your interrupt is shared you must pass a non NULL dev_id
  *	as this is required when freeing the interrupt.
  *
+ *	If you want to assign a priority for your irq handler thread
+ *	instead of default value, you need to supply @prio.
+ *
  *	Flags:
  *
  *	IRQF_SHARED		Interrupt is shared
  *	IRQF_TRIGGER_*		Specify active edge(s) or level
  *
  */
-int request_threaded_irq(unsigned int irq, irq_handler_t handler,
+int request_threaded_irq_with_prio(unsigned int irq, irq_handler_t handler,
 			 irq_handler_t thread_fn, unsigned long irqflags,
-			 const char *devname, void *dev_id)
+			 const char *devname, void *dev_id, int prio)
 {
 	struct irqaction *action;
 	struct irq_desc *desc;
@@ -2121,6 +2125,7 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 	action->flags = irqflags;
 	action->name = devname;
 	action->dev_id = dev_id;
+	action->prio = prio;
 
 	retval = irq_chip_pm_get(&desc->irq_data);
 	if (retval < 0) {
@@ -2157,6 +2162,57 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 #endif
 	return retval;
 }
+EXPORT_SYMBOL(request_threaded_irq_with_prio);
+
+/**
+ *	request_threaded_irq - allocate an interrupt line
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs.
+ *		  Primary handler for threaded interrupts
+ *		  If NULL and thread_fn != NULL the default
+ *		  primary handler is installed
+ *	@thread_fn: Function called from the irq handler thread
+ *		    If NULL, no irq thread is created
+ *	@irqflags: Interrupt type flags
+ *	@devname: An ascii name for the claiming device
+ *	@dev_id: A cookie passed back to the handler function
+ *
+ *	This call allocates interrupt resources and enables the
+ *	interrupt line and IRQ handling. From the point this
+ *	call is made your handler function may be invoked. Since
+ *	your handler function must clear any interrupt the board
+ *	raises, you must take care both to initialise your hardware
+ *	and to set up the interrupt handler in the right order.
+ *
+ *	If you want to set up a threaded irq handler for your device
+ *	then you need to supply @handler and @thread_fn. @handler is
+ *	still called in hard interrupt context and has to check
+ *	whether the interrupt originates from the device. If yes it
+ *	needs to disable the interrupt on the device and return
+ *	IRQ_WAKE_THREAD which will wake up the handler thread and run
+ *	@thread_fn. This split handler design is necessary to support
+ *	shared interrupts.
+ *
+ *	Dev_id must be globally unique. Normally the address of the
+ *	device data structure is used as the cookie. Since the handler
+ *	receives this value it makes sense to use it.
+ *
+ *	If your interrupt is shared you must pass a non NULL dev_id
+ *	as this is required when freeing the interrupt.
+ *
+ *	Flags:
+ *
+ *	IRQF_SHARED		Interrupt is shared
+ *	IRQF_TRIGGER_*		Specify active edge(s) or level
+ *
+ */
+int request_threaded_irq(unsigned int irq, irq_handler_t handler,
+			 irq_handler_t thread_fn, unsigned long irqflags,
+			 const char *devname, void *dev_id)
+{
+	return request_threaded_irq_with_prio(irq, handler, thread_fn,
+				irqflags, devname, dev_id, DEFAULT_RT_PRIO);
+}
 EXPORT_SYMBOL(request_threaded_irq);
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9819121..7941595 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6439,6 +6439,17 @@ void sched_set_fifo_low(struct task_struct *p)
 }
 EXPORT_SYMBOL_GPL(sched_set_fifo_low);
 
+/*
+ * For when you want a specific priority.
+ */
+void sched_set_fifo_with_prio(struct task_struct *p, int prio)
+{
+	struct sched_param sp = { .sched_priority =
+		(prio > 0 && prio < MAX_RT_PRIO) ? prio : DEFAULT_RT_PRIO };
+	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) != 0);
+}
+EXPORT_SYMBOL_GPL(sched_set_fifo_with_prio);
+
 void sched_set_normal(struct task_struct *p, int nice)
 {
 	struct sched_attr attr = {
-- 
2.7.4

