From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/5] net: Have __napi_schedule_irqoff() disable interrupts on RT
Date: Thu, 09 Feb 2017 10:21:18 -0500
Message-ID: <20170209152229.420814579@goodmis.org>
References: <20170209152115.146963512@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751940AbdBIPWd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Feb 2017 10:22:33 -0500
Content-Disposition: inline; filename=0003-net-Have-__napi_schedule_irqoff-disable-interrupts-o.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.4.47-rt59-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

A customer hit a crash where the napi sd->poll_list became corrupted.
The customer had the bnx2x driver, which does a
__napi_schedule_irqoff() in its interrupt handler. Unfortunately, when
running with CONFIG_PREEMPT_RT_FULL, this interrupt handler is run as a
thread and is preemptable. The call to ____napi_schedule() must be done
with interrupts disabled to protect the per cpu softnet_data's
"poll_list, which is protected by disabling interrupts (disabling
preemption is enough when all interrupts are threaded and
local_bh_disable() can't preempt)."

As bnx2x isn't the only driver that does this, the safest thing to do
is to make __napi_schedule_irqoff() call __napi_schedule() instead when
CONFIG_PREEMPT_RT_FULL is enabled, which will call local_irq_save()
before calling ____napi_schedule().

Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h | 12 ++++++++++++
 net/core/dev.c            |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0590f5380814..b3fa55658bd2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -390,7 +390,19 @@ typedef enum rx_handler_result rx_handler_result_t;
 typedef rx_handler_result_t rx_handler_func_t(struct sk_buff **pskb);
 
 void __napi_schedule(struct napi_struct *n);
+
+/*
+ * When PREEMPT_RT_FULL is defined, all device interrupt handlers
+ * run as threads, and they can also be preempted (without PREEMPT_RT
+ * interrupt threads can not be preempted). Which means that calling
+ * __napi_schedule_irqoff() from an interrupt handler can be preempted
+ * and can corrupt the napi->poll_list.
+ */
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define __napi_schedule_irqoff(n) __napi_schedule(n)
+#else
 void __napi_schedule_irqoff(struct napi_struct *n);
+#endif
 
 static inline bool napi_disable_pending(struct napi_struct *n)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index e31ece38d1ec..d63b1f9ca08f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4714,6 +4714,7 @@ void __napi_schedule(struct napi_struct *n)
 }
 EXPORT_SYMBOL(__napi_schedule);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /**
  * __napi_schedule_irqoff - schedule for receive
  * @n: entry to schedule
@@ -4725,6 +4726,7 @@ void __napi_schedule_irqoff(struct napi_struct *n)
 	____napi_schedule(this_cpu_ptr(&softnet_data), n);
 }
 EXPORT_SYMBOL(__napi_schedule_irqoff);
+#endif
 
 void __napi_complete(struct napi_struct *n)
 {
-- 
2.10.2


