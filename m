From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH -rt 6/6] Compile fix for PREEMPT_TIMING on and IRQSOFF_TIMING
 off
Date: Fri, 13 Jul 2007 16:22:29 -0700
Message-ID: <46980935.3060509@mvista.com>
References: <20070713175214.336577416@mvista.com> <20070713175229.239602308@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mingo@elte.hu, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.158]:7301 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1759161AbXGMXW1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 19:22:27 -0400
In-Reply-To: <20070713175229.239602308@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[Minor update to avoid a compiler warning in the case of DEBUG_KERNEL=n]

Compile fix for PREEMPT_TIMING on and IRQSOFF_TIMING off

The per-cpu trace_cpu_idle variable is used when timing *either*
IRQs-off or preempt sections.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 kernel/latency_trace.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/latency_trace.c
===================================================================
--- linux-2.6.orig/kernel/latency_trace.c
+++ linux-2.6/kernel/latency_trace.c
@@ -85,9 +85,13 @@ static inline int DEBUG_WARN_ON(int cond
 }
 #endif

+#if defined(CONFIG_CRITICAL_IRQSOFF_TIMING) || \
+   (defined(CONFIG_CRITICAL_PREEMPT_TIMING) &&
defined(CONFIG_TRACE_IRQFLAGS))
+   static DEFINE_PER_CPU(int, trace_cpu_idle);
+#endif
+
 #ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
 # ifdef CONFIG_CRITICAL_PREEMPT_TIMING
-   static DEFINE_PER_CPU(int, trace_cpu_idle);
 #  define irqs_off_preempt_count() (preempt_count() &&
!__get_cpu_var(trace_cpu_idle))
 # else
 #  define irqs_off_preempt_count() 0
