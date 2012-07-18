From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/12] Latency histograms: Detect another yet overlooked sharedprio
 condition
Date: Wed, 18 Jul 2012 18:39:14 -0400
Message-ID: <20120718223957.636657441@goodmis.org>
References: <20120718223910.898476857@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-Latency-histograms-Detect-another-yet-overlooked-sha.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Carsten Emde <C.Emde@osadl.org>

While waiting for an RT process to be woken up, the previous process may
go to wait and switch to another one with the same priority which then
becomes current. This condition was not correctly recognized and led to
erroneously high latency recordings during periods of low CPU load.

This patch correctly marks such latencies as sharedprio and prevents
them from being recorded as actual system latency.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/latency_hist.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/latency_hist.c b/kernel/trace/latency_hist.c
index d514eef..6a4c869 100644
--- a/kernel/trace/latency_hist.c
+++ b/kernel/trace/latency_hist.c
@@ -935,6 +935,9 @@ static notrace void probe_wakeup_latency_hist_stop(void *v,
 		goto out;
 	}
 
+	if (current->prio == cpu_wakeup_task->prio)
+		per_cpu(wakeup_sharedprio, cpu) = 1;
+
 	/*
 	 * The task we are waiting for is about to be switched to.
 	 * Calculate latency and store it in histogram.
-- 
1.7.10.4
