From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch RT 4/7] Latency histograms: Detect another yet overlooked
 sharedprio condition
Date: Wed, 11 Jul 2012 22:05:19 -0000
Message-ID: <20120711215611.943318314@linutronix.de>
References: <20120711214552.036760674@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=latency-histograms-detect-another-yet-overlooked-sharedprio-condition.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

While waiting for an RT process to be woken up, the previous process may
go to wait and switch to another one with the same priority which then
becomes current. This condition was not correctly recognized and led to
erroneously high latency recordings during periods of low CPU load.

This patch correctly marks such latencies as sharedprio and prevents
them from being recorded as actual system latency. 

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/trace/latency_hist.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-3.4.2-rt10-64+/kernel/trace/latency_hist.c
===================================================================
--- linux-3.4.2-rt10-64+.orig/kernel/trace/latency_hist.c
+++ linux-3.4.2-rt10-64+/kernel/trace/latency_hist.c
@@ -935,6 +935,9 @@ static notrace void probe_wakeup_latency
 		goto out;
 	}
 
+	if (current->prio == cpu_wakeup_task->prio)
+		per_cpu(wakeup_sharedprio, cpu) = 1;
+
 	/*
 	 * The task we are waiting for is about to be switched to.
 	 * Calculate latency and store it in histogram.
