From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] net: Have __napi_schedule_irqoff() disable interrupts on
 RT
Date: Tue, 6 Dec 2016 17:50:30 -0500
Message-ID: <20161206175030.636989f0@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        John Kacur <jkacur@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

A customer hit a crash where the napi sd->poll_list became corrupted.
The customer had the bnx2x driver, which does a
__napi_schedule_irqoff() in its interrupt handler. Unfortunately, when
running with CONFIG_PREEMPT_RT_FULL, this interrupt handler is run as a
thread and is preemptable. The call to ____napi_schedule() must be done
with interrupts disabled to protect the per cpu softnet_data's
poll_list, which is protected by disabling interrupts (disabling
preemption is enough when all interrupts are threaded and
local_bh_disable() can't preempt).

As bnx2x isn't the only driver that does this, the safest thing to do
is to make __napi_schedule_irqoff() call __napi_schedule() instead when
CONFIG_PREEMPT_RT_FULL is enabled, which will call local_irq_save()
before calling ____napi_schedule().

Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
---
 include/linux/netdevice.h |   12 ++++++++++++
 net/core/dev.c            |    2 ++
 2 files changed, 14 insertions(+)

Index: linux-rt.git/include/linux/netdevice.h
===================================================================
--- linux-rt.git.orig/include/linux/netdevice.h	2016-11-18 14:59:01.679547362 -0500
+++ linux-rt.git/include/linux/netdevice.h	2016-12-06 17:35:38.506672042 -0500
@@ -395,7 +395,19 @@ typedef enum rx_handler_result rx_handle
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
Index: linux-rt.git/net/core/dev.c
===================================================================
--- linux-rt.git.orig/net/core/dev.c	2016-11-18 14:59:02.876527251 -0500
+++ linux-rt.git/net/core/dev.c	2016-12-06 17:35:38.513672035 -0500
@@ -4910,6 +4910,7 @@ void __napi_schedule(struct napi_struct
 }
 EXPORT_SYMBOL(__napi_schedule);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /**
  * __napi_schedule_irqoff - schedule for receive
  * @n: entry to schedule
@@ -4921,6 +4922,7 @@ void __napi_schedule_irqoff(struct napi_
 	____napi_schedule(this_cpu_ptr(&softnet_data), n);
 }
 EXPORT_SYMBOL(__napi_schedule_irqoff);
+#endif
 
 void __napi_complete(struct napi_struct *n)
 {
