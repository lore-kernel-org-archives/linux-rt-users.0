From: Carsten Emde <C.Emde@osadl.org>
Subject: trace/latency-hist: Consider new argument when probing the
 sched_switch tracer
Date: Tue, 5 Jan 2016 10:21:59 +0100
Message-ID: <568B8B37.9070804@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:41644 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbcAEJWQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jan 2016 04:22:16 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas & Sebastian,

The sched_switch tracer has got a new argument. Fix the latency tracer
accordingly.

Thanks,
    -Carsten.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
 kernel/trace/latency_hist.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-4.4.0-rc6-rt1/kernel/trace/latency_hist.c
===================================================================
--- linux-4.4.0-rc6-rt1.orig/kernel/trace/latency_hist.c
+++ linux-4.4.0-rc6-rt1/kernel/trace/latency_hist.c
@@ -117,7 +117,7 @@ static char *wakeup_latency_hist_dir_sha
 static notrace void probe_wakeup_latency_hist_start(void *v,
 	struct task_struct *p);
 static notrace void probe_wakeup_latency_hist_stop(void *v,
-	struct task_struct *prev, struct task_struct *next);
+	bool preempt, struct task_struct *prev, struct task_struct *next);
 static notrace void probe_sched_migrate_task(void *,
 	struct task_struct *task, int cpu);
 static struct enable_data wakeup_latency_enabled_data = {
@@ -907,7 +907,7 @@ out:
 }

 static notrace void probe_wakeup_latency_hist_stop(void *v,
-	struct task_struct *prev, struct task_struct *next)
+	bool preempt, struct task_struct *prev, struct task_struct *next)
 {
 	unsigned long flags;
 	int cpu = task_cpu(next);
