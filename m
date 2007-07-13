From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH -rt 3/6] Compile fix for PREEMPT_TIMING on and TRACE_IRQFLAGS off
Date: Fri, 13 Jul 2007 10:52:17 -0700
Message-ID: <20070713175228.311226264@mvista.com>
References: <20070713175214.336577416@mvista.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: tglx@linutronix.de, mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:38939 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759850AbXGMSNG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 14:13:06 -0400
Content-Disposition: inline; filename=latency-trace-fix.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Fix compile of latency_trace.c in the case where
CRITICAL_PREEMPT_TIMING=y and TRACE_IRQFLAGS=n (because DEBUG_KERNEL
is disabled)

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 kernel/latency_trace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.21/kernel/latency_trace.c
===================================================================
--- linux-2.6.21.orig/kernel/latency_trace.c
+++ linux-2.6.21/kernel/latency_trace.c
@@ -2151,7 +2151,7 @@ void notrace unmask_preempt_count(unsign
 }
 EXPORT_SYMBOL(unmask_preempt_count);
 
-#ifdef CONFIG_CRITICAL_PREEMPT_TIMING
+#if defined(CONFIG_CRITICAL_PREEMPT_TIMING) && defined(CONFIG_TRACE_IRQFLAGS)
 
 /* Some archs do their cpu_idle with preemption on. Don't measure it */
 void notrace trace_preempt_enter_idle(void)

--
